extends Timer

@export var amount_of_health_per_second := 5


func _on_timeout():
	PlayerState.remove_health(amount_of_health_per_second)
