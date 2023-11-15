class_name DrillVisual extends Node2D

@onready var drill_anim = $Drill_Anim
@onready var drill_sprite = $Drill_Sprite

@export var shrink_sfx: AudioStreamPlayer
@export var move_sfx: AudioStreamPlayer
@export var blocked_sfx: AudioStreamPlayer


#receives direction
func dig_direction(anim_name: String):
	if !drill_anim.has_animation(anim_name):
		printerr("missing animation " + anim_name + " in  drill animator")

	drill_anim.play(anim_name)


func move_right():
	drill_anim.play("move_right")


func move_left():
	drill_anim.play("move_left")


func move_down():
	drill_anim.play("dig_down")


func move_dig_left():
	drill_anim.play("move_dig_left")


func move_dig_right():
	drill_anim.play("move_dig_right")

func shrink():
	drill_anim.play("shrink")

func blocked():
	drill_anim.play("blocked")


func get_current_anim():
	return drill_anim.current_animation
