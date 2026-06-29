@tool
extends PuzzleLogicNode
class_name PuzzleLogicDoor

@export_category("Door")
@export var start_open: bool = false
@export var color: Color = Color.DIM_GRAY:
	set(v):
		color = v
		reload_color()

@export_category("Configuration")
@export var collider: StaticBody2D
@export var collision_shape: CollisionShape2D
@export var sprite: Sprite2D

func reload_color():
	if sprite:
		sprite.self_modulate = color

func activate():
	#collision_shape.set_deferred("disabled", start_open)
	collision_shape.set_deferred("disabled", !start_open)
	sprite.visible = start_open

func deactivate():
	#collision_shape.set_deferred("disabled", !start_open)
	collision_shape.set_deferred("disabled", start_open)
	sprite.visible = !start_open

func _ready():
	reload_color()
	deactivate()
