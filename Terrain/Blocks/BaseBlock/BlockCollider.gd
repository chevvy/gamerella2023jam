class_name BlockCollider extends StaticBody2D

## Class to simply pass the event to baseblock
@export var base_block: BaseBlock

func receiveHit(damage: int) -> void:
	base_block.hitBlock(damage)

func get_health() -> int:
	return base_block.health
