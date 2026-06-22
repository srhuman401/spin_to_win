extends PuzzleLogicNode
class_name PuzzleLogicDoor

@export_category("Door")
@export var start_open: bool = false

@export_category("Configuration")
@export var collider: StaticBody2D
@export var collision_shape: CollisionShape2D
@export var sprite: Sprite2D

func activate():
	#collision_shape.set_deferred("disabled", start_open)
	collision_shape.set_deferred("disabled", !start_open)
	sprite.visible = start_open

func deactivate():
	#collision_shape.set_deferred("disabled", !start_open)
	collision_shape.set_deferred("disabled", start_open)
	sprite.visible = !start_open

func _ready():
	deactivate()
