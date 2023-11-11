class_name WinBlock extends Node2D


func _on_player_detector_area_entered(area):
	if area is Player:
		LevelManager.load_credit()
