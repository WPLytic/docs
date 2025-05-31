# Updating fails

Here are a few potential cases where the update might fail, and the fixes for it.

## Problem - File integrity check failed:

:::warning
Warning: file\_get\_contents(**https://raw.githubusercontent.com/WPLytic/update-integrity-check/master/v2/latest-version-hash-wp?token=1734455519**): \
Failed to open stream: HTTP request failed! HTTP/1.1 404 Not Found in **/var/www/wp-content/plugins/wp-wplytic/wplytic/server/helpers/update/update.php** on line 102\
Expected hash:\
Remote hash: c336aecf77044d8a56004e226f1a3c896ec4c8d541b1cc10e8adebdabe9eaf34\
File integrity check failed. Update process stopped.
:::

### Why this happens:

For security, the updater checks each new .zip update file with a remote GitHub repository that contains the correct integrity hash for that version. If the hash of the downloaded file is different the integrity hash in the GitHub repository, the updater will stop the updating process.\
**GitHub has recently changed how their content is delivered. Because the updating will fail with the old URL, you have to manually fix the URL.**

### Solution:

:::success
**Please do those steps to fix the updater:**

In **/server/helpers/update/update.php** please replace this line:

/var/www/htm&#x6C;**/server/helpers/update/update.php - Line #72 (or near it)**

Old integrity check URLCopy

```
$HASH_CHECK_URL = 'https://raw.githubusercontent.com/WPLytic/update-integrity-check/master/v2/latest-version-hash';
```

With this one:

New integrity check URLCopy

```
$HASH_CHECK_URL = 'https://wplytic.github.io/update-integrity-check/v2/latest-version-hash';
```
:::









