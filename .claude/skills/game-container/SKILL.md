---
name: game-container
description: Create a game container node in the Pinball App scene. A game container is the border/frame that surrounds the playfield. Use when the user wants to add or recreate a game container, table border, playfield frame, or outer wall structure. Triggers on "create a container", "add a game container", "create the playfield border", or any request for a table boundary shape.
---

# Game Container Skill

Creates a bordered playfield container in the Pinball App main scene. A game container has an outer boundary and an inner play field cutout, forming a frame/border that also acts as a StaticBody2D for ball collision.

## Container Types

### Default
A clean rectangular frame — straight edges on all sides. This is the standard container.

- Outer shape: rectangle (1280×720)
- Inner play field: rectangle (1248×672) — 16px padding left/right/top, 32px padding bottom
- Visual: white outlined rectangle border

### Arch
A rectangle with a **semicircular arch at the top**. The top edge curves inward into a dome. The sides and bottom remain straight. Inspired by classic arcade cabinet shapes.

- Outer shape: rectangle base with arched/rounded top
- Inner play field: same arch shape, inset by padding
- Visual: red outlined frame with arched top

### Shield
A **pentagon / shield shape** — rectangular with two diagonal chamfers at the **bottom corners** (angled inward). The top and sides are straight; the bottom two corners are cut at an angle rather than right angles.

- Outer shape: rectangle with chamfered bottom-left and bottom-right corners
- Inner play field: matching shield shape, inset by padding
- Visual: black outlined shield/pentagon frame

---

## Project Constants

- **Project path:** `/Users/ericchen/Documents/Pinball App`
- **Scene path:** `scenes/main.tscn`
- **SVS script:** `addons/curved_lines_2d/scalable_vector_shape_2d.gd`
- **Arc list script:** `addons/curved_lines_2d/scalable_arc_list.gd`

## Default Container Dimensions

| Property | Value |
|---|---|
| Outer width | 1280 |
| Outer height | 720 |
| Inner width | 1248 (1280 − 16 − 16) |
| Inner height | 672 (720 − 16 − 32) |
| Padding left/right/top | 16 px |
| Padding bottom | 32 px |
| StaticBody2D position | Vector2(640, 360) — screen center |
| StaticBody2D scale | Vector2(1, 1) |
| Inner field offset from center | Vector2(0, −8) — shifted up 8px because top pad (16) ≠ bottom pad (32) |

## Node Hierarchy

```
Game Container          [Node2D, root]
  StaticBody2D          [StaticBody2D, physics body]
    Game Container      [Node2D + SVS script, outer frame shape]
      Fill              [Polygon2D, frame fill polygon — two loops]
      CutoutOfRectangle [Node2D + SVS script, inner cutout shape]
```

## Construction Sequence (Default)

### Step 1 — Root Node2D

```
mcp__godot__add_node:
  projectPath: /Users/ericchen/Documents/Pinball App
  scenePath: scenes/main.tscn
  nodeType: Node2D
  nodeName: Game Container
  parentNodePath: .
```

### Step 2 — StaticBody2D

```
mcp__godot__add_node:
  nodeType: StaticBody2D
  nodeName: StaticBody2D
  parentNodePath: Game Container
  properties:
    position: Vector2(640, 360)
```

### Step 3 — Outer SVS Node

Add the inner `Game Container` Node2D and attach the SVS script:

```
mcp__godot__add_node:
  nodeType: Node2D
  nodeName: Game Container
  parentNodePath: Game Container/StaticBody2D
```

```
mcp__godot__attach_script:
  nodePath: Game Container/StaticBody2D/Game Container
  scriptPath: addons/curved_lines_2d/scalable_vector_shape_2d.gd
```

Set SVS properties for the outer rectangle:

```
mcp__godot__modify_scene_node:
  nodePath: Game Container/StaticBody2D/Game Container
  properties:
    polygon: NodePath("Fill")
    collision_object: NodePath("..")
    update_curve_at_runtime: true
    shape_type: 1
    offset: Vector2(0, 0)
    size: Vector2(1280, 720)
    clip_paths: [NodePath("CutoutOfRectangle")]
```

### Step 4 — Fill Polygon2D (frame border)

The Fill polygon represents the outer frame as two mirrored L-shaped halves split at x=0.

Outer corners (half-size 640×360): (±640, ±360)
Inner corners (half inner: 624 wide, top at −344, bottom at +328): split at x=0

```
mcp__godot__add_node:
  nodeType: Polygon2D
  nodeName: Fill
  parentNodePath: Game Container/StaticBody2D/Game Container
  properties:
    color: Color(1, 1, 1, 1)
```

```
mcp__godot__modify_scene_node:
  nodePath: Game Container/StaticBody2D/Game Container/Fill
  properties:
    polygon: PackedVector2Array(0, -344, -624, -344, -624, 328, 0, 328, 0, 360, -640, 360, -640, -360, 0, -360, 640, 360, 0, 360, 0, 328, 624, 328, 624, -344, 0, -344, 0, -360, 640, -360)
    polygons: [[0, 1, 2, 3, 4, 5, 6, 7], [8, 9, 10, 11, 12, 13, 14, 15]]
```

### Step 5 — CutoutOfRectangle SVS Node

Add, attach script, and configure the inner cutout:

```
mcp__godot__add_node:
  nodeType: Node2D
  nodeName: CutoutOfRectangle
  parentNodePath: Game Container/StaticBody2D/Game Container
  properties:
    position: Vector2(0, -8)
```

```
mcp__godot__attach_script:
  nodePath: Game Container/StaticBody2D/Game Container/CutoutOfRectangle
  scriptPath: addons/curved_lines_2d/scalable_vector_shape_2d.gd
```

```
mcp__godot__modify_scene_node:
  nodePath: Game Container/StaticBody2D/Game Container/CutoutOfRectangle
  properties:
    update_curve_at_runtime: true
    shape_type: 1
    size: Vector2(1248, 672)
```

## Curve2D Sub-Resources (manual .tscn editing)

When editing the `.tscn` file directly, the Curve2D resources for the Default container are:

**Outer (1280×720, corners at ±640, ±360):**
```
_data = {
"points": PackedVector2Array(0, 0, 0, 0, -640, -360, 0, 0, 0, 0, 640, -360, 0, 0, 0, 0, 640, 360, 0, 0, 0, 0, -640, 360, 0, 0, 0, 0, -640, -360)
}
point_count = 5
```

**Inner cutout (1248×672, corners at ±624, ±336 in CutoutOfRectangle local space):**
```
_data = {
"points": PackedVector2Array(0, 0, 0, 0, -624, -336, 0, 0, 0, 0, 624, -336, 0, 0, 0, 0, 624, 336, 0, 0, 0, 0, -624, 336, 0, 0, 0, 0, -624, -336)
}
point_count = 5
```

## Padding Formula (for custom sizes)

Given outer dimensions W×H and padding (left, right, top, bottom):
- Inner width = W − left − right
- Inner height = H − top − bottom
- Inner center offset = Vector2((left − right) / 2, (top − bottom) / 2)
- Outer half = Vector2(W/2, H/2)
- Inner half = Vector2(inner_width/2, inner_height/2)

Fill polygon split-x = offset.x of outer SVS (default 0).

Left loop: (split_x, −inner_half.y − top), (−outer_half.x, −outer_half.y) ... (outer_half.x, outer_half.y) etc.
