class_name CutscenePlayer
extends Node2D

@export var cutscene_to_play: CutsceneData
@export var dialog_box: Label

var current_visual: Node
var playing: bool = false
var clicked: bool = false

signal next_frame
signal cutscene_ended

func _ready():
	dialog_box.visible = false
	
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton && playing :
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed && !clicked:
				next_frame.emit()
				clicked = true
			if !event.pressed && clicked:
				clicked = false

func play():
	assert(cutscene_to_play)
	assert(dialog_box)
	
	if playing: return
	playing = true
	
	for frame in cutscene_to_play.frames:
		if frame.text != "":
			dialog_box.text = frame.text
			dialog_box.visible = true
		else:
			dialog_box.visible = false
		
		if frame.visual != null:
			current_visual = frame.visual.instantiate()
			add_child(current_visual)
		
		await next_frame
		if current_visual: current_visual.queue_free()
	playing = false
	cutscene_ended.emit()
