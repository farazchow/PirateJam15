extends Control

func _make_custom_tooltip(for_text: String):
	var tooltip = preload("res://prefabs/tooltip/hover_tooltip.tscn").instantiate()
	tooltip.title = "TestTitle"
	tooltip.stacks = 10
	tooltip.description = for_text
	return tooltip
