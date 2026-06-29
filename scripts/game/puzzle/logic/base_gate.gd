@abstract class_name PuzzleLogicGate
extends PuzzleLogicNode

var is_activated: bool = false

@export_category("Gate Logic")
@export var connections: Array[PuzzleLogicNode] = []

func activate_connections():
	if is_activated: return	
	is_activated = true
	
	for conn in connections:
		assert(conn != self, "Gate cannot activate self")
		conn.activate()

func deactivate_connections():
	if !is_activated: return
	is_activated = false
	
	for conn in connections:
		assert(conn != self, "Gate cannot activate self")
		conn.deactivate()

@abstract func activate()
@abstract func deactivate()
