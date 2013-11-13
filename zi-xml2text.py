#!/usr/bin/env python

from xml.dom.minidom import *

xml = parse('dump.xml')
name = xml.getElementsByTagName('ip')

for node in name:
  print node.childNodes[0].nodeValue
