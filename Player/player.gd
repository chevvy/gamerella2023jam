class_name Player extends Area2D

@export var tile_map: TileMap
@export var speed = 400 # How fast the player will set_direction (pixels/sec).
@export var damage = 1
@export var ray: RayCast2D
@export var drill_visual: DrillVisual

var screen_size # Size of the game window.

## TODO
# liste des blocks: 
# [x] - block finish line 
# [x] - block indestructibles (mauve)
# [x] - Attack + adjusted player set_direction
# [] - move_to for smooth move baby
# [x] - block de 1 a 4 de vie (jaune, gris ,bleu, rouge)
# [] - serpent
# [] - block d'energy + 1 de vie 
# [] - block de buff augmente de 5 dps
# [] - block d'invicibilite
# [] - block de gold (qui est son propre metric)
# [] - block de dommage

# timer/lifebar (-delta 1 de vie)


var tile_size = 48
var inputs = {
	"move_right": Vector2.RIGHT,
	"move_left": Vector2.LEFT,
	"move_up": Vector2.UP,
	"move_down": Vector2.DOWN
}

var animByInput = {
	"move_right": "dig_right",
	"move_left": "dig_left",
	"move_up": "dig_up",
	"move_down": "dig_down"
}

var current_direction: Vector2 = Vector2.DOWN

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	if ray == null:
		printerr("missing raycast ref on player")


func _unhandled_input(event):
	if event.is_action_pressed("quit"):
		get_tree().quit()
	
	if event.is_action_pressed("dig"):
		_handle_dig_action()

	# direction handling
	for dir in inputs.keys():
		if event.is_action_pressed(dir):
			set_direction(dir)
		

func _handle_dig_action():
	ray.target_position = current_direction * tile_size
	ray.force_raycast_update()
	var col = ray.get_collider()
	if !ray.is_colliding() and not col is StaticBody2D:
		_move_player()
		return

	if col is BlockCollider:
		col.receiveHit(damage, current_direction)

		# if block is dead after attack, then we move to the place of block
		if col.get_health() <= 0:
			_move_player()
	
	

func _move_player():
	position += current_direction * tile_size



func set_direction(dir):
	current_direction = inputs[dir]
	drill_visual.dig_direction(animByInput[dir])
	
	
