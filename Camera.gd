class_name PlayerCamera extends Camera2D

var absolute_min_position = 240
var min_position = 240
var max_position = 260

var is_in_downzone := false
var is_in_upzone := false

func _ready():
	EventManager.onBlockHit.connect(camera_shake)

func move_camera(current_player_position: Vector2, previous_player_position: Vector2):
	if current_player_position.y <= 240:
		return 
	if previous_player_position.y - current_player_position.y <= 0:
		#player going up
		if current_player_position.y <= min_position:
			min_position -= 48
			move_camera_up()
	else:
		# if player going down
		if current_player_position.y >= max_position:
			min_position += 48
			move_camera_down()
	

func move_camera_up():
	position -= Vector2(0, 48)

func move_camera_down():
	position += Vector2(0, 48)
	
func camera_shake():
	var twe = create_tween()
	twe.tween_property(self,"zoom",Vector2(randf_range(1.01,1.065),randf_range(1.01,1.07)),0.03)
	twe.tween_property(self,"zoom",Vector2(1,1),0.01)
