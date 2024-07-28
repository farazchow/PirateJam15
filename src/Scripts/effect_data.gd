extends Resource

class_name Effect

@export var name: String
@export var stacks: int
@export var apply_first: bool = false
@export var apply_last: bool = false


func _init(_name, _stacks):
	name = _name
	stacks = _stacks

func apply_effect():
# Meant to be overwritten by inheritors
	pass
