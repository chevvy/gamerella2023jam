extends Node2D

#list of rock visual that should be hidden by default
@export var list_of_rocks: Array[RockVisual] = []
@export var destructible_rock: DestructibleBlock


func _ready():
	if list_of_rocks.is_empty():
		printerr("missing rocks visual reference")
		return
	
	for visual in list_of_rocks:
		visual.hide()
		
	var rand_index = randi_range(0, list_of_rocks.size() - 1)
	var selected_rock_visual = list_of_rocks[rand_index]
	selected_rock_visual.show()
	destructible_rock.rock_visual = selected_rock_visual
	


func _on_destructible_block_on_destroy():
	queue_free()

