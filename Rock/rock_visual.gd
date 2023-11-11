class_name RockVisual extends Node2D

@export var vfx_hit : PackedScene
@export var vfx_destroy : PackedScene

@onready var sprite = $Base
@onready var crack = $Base/Crack


func _ready() -> void:
	if vfx_hit == null :
		print("VFX MISSING ON ROCK VISUAL")
	if vfx_destroy == null :
		print("VFX MISSING ON ROCK VISUAL")
#	hit_feeback()
#	add_crack(3)
#	print(Vector2.from_angle(deg_to_rad(90)))
	pass # Replace with function body.


func hit_feeback(_degree = null):
	var vfx = vfx_hit.instantiate()
	add_child(vfx)
	vfx.emitting = true
	if _degree == null :
		tween_pos(0)
	else: 
		tween_pos(_degree)
	
	pass
	

func destroy_feedback():
	vfx_destroy.emitting = true
	pass

func add_crack(_integrity = null):
	if  _integrity == null :
		crack.frame = 5
	else :
		crack.frame = _integrity

func tween_pos(_degree = null):
	var twe = create_tween()
#	var dir = angle
	print()
	twe.tween_property(sprite,"position",Vector2.from_angle(deg_to_rad(_degree))*40,0.2) 
	twe.tween_property(sprite,"position",Vector2(0,0),0.2) 
