extends Node2D

@onready var game_manager: Node = get_node("/root/GameManager")
@onready var ball: RigidBody2D = $Ball
@onready var plunger: Node2D = $Plunger
@onready var drain_zone: Area2D = $Table/DrainZone
@onready var camera: Camera2D = $Camera2D
@onready var ui: CanvasLayer = $UI

var ball_scene: PackedScene

func _ready() -> void:
	game_manager.reset_game()
	game_manager.game_over.connect(_on_game_over)

func _on_ball_drained() -> void:
	game_manager.ball_drained()
	if not game_manager.is_game_over:
		await get_tree().create_timer(1.0).timeout
		_respawn_ball()

func _respawn_ball() -> void:
	ball.linear_velocity = Vector2.ZERO
	ball.angular_velocity = 0.0
	plunger.set_ball(ball)

func _on_game_over() -> void:
	await get_tree().create_timer(1.5).timeout
	ui.show_game_over()

#func _physics_process(_delta: float) -> void:
	#if ball and not ball.freeze:
		#camera.global_position.y = lerp(camera.global_position.y, ball.global_position.y, 0.05)
		#camera.global_position.y = clamp(camera.global_position.y, 200.0, 1800.0)
