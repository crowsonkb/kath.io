kath.io
=======

Hakyll source for <https://kath.io/>. The CSS/HTML5 layout is FreshPick from <http://www.styleshout.com/>.

Installation instructions
-------------------------

To install this site on Debian/Ubuntu with nginx, decrypt the SSL private key:

```
gpg < kath.io.key.asc > kath.io.key
sudo chgrp www-data kath.io.key
chmod 640 kath.io.key
```

Generate the static HTML: `./site.hs rebuild`.

Create a symlink to `nginx_server.conf` in `/etc/nginx/conf.d`.  
Create a symlink to `nginx_site.conf` in `/etc/nginx/sites-enabled`.
