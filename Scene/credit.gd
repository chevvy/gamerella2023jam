extends Node2D


func _on_button_pressed() -> void:
	get_tree().quit()


func _on_button_2_pressed() -> void:
	LevelManager.load_main()


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	
	if Input.is_action_just_pressed("anything"):
		LevelManager.load_menu()
	
	
		
	
