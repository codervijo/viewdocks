from kivy.app import App
from kivy.uix.floatlayout import FloatLayout
from kivy.factory import Factory
from kivy.properties import ObjectProperty
from kivy.properties import DictProperty
from kivy.uix.popup import Popup

import os
import pdb

class CalcRuntime:
    def __init__(self):
        self.text = "Start Typing..."
        self.typed = False

    def clear(self):
        print("Clearing values")
        self.text = ""

    def get_text(self):
        return self.text

    def set_val(self, val):
        print("Got value", val)
        if self.typed is False:
            self.text = ""
        self.typed = True
        self.text += val

class Root(FloatLayout):
    #def __init__(self):
    #    self.rt = CalcRuntime()
    rt = CalcRuntime()

    def dismiss_popup(self):
        self._popup.dismiss()

    def exit(self):
        os._exit(1)

    def get_text(self):
        #pdb.set_trace()
        return self.rt.get_text()

    def clear_values(self):
        self.rt.clear()

    def print_value(*args):
        print(args[0])
        print(args[1])

    def pressed_value(self, *args):
        self.rt.set_val(args[0])
        #pdb.set_trace()
        self.ids.show_eq.text = self.rt.get_text()

class Calc(App):
    def print_val(self, *args):
        print('jaja')


Factory.register('Root', cls=Root)

if __name__ == '__main__':
    Calc().run()
