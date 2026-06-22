extends Area2D
class_name PuzzleExit

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D):
	if body is PuzzleSun:
		set_deferred("monitoring", false)
		GameMgr.controller.load_chamber(GameMgr.controller.current_chamber_path)
