class_name Pipe extends Node2D

@export var pipe_visual: PipeVisual

var previous_pipe: Pipe
# the local player position of the player when they placed that pipe
# will be used to undo the move and go back to this position
var local_player_position: Vector2

func set_previous_pipe(pipe: Pipe):
	previous_pipe = pipe

func delete_single_pipe():
	queue_free()
	
func delete_whole_pipe_queue():
	if previous_pipe == null:
		return
	previous_pipe.queue_free()
	queue_free()

func set_local_player_position(pos: Vector2):
	local_player_position = pos

func get_local_player_pos() -> Vector2:
	return local_player_position
