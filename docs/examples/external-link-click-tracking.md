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
      label: destination.href.slice(0, 128),
      data: { text: anchor.innerText || 'No Label' }
    });
    WPLY.addTag('outbout_click');
  });
});
```

The example keeps the existing `OUTBOUNT_CLICK` event action and `outbout_click` tag names so saved reports continue to match. The event label is limited to 128 characters.

This records a click, not a completed download or proof that the destination loaded. Leaving the page or a network failure can prevent delivery.
