python3 -m pip install --upgrade pip setuptools virtualenv
python3 -m virtualenv kvenv
source kvenv/bin/activate
python3 -m pip install kivy[full]
python3 -m pip install kivy-examples
python3 kvenv/share/kivy-examples/demo/showcase/main.py 

