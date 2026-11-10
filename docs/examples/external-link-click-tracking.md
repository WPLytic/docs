# External Link Click Tracking

Track clicks on HTTP(S) links to a different hostname, including subdomains, using [Events](../api/events.md) and [Tags](../api/tags.md). Links to the same hostname, email addresses and phone numbers are excluded.

Run this after the WPLytic tracking snippet and after the links exist in the DOM. It binds only those links; links added later need their own listener.

```javascript
// Run after the tracking snippet and after these links exist in the DOM.
document.querySelectorAll('a[href]').forEach(link => {
  link.addEventListener('click', event => {
    const anchor = event.currentTarget;
    const destination = new URL(anchor.href);
    if (!['http:', 'https:'].includes(destination.protocol) ||
        destination.hostname === location.hostname) return;

    WPLY.addEvent({
      category: 'LINK',
      // Preserve the existing example's event/tag names for saved reports.
      action: 'OUTBOUNT_CLICK',
      label: destination.hostname
    });
    WPLY.addTag('outbout_click');
  });
});
```

The example records only the destination hostname. It omits the path, query string, fragment and link text, which can contain user-specific identifiers or tokens. It keeps the existing `OUTBOUNT_CLICK` action and `outbout_click` tag so saved report filters still match; new labels group clicks by hostname rather than full URL.

This records a click, not a completed download or proof that the destination loaded. Leaving the page or a network failure can prevent delivery.
