import pygame
from pygame.locals import *
from system_event import SystemEvent
from background import Background
from enemy import Enemy
from player import Player


class TheApp(SystemEvent):
    def __init__(self):
        self._running = True
        self._display_surf = None
        self._background = Background()
        self._timer = 0
        self._font = None
        self._clock = pygame.time.Clock()
        self._player = None
        self._objects = []

    def on_init(self):
        pygame.init()
        self._display_surf = pygame.display.set_mode((640, 480))
        self._font = pygame.font.Font(None, 24)
        self._background.init()
        self._running = True
        en = Enemy()
        en.init()
        self._objects.append(en)
        self._player = Player()
        self._player.init()
        self._objects.append(self._player)

    def update(self, ft):
        self._background.update(ft)

    def render(self):
        self._background.render(self._display_surf)
        for en in self._objects:
            en.render(self._display_surf)

    def on_exit(self):
        self._running = False

    def on_cleanup(self):
        pygame.quit()

    def on_execute(self):
        if self.on_init() == False:
            self._running = False
        self._timer = pygame.time.get_ticks()

        while( self._running ):
            # Get frame time
            ft = 1
            if self._clock.get_fps() != 0:
                ft = 1 / self._clock.get_fps()

            # Event loop
            for event in pygame.event.get():
                self.on_event(event)
            # Update / render
            self.update(ft)
            self.render()
            # Show FPS
            text_fps = 'FPS: %f' % self._clock.get_fps()
            surf_fps = self._font.render(text_fps, True, (255, 255, 255))
            self._display_surf.blit(surf_fps, (0, 0))
            # Flip screen
            pygame.display.flip()
            # Don't limit FPS, there is a problem when setting a fixed value
            self._clock.tick()

        self.on_cleanup()

    def on_key_down(self, event):
        if event.key == K_DOWN:
            self._player.setDirection(0)
        if event.key == K_RIGHT:
            self._player.setDirection(1)
        if event.key == K_UP:
            self._player.setDirection(2)
        if event.key == K_LEFT:
            self._player.setDirection(3)
