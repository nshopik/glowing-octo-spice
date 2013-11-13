#!/usr/bin/env python

import xml.etree.ElementTree as ET
tree = ET.parse('dump.xml')
root = tree.getroot()
print root.attrib["updateTime"]
