extends Node2D

@export var is_left: bool = true
@export var flip_speed: float = 15.0
@export var rest_angle: float = 30.0
@export var flip_angle: float = -30.0

var _current_angle: float = 0.0
var _target_angle: float = 0.0

@onready var body: AnimatableBody2D = $AnimatableBody2D


func _physics_process(delta: float) -> void:
	var action = "flip_left" if is_left else "flip_right"
	if Input.is_action_pressed(action):
		_target_angle = flip_angle
	else:
		_target_angle = rest_angle

	_current_angle = lerp(_current_angle, _target_angle, flip_speed * delta)
	body.rotation = deg_to_rad(_current_angle)
