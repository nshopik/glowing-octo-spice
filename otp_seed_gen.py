#!/usr/bin/env python

user = raw_input('Username: ')
rand = open('/dev/urandom')
salt = rand.read(8).encode('hex')
secret = rand.read(16).encode('hex')
print 'HOTP/T30/6 %s %s' % (user, secret)
