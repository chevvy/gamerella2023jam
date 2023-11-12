class_name DestructibleBlock extends Node2D


@export var base_block: BaseBlock
@export var rock_visual: RockVisual
@export var timer: Timer

signal onDestroy

var initial_health = 2
var degreeByDirection = {
	Vector2.RIGHT: 0,
	Vector2.UP: 270.0,
	Vector2.LEFT: 180.0,
	Vector2.DOWN: 90.0,
}

	


func _on_base_block_hit_received(damageReceived: int, direction: Vector2):
	base_block.remove_health(damageReceived)
	
	var hit_direction_in_degree = degreeByDirection[direction]
	var should_destroy = false
	if base_block.health <= 0:
		should_destroy = true
		_start_destruction_process()
		
	rock_visual.hit_block_received(hit_direction_in_degree, should_destroy)

func _start_destruction_process():
	base_block.queue_free()
	EventManager.onBlockDestroy.emit()
	timer.start()

func _on_destroy_timer_timeout():
	onDestroy.emit()
	queue_free()
	pass # Replace with function body.
