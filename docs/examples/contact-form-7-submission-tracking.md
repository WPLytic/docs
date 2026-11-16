# Contact Form 7 Submission Tracking

Record a sent [Contact Form 7](https://contactform7.com/) form in WPLytic with an [event](../api/events.md) and a [tag](../api/tags.md). The example listens for `wpcf7mailsent`, one of the [DOM events that Contact Form 7 documents](https://contactform7.com/dom-events/), and then calls `WPLY.addEvent` and `WPLY.addTag`.

```javascript
// The ID that Contact Form 7 reports in event.detail.contactFormId.
const FORM_ID = '123';

document.addEventListener('wpcf7mailsent', event => {
  // Contact Form 7 events bubble to the document, so every form on the page arrives here.
  if (String(event.detail.contactFormId) !== FORM_ID) return;
  // Do nothing when the WPLytic tracker is not loaded on this page.
  if (typeof WPLY === 'undefined') return;

  WPLY.addEvent({
    category: 'FORM',
    action: 'CF7_MAIL_SENT',
    label: 'contact-form-' + FORM_ID
  });
  WPLY.addTag('cf7_mail_sent_' + FORM_ID);
}, false);
```

On WordPress you can add the script with your theme's Custom JS setting or a plugin like WPCode. Add it on the pages that show the form. The WPLytic tracker must also be on those pages; see [Tracking Current WordPress Site](../guides/tracking-current-wordpress-site.md).

## Find the form ID

Add this line for a moment, send the form once and read the ID in the browser console. Then remove the line.

```javascript
document.addEventListener('wpcf7submit', event => console.log(event.detail.contactFormId));
```

## What the event means

Contact Form 7 fires `wpcf7mailsent` when an Ajax form submission has completed and the mail has been sent. It does not fire for these results, so they are not recorded:

| Contact Form 7 event | Result |
| --- | --- |
| `wpcf7invalid` | A field has invalid input. |
| `wpcf7spam` | Possible spam activity was detected. |
| `wpcf7mailfailed` | Sending the mail failed. |

Do not use `wpcf7submit` to count leads. It fires after every completed Ajax submission, including the three results above.

## Limits

- **Ajax only.** Contact Form 7 states that [none of its DOM events fire in non-Ajax submission mode](https://contactform7.com/faq/dom-event-doesnt-work/). If your form reloads the page on submit, this example records nothing.
- **Sent is not delivered.** The event shows that WordPress sent the mail. It does not show that the message reached an inbox.
- **No form content.** The example stores only the form ID. Do not copy `event.detail.inputs` into the label or the tag: it holds what the visitor typed, such as a name, email address or message.
- **One tag per session.** Tags are unique per session, so the tag shows that a session sent the form at least once. Use the tag to filter and segment sessions.
- **Events are per user.** Events are currently stored and displayed per user in the dashboard, not in filters or charts. See the note on the [Events](../api/events.md) page.
- **Not a conversion goal.** This example does not create a goal.
- **Delivery can fail.** Leaving the page or a network failure can prevent the event and the tag from being saved.

After you add the script, send one valid test form and one with an invalid field. Only the valid one should add the event and the tag to your session.
