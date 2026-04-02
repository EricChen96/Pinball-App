extends StaticBody2D

@export var bounce_force: float = 600.0
@export var points: int = 100

@onready var game_manager: Node = get_node("/root/GameManager")

func _ready() -> void:
	var area = $Area2D
	area.body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body is RigidBody2D:
		var direction = (body.global_position - global_position).normalized()
		body.apply_central_impulse(direction * bounce_force)
		game_manager.add_score(points)
		_flash()

func _flash() -> void:
	modulate = Color(2, 2, 2)
	var tween = create_tween()
	tween.tween_property(self, "modulate", Color.WHITE, 0.15)
