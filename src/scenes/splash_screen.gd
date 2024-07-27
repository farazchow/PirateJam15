extends Node2D

var time = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	time = time + 1
	
	if (time > 120):
		get_tree().change_scene_to_file("res://scenes/root_scene.tscn")
	
	
