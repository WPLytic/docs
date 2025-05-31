# External Link Click Tracking

Example of tracking all outbound clicks on links, using [Events ](../api/events.md)and [Tags](../api/tags.md).

```javascript
document.querySelectorAll('a').forEach(link => {
  link.addEventListener('click', (event) => {
    const url = event.target.href;

    if (url && !url.includes(location.hostname)) { // Outbound link check
      WPLY.addEvent({
        category: 'LINK', // REQUIRED
        action: 'OUTBOUNT_CLICK', // REQUIRED
        label: url, // OPTIONAL: URL of the link
        data: \{ text: event.target.innerText || 'No Label' \} // OPTIONAL: Extra details
      });
     WPLY.addTag('outbout_click');
    }
  });
});
```






