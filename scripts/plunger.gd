extends Node2D

@export var max_force: float = 3000.0
@export var charge_speed: float = 2.0

var charge: float = 0.0
var is_charging: bool = false
var ball: RigidBody2D = null

@onready var spawn_marker: Marker2D = $SpawnPosition

func _process(delta: float) -> void:
	if Input.is_action_pressed("launch"):
		is_charging = true
		charge = min(charge + charge_speed * delta, 1.0)
	elif is_charging:
		is_charging = false
		_launch()
		charge = 0.0

func _launch() -> void:
	if ball and not ball.freeze:
		return
	if ball:
		ball.freeze = false
		ball.linear_velocity = Vector2.ZERO
		ball.apply_central_impulse(Vector2.UP * max_force * charge)

func set_ball(b: RigidBody2D) -> void:
	ball = b
	ball.global_position = spawn_marker.global_position
	ball.linear_velocity = Vector2.ZERO
	ball.freeze = true
