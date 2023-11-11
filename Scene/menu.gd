class_name Menu extends Node2D

func _on_button_pressed() -> void:
	LevelManager.load_main()


func _on_button_2_pressed() -> void:
	LevelManager.load_credit()
