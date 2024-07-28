extends Node2D

@onready var ChimeraHPLabel := $"Chimera HP"
@onready var EnemyHPLabel := $"Enemy HP"

@onready var demo_chimera_resource := preload("res://resources/demo_chimera.tres")
@onready var demo_enemy_resource := preload("res://resources/demo_enemy.tres")
@onready var character_scene := preload("res://scenes/chimera.tscn")

var chimera
var enemy

var round_counter: int = 0
var chimera_initiative: int = 0
var enemy_initiative: int = 0

func _ready():
	chimera = character_scene.instantiate()
	chimera.character_data = demo_chimera_resource
	
	enemy = character_scene.instantiate()
	enemy.character_data = demo_enemy_resource

	add_child(chimera)
	add_child(enemy)
	chimera.global_position = ChimeraHPLabel.global_position
	chimera.global_position.y -= 40
	enemy.global_position = EnemyHPLabel.global_position
	enemy.global_position.y -= 40
	ChimeraHPLabel.text = "HP: %s" % chimera.character_data.health
	EnemyHPLabel.text = "HP: %s" % enemy.character_data.health
	$RoundTimer.start()

func _on_round_timer_timeout():
	if round_counter >= 500:
		$RoundTimer.stop()
		return
	
	round_counter += 1
	chimera_initiative += chimera.character_data.speed
	enemy_initiative += enemy.character_data.speed
	if chimera_initiative >= 100:
		enemy.character_data.health -= chimera.character_data.attack
		chimera_initiative = 0
		EnemyHPLabel.text = "HP: %s" % enemy.character_data.health
		print("Chimera Attack")
	if enemy_initiative >= 100:
		chimera.character_data.health -= enemy.character_data.attack
		enemy_initiative = 0
		EnemyHPLabel.text = "HP: %s" % enemy.character_data.health
		print("Enemy Attack")
	if enemy.character_data.health <= 0 or chimera.character_data.health <= 0:
		$RoundTimer.stop()
	
	$RoundCounter.text = "Round Counter: %s" % round_counter
	print("Round %s: Chimera has %s hp. Enemy has %s hp" % [round_counter, chimera.character_data.health, enemy.character_data.health])
