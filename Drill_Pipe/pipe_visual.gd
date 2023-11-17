class_name PipeVisual extends Node2D

@onready var pipe_straight = $Pipe_Straight_Sprite
@onready var pipe_anti = $Pipe_Anti_Corner_Sprite
@onready var pipe_corner = $Pipe_Corner_Sprite
@onready var sfx_explode = $SFX_Explode


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if [pipe_anti, pipe_corner, pipe_straight] == null:
		print("missing pipe ref in pipe visual")
	pipe_anti.hide()
	pipe_corner.hide()
	pipe_straight.hide()
	modulate_color()
	sfx_explode.pitch_scale = randf_range(0.4,2)
	pass  # Replace with function body.


func spawn_right():
	pipe_anti.hide()
	pipe_straight.hide()

	pipe_corner.show()
	pass


func spawn_left():
	pipe_straight.hide()
	pipe_corner.hide()

	pipe_anti.show()
	pass


func spawn_straight():
	pipe_corner.hide()
	pipe_anti.hide()

	pipe_straight.show()
	pass


func modulate_color():
	var twe = create_tween()
	self.modulate = Color(6, 3, 0.8)
	twe.tween_property(self, "modulate", Color(1, 1, 1), 0.5)
