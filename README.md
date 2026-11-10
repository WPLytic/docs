# Website

This website is built using [Docusaurus](https://docusaurus.io/), a modern static website generator.

## Installation

```bash
yarn
```

## Local Development

```bash
yarn start
```

This command starts a local development server and opens up a browser window. Most changes are reflected live without having to restart the server.

## Build

```bash
yarn build
```

This command generates static content into the `build` directory and can be served using any static contents hosting service.

## Deployment

Production is https://wplytic.com/docs/, served from the WordPress volume on Hetzner EX63. It is not GitHub Pages; do not use `docusaurus deploy` (it pushes to `gh-pages`).

Commit first, then from the repo root:

```powershell
pwsh -NoProfile -File scripts/deploy.ps1
```

The script refuses uncommitted changes, builds, uploads `build/` over SFTP (add and replace only, no deletes) and checks that live pages match the build. Git is the backup: to roll back, check out the last good commit and run it again.
