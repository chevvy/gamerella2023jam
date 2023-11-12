class_name DestructibleBlock extends Node2D


@export var base_block: BaseBlock
@export var rock_visual: RockVisual

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
	rock_visual.hit_feeback(hit_direction_in_degree)
	rock_visual.hit_rock()

	if base_block.health <= 0:
		onDestroy.emit()
		queue_free()
