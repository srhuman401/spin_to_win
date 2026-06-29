@tool
class_name PuzzleLogicButton
extends PuzzleLogicActivator

@export_category("Button")
@export var button_color: Color = Color.DIM_GRAY:
	set(v):
		button_color = v
		reload_color()
@export var button_triggerable_ids: Array[String] = ["sun"]
@export var button_triggerable_by_any: bool = false
@export var button_permanent: bool = false

@export_category("Button Configuration")
@export var button_trigger: Area2D
@export var button_sprite: Sprite2D
@export var button_activ_sprite: Sprite2D
@export var button_plate_sprite: Sprite2D

var button_currently_triggered_by: Array[PuzzlePhysicsBall] = []
var button_locked: bool = false

func reload_color():
	if !button_activ_sprite: return
	if !button_sprite: return
	if !button_plate_sprite: return
	
	button_sprite.self_modulate = button_color
	button_activ_sprite.self_modulate = get_active_color()
	if is_activated:
		button_plate_sprite.position.y = 4.69
	else:
		button_plate_sprite.position.y = 0

func get_active_color() -> Color:
	return Color.GREEN if is_activated else Color.RED

func ball_qualifys(ball: PuzzlePhysicsBall) -> bool:
	return button_triggerable_by_any or button_triggerable_ids.has(ball.id)

func _ready():
	assert(button_trigger, "Button does not have button_trigger!")
	
	reload_color()
	if Engine.is_editor_hint():
		return
	
	button_trigger.body_entered.connect(_on_trigger_body_entered)
	button_trigger.body_exited.connect(_on_trigger_body_exited)
	activated.connect(func():
		reload_color()
		)

func _on_trigger_body_exited(body: Node2D):
	if button_permanent: return
	if body is PuzzlePhysicsBall:
		if button_currently_triggered_by.has(body):
			button_currently_triggered_by.erase(body)
			if button_currently_triggered_by.size() <= 0 && is_activated && !button_locked:
				deactivate_connections()

func _on_trigger_body_entered(body: Node2D):
	if body is PuzzlePhysicsBall && ball_qualifys(body):
		print('hi')
		if !button_currently_triggered_by.has(body):
			button_currently_triggered_by.append(body)
			print('active already: ', is_activated, ' size: ', button_currently_triggered_by.size())
			if button_currently_triggered_by.size() > 0 && !is_activated && !button_locked:
				print("activating")
				activate_connections()
