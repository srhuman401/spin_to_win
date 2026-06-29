class_name PuzzleCamera2D
extends Camera2D

const PAN_MOUSE_BUTTON: MouseButton = MOUSE_BUTTON_RIGHT

var is_panning: bool = false
@export var free_camera_enabled: bool = false

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == PAN_MOUSE_BUTTON:
			is_panning = event.pressed
	
	elif event is InputEventMouseMotion && is_panning && free_camera_enabled:
		position -= event.relative / zoom.x
