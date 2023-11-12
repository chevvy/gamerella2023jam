class_name Player extends Area2D

@export var speed = 400 # How fast the player will set_direction (pixels/sec).
@export var damage = 1
@export var ray: RayCast2D
@export var drill_visual: DrillVisual

@export var tuyau_scene: PackedScene

var screen_size # Size of the game window.
# the dept of the player (1 = 48px)
var current_depth := 0
## TODO
# liste des blocks: 
# [x] - block finish line 
# [x] - block indestructibles (mauve)
# [x] - Attack + adjusted player set_direction
# [] - move_to for smooth move baby
# [x] - block de 1 a 4 de vie (jaune, gris ,bleu, rouge)
# [x] - serpent
# [] - camera movement
# [x] - block d'energy + 1 de vie 
# [x] - Block clean final
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

var debug_keys = {
	Vector2.RIGHT: "right",
	Vector2.UP: "up",
	Vector2.LEFT: "left",
	Vector2.DOWN: "down",
}

var opposed_direction = {
	Vector2.RIGHT: Vector2.LEFT,
	Vector2.UP: Vector2.DOWN,
	Vector2.LEFT: Vector2.RIGHT,
	Vector2.DOWN: Vector2.UP,
}

var animByInput = {
	"move_right": "dig_right",
	"move_left": "dig_left",
	"move_up": "dig_up",
	"move_down": "dig_down"
}

var animByVector = {
	Vector2.RIGHT: "dig_right",
	Vector2.LEFT: "dig_left",
	Vector2.UP: "dig_up",
	Vector2.DOWN: "dig_down"
}

var current_direction: Vector2 = Vector2.DOWN
var previous_direction: Vector2 = Vector2.DOWN

var previous_position = position

var previous_pipe_reference = null
var previous_animation_state = null

@export var player_camera: PlayerCamera

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
	
	if event.is_action_pressed("go_back"):
		_undo_move()

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


func _undo_move():
	if previous_pipe_reference == null:
		return
		
	var previous_previous_pipe = previous_pipe_reference.previous_pipe
	previous_position = position
	position = previous_pipe_reference.get_local_player_pos()
	player_camera.move_camera(previous_position, position)
	previous_pipe_reference.delete_single_pipe()
	previous_pipe_reference = previous_previous_pipe
	drill_visual.dig_direction(previous_animation_state)
	## TODO set on pipe the direction so we can  go to it and change orientation
	## of anim
	#position -= current_direction * tile_size
	
	

func _move_player():
	# generate tunnel
	var tuyau = tuyau_scene.instantiate()
	# TODO handle previous state altogheter ? animation direction included
	if previous_pipe_reference != null:
		tuyau.set_previous_pipe(previous_pipe_reference)
		
	tuyau.set_local_player_position(position)	
	previous_pipe_reference = tuyau
	previous_animation_state = animByVector[current_direction]
	get_tree().root.add_child(tuyau)
	tuyau.position = Vector2(global_position.x + 24, global_position.y + 24)

	if current_direction != previous_direction:
		if current_direction == Vector2.DOWN:  
			if previous_direction == Vector2.LEFT:
				(tuyau.pipe_visual as PipeVisual).spawn_right()
				tuyau.rotation = (deg_to_rad(180))
			if previous_direction == Vector2.RIGHT:
				(tuyau.pipe_visual as PipeVisual).spawn_left()
				tuyau.rotation = (deg_to_rad(180))
			

		if current_direction == Vector2.LEFT:
			# inverted because MARC :ANGRY
			(tuyau.pipe_visual as PipeVisual).spawn_right()
		if current_direction == Vector2.RIGHT:
			# inverted because MARC :ANGRY
			(tuyau.pipe_visual as PipeVisual).spawn_left()
	else:
		if current_direction == Vector2.DOWN:
			(tuyau.pipe_visual as PipeVisual).spawn_straight()

		if current_direction == Vector2.LEFT || current_direction == Vector2.RIGHT:
			(tuyau.pipe_visual as PipeVisual).spawn_straight()
			tuyau.rotation = deg_to_rad(90)

	previous_position = position
	position += current_direction * tile_size
	player_camera.move_camera(previous_position, position)
	previous_direction = current_direction
	


func set_direction(dir):
	if inputs[dir] == Vector2.UP:
		## TODO REMOVE IF WE DO USE UP
		return
	current_direction = inputs[dir]
	var anim_direction = animByInput[dir]
	drill_visual.dig_direction(anim_direction)
	
	
