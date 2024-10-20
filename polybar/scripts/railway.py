#!/usr/bin/python3
# -*- coding: utf-8 -*-

import os
import time
import random
from threading import Event, Thread
from pynput import keyboard
from pathlib import Path

FPS = 30
DELAY = 1.0 / FPS

WIDTH = 16
PLAYER_POS = 3

MAX_SPEED = 1
FRICTION_CONST = 0.8

PLAYER_CHAR = '🚀'
RAIL_CHAR = '. '
FIRE_CHAR = '🎆'
CACTUS_CHAR = '✨'

world = [RAIL_CHAR] * WIDTH
foreground = [RAIL_CHAR] * WIDTH
background = [None] * WIDTH

velocity = 0.0
total_km = 0.0
c = 0

new_press = Event()
pressed = False

debug_text = None
data_file = Path(os.environ.get("XDG_DATA_HOME", Path.home() / ".local/share")) / "game_data.txt"

def load_km():
    try:
        with open(data_file, "r") as file:
            return float(file.read().strip())
    except (FileNotFoundError, ValueError):
        return 0.0

def save_km(km):
    data_file.parent.mkdir(parents=True, exist_ok=True)
    with open(data_file, "w") as file:
        file.write(f"{km:.2f}")

def render():
    print(f"Total km: {total_km:.2f} ", end="")

    global c
    local_world = [x for x in foreground]
    local_world[PLAYER_POS] = PLAYER_CHAR
    if velocity > 0.9:
        local_world[PLAYER_POS-1] = FIRE_CHAR
        if c % 3 == 0 or c % 2 == 0:
            local_world[PLAYER_POS-2] = FIRE_CHAR
        c += 1

    print(''.join(local_world[:-1]))
    if debug_text: print(f"DEBUG: {debug_text}")

def on_release(key):
    global pressed
    new_press.set()
    pressed = True

def run():
    global velocity, total_km, pressed

    ax = 0.0
    counter = 0.0
    total_km = load_km()

    listener = Thread(target=lambda: keyboard.Listener(on_release=on_release).start())
    listener.daemon = True
    listener.start()

    render()

    while True:
        n_evts = 0

        if pressed:
            n_evts += 1
            pressed = False
        elif n_evts > 0:
            n_evts -= 1

        if n_evts > 0:
            ax += 0.02
        elif velocity > 0:
            ax -= 0.005
        elif velocity <= 0:
            ax = 0
            velocity = 0

        velocity += ax - velocity * FRICTION_CONST
        velocity = min(velocity, MAX_SPEED)

        if velocity == 0:
            new_press.wait(DELAY)
            new_press.clear()
            continue

        counter += velocity

        if counter >= 1:
            foreground.pop(0)
            if random.randint(0, 5) ==  1:
                foreground.append(CACTUS_CHAR)
            else:
                foreground.append(RAIL_CHAR)

            counter -= 1
            total_km += 0.01
            save_km(total_km)

        render()
        time.sleep(max(0, DELAY - (time.time() % DELAY)))

if __name__ == "__main__":
    run()
