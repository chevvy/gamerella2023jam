extends Node


var _health = 100
var _can_player_move = false
# Called when the node enters the scene tree for the first time.

func remove_health(damage: int) -> void:
	if _health - damage < 0:
		_health = 0
		# print("health is zero")
		return
	
		_health -= damage
	# print("removing health: ")
	#print(health)

func add_health(health_point: int) -> void:
	if _health + health_point > 100:
		_health = 100
		# print("health is 100")
		return
	
		_health += health_point
	# print("adding health: ")
	#print(health)

func can_player_move() -> bool:
	return _can_player_move

func set_can_player_move(can_move: bool) -> void:
	_can_player_move = can_move
