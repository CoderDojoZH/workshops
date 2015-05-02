import pyglet
import cocos
from object import Object

class Enemy(Object):
    def __init__(self):
        self._image = None
        self._pos = (0, 0)

    def init(self):
        self._image = pyglet.resource.image('units_blue.png')

    def draw(self):
        self._image.get_region(0, 224 - 32, 32, 32).blit(0, 0, width = 32, height = 32)

    def update(self, ft):
        pass
