@icon("res://kenney/PNG/Green/Default/icon_circle.png")
class_name Poison 
extends "res://Scripts/effect_data.gd"

func _init(_stacks: int):
	super._init(_stacks)
	name = "Poison"
	pre_turn = true

func apply_effect(_target: CharacterData):
	_target.health -= stacks
	stacks = stacks - 1
