extends Resource

class_name Effect

@export var name: String
@export var stacks: int

var target

func _init(_target, _name, _stacks):
	target = _target
	name = _name
	stacks = _stacks

func apply_effect():
# Meant to be overwritten by inheritors
	pass
