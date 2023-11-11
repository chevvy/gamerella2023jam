class_name DrillVisual extends Node2D

@onready var drill_anim = $Drill_Anim
@onready var drill_sprite =$Drill_Sprite

	
func dig_up():
	drill_anim.play("dig_up")
	pass
func dig_left():
	drill_anim.play("dig_left")
	pass
func dig_right():
	drill_anim.play("dig_right")
	pass
func dig_down():
	drill_anim.play("dig_down")
	pass
