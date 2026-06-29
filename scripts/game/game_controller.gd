class_name GameController
extends Node2D

signal progress_to_next_level

const MAX_ROTATION_SPEED: float = 5

@export var sun_scene: PackedScene
@export var chamber_spawn: Marker2D
@export var intro_cutscene: CutscenePlayer
@export var gui: CanvasLayer

var current_chamber_path: String = "none"
var current_chamber: PuzzleChamber
var current_sun: PuzzleSun
var current_rotation_speed: float = 0.0

func cleanup_current_chamber():
	current_rotation_speed = 0
	
	if current_chamber:
		current_chamber.queue_free()
		current_chamber = null
	
	if current_sun:
		current_sun.queue_free()
		current_sun = null

func load_chamber(scene_path: String):
	var scene_load = load(GameMgr.LEVEL_PATH_DIR + scene_path)
	if scene_load is PackedScene:
		if !scene_load.can_instantiate(): return
		
		current_chamber_path = "none"
		cleanup_current_chamber()
		var chamber: Node = scene_load.instantiate()
		add_child.call_deferred(chamber)
		current_chamber = chamber
		
		if chamber is PuzzleChamber:
			chamber.global_position = chamber_spawn.global_position
			var sun: PuzzleSun = sun_scene.instantiate()
			if !(sun is PuzzleSun): 
				cleanup_current_chamber()
				return
			add_child.call_deferred(sun)
			current_sun = sun
			
			if chamber.sun_spawn != null:
				sun.global_position = chamber.sun_spawn.global_position
			
			current_chamber_path = scene_path
			print("chamber loaded succesfully")
		else:
			cleanup_current_chamber()
			return

func rotate_chamber(speed: float = 0.0):
	#if current_rotation_speed >10: speed = 0
	current_rotation_speed = clampf(
		current_rotation_speed + speed,
		-MAX_ROTATION_SPEED,
		MAX_ROTATION_SPEED
	)

func restart_chamber():
	load_chamber(current_chamber_path)

func _ready():
	GameMgr.controller = self
	
	gui.visible = false
	
	intro_cutscene.play()
	await intro_cutscene.cutscene_ended
	
	gui.visible = true
	
	for level_path in GameMgr.order.level_paths:
		load_chamber(level_path)
		await progress_to_next_level
	
	get_tree().change_scene_to_file("res://scenes/game/ending.tscn")

func _process(delta: float) -> void:
	if Input.is_action_just_pressed('SKIP'):
		progress_to_next_level.emit()

func _physics_process(delta: float) -> void:
	if current_chamber && current_chamber.rotating_root:
		current_chamber.rotating_root.rotation += current_rotation_speed * delta
		current_rotation_speed = move_toward(current_rotation_speed, 0, 10 * delta)
