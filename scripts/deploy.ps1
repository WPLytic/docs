# Build the committed docs and upload them to https://wplytic.com/docs/ over SFTP, then check live.
# Usage (from the repo root):
#   pwsh -NoProfile -File scripts/deploy.ps1
# Rollback: check out the last good commit and run this script again. Git is the backup.
# The upload adds and replaces files; it never deletes on the server, so old hashed assets stay harmless.
# Production is the WordPress volume on Hetzner EX63, not GitHub Pages. Never use `docusaurus deploy`.
$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot
$remoteRoot = '/var/lib/docker/volumes/fog48g48kwo8gosokwo880cg_wordpress-files/_data/docs'
$target = 'root@91.98.178.180'
$key = 'C:/Users/XCS/Dropbox/keys/hetzner_EX63.pem'

Push-Location $root
try {
    git diff --quiet HEAD
    if ($LASTEXITCODE) { throw 'Uncommitted changes. Commit first so Git can restore this release.' }

    node node_modules/@docusaurus/core/bin/docusaurus.mjs build
    if ($LASTEXITCODE) { throw 'Build failed.' }

    $build = Join-Path $root 'build'
    $files = Get-ChildItem -LiteralPath $build -Recurse -File
    # Every ancestor folder, parents first (sftp mkdir is not recursive; existing folders just print a failure).
    $dirs = $files | ForEach-Object {
        $rel = $_.DirectoryName.Substring($build.Length) -replace '\\', '/'
        while ($rel) { $rel; $rel = $rel.Substring(0, $rel.LastIndexOf('/')) }
    } | Sort-Object -Unique
    $batch = @($dirs | ForEach-Object { "-mkdir $remoteRoot$_" }) +
        @($files | ForEach-Object { "put `"$($_.FullName -replace '\\', '/')`" `"$remoteRoot$($_.FullName.Substring($build.Length) -replace '\\', '/')`"" })
    $batchFile = Join-Path ([IO.Path]::GetTempPath()) "wplytic-docs-deploy-$PID.txt"
    Set-Content -LiteralPath $batchFile -Value $batch -Encoding ascii
    Write-Host "Uploading $($files.Count) files from $(git rev-parse --short HEAD)"
    sftp -q -i $key -o BatchMode=yes -b $batchFile $target | Out-Null
    $code = $LASTEXITCODE
    Remove-Item -LiteralPath $batchFile
    if ($code) { throw 'SFTP upload failed.' }

    # Live pages must match the build byte for byte.
    foreach ($page in 'index.html', 'examples/external-link-click-tracking/index.html', 'guides/tracking-utm-parameters/index.html', 'sitemap.xml') {
        $url = "https://wplytic.com/docs/$($page -replace 'index\.html$', '')"
        $live = (Invoke-WebRequest -Uri "$url`?deploycheck=$PID" -TimeoutSec 30).Content
        $expected = Get-Content -Raw -LiteralPath (Join-Path $build $page)
        $status = if ($live -eq $expected) { 'match' } else { 'DIFFERENT' }
        Write-Host "$status $url"
        if ($status -ne 'match') { throw "Live check failed: $url" }
    }
} finally {
    Pop-Location
}
