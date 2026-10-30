# Tracking UTM parameters

By default, UTM parameters are not tracked in any way, they are even removed from the saved URL so that the number of unique links stored is reduced.

If you want to store the UTM params for each session, you can automatically tag each session with the name and value of each UTM parameter. Add this after the tracking snippet:

### Store UTM parameters as tags

```html
<script>
(function () {
  var params = new URLSearchParams(window.location.search);
  ['utm_source', 'utm_medium', 'utm_campaign'].forEach(function (utm) {
    var value = params.get(utm);
    if (value) WPLY.addTag(utm + ':' + value);
  });
})();
</script>
```

This example saves only `utm_source`, `utm_medium` and `utm_campaign`. Empty values are skipped; if a parameter occurs more than once, its first value is used. Malformed percent encoding in one value does not stop the later parameters from being processed.

:::info
Once you have stored the utm parameters as tags you can create segments and filter sessions based on those tags.
:::
