extends Node2D

#constant definitions
const INITIAL_BALL_SPEED = 80
const PAD_SPEED = 300

#variables

var direction = Vector2(1.0, 0.0)
var ball_speed = INITIAL_BALL_SPEED
var score_l = 0
var score_r = 0
var net
var start_pos
var screen_size
var pad_size

func _ready():
	screen_size = get_viewport_rect().size
	net = screen_size.x / 2
	pad_size = get_node("left").get_texture().get_size()
	var start_pos = get_node("ball").get_position()
	get_node("score_left").set_text(str(score_l))
	get_node("score_right").set_text(str(score_r))
	
	
func _process(delta):
	var ball_pos = get_node("ball").get_position()
	var left_rect = Rect2( get_node("left").get_position() - pad_size*0.5, pad_size )
	var right_rect = Rect2( get_node("right").get_position() - pad_size*0.5, pad_size )
	ball_pos += direction * ball_speed * delta
	
	#Ball logic
	get_node("ball").set_position(ball_pos)
	#hits wall
	if ((ball_pos.x < 0 and direction.x < 0) or (ball_pos.x > screen_size.x and direction.x > 0)):
		if(ball_pos.x < 0):
			score_r += 1
		else:
			score_l += 1
		direction.x = -direction.x

		
	#hits roof/floor
	if ((ball_pos.y < 0 and direction.y < 0) or (ball_pos.y > screen_size.y and direction.y > 0)):
		if(ball_pos.y > net):
			score_r += 1
		else:
			score_l += 1
		direction.y = -direction.y
	
	#hits paddle
	if ((left_rect.has_point(ball_pos) and direction.x < 0) or (right_rect.has_point(ball_pos) and direction.x > 0)):
    	direction.x = -direction.x
    	direction.y = randf()*2.0 - 1
    	direction = direction.normalized()
   		ball_speed *= 1.1
	





