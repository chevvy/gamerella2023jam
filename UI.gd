class_name PlayerUI extends CanvasLayer


@onready var fader = $Fader
@onready var get_ready_title = $CenterContainer
@onready var time_out_title = $Time_Out
@onready var well_done_title = $Well_Done
@onready var progress_bar = $ProgressBar
@onready var energy_title = $Energy_Title
@onready var depth_cont = $MarginContainer
@onready var depth_score = $MarginContainer/VBoxContainer/Depth_SCORE
@onready var ui = self


# update_bar() - pour update la barre
# update_bar() - pour update le depth
# time_out() - pour lancer le visuel de fin


func _ready() -> void:
	var twe = create_tween()
	depth_score.text = str(0)
	fade_in()
	hide_title()
	twe.tween_interval(1)
	twe.tween_callback(get_ready)
	
	#twe.tween_interval(3)
	#twe.tween_callback(time_out)
#	twe.tween_interval(3)
#	twe.tween_callback(fade_out)
	pass # Replace with function body.



func _process(delta: float) -> void:
	pass

func update_bar(_value):
	var twe_color = create_tween()
	var twe_value = create_tween()
	twe_color.tween_property(progress_bar,"modulate",Color(3,3,3,1),0.2)
	twe_color.tween_property(progress_bar,"modulate",Color(1,1,1,1),0.2)
	twe_value.tween_property(progress_bar,"value",_value,2)
	progress_bar.value = _value

func update_depth(_value = null ):
	var twe = create_tween()
	if _value != null:
		depth_score.text = str(_value)
	twe.tween_property(depth_cont,"position",Vector2(0,randi_range(-5,-20)),0.03)
	twe.tween_property(depth_cont,"position",Vector2(0,0),0.02)
	
	
func get_ready():
	var twe = create_tween()
	var twe_text = create_tween() 
	progress_bar.position = Vector2(45,-220)
	get_ready_title.position = Vector2(-800,0)
	depth_cont.position = Vector2(300,0)
	energy_title.position = Vector2(-300,72)
	depth_cont.show()
	get_ready_title.show()
	progress_bar.show()
	energy_title.show()
	twe.tween_property(get_ready_title,"position",Vector2(0,0),1).set_trans(Tween.TRANS_SPRING)
	twe.tween_interval(0.1)
	twe.tween_property(get_ready_title,"scale",Vector2(1.3,1.3),0.15)
	twe.tween_property(get_ready_title,"scale",Vector2(0.8,0.8),0.1)
	twe.tween_property(get_ready_title,"scale",Vector2(1.2,1.2),0.08)
	twe.tween_property(get_ready_title,"scale",Vector2(1,1),0.05)
	twe.tween_property(ui,"offset",Vector2(0,10),0.2).set_trans(Tween.TRANS_SPRING)
	twe.tween_property(ui,"offset",Vector2(0,-10),0.05).set_trans(Tween.TRANS_SPRING)
	twe.tween_property(ui,"offset",Vector2(0,0),0.05).set_trans(Tween.TRANS_SPRING)
	twe.tween_property(get_ready_title,"position",Vector2(800,0),1).set_trans(Tween.TRANS_SPRING)

	_bar_anim()
	twe.tween_interval(1)
	twe_text.tween_property(energy_title,"position",Vector2(45,72),0.2).set_trans(Tween.TRANS_SPRING)
	twe_text.tween_property(depth_cont,"position",Vector2(0,0),0.2).set_trans(Tween.TRANS_SPRING)
	twe.tween_callback(enable_player_move)
	
	pass
	
func enable_player_move():
	PlayerState.set_can_player_move(true)
	
	
func time_out():

	var twe = create_tween()
	var twe_02 = create_tween()
	var twe_loop = create_tween().set_loops()
	var twe_loop_02 = create_tween().set_loops()
	time_out_title.position = Vector2(-800,151)
	well_done_title.position = Vector2(800,250)
	
	time_out_title.show()
	well_done_title.show()
	
	twe.tween_property(time_out_title,"position",Vector2(110,151),0.5).set_trans(Tween.TRANS_SPRING)
	twe_02.tween_property(well_done_title,"position",Vector2(60,250),0.5).set_trans(Tween.TRANS_SPRING)
	twe.tween_interval(3)
	twe.tween_callback(fade_out)
	
	twe_loop.tween_interval(0.9)
	twe_loop.tween_property(time_out_title,"modulate",Color(1,1,1,0),0.01)
	twe_loop.tween_interval(0.3)
	twe_loop.tween_property(time_out_title,"modulate",Color(1,1,1,1),0.01)
	
	twe_loop_02.tween_interval(0.9)
	twe_loop_02.tween_property(well_done_title,"modulate",Color(1,1,1,0),0.01)
	twe_loop_02.tween_interval(0.3)
	twe_loop_02.tween_property(well_done_title,"modulate",Color(1,1,1,1),0.01)
	
	pass

func fade_in():
	var twe = create_tween()
	fader.show()
	fader.modulate = Color(0,0,0,1)
	twe.tween_property(fader,"modulate", Color(0,0,0,0),1)
	pass
	
func fade_out():
	var twe = create_tween()
	fader.show()
	fader.modulate = Color(0,0,0,0)
	twe.tween_property(fader,"modulate", Color(0,0,0,1),1)
	pass
	
func hide_title():
	energy_title.hide()
	depth_cont.hide()
	progress_bar.hide()
	get_ready_title.hide()
	time_out_title.hide()
	well_done_title.hide()

func _bar_anim():
	var twe_ui = create_tween()
	var twe_color = create_tween()
	var twe_value = create_tween()
	progress_bar.value = 0
	twe_value.tween_interval(1)
	twe_value.tween_property(progress_bar,"value",100,2)
	twe_ui.tween_interval(0.5)
	twe_ui.tween_property(progress_bar,"position",Vector2(45,20),0.5).set_trans(Tween.TRANS_SPRING)
	twe_ui.tween_property(progress_bar,"scale",Vector2(1.05,1.05),0.15)
	twe_ui.tween_property(progress_bar,"scale",Vector2(0.95,0.95),0.1)
	twe_ui.tween_property(progress_bar,"scale",Vector2(1.02,1.02),0.08)
	twe_ui.tween_property(progress_bar,"scale",Vector2(0.95,0.95),0.1)
	twe_ui.tween_property(progress_bar,"scale",Vector2(1.01,1.01),0.08)
	twe_ui.tween_property(progress_bar,"scale",Vector2(0.95,0.95),0.1)
	twe_ui.tween_property(progress_bar,"scale",Vector2(1.02,1.02),0.08)
	twe_ui.tween_property(progress_bar,"scale",Vector2(0.95,0.95),0.1)
	twe_ui.tween_property(progress_bar,"scale",Vector2(1.01,1.01),0.08)
	twe_ui.tween_property(progress_bar,"scale",Vector2(0.95,0.95),0.1)
	twe_ui.tween_property(progress_bar,"scale",Vector2(1.02,1.02),0.08)
	twe_ui.tween_property(progress_bar,"scale",Vector2(0.95,0.95),0.1)
	twe_ui.tween_property(progress_bar,"scale",Vector2(1.01,1.01),0.08)
	twe_ui.tween_property(progress_bar,"scale",Vector2(0.95,0.95),0.1)
	twe_ui.tween_property(progress_bar,"scale",Vector2(1.02,1.02),0.08)
	twe_ui.tween_property(progress_bar,"scale",Vector2(0.95,0.95),0.1)
	twe_ui.tween_property(progress_bar,"scale",Vector2(1.01,1.01),0.08)
	twe_ui.tween_property(progress_bar,"scale",Vector2(0.95,0.95),0.1)
	twe_ui.tween_property(progress_bar,"scale",Vector2(1.02,1.02),0.08)
	twe_ui.tween_property(progress_bar,"scale",Vector2(0.95,0.95),0.1)
	twe_ui.tween_property(progress_bar,"scale",Vector2(1.01,1.01),0.08)
	twe_ui.tween_property(progress_bar,"scale",Vector2(1,1),0.05)
	twe_color.tween_property(progress_bar,"modulate",Color(3,3,3,1),0.2)
	twe_color.tween_property(progress_bar,"modulate",Color(1,1,1,1),0.2)
	twe_color.tween_property(progress_bar,"modulate",Color(3,3,3,1),0.2)
	twe_color.tween_property(progress_bar,"modulate",Color(1,1,1,1),0.2)
	twe_color.tween_property(progress_bar,"modulate",Color(3,3,3,1),0.2)
	twe_color.tween_property(progress_bar,"modulate",Color(1,1,1,1),0.2)
	twe_color.tween_property(progress_bar,"modulate",Color(3,3,3,1),0.2)
	twe_color.tween_property(progress_bar,"modulate",Color(1,1,1,1),0.2)
	twe_color.tween_property(progress_bar,"modulate",Color(3,3,3,1),0.2)
	twe_color.tween_property(progress_bar,"modulate",Color(1,1,1,1),0.2)
	twe_color.tween_property(progress_bar,"modulate",Color(3,3,3,1),0.2)
	twe_color.tween_property(progress_bar,"modulate",Color(1,1,1,1),0.2)
	twe_color.tween_property(progress_bar,"modulate",Color(3,3,3,1),0.2)
	twe_color.tween_property(progress_bar,"modulate",Color(1,1,1,1),0.2)

	
