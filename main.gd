extends Node

""" constant declarations """
const MARGIN = 40
const START_SPEED = 150
const PAD_SPEED = 150
""" window dimensions """
var window
""" start positions """
var start_l
var start_r
var start_b
""" prepacked paddle scene """
var paddle = load("res://paddle.tscn")
var left
var right
""" prepacked ball scene """
var ball_scene = load("res://ball.tscn")
var ball
var ball_pos
var ball_direction = Vector2(0.75, 0.75)
var ball_speed = START_SPEED
""" score labels """
var score_l = 0
var score_r = 0

func update_score():
	get_node("score_l").set_text(str(score_l))
	get_node("score_r").set_text(str(score_r))
	return
	
func reset():
	get_node("ball").set_position(start_b)
	ball_pos = get_node("ball").get_position()
	ball_speed = START_SPEED
	ball_direction
	return

func _ready():
	# get window size and paddle start positions
	window = OS.window_size
	print("window size = " + str(window))
	start_l = Vector2(MARGIN, window.y / 2)
	start_r = Vector2(window.x - MARGIN, window.y / 2)
	start_b = Vector2(window.x / 2, window.y / 2)
	
	# draw objects to screen
	# left
	var left = paddle.instance()
	left.set_name("l_pad")
	left.set_position(start_l)
	self.add_child(left)
	# right
	var right = paddle.instance()
	right.set_name("r_pad")
	right.set_position(start_r)
	self.add_child(right)
	#ball
	var ball = ball_scene.instance()
	self.add_child(ball)
	ball.set_position(start_b)
	ball_pos = ball.get_position()
	
func _process(delta):
	#move the ball
	ball_pos += ball_direction * ball_speed * delta
		#hits roof/floor
	if ((ball_pos.y < 0 and ball_direction.y < 0) or (ball_pos.y > window.y and ball_direction.y > 0)):
		ball_direction.y = -ball_direction.y
	self.get_node("ball").set_position(ball_pos)
		#hits wall
	if ((ball_pos.x < 0 and ball_direction.x < 0) or (ball_pos.x > window.x and ball_direction.x > 0)):
		if(ball_pos.x < 0):
			score_r += 1
			#serve to r
			ball_direction = Vector2(1.0, 0.0)
		else:
			score_l += 1
			#serve to l
			ball_direction = Vector2(-1.0, 0)
		reset()
	
	#move the paddles
		#control left paddle
	var left_pos = get_node("l_pad").get_position()
	if (left_pos.y > 0 and Input.is_action_pressed("left_up")):
    	left_pos.y += -PAD_SPEED * delta
	if (left_pos.y < window.y and Input.is_action_pressed("left_down")):
    	left_pos.y += PAD_SPEED * delta
	get_node("l_pad").set_position(left_pos)

		# Move right pad
	var right_pos = get_node("r_pad").get_position()
	if (right_pos.y > 0 and Input.is_action_pressed("right_up")):
    	right_pos.y += -PAD_SPEED * delta
	if (right_pos.y < window.y and Input.is_action_pressed("right_down")):
    	right_pos.y += PAD_SPEED * delta
	get_node("r_pad").set_position(right_pos)
	
	update_score()
