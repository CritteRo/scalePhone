# scalePhone
GTAPhone for FiveM, using scaleforms.

## Purpose
Phone will be designed to handle the following:
* Template menus like: Numpad, Callscreen, Email List/View, SMS List/View, Contacts or Snapmatic
* Generic list menus, like: Settings

Every menu will have a openEvent(triggered with the menu opening of the menu), a backEvent(triggered when hitting a back button. This should handle closing the menu / going back too), a data array, and buttons.

Buttons are used to build the item lists(contacts, text rows, emails, messages, things like that). The data array will be used on the openEvent and backEvent, as the only param passed.

