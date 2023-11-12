extends AudioStreamPlayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var twe = create_tween()
	twe.tween_interval(1.5)
	twe.tween_callback(play_song)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func play_song():
	self.playing = true
