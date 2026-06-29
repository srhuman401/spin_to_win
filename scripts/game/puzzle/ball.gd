@tool
class_name PuzzlePhysicsBall
extends RigidBody2D

@export_category("Ball")
@export var id: String = "noIdSet"
@export var color: Color = Color.GRAY:
	set(v):
		color = v
		reload_color_if_editor()

@export_category("Configuration")
@export var sprite: Sprite2D
@export var collider: CollisionShape2D

func reload_color():
	if sprite and id != "sun":
		sprite.self_modulate = color

func reload_color_if_editor():
	if Engine.is_editor_hint():
		reload_color()

func _ready():
	reload_color()
