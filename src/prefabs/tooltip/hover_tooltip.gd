extends Control

var title: String
var stacks: int = 0
var description: String

func _ready():
	var stacksText = ""
	if stacks > 0:
		stacksText = "[right][font_size=10]x[/font_size]%s[/right]" % stacks
	var upperText = "[font_size=25]%s[/font_size] %s" % [title, stacksText]
	$UpperPanel/UpperText.text = upperText
	$LowerPanel/LowerText.text = description
