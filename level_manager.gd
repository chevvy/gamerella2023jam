extends Node

@onready var menu_path = "res://Scene/menu.tscn"
@onready var main_path = "res://main.tscn"
@onready var credit_path = "res://Scene/credit.tscn"
@onready var sfx = preload("res://Rock/rock_visual.tscn")

func load_menu():
	get_tree().change_scene_to_file(menu_path)
	
func load_main():
	get_tree().change_scene_to_file(main_path)
	# hopefully will help with shader cache
	var ref = sfx.instantiate()
	add_child(ref)
	PlayerState.on_level_start()
	
func load_credit():
	get_tree().change_scene_to_file(credit_path)
	PlayerState.clean_up_at_end_of_level()


