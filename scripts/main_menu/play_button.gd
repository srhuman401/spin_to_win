extends Button

func _on_self_pressed():
	get_tree().change_scene_to_file("res://scenes/game/main_game.tscn")

func _ready():
	pressed.connect(_on_self_pressed)
