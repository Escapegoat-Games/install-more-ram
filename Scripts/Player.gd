extends KinematicBody2D

onready var ram_sprite = $AnimatedSprite

var speed = 200
var isMoving = false
var canMove = true

signal talk

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	
	# animation and movement
	isMoving = false
	
	if Input.is_action_pressed("move_left") && canMove:
		self.move_and_slide(Vector2(-speed, 0))
		isMoving = true
		ram_sprite.flip_h = false
	elif Input.is_action_pressed("move_right") && canMove:
		self.move_and_slide(Vector2(speed, 0))
		isMoving = true
		ram_sprite.flip_h = true
		
	ram_sprite.playing = isMoving
	if ram_sprite.playing == false:
		ram_sprite.frame = 0
	
	# talk
	if canMove && Input.is_action_pressed("move_up"):
		emit_signal("talk")

func _on_HUD_end_talk():
	canMove = true

func _on_HUD_start_talk():
	canMove = false
