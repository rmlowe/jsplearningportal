A sample e-learning portal site based on the [NetDimensions SDK](http://www.netdimensions.com/solutions/learning-portals.php). Created using JavaServer Pages (JSP).

To configure delegated authentication you will need to rename the file named `config-example.jsp` to `config,jsp`, and then edit the values of the variables listed below.

  * `authKey` should have the same value as the `authentication.key` property defined in `ekp.properties`.
  * Create a user in Talent Suite with the _Switch User_ permission (probably a System Administrator) and configure `adminUserName` and `adminPassword` as, respectively, the user ID and password of that user. (This is the user that the JSP site will authenticate as when calling the API.)

You will also need to make the following changes to `signin.jsp`.

  * `callback` should be the absolute URL of the file `authcallback.jsp` on your server.
  * The base redirect URL needs to be changed to reference your Talent Suite installation—for example `http://utest2.netdimensions.com/utest/` might be changed to `https://www.example.com/ekp/`.

You will also need to add the host name or IP address of the JSP site to the list _Trusted relying parties for delegated authentication_, which is under the _Users_ category of _Manage_ > _System Administration_ > _System Settings_ > _System Configuration_. (The value configured here must exactly match the host portion of the `callback` value value configured above.)

If you want to use a custom login page template for the portal (that is, different from the generic login page template for the Talent Suite site), place the login page template under the `WEB-INF/conf/` directory and add the value **`host`**`:`**`template`** under _Trusted relying parties for delegated authentication_, where **`host`** is the host name or IP address of the JSP site and **`template`** is the file name of the custom login page template. Example: `www.example.com:myTemplate.wm`

Delegated authentication is explained in more detail in the [documentation](https://wiki.netdimensions.com/confluence/display/products/Delegated+authentication).