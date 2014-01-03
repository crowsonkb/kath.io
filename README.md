kath.io
=======

Hakyll source for <https://kath.io/>.

Installation instructions
-------------------------

To install this site on Debian/Ubuntu with nginx, decrypt the SSL private key:

```
gpg < kath.io.key.asc > kath.io.key
sudo chgrp www-data kath.io.key
chmod 640 kath.io.key
```

Create a symlink to `nginx_server.conf` in `/etc/nginx/conf.d`.
Create a symlink to `nginx_site.conf` in `/etc/nginx/sites-enabled`.

Build the static HTML: `ghc --make site.hs && ./site rebuild`.
