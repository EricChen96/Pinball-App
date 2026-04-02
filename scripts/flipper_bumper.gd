extends AnimatableBody2D

# Flipper that uses AnimatableBody2D for proper physics interaction

@export var is_left: bool = true
@export var flip_speed: float = 12.0
@export var rest_angle_deg: float = 25.0
@export var flip_angle_deg: float = -25.0

var _current_angle: float = 0.0
var _target_angle: float = 0.0

func _ready() -> void:
	_current_angle = rest_angle_deg if is_left else -rest_angle_deg
	rotation = deg_to_rad(_current_angle)

func _physics_process(delta: float) -> void:
	var action = "flip_left" if is_left else "flip_right"
	if Input.is_action_pressed(action):
		_target_angle = flip_angle_deg if is_left else -flip_angle_deg
	else:
		_target_angle = rest_angle_deg if is_left else -rest_angle_deg

	var prev_angle = _current_angle
	_current_angle = lerp(_current_angle, _target_angle, flip_speed * delta)
	rotation = deg_to_rad(_current_angle)
