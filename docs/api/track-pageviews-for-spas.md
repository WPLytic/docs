# Track pageviews for SPAs

After including the tracking snippet in your SPA application, call this function whenever your route changes. Note that you might want to avoid calling this on the initial load, if that triggers a route change (so it doesn't track first pageview twice).

```javascript
// Creates a new pageview for this session
WPLY.trackNewPage();
```

**Instructions**

* This is often used when tracking Single Page Applications (SPAs). You normally want to call this when your routes changes, to track a new pageview (otherwise WPLytic will keep recording data as being for the initial entry page, so you will have 1 pageview only per session).



To automatically track pageviews whenever the URL changes:

````html
```html
<script>
    (() => {
        let lastTrackedUrl = window.location.href;

        // Whenever 
        const trackPageView= () => {
            const currentUrl = window.location.href;
            if (currentUrl === lastTrackedUrl) return;
            
            // Page changed
            WPLY.trackNewPage();
            lastTrackedUrl = currentUrl;
        };

        // Monitor URL changes (pushState, replaceState, and popstate)
        ['pushState', 'replaceState'].forEach((method) => {
            const original = history[method];
            history[method] = function (...args) {
                const result = original.apply(this, args);
                try {
                    trackPageView();
                } catch (e) {
                    console.error(e);
                }
                return result;
            };
        });

        window.addEventListener('popstate', trackPageView);
    })();
</script>
```
````






