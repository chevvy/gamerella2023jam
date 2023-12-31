class_name Player extends Area2D

@export var speed = 400  # How fast the player will set_direction (pixels/sec).
@export var damage = 1
@export var ray: RayCast2D
@export var drill_visual: DrillVisual

@export var tuyau_scene: PackedScene
@export var player_camera: PlayerCamera

@export var is_debug = false

var drill_visual_list = []

var screen_size  # Size of the game window.
# the dept of the player (1 = 48px)
var current_depth := 0

var tile_size = 48
var inputs = {
	"move_right": Vector2.RIGHT,
	"move_left": Vector2.LEFT,
	"move_up": Vector2.UP,
	"move_down": Vector2.DOWN
}

var animByInput = {
	"move_right": "dig_right", "move_left": "dig_left", "move_up": "dig_up", "move_down": "dig_down"
}

var current_direction: Vector2 = Vector2.DOWN
var previous_direction: Vector2 = Vector2.DOWN

var previous_position = position

var previous_pipe_reference = null
var previous_animation_state: Array[String] = []
var current_animation_state: String

enum DrillMoveState {
	left,
	right,
	down,
	up,
	move_right,
	move_left,
	move_dig_right,
	move_dig_left,
}

var animation_by_move_states = {
	DrillMoveState.move_left: "move_left",
	DrillMoveState.move_right: "move_right",
	DrillMoveState.move_dig_left: "move_dig_left",
	DrillMoveState.move_dig_right: "move_dig_right",
	DrillMoveState.right: "dig_right",
	DrillMoveState.left: "dig_left",
	DrillMoveState.up: "dig_up",
	DrillMoveState.down: "dig_down"
}

var anim_state_by_vector = {
	Vector2.RIGHT: DrillMoveState.right,
	Vector2.LEFT: DrillMoveState.left,
	Vector2.UP: DrillMoveState.up,
	Vector2.DOWN: DrillMoveState.down,
}


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	if ray == null:
		printerr("missing raycast ref on player")

	PlayerState.on_player_timeout_event.connect(on_player_timeout)


func _input(event):
	if not PlayerState.can_player_move() and not is_debug:
		return

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
	var col = get_collider_at_direction(current_direction)
	if can_player_move_at_tile(col):
		_move_player()
		return

	if col is BlockCollider:
		apply_damage_to_block(col)
		# if block is dead after attack, then we move to the place of block
		if col.get_health() <= 0:
			_move_player()
		return

	on_move_blocked()


func get_collider_at_direction(dir: Vector2) -> Object:
	ray.target_position = dir * tile_size
	ray.force_raycast_update()
	return ray.get_collider()


func can_player_move_at_tile(collider: Object) -> bool:
	var is_tile_empty = !ray.is_colliding() and !(collider is StaticBody2D)
	var is_tile_pipe = collider is PipeBody
	return is_tile_empty and not is_tile_pipe


func apply_damage_to_block(block: BlockCollider):
	block.receiveHit(damage, current_direction)


func on_move_blocked():
	drill_visual.blocked()


func _undo_move():
	if previous_pipe_reference == null:
		return

	drill_visual.shrink()

	var previous_previous_pipe = previous_pipe_reference.previous_pipe
	previous_position = position
	position = previous_pipe_reference.get_local_player_pos()
	player_camera.move_camera(previous_position, position)
	previous_pipe_reference.delete_single_pipe()
	previous_pipe_reference = previous_previous_pipe
	revert_to_latest_direction()
	PlayerState.update_depth(position.y)


func _move_player():
	# generate tunnel
	var tuyau = tuyau_scene.instantiate()
	if previous_pipe_reference != null:
		tuyau.set_previous_pipe(previous_pipe_reference)

	tuyau.set_local_player_position(position)
	previous_pipe_reference = tuyau

	get_tree().root.add_child(tuyau)
	tuyau.position = Vector2(global_position.x + 24, global_position.y + 24)

	drill_visual_list.append(tuyau)
	#add current anim as previous anim
	previous_animation_state.append(current_animation_state)

	if current_direction != previous_direction:
		if current_direction == Vector2.DOWN:
			if previous_direction == Vector2.LEFT:
				(tuyau.pipe_visual as PipeVisual).spawn_right()
				tuyau.rotation = (deg_to_rad(180))
			if previous_direction == Vector2.RIGHT:
				(tuyau.pipe_visual as PipeVisual).spawn_left()
				tuyau.rotation = (deg_to_rad(180))
			if current_direction == Vector2.DOWN:
				set_drill_body_direction(DrillMoveState.down)
		if current_direction == Vector2.LEFT:
			# inverted because MARC :ANGRY
			(tuyau.pipe_visual as PipeVisual).spawn_right()
		if current_direction == Vector2.RIGHT:
			# inverted because MARC :ANGRY
			(tuyau.pipe_visual as PipeVisual).spawn_left()
	else:
		if current_direction == Vector2.DOWN:
			(tuyau.pipe_visual as PipeVisual).spawn_straight()
			# we change the body direction straight
			set_drill_body_direction(DrillMoveState.down)

		if current_direction == Vector2.LEFT || current_direction == Vector2.RIGHT:
			(tuyau.pipe_visual as PipeVisual).spawn_straight()
			tuyau.rotation = deg_to_rad(90)

	# handling body direction when we turn direction
	if current_direction == Vector2.LEFT:
		set_drill_body_direction(DrillMoveState.move_left)

	if current_direction == Vector2.RIGHT:
		set_drill_body_direction(DrillMoveState.move_right)

	previous_position = position
	position += current_direction * tile_size
	player_camera.move_camera(previous_position, position)
	previous_direction = current_direction

	PlayerState.update_depth(position.y)


func set_direction(dir):
	# If we are going up, we do nothing
	if inputs[dir] == Vector2.UP:
		return
	current_direction = inputs[dir]
	if previous_direction == Vector2.LEFT:
		set_drill_body_direction(DrillMoveState.move_dig_left)
		return
	if previous_direction == Vector2.RIGHT:
		set_drill_body_direction(DrillMoveState.move_dig_right)
		return

	set_drill_body_direction(anim_state_by_vector[current_direction])


func set_drill_body_direction(anim_dir: DrillMoveState):
	if anim_dir == null:
		return
	var new_animation_state = animation_by_move_states[anim_dir]
	current_animation_state = new_animation_state
	drill_visual.dig_direction(new_animation_state)


func revert_to_latest_direction():
	var latest_anim_state: String = previous_animation_state.pop_front()
	drill_visual.dig_direction(latest_anim_state)


func on_player_timeout():
	drill_visual.die() # trigger die anim on player

	drill_visual_list.reverse()
	for pipe in drill_visual_list:
		if pipe != null:
			await delete_pipe_delayed(pipe)
	drill_visual_list.clear()

func _exit_tree() -> void:
	for pipe in drill_visual_list:
		if pipe != null:
			pipe.queue_free()

func delete_pipe_delayed(pipe):
	if pipe is Pipe:
		pipe.trigger_destroy()
	await create_tween().tween_interval(0.33).finished
	pipe.queue_free()
