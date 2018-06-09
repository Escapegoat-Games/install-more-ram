extends AnimatedSprite

var is_moving

func _process(delta):
	
	# animation
	is_moving = false
	
	if Input.is_action_pressed("move_left") && get_node("..").can_move:
		is_moving = true
		flip_h = false
	elif Input.is_action_pressed("move_right") && get_node("..").can_move:
		is_moving = true
		flip_h = true
		
	playing = is_moving
	if playing == false:
		frame = 0