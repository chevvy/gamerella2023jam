class_name PlayerDetector extends Area2D


func _on_area_entered(area):
	if area is Player:
		print("player win")
