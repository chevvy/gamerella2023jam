class_name IndestructibleBlock extends Node2D

@export var base_block: BaseBlock

func _ready():
	if base_block == null:
		printerr("missing baseblock ref on Indestructible block")


func _on_base_block_hit_received(damageReceived):
	print("indes block received damage, but not thing shit whit it")
