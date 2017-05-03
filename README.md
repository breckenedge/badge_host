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

Example
-------

[![example
unknown](https://badge-host.herokuapp.com/badges/79de04f884e768bc28ce138017ab6ef8a7a4307108f49014eaefa94fdf778364.svg)](https://badge-host.herokuapp.com/badges/79de04f884e768bc28ce138017ab6ef8a7a4307108f49014eaefa94fdf778364)

Update the above badge with an HTTP `POST`, for example via the following cURL
command:

```sh
curl -X POST -d 'owner=breckenedge&project=badge_host&subject=example&status=OK&color=green' https://badge-host.herokuapp.com/badges
```

Try changing the `status` and `color` parameters in this command and then
reloading the page. Note that Github caches images in READMEs, so it may take a
few moments for the update to propagate.

Credits
-------

Shields are generated via a cURL request to [shields.io](https://shields.io).
