#!/usr/bin/env python

import sys
import os
import argparse
from glob import glob


parser = argparse.ArgumentParser()
parser.add_argument("inputfile", nargs='+', help="input file file the computation")
parser.add_argument('--foo', nargs=1, help='foo help')
parser.add_argument('--bar', action="store_true", default=False, help='bar help')
args = parser.parse_args()

print(args)
