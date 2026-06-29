class_name GameManager
extends Node

const LEVEL_PATH_DIR = "res://scenes/chambers/"
const SAVE_FILE_PATH = "user://NOTtheGameSaveFile.res"

var controller: GameController
var order: GameOrder

var save_file: UserSaveFile

func _ready():
	order = load("res://data/game_info.tres")
	if FileAccess.file_exists(SAVE_FILE_PATH):
		save_file = ResourceLoader.load(SAVE_FILE_PATH)
		print("Save file random number: ", save_file.random_number)
	else:
		save_file = UserSaveFile.new()
		save_file.random_number = randi_range(1, 9_999_999)

func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST && save_file != null:
		print("SAVING...")
		ResourceSaver.save(save_file, SAVE_FILE_PATH)
