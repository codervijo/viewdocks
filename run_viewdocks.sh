#!/bin/bash
apt-get install -y python3-pip
python3 -m pip install --upgrade pip setuptools virtualenv
python3 -m virtualenv kvenv
source kvenv/bin/activate
python3 -m pip install kivy[full]
python3 -m pip install kivy-examples
python3 src/main.py

