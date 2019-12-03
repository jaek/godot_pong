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
	print(screen_size)

func _process(delta):
	var ball_pos = get_node("ball").get_position()
	var left_rect = Rect2( get_node("left").get_position() - pad_size*0.5, pad_size )
	var right_rect = Rect2( get_node("right").get_position() - pad_size*0.5, pad_size )
	ball_pos += direction * ball_speed * delta
	
	#Ball logic
	get_node("ball").set_position(ball_pos)
	#hits wall
	if ((ball_pos.x < 0 and direction.x < 0) or (ball_pos.x > screen_size.x and direction.x > 0)):
		direction.x = -direction.x
	#hits roof/floor
	if ((ball_pos.y < 0 and direction.y < 0) or (ball_pos.y > screen_size.y and direction.y > 0)):
		direction.y = -direction.y
	#hits paddle
	if ((left_rect.has_point(ball_pos) and direction.x < 0) or (right_rect.has_point(ball_pos) and direction.x > 0)):
    	direction.x = -direction.x
    	direction.y = randf()*2.0 - 1
    	direction = direction.normalized()
   		ball_speed *= 1.1
	
	#control left paddle
	var left_pos = get_node("left").get_position()
	if (left_pos.y > 0 and Input.is_action_pressed("left_up")):
    	left_pos.y += -PAD_SPEED * delta
	if (left_pos.y < screen_size.y and Input.is_action_pressed("left_down")):
    	left_pos.y += PAD_SPEED * delta

	get_node("left").set_position(left_pos)

# Move right pad
	var right_pos = get_node("right").get_position()
	if (right_pos.y > 0 and Input.is_action_pressed("right_up")):
    	right_pos.y += -PAD_SPEED * delta
	if (right_pos.y < screen_size.y and Input.is_action_pressed("right_down")):
    	right_pos.y += PAD_SPEED * delta
	get_node("right").set_position(right_pos)



