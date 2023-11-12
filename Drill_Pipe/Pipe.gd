class_name Pipe extends Node2D

@export var pipe_visual: PipeVisual

var previous_pipe: Pipe

func set_previous_pipe(pipe: Pipe):
	previous_pipe = pipe

func delete_single_pipe():
	queue_free()
	
func delete_whole_pipe_queue():
	if previous_pipe == null:
		return
	previous_pipe.queue_free()
	queue_free()
	
