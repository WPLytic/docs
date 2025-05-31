# Events

:::warning
**Note:** Currently the events are only stored and displayed per user in the dashboard. In the future versions you will be able to filter and generate charts based on those events. Until then, you can use MySQL to directly query the database.
:::

Events allow you to store arbitrary data for a specific session or pageview.\
The main difference between **events** and [**tags**](tags.md) is that **tags** are unique strings stored per session, whereas events are complex objects saved per individual page visited.

### WPLY.addEvent(eventData)

Example:

```javascript
// NOTE: Make sure this code snipped is added AFTER the tracking snippet
WPLY.addEvent({
    category: 'SHOP', // REQUIRED
    action: 'PURCHASED', // REQUIRED
    label: 'Football Shoes',
    value: 49.99,
    value_secondary: 15.99,
    item_id: 'SHOE123',
    data: { img: "prod/img/shoe.png" }
});
```

#### Input parameters

You can pass those values in the **eventData** argument:

| Parameter            | Type              | Example value                | Info                     |
| -------------------- | ----------------- | ---------------------------- | ------------------------ |
| **category**         | string - REQUIRED | "SHOP"                       |                          |
| **action**           | string - REQUIRED | "PURCHASED"                  |                          |
| **label**            | string - OPTIONAL | "Football Shoes"             |                          |
| **value**            | number - OPTIONAL | 49.99                        | eg. product price        |
| **value\_secondary** | number - OPTIONAL | 15.99                        | eg. shipping costs/tax   |
| **item\_id**         | string - OPTIONAL | "SHOE123"                    | eg. item SKU             |
| **data**             | string - OPTIONAL | \{ img: "prod/img/shoe.png" \} | This can be any object.  |

:::warning
**Data types limits**

* **strings** (**category**, **action**, **label**, **item\_id**) have a **character limit of 128**.
*   **numbers** (**value** and **value\_secondary**) are stored as fixed precision decimal numbers. \
    They always have **2 decimals** and a maximum of **13** digits before the decimal.

    Max decimal number format example: **9,999,999,999,999.99**
* The **data** field is stored as a MySQL **TEXT** variable and can have any size (limited by the database engine).
:::

:::info
**Note:** The **data** field is automatically converted to **JSON** using [**JSON.stringify()**](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/JSON/stringify) on the client-side **if** the passed value is not already a string.
:::

#### Autofilled values

Those values are automatically added by the server for each event

| Name             | Type             | Info                                                   |
| ---------------- | ---------------- | ------------------------------------------------------ |
| **id**           | UNSIGNED INTEGER | ID of the event                                        |
| **clientid**     | UNSIGNED INTEGER | ID of the client (session)                             |
| **clientpageid** | UNSIGNED INTEGER | ID of the client page (pageview)                       |
| **date**         | DATETIME         | Date and time when the event was added to the database |

:::info
The events system is loosely opinionated, meaning that you can store values in any way you prefer. The system provides multiple **string** and **number** fields that you populate.

In the future, the value of some of those fields might gain a specific meaning in order to automatically generate and display specific charts. For example, the dashboard could automatically show "Revenue" as being the sum of "value" for events that have the action name "PURCHASED".
:::
