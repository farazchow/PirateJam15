extends Resource

class_name CharacterData

@export_category("Stats")
@export var base_health: int:
	get:
		return base_health
	set(value):
		assert(value >= 0)
		base_health = value
		health = value
@export var attack: int = 1
@export var armor: int = 1
@export var speed: int = 1
@export var level: int = 1
var speed_to_evasion_ratio := .1
var evasion: int = 0
var health: int = 0
var effect_holder: Dictionary = {"Pre-turn": [], "Post-Turn": [], "Persistent": []}

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
	base_health = p_health
	health = p_health
	texture = p_texture
	name = p_name

func setup():
	health = base_health
	for equipment in [back_leg, front_leg, head, body, tail]:
		if not equipment:
			continue
		equipment.apply_equipment(self)
	evasion = speed * speed_to_evasion_ratio
