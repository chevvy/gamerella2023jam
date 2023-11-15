class_name EnergyBlock extends Node2D

@export var health_point_for_player = 5
@export var rock_visual: RockVisual
@export var base_rock: BaseBlock
@export var destroy_timer: Timer


func _on_base_block_hit_received(damageReceived, _direction):
	PlayerState.add_health(health_point_for_player)
	rock_visual.destroy_feedback()
	base_rock.health -= damageReceived
	destroy_timer.start()


func _on_destroy_timer_timeout():
	base_rock.queue_free()
	queue_free()
