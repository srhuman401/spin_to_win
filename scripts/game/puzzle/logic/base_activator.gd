class_name PuzzleLogicActivator
extends Node2D

signal activated

var is_activated: bool = false:
	set(v):
		is_activated = v
		activated.emit()

@export_category("Activator Config")
@export var connections: Array[PuzzleLogicNode] = []

func activate_connections():
	if is_activated: return
	is_activated = true
	
	for conn in connections:
		conn.activate()

func deactivate_connections():
	if !is_activated: return
	is_activated = false
	
	for conn in connections:
		conn.deactivate()
