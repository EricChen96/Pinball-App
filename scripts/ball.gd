extends RigidBody2D

@export var max_speed: float = 1500.0

func _ready() -> void:
	contact_monitor = true
	max_contacts_reported = 4

func _physics_process(_delta: float) -> void:
	if linear_velocity.length() > max_speed:
		linear_velocity = linear_velocity.normalized() * max_speed
