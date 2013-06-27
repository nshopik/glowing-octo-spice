Local generated private key
===========================
pem file with private key stays at /etc/ssl/private/some_key.pem

downloaded files
----------------
* sub.domain.tld.crt file - public goes to /etc/ssl/certs
* gd_bundle.rt - /etc/ssl/certs

### installation
```
cat sub.domain.tld.crt gd_bundle.rt > chain-domain.tld.crt
cp chain-domain.tld.crt /etc/ssl/certs
```

