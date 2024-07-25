extends Resource

class_name CharacterData

@export_category("Stats")
@export var initial_health: int:
	get:
		return initial_health
	set(value):
		assert(initial_health >= 0)
		initial_health = value
@export var health: int
@export var attack: int = 0
@export var armor: int = 0
@export var speed: int = 0
@export var level: int = 1
var evasion: int = 0

@export_category("Equipment")
@export var back_leg: EquipmentData:
	get:
		return back_leg
	set(value):
		assert(value.equipment_slot == 0)
		back_leg = value
@export var front_leg: EquipmentData:
	get:
		return front_leg
	set(value):
		assert(value.equipment_slot == 0)
		front_leg = value
@export var head: EquipmentData:
	get:
		return head
	set(value):
		assert(value.equipment_slot == 1)
		head = value
@export var body: EquipmentData:
	get:
		return body
	set(value):
		assert(value.equipment_slot == 2)
		body = value
@export var tail: EquipmentData:
	get:
		return tail
	set(value):
		assert(value.equipment_slot == 3)
		tail = value

@export var texture: Texture
@export var name: String

func _init(p_health = 20, p_texture = null, p_name = ""):
	initial_health = p_health
	health = p_health
	texture = p_texture
	name = p_name
