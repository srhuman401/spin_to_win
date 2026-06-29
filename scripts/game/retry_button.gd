class_name RetryButton
extends Button

@export var controller: GameController

func _ready():
	assert(controller, "Controller not set!")
	pressed.connect(_on_self_pressed)

func _on_self_pressed():
	controller.restart_chamber()
