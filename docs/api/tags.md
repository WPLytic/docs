# Tags

:::info
Tags can be added by **adding a JavaScript snippet on all pages of your website,** by calling the function`WPLY.addTag('your_tag_name')`.\
\
Tags can also be added by **editing the HTML of your website** and adding the `data-wply-click-tag="your_tag_name" to any HTML element on the page.`
:::

**Tags** are strings that can be associated with a specific visit/session.\
Unlike [**events**](events.md), tags are unique per session (i.e. can not have duplicate tags), are simple strings of a length of maximum 128 characters.\
Tags can be used to quickly filter/segment data.

**Example**

```javascript
// Call this when the scrollbar reaches the end
WPLY.addTag('scrolled_to_footer')

// Call this when user adds an item to the basket
WPLY.addTag('add_to_basket_timestamp: ' + Date.now())
```

**Instructions**

* Sometimes you might want to save additional data for each tracked user (such as username or whether they clicked a button or not).
*   To add a tag, the function **WPLY.addTag()** is provided. It has only one parameter, which is the tag value. For example, after calling this: **WPLY.addTag("username\_John")**

    The tag will be saved for the current recording, and you will be able to find it more easily.

You can also use a HTML5 data attribute to track clicks on specific elements using **data-wply-click-tag**, for example:

```html
<a href="checkout.html" data-wply-click-tag="checkout">My checkout link</a>
```

### Examples

1. Tagging visitors that scrolled at least once on a page:

```javascript
/// Add a tag for users who scroll at least once on the homepage
window.addEventListener('scroll', function didScroll() {
    WPLY.addTag('scrolled_on_home');
    window.removeEventListener('scroll', didScroll); // Sending it once is enough, remove listener
});
```

:::info
On WordPress you can add JavaScript on your site using your Theme's appearance settings (Custom JS) or a plugin like [WPCode - Insert Headers and Footers](https://wordpress.org/plugins/insert-headers-and-footers/).
:::
