# Botscape

Botscape is a Godot 4 project experimenting with grid‑based movement, procedural
terrain generation, and basic resource interaction. It serves as a playground
for building RTS‑style mechanics in a small, extensible codebase.

## Project Goals

- Demonstrate a simple grid and tile system driven by GDScript.
- Explore A* pathfinding and camera controls common in strategy games.
- Provide a foundation for experimenting with harvesting and other interactions.

## Setup

1. **Install Godot 4.2 or later.** The project was built with Godot 4.2.1.
2. **Clone this repository** and open it in Godot using `project.godot`.
3. **Run the project** from the Godot editor to generate the terrain and spawn the player.

## Basic Usage

- Rotate the camera with the left and right arrow keys. Zoom with the up/down
  keys or the mouse wheel.
- Left‑click on the terrain to move the player to that tile using pathfinding.
- Click on objects such as trees to move to the nearest tile and trigger the
  interaction (e.g., cutting down the tree).

These controls and mechanics provide a starting point for extending Botscape
into a richer strategy or simulation experience.

