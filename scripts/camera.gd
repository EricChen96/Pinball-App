extends Camera2D

enum Mode { FIXED, TRACKING }

@export var mode: Mode = Mode.FIXED
@export var track_target: NodePath
@export var track_speed: float = 5.0
@export var fixed_position: Vector2 = Vector2.ZERO

var _target: Node2D

func _ready() -> void:
	if track_target:
		_target = get_node(track_target)
	_apply_mode()

func _physics_process(delta: float) -> void:
	if mode == Mode.TRACKING and _target:
		global_position = global_position.lerp(_target.global_position, track_speed * delta)

func set_mode(new_mode: Mode) -> void:
	mode = new_mode
	_apply_mode()

func _apply_mode() -> void:
	if mode == Mode.FIXED:
		global_position = fixed_position
