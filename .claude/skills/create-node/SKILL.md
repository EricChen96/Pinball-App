---
name: create-node
description: Create a collidable game node in the Pinball App scene using the standard path-based template. Use when the user wants to add a bumper, wall, obstacle, flipper, or any physics object to the pinball table. Triggers on "add a node", "create a bumper", "place an obstacle", "new wall", "add a shape", or any request to put a new collidable object in the scene.
---

# Create Node from Template

Construct a collidable game node in the Pinball App main scene using the standard 5-node hierarchy.

## Arguments

Parse from the user's message. Ask for any missing required values.

| Arg | Required | Default | Description |
|---|---|---|---|
| name | yes | — | Node name, e.g. "Bumper1", "Right Wall" |
| position | yes | — | x, y coordinates on the table |
| polygon | no | — | Custom polygon points. If omitted, use the EllipsesPath default (see below). Do NOT infer shape from the node name. |
| scale | no | 1, 1 | Scale of the root Node2D |
| script | no | none | Path to a .gd script to attach to the root node (e.g. "scripts/flipper.gd") |
| parent | no | root | Parent node path in the scene |

## Project Constants

- **Project path:** `/Users/ericchen/Documents/Pinball App`
- **Scene path:** `scenes/main.tscn`
- **SVS script:** `addons/curved_lines_2d/scalable_vector_shape_2d.gd`

## Default Polygon (EllipsesPath template)

If no custom polygon is provided, use this 64-point circle (radius 50) for both CollisionPolygon2D and Fill:

```
PackedVector2Array(50, 0, 49.74186, 5.112335, 48.98421, 10.07696, 47.75216, 14.86875, 46.07086, 19.46258, 43.96542, 23.83331, 41.46099, 27.95581, 38.58268, 31.80496, 35.35563, 35.35563, 31.80496, 38.58268, 27.95581, 41.46099, 23.83331, 43.96542, 19.46258, 46.07086, 14.86875, 47.75217, 10.07696, 48.98421, 5.112335, 49.74186, 0, 50, -5.112335, 49.74186, -10.07696, 48.98421, -14.86875, 47.75216, -19.46258, 46.07086, -23.83331, 43.96542, -27.95581, 41.46099, -31.80496, 38.58268, -35.35563, 35.35563, -38.58268, 31.80496, -41.46099, 27.95581, -43.96542, 23.83331, -46.07086, 19.46258, -47.75217, 14.86875, -48.98421, 10.07696, -49.74186, 5.112335, -50, 0, -49.74186, -5.112335, -48.98421, -10.07696, -47.75216, -14.86875, -46.07086, -19.46258, -43.96542, -23.83331, -41.46099, -27.95581, -38.58268, -31.80496, -35.35563, -35.35563, -31.80496, -38.58268, -27.95581, -41.46099, -23.83331, -43.96542, -19.46258, -46.07086, -14.86875, -47.75217, -10.07696, -48.98421, -5.112335, -49.74186, 0, -50, 5.112335, -49.74186, 10.07696, -48.98421, 14.86875, -47.75216, 19.46258, -46.07086, 23.83331, -43.96542, 27.95581, -41.46099, 31.80496, -38.58268, 35.35563, -35.35563, 38.58268, -31.80496, 41.46099, -27.95581, 43.96542, -23.83331, 46.07086, -19.46258, 47.75217, -14.86875, 48.98421, -10.07696, 49.74186, -5.112335)
```

## Construction Sequence

Execute these steps in order. Each step depends on the previous node existing.

### Step 1 — Root Node2D

```
mcp__godot__add_node:
  projectPath: /Users/ericchen/Documents/Pinball App
  scenePath: scenes/main.tscn
  nodeType: Node2D
  nodeName: {name}
  parentNodePath: {parent}
  properties:
    position: Vector2({x}, {y})
    scale: Vector2({scale_x}, {scale_y})
```

If a script was specified, attach it:

```
mcp__godot__attach_script:
  projectPath: /Users/ericchen/Documents/Pinball App
  scenePath: scenes/main.tscn
  nodePath: {parent}/{name}
  scriptPath: {script}
```

### Step 2 — AnimatableBody2D

```
mcp__godot__add_node:
  nodeType: AnimatableBody2D
  nodeName: AnimatableBody2D
  parentNodePath: {parent}/{name}
```

### Step 3 — CollisionPolygon2D

Add node first, then set polygon via modify (add_node does not reliably apply polygon data):

```
mcp__godot__add_node:
  nodeType: CollisionPolygon2D
  nodeName: CollisionPolygon2D
  parentNodePath: {parent}/{name}/AnimatableBody2D
```

```
mcp__godot__modify_scene_node:
  nodePath: {parent}/{name}/AnimatableBody2D/CollisionPolygon2D
  properties:
    polygon: {polygon_data}
```

### Step 4 — Inner visual Node2D (SVS)

The inner visual node shares the same name as the root node:

```
mcp__godot__add_node:
  nodeType: Node2D
  nodeName: {name}
  parentNodePath: {parent}/{name}/AnimatableBody2D
```

Attach the SVS addon script:

```
mcp__godot__attach_script:
  nodePath: {parent}/{name}/AnimatableBody2D/{name}
  scriptPath: addons/curved_lines_2d/scalable_vector_shape_2d.gd
```

Set SVS properties to match the EllipsesPath template:

```
mcp__godot__modify_scene_node:
  nodePath: {parent}/{name}/AnimatableBody2D/{name}
  properties:
    shape_type: 0
    size: Vector2(100, 100)
    stroke_color: Color(1, 1, 1, 1)
    stroke_width: 10.0
    line_joint_mode: 1
    lock_assigned_shapes: true
    polygon: NodePath("Fill")
    collision_object: NodePath("..")
    update_curve_at_runtime: true
```

### Step 5 — Fill Polygon2D

Add node first, then set polygon via modify:

```
mcp__godot__add_node:
  nodeType: Polygon2D
  nodeName: Fill
  parentNodePath: {parent}/{name}/AnimatableBody2D/{name}
  properties:
    color: Color(1, 1, 1, 1)
```

```
mcp__godot__modify_scene_node:
  nodePath: {parent}/{name}/AnimatableBody2D/{name}/Fill
  properties:
    polygon: {polygon_data}
```

## After Construction

Tell the user:
- The node "{name}" was created at position ({x}, {y})
- They may need to reload the scene in Godot (Scene → Reload Saved Scene) to see it
- The shape can be adjusted by selecting the inner "{name}" SVS node and tweaking `size`, `rx`, `ry` in the Inspector
