class_name BaseBlock extends Area2D

@export_category("General Settings")
@export var health := 1

@export_category("Interaction settings")
@export var is_collision_enabled := true

@export_category("Debug")
@export var enable_debug_visual := false

@export_category("Ressources")
@export var collision_shape: StaticBody2D
@export var debug_sprite: Sprite2D

## send hit to the block. The respective will decide how to handle this
## returns damage as int
signal hitReceived(damageReceived: int)

# Called when the node enters the scene tree for the first time.
func _ready():
	if enable_debug_visual:
		debug_sprite.show()
	else:
		debug_sprite.hide()
		
	if not is_collision_enabled:
		collision_shape.queue_free()

func hitBlock(damageReceived: int):
	hitReceived.emit(damageReceived)
