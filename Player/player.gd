class_name Player extends Area2D

@export var tile_map: TileMap

@export var speed = 400 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.

var tile_size = 48
var inputs = {
	"move_right": Vector2.RIGHT,
	"move_left": Vector2.LEFT,
	"move_up": Vector2.UP,
	"move_down": Vector2.DOWN
}

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	# position = position.snapped(Vector2.ONE * tile_size)
	# position += Vector2.ONE * tile_size/2

func _input(event):
	if event.is_action_pressed("quit"):
		get_tree().quit()

func _unhandled_input(event):
	for dir in inputs.keys():
		if event.is_action_pressed(dir):
			move(dir)

func move(dir):
	position += inputs[dir] * tile_size
