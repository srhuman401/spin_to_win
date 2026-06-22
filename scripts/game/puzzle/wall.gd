@tool
class_name Wall
extends StaticBody2D

@export_category("Wall Generation")
@export var wall_width: float = 25:
	set(v):
		wall_width = v
		regenerate_wall()
@export var wall_height: float = 45:
	set(v):
		wall_height = v
		regenerate_wall()
@export var wall_color: Color = Color.WHITE:
	set(v):
		wall_color = v
		regenerate_wall()

@export_category("Attributes")
@export var bouncy: bool = false

@export_category("Config")
@export var collider: CollisionShape2D
@export var sprite: Sprite2D

func regenerate_wall():
	assert(collider)
	assert(sprite)
	#print("regenerate wall...")
	if sprite.texture == null: return
	
	var shape: Shape2D = collider.shape
	if shape is RectangleShape2D:
		#collider.shape = collider.shape.duplicate()
		#print('setting collision shape size')
		shape.size = Vector2(wall_width, wall_height)
	
	var sprite_size := sprite.texture.get_size()
	sprite.scale = Vector2(
		wall_width / float(sprite_size.x),
		wall_height / float(sprite_size.y)
	)
	sprite.self_modulate = wall_color

func _ready() -> void:
	if !Engine.is_editor_hint():
		return
	
	regenerate_wall()
