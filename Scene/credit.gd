extends Node2D

@onready var fader = $CanvasLayer/Fader
@onready var page = $CanvasLayer/Page
@onready var sfx_click = $SFX_Click

var can_input = false

func _ready():
	can_input = false
	_fade_in()

func _on_button_pressed() -> void:
	get_tree().quit()


func _on_button_2_pressed() -> void:
	get_tree().quit()
	#LevelManager.load_main()


func _process(_delta: float) -> void:
	
	if can_input == true :
		
		if Input.is_action_just_pressed("quit"):
			var twe = create_tween()
			twe.tween_callback(_press_feedback)
			twe.tween_callback(_fade_out)
			twe.tween_interval(2)
			twe.tween_callback(_quit())


		if Input.is_action_just_pressed("dig"):
			var twe = create_tween()
			twe.tween_callback(_press_feedback)
			twe.tween_callback(_fade_out)
			twe.tween_interval(2)
			twe.tween_callback(_load_level)
	

func _load_level():
	LevelManager.load_main()
	
func _quit():
	get_tree().quit()

func _fade_in():
	fader.show()
	fader.modulate = Color(0,0,0,1)
	var twe = create_tween()
	twe.tween_property(fader,"modulate",Color(0,0,0,0),1)
	pass
	
func _fade_out():
	fader.show()
	fader.modulate = Color(0,0,0,0)
	var twe = create_tween()
	twe.tween_property(fader,"modulate",Color(0,0,0,1),0.5)
	pass

func _press_feedback():
	sfx_click.playing = true
	var twe = create_tween()
	twe.tween_property(page,"scale",Vector2(0.9,0.9),0.1).set_trans
	twe.tween_property(page,"scale",Vector2(1,1),0.05).set_trans
	


func _on_intro_delay_timeout():
	can_input = true
	pass # Replace with function body.
