extends Node2D

@export var character_data: CharacterData
@onready var sprite: Sprite2D = $Sprite2D

func _ready():
	if character_data:
		sprite.texture = character_data.texture
		print(character_data.health)
