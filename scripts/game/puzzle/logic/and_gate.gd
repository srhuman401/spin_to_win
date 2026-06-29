class_name PuzzleLogicANDGate
extends PuzzleLogicGate

@export_category("AND Gate")
@export var required_to_pass: int = 2
@export var permanent_trigger: bool = false
## requires Permanent Trigger enabled
@export var buttons_to_lock: Array[PuzzleLogicButton] = []
## this is stupid; array of buttons that must not be active for the AND gate to pass
## basically a AND NOT
@export var buttons_that_cannot_be_active: Array[PuzzleLogicButton] = []

var current_signals: int = 0

func cannot_pass():
	for btn in buttons_that_cannot_be_active:
		if btn.is_activated: return true

func activate():
	if is_activated: return
	
	current_signals += 1
	if current_signals >= required_to_pass && !cannot_pass():
		activate_connections()
		if permanent_trigger:
			for button in buttons_to_lock:
				if button.is_activated: button.button_locked = true

func deactivate():
	current_signals -= 1
	
	if is_activated && current_signals < required_to_pass && !permanent_trigger:
		deactivate_connections()
		if permanent_trigger:
			for button in buttons_to_lock:
				if button.is_activated && button.button_locked:
					button.button_locked = false
