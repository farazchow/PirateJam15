extends Resource

class_name Effect

@export var name: String
@export var stacks: int
@export var pre_turn: bool = false
@export var post_turn: bool = false
@export var persistent: bool = false

func _init(_stacks: int):
	stacks = _stacks

func apply_effect(_target: CharacterData):
# Meant to be overwritten by inheritors
	pass

func change_stacks(_stacks: int):
	stacks = _stacks
