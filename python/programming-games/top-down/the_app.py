import pyglet
from pyglet.window import key
import cocos
from cocos.director import director
import math

from background import Background
from enemy import Enemy
from player import Player

class TheApp(cocos.layer.Layer):
    # If you want that your layer receives events
    # you must set this variable to 'True',
    # otherwise it won't receive any event.
    is_event_handler = True

    def __init__(self):
        super(TheApp, self).__init__()

        self.image = pyglet.resource.image('terrain_4.png')
        self._background = Background()
        self._objects = []
        enemy = Enemy()
        self._objects.append(enemy)
        self._player = Player()
        self._objects.append(self._player)
        # call the "step" method every frame when the layer is active
        self.schedule(self.step)

    def on_enter(self):
        super(TheApp, self).on_enter()
        self._background.init()
        for ob in self._objects:
            ob.init()

    def draw(self):
        super(TheApp, self).draw()
        self._background.draw()
        for ob in self._objects:
            ob.draw()

    def step(self, dt):
        for ob in self._objects:
            ob.update(dt)

    def on_key_press(self, symbol, modifiers):
        if symbol == key.RIGHT:
            self._player.setXVelocity(10)
        if symbol == key.LEFT:
            self._player.setXVelocity(-10)

    def on_key_release(self, key, modifiers):
        self._player.setXVelocity(0)


if __name__ == '__main__':
    director.init()
    # enable depth test
    director.set_depth_test()
    s = cocos.scene.Scene()
    s.add(TheApp())
    director.run(s)
