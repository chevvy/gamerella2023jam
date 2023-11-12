class_name EnergyBlock extends Node2D

@export var health_point_for_player = 5
@export var rock_visual: RockVisual

func _on_base_block_hit_received(damageReceived, direction):
	PlayerState.add_health(health_point_for_player)
	rock_visual.destroy_feedback()
	queue_free()
