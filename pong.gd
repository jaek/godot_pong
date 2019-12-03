extends Node2D

#constant definitions
const INITIAL_BALL_SPEED = 80
const PAD_SPEED = 150

#variables
var screen_size
var pad_size
var direction = Vector2(1.0, 0.0)
var ball_speed = INITIAL_BALL_SPEED




func _ready():
	screen_size = get_viewport_rect().size
	pad_size = get_node("left").get_texture().get_size()

func _process(delta):
	var ball_pos = get_node("ball").get_position()
	ball_pos += direction * ball_speed * delta
	get_node("ball").set_position(ball_pos)