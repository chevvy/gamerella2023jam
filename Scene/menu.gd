class_name Menu extends Node2D

@onready var fade = $CanvasLayer/Black_Fade
@onready var page_01 = $CanvasLayer/Page_01
@onready var page_02 = $CanvasLayer/Page_02
@onready var page_03 = $CanvasLayer/Page_03
@onready var drill = $CanvasLayer/Page_01/Origin_Drill/Drill_Head
@onready var title = $CanvasLayer/Page_01/Origin_Title/Title
@onready var note_01 = $CanvasLayer/Page_02/Note_Origin/Note_01
@onready var note_02 = $CanvasLayer/Page_03/Note_02_Origin/Note_02
@onready var animator = $Animator
@onready var audio = $AudioStreamPlayer
@onready var click_sound = $Click

var current_page = 1
var skip_intro = false


func _on_button_pressed() -> void:
	LevelManager.load_main()


func _on_button_2_pressed() -> void:
	LevelManager.load_credit()


func _ready() -> void:
	var twe = create_tween()

	page_01.hide()
	page_02.hide()
	page_03.hide()

	current_page = 1

	fade.show()
	if skip_intro == false:
		twe.tween_callback(fade_in)
		twe.tween_interval(1)
		twe.tween_callback(page_01_show)


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("dig"):
		skip_intro = true
		change_page(current_page)


func change_page(next_page):
	match next_page:
		1:
			click_sound.playing = true
			var twe = create_tween()
			twe.tween_callback(page_01_hide)
			twe.tween_interval(0.5)
			twe.tween_callback(page_02_show)
			current_page = 2

		2:
			click_sound.playing = true
			var twe = create_tween()
			twe.tween_callback(page_02_hide)
			twe.tween_interval(0.5)
			twe.tween_callback(page_03_show)
			current_page = 3
		3:
			click_sound.playing = true
			var twe = create_tween()
			twe.tween_callback(fade_out)
			twe.tween_callback(page_03_hide)
			twe.tween_interval(2)
			twe.tween_callback(LevelManager.load_main)
			current_page = 4


func fade_in():
	var twe = create_tween()
	fade.modulate = Color(0, 0, 0, 1)
	twe.tween_property(fade, "modulate", Color(0, 0, 0, 0), 3)


func fade_out():
	var twe = create_tween()
	fade.modulate = Color(0, 0, 0, 0)
	twe.tween_property(fade, "modulate", Color(0, 0, 0, 1), 1)


func page_01_show():
	var twe = create_tween()
	var twe_loop_01 = create_tween().set_loops().set_trans(Tween.TRANS_SINE)
	var twe_loop_02 = create_tween().set_loops().set_trans(Tween.TRANS_SINE)
	drill.position = Vector2(0, -600)
	title.position = Vector2(0, 600)
	page_01.show()
	twe.set_parallel(false)
	twe.set_parallel(true)
	twe.tween_property(drill, "position", Vector2.ZERO, 2).set_trans(Tween.TRANS_SPRING)
	twe.tween_property(title, "position", Vector2.ZERO, 2).set_trans(Tween.TRANS_SPRING)
	twe.set_parallel(false)
	if skip_intro == false:
		twe_loop_01.tween_property(drill, "position", Vector2(0, 10), 1)
		twe_loop_02.tween_property(title, "position", Vector2(0, -10), 1)
		twe_loop_01.tween_property(drill, "position", Vector2.ZERO, 1)
		twe_loop_02.tween_property(title, "position", Vector2.ZERO, 1)
	pass


func page_01_hide():
	var twe = create_tween()
	twe.tween_property(page_01, "scale", Vector2(1.4, 1.4), 0.05)
	twe.tween_property(page_01, "scale", Vector2(1, 1), 0.03)
	twe.set_parallel(true)
	twe.tween_property(drill, "position", Vector2(0, -600), 1).set_trans(Tween.TRANS_SPRING)
	twe.tween_property(title, "position", Vector2(0, 600), 1).set_trans(Tween.TRANS_SPRING)
	twe.set_parallel(false)
	twe.tween_callback(page_01.hide)
	pass


func page_02_show():
	var twe_page = create_tween()
	note_01.position = Vector2(0, -600)
	page_02.show()
	twe_page.tween_property(note_01, "position", Vector2(0, 0), 1).set_trans(Tween.TRANS_SPRING)
	pass


func page_02_hide():
	var twe_page = create_tween()
	twe_page.tween_property(page_02, "scale", Vector2(1.4, 1.4), 0.05)
	twe_page.tween_property(page_02, "scale", Vector2(1, 1), 0.03)
	twe_page.tween_property(note_01, "position", Vector2(0, 600), 1).set_trans(Tween.TRANS_SPRING)
	twe_page.tween_callback(page_02.hide)
	pass


func page_03_show():
	var twe_page = create_tween()
	note_02.position = Vector2(0, -600)
	page_03.show()
	twe_page.tween_property(note_02, "position", Vector2(0, 0), 1).set_trans(Tween.TRANS_SPRING)
	pass


func page_03_hide():
	var twe_page = create_tween()
	twe_page.tween_property(audio, "volume_db", -80, 3)
	twe_page.tween_property(page_03, "scale", Vector2(1.4, 1.4), 0.05)
	twe_page.tween_property(page_03, "scale", Vector2(1, 1), 0.03)
	twe_page.tween_property(note_02, "position", Vector2(0, 600), 1).set_trans(Tween.TRANS_SPRING)
	twe_page.tween_callback(page_03.hide)

	pass
