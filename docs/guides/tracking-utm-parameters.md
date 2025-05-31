# Tracking UTM parameters

By default, UTM parameters and not tracked in any way, they are even removed from the saved URL so that the number of unique links stored is reduced.

If you want to store the UTM params for each session, you can automatically tag each session with the name and value of each UTM parameter. Add this after the tracking snippet:

### Store UTM parameters as tags

```html
<script>
(function() {
function getParameterByName(name, url = window.location.href) {
    name = name.replace(/[\[\]]/g, '\\$&');
    var regex = new RegExp('[?&]' + name + '(=([^&#]*)|&|#|$)'),
        results = regex.exec(url);
    if (!results) return null;
    if (!results[2]) return '';
    return decodeURIComponent(results[2].replace(/\+/g, ' '));
}

var utms = ['utm_source', 'utm_medium', 'utm_campaign'];
utms.forEach(function(utm) {
   var val = getParameterByName(utm);
   val && WPLY.addTag(utm + ':' + val);
});
})();
</script>
```

:::info
Once you have stored the utm parameters as tags you can create segments and filter sessions based on those tags.
:::
