class_name RockVisual extends Node2D

@export var vfx_hit: PackedScene
@export var vfx_destroy: PackedScene

@export var sfx_hit: AudioStreamPlayer
@export var sfx_explode: AudioStreamPlayer

@onready var sprite = $Base
@onready var crack = $Base/Crack

var cracked_state = 5


func _ready() -> void:
	if sfx_hit == null:
		print("SFX MISSING ON ROCK VISUAL")
		return
	if sfx_explode == null:
		print("SFX MISSING ON ROCK VISUAL")
		return
	if vfx_hit == null:
		print("VFX MISSING ON ROCK VISUAL")
		return
	if vfx_destroy == null:
		print("VFX MISSING ON ROCK VISUAL")
		return

#	hit_feeback()
#	add_crack(3)
#	print(Vector2.from_angle(deg_to_rad(90)))
	pass  # Replace with function body.


func destroy_feedback():
	sfx_explode.pitch_scale = randf_range(0.6, 1.2)
	sfx_explode.play()
	var vfx = vfx_destroy.instantiate()
	get_tree().root.add_child(vfx)
	vfx.position = self.global_position
	vfx.emitting = true
	pass


func hit_block_received(direction: float, should_destroy: bool = false):
	# ICI MARC
	sfx_hit.pitch_scale = randf_range(0.5, 1.8)
	sfx_hit.play()
	hit_feeback(direction)
	if should_destroy:
		destroy_feedback()
		return
	hit_rock()
	pass


func hit_feeback(_degree = null):
	var vfx = vfx_hit.instantiate()
	get_tree().root.add_child(vfx)
	vfx.position = self.global_position
	vfx.emitting = true
	if _degree == null:
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
	twe.tween_property(
		sprite, "position", Vector2.from_angle(deg_to_rad(_degree)) * randi_range(10, 30), 0.0
	)
	twe.tween_property(sprite, "modulate", Color(4, 1.5, 0.6, 1), 0.00)
	twe.tween_property(sprite, "scale", Vector2(1.2, 1.2), 0.00)
	twe.tween_property(sprite, "position", Vector2(0, 0), 0.05)
	twe.tween_property(sprite, "scale", Vector2(1, 1), 0.05)
	twe.tween_property(sprite, "modulate", Color(1, 1, 1, 1), 0.05)
