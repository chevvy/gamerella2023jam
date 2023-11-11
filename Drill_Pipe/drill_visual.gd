class_name DrillVisual extends Node2D

@onready var drill_anim = $Drill_Anim
@onready var drill_sprite =$Drill_Sprite

func dig_direction(anim_name: String):
	if !drill_anim.has_animation(anim_name):
		printerr("missing animation " + anim_name + " in  drill animator")
	
	drill_anim.play(anim_name)

