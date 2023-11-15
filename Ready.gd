extends AudioStreamPlayer


func _ready() -> void:
	var twe = create_tween()
	twe.tween_interval(1.5)
	twe.tween_callback(play_song)


func play_song():
	self.playing = true
