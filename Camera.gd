class_name PlayerCamera extends Camera2D

var absolute_min_position = 240
var min_position = 240
var max_position = 260

var is_in_downzone := false
var is_in_upzone := false

func move_camera(current_player_position: Vector2, previous_player_position: Vector2):
	# if we are going up
	print("previous - current")
	print(previous_player_position.y - current_player_position.y)

	if current_player_position.y <= 240:
		return 
	if previous_player_position.y - current_player_position.y <= 0:
		if current_player_position.y <= min_position:
			min_position -= 48
			move_camera_up()
	else:
		if current_player_position.y >= max_position:
			min_position += 48
			move_camera_down()
	# if we are going down
	

	



# func _on_player_deadzone_down_area_exited(area):
# 	is_in_downzone = false
# 	if area.position.y <= max_position:
# 		move_camera_down()
# 	pass # Replace with function body.


# func _on_player_deadzone_down_area_entered(area):
# 	is_in_downzone = true
# 	pass # Replace with function body.


# func _on_player_deadzone_up_area_exited(area):
# 	#print("up area exit")
# 	if area.position.y >= min_position && area.position.y <= max_position:
# 		print(area.position.y)
# 		move_camera_up()

# 	pass # Replace with function body.


# func _on_player_deadzone_up_area_entered(area):
# 	#print("up area enter")
# 	is_in_upzone = true
# 	#move_camera_down()
# 	pass # Replace with function body.

func move_camera_up():
	position -= Vector2(0, 48)

func move_camera_down():
	position += Vector2(0, 48)
