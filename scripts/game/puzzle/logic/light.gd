class_name PuzzleLogicLight
extends PuzzleLogicNode

@export_category("Light")
@export var on_color: Color = Color.GREEN
@export var off_color: Color = Color.RED

@export_category("Light Config")
@export var sprite: Sprite2D

func _ready():
	sprite.self_modulate = off_color

func activate():
	assert(sprite, "Sprite not set!")
	sprite.self_modulate = on_color

func deactivate():
	sprite.self_modulate = off_color
