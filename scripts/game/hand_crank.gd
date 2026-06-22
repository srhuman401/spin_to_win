class_name HandCrank
extends TextureRect

@export var controller: GameController
@export var speed_display: Label

const SENSITIVITY = 0.02

var last_mouse_angle: float = 0.0
var crank_rotation: float = 0.0
var holding: bool = false
var last_mouse_pos: Vector2
var last_mouse_direction: Vector2
var crank_speed: float = 0.0

func get_mouse_angle() -> float:
	return (global_position + size / 2).angle_to_point(get_global_mouse_position())

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed && event.button_index == MOUSE_BUTTON_LEFT:
			holding = true
			last_mouse_angle = get_mouse_angle()
			last_mouse_pos = get_global_mouse_position()
			last_mouse_direction = Vector2.ZERO

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT && !event.pressed:
			holding = false

func _process(_delta: float) -> void:
	if holding:
		var mouse_pos = get_global_mouse_position()
		var movement = mouse_pos - last_mouse_pos
		if movement.length() > 0:
			var direction = movement.normalized()
			if last_mouse_direction != Vector2.ZERO:
				var turn = last_mouse_direction.cross(direction)
				var speed = movement.length()
				crank_speed = turn * speed * SENSITIVITY
				crank_rotation += crank_speed
				if speed_display && speed_display.visible:
					speed_display.text = str(crank_speed)
				if controller: controller.rotate_chamber(crank_speed)
			last_mouse_direction = direction
		last_mouse_pos = mouse_pos
		rotation = crank_rotation
