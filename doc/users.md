Users
=====

Users represent an individual's account on Box.

* [Get the Current User's Information](#get-the-current-users-information)

Get the Current User's Information
----------------------------------

To get the current user, call the static `getCurrentUser(BoxAPIConnection)` method. 

```java
BoxUser.Info userInfo = BoxUser.getCurrentUser(api);
```
