Authentication
==============

The Box API uses OAuth2 for authentication, which can be difficult to implement.
The SDK makes it easier by providing classes that handle obtaining tokens and
automatically refreshing them.

Ways to Authenticate
--------------------

### Developer Tokens

The fastest way to get started using the API is with developer tokens. A
developer token is simply a short-lived access token that cannot be refreshed
and can only be used with your own account. Therefore, they're only useful for
testing an app and aren't suitable for production. You can obtain a developer
token from your application's [developer
console](https://cloud.app.box.com/developers/services).

The following example creates an API connection with a developer token:

```java
BoxApiConnection api = new BoxApiConnection('YOUR-DEVELOPER-TOKEN');
```

### Normal Authentication

Using an auth code is the most common way of authenticating with the Box API.
Your application must provide a way for the user to login to Box via the 
[oauth authentication endpoint][oauth-authorize] in order to obtain an auth code.

After a user logs in and grants your application access to their Box account,
they will be redirected to your application's `redirect_uri` which will contain
an auth code. This auth code can then be used along with your client ID and
client secret to establish an API connection.

```java
BoxApiConnection api = new BoxApiConnection('YOUR-CLIENT-ID',
    'YOUR-CLIENT-SECRET', 'YOUR-AUTH-CODE');
```

### Manual Authentication

For scenarios where you only want to grant authorization once and store
access and refresh tokens yourself, you can create an API connection with
the tokens directly.  It's up to you how to store these tokens but it's 
important to store them securely.  Hierarchical custom settings are a
good place to start.  Encrypting the fields is a priority for security
since having these tokens and your client information grants full access
to the Box account they're associated with.

```java
BoxApiConnection api = new BoxApiConnection('YOUR-CLIENT-ID',
    'YOUR-CLIENT-SECRET', 'YOUR-ACCESS-TOKEN', 'YOUR-REFRESH-TOKEN');
```

Auto-Refresh
------------

By default, a `BoxApiConnection` will automatically refresh the access token if
it has expired. To disable auto-refresh, set the connection's auto-refresh
setting to false with [`setAutoRefresh(false)`]. Keep in mind that
you will have to manually refresh the access token yourself.

```java
// This connection won't auto-refresh.
BoxApiConnection api = new BoxAPIConnection('YOUR-CLIENT-ID',
    'YOUR-CLIENT-SECRET', 'YOUR-ACCESS-TOKEN', 'YOUR-REFRESH-TOKEN');
api.setAutoRefresh(false);

// If the access token expires, you will have to manually refresh it.
api.refresh();
```

[oauth-authorize]: https://box-content.readme.io/reference#authorize