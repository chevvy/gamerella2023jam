extends Node


var _health = 100
var _can_player_move = false
var player_ui: PlayerUI

var UI_SCENE: PackedScene = preload("res://UI/ui.tscn")
# Called when the node enters the scene tree for the first time.
var can_be_damaged = true

var has_timedout = false
signal on_player_timeout_event
	
func on_level_start():
	_health = 100
	player_ui = UI_SCENE.instantiate()
	add_child(player_ui)

func clean_up_at_end_of_level():
	if player_ui:
		player_ui.queue_free()
	_can_player_move = false
	has_timedout = false
	
	
func remove_health(damage: int) -> void:
	if not can_be_damaged:
		print("cant be damaged")
		return
	if not can_player_move():
		return
	
	if _health - damage < 0:
		_health = 0
		update_health(_health)
		# print("health is zero")
		return

	update_health(_health - damage)


	
func enable_damage():
	print("can be damaged")
	can_be_damaged = true

func add_health(health_point: int) -> void:
	print(health_point)
	if not can_player_move():
		return
	if _health + health_point > 100:
		on_heal(100)
		return
	
	on_heal(_health + health_point)

func on_heal(health_point: int):
	can_be_damaged = false
	update_health(health_point)
	await create_tween().tween_interval(1.5).finished
	enable_damage()

func update_health(new_health_value: int):
	_health = new_health_value
	player_ui.update_bar(_health)
	if _health <= 0 and not has_timedout:
		on_timeout()

func can_player_move() -> bool:
	return _can_player_move

func set_can_player_move(can_move: bool) -> void:
	_can_player_move = can_move

func on_timeout():
	if player_ui.progress_bar.value == 0:
		has_timedout = true
		await create_tween().tween_interval(3).finished
		on_player_timeout_event.emit()
		player_ui.time_out()
		await create_tween().tween_interval(3).finished
		player_ui.hide_self()
		LevelManager.load_credit()

func update_depth(player_y_pos: float):
	# -6 because of the initial height of the player lol
	var depth = floor(player_y_pos / 48) - 6
	player_ui.update_depth(depth)
