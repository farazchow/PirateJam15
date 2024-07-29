class HarvestArea extends TextureRect:

	var day = -1
	var currentDay = -1
	var harvested = false

	# Called when the node enters the scene tree for the first time.
	func _ready():
		visible = ! harvested

	func _onRefreshScene(truths : Node2D):
		pass

	func _onHarvest():
		pass

	func refreshScene(truths : Node2D):
		# if (day < truths.currentDay()):
		# 	harvested = false
		# 	visible = true
		_onRefreshScene(truths)

	func _on_texture_button_pressed():
		harvested = true
		# day = currentDay()
		_onHarvest()
