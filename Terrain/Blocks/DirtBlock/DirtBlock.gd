class_name DirtBlock extends Node2D


@export var base_block: BaseBlock

func _ready():
	if base_block == null:
		printerr("missing base block reff on DirtBlock")



func _on_base_block_hit_received(damageReceived, direction):
	base_block.remove_health(damageReceived)
	
	if base_block.health <= 0:
		print("dirt destroyed")
		queue_free()
