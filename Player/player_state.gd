extends Node


var health = 100
# Called when the node enters the scene tree for the first time.

func remove_health(damage: int) -> void:
	if health - damage < 0:
		health = 0
		print("health is zero")
		return
	
	health -= damage
	print("removing health: ")
	print(health)

func add_health(health_point: int) -> void:
	if health + health_point > 100:
		health = 100
		print("health is 100")
		return
	
	health += health_point
	print("adding health: ")
	print(health)
