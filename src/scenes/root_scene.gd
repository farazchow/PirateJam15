extends Node

var currentChimera : CharacterData
var allChimeras : Dictionary

var scene : Node2D
var ui : Control

var _nextScene : Node2D
var _nextUI : Control
var firstScene = preload("res://prefabs/potion_scene.tscn").instantiate()
var firstUI = preload("res://prefabs/RunesBook.tscn").instantiate()

# Called when the node enters the scene tree for the first time.
func _ready():
	regenerateFresh()
	scene.add_child(firstScene)
	ui.add_child(firstUI)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func startBattleScene():
	# 
	
	pass

func regenerateFresh():
	scene = Node2D.new()
	ui = Control.new()
	add_child(scene)
	add_child(ui)
	
func transitionScene(nextScene: String):
	# play pre-transition
	scene.queue_free()
	ui.queue_free()

	regenerateFresh()
	# play post-transition	
	pass

