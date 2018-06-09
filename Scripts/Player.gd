extends KinematicBody2D

var speed = 200
var can_move = true

signal talk
signal move_left_area
signal move_right_area

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	
	if Input.is_action_pressed("move_left") && can_move:
		self.move_and_slide(Vector2(-speed, 0))
		
	elif Input.is_action_pressed("move_right") && can_move:
		self.move_and_slide(Vector2(speed, 0))
	
	# talk
	if can_move && Input.is_action_pressed("move_up"):
		emit_signal("talk")
		
	# area switch
	if get_slide_count() > 0:
		if get_slide_collision(0).collider.name == "RightWall":
			emit_signal("move_right_area")
		elif get_slide_collision(0).collider.name == "LeftWall":
			emit_signal("move_left_area")

func _on_HUD_end_talk():
	can_move = true

func _on_HUD_start_talk():
	can_move = false

func _on_GameManager_moved_left():
	position = Vector2(999, 50)

func _on_GameManager_moved_right():
	position = Vector2(-999, 50)
