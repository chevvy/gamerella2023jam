extends Node2D

@onready var credit_path = "res://Scene/credit.tscn"
@onready var main_path = "res://main.tscn"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func load_main():
	get_tree().change_scene_to_file(main_path)
	pass

func load_credit():
	get_tree().change_scene_to_file(credit_path)
	pass


func _on_button_pressed() -> void:
	load_main()
	pass # Replace with function body.


func _on_button_2_pressed() -> void:
	load_credit()
	pass # Replace with function body.
