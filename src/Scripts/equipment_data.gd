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
#@export var effect: Effect
