Badge Host
==========

Exfiltrate your application's badges.

[![awesome
yea](https://badge-host.herokuapp.com/badges/d81c73fa9049ccf9aea33ea6fc9c70a23259147db6c5d80886f3fe64fa1c3fba.svg)](https://badge-host.herokuapp.com/badges/d81c73fa9049ccf9aea33ea6fc9c70a23259147db6c5d80886f3fe64fa1c3fba)

About
-----

Publicly host and manage your (private) project badges. Github's cacher can't
get to your firewalled CI server, so it'll render a broken image if you try to
add a reference to it. Use Badge Host and cURL to exfiltrate your application's
badges.

Usage
-----

Submit the form and then add the returned SHA256-based URL to your project's
README as an image. Updates with the same `owner`, `project`, `subject` and
`password` parameters will overwrite the existing icon.

Credits
-------

Shields are generated via a cURL request to [shields.io](https://shields.io).
