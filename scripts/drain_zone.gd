extends Area2D

signal ball_drained

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body is RigidBody2D:
		ball_drained.emit()
