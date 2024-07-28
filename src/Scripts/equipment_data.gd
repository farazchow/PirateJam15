extends Resource

class_name EquipmentData

enum EquipmentSlot {LEG, HEAD, BODY, TAIL}

@export_category("General Data")
@export var equipment_slot: EquipmentSlot
@export var name: String

@export_category("Stats")
@export var health: int
@export var speed: int
@export var armor: int
@export var attack: int
@export var effect: Effect

func apply_equipment(target: CharacterData):
	target.speed += speed
	target.health += health
	target.armor += armor
	target.attack += attack
	
	if not effect:
		return
	if effect.apply_first:
		target.effect_holder["Pre-turn"].append(effect)
	elif effect.apply_last:
		target.effect_holder["Post-turn"].append(effect)
	else:
		target.effect_holder["Persistent"].append(effect)
