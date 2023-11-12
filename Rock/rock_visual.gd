class_name RockVisual extends Node2D

@export var vfx_hit : PackedScene
@export var vfx_destroy : PackedScene

@export var sfx_hit : AudioStreamPlayer
@export var sfx_explode : AudioStreamPlayer


@onready var sprite = $Base
@onready var crack = $Base/Crack

var cracked_state = 5

func _ready() -> void:
	if sfx_hit == null :
		print("SFX MISSING ON ROCK VISUAL")
		return
	if sfx_explode == null :
		print("SFX MISSING ON ROCK VISUAL")
		return
	if vfx_hit == null :
		print("VFX MISSING ON ROCK VISUAL")
		return
	if vfx_destroy == null :
		print("VFX MISSING ON ROCK VISUAL")
		return
	
	
#	hit_feeback()
#	add_crack(3)
#	print(Vector2.from_angle(deg_to_rad(90)))
	pass # Replace with function body.


func destroy_feedback():
	sfx_explode.play()
	vfx_destroy.emitting = true
	pass


func hit_block_received(direction: float):
	# ICI MARC
	sfx_hit.play()
	hit_feeback(direction)
	hit_rock()
	pass


func hit_feeback(_degree = null):
	var vfx = vfx_hit.instantiate()
	add_child(vfx)
	vfx.emitting = true
	if _degree == null :
		tween_pos(0)
	else: 
		tween_pos(_degree)
	
	pass
		

func hit_rock():
	if cracked_state <= 0:
		return
	
	cracked_state -= 1
	crack.frame = cracked_state


func tween_pos(_degree = null):
	var twe = create_tween()
#	var dir = angle
	print()
	twe.tween_property(sprite,"position",Vector2.from_angle(deg_to_rad(_degree))*40,0.2) 
	twe.tween_property(sprite,"position",Vector2(0,0),0.2) 
