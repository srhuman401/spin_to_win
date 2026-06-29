class_name PuzzleAutomateConnectionsToLogicActivator
extends Node

@export var group_name: String = "Group name"
@export var target: PuzzleLogicActivator

func _ready():
	target.connections.assign(get_tree().get_nodes_in_group(group_name))
