class_name EnergyBlock extends Node2D

@export var health_point_for_player = 5

func _on_base_block_hit_received(damageReceived, direction):
	if damageReceived >= 1:
		PlayerState.add_health(health_point_for_player)
		queue_free()
