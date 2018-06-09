extends Area2D

onready var indicator = $Indicator
onready var main_sprite = $Sprite

export(Array, String) var dialogue_text
export(Texture) var texture

func _ready():
	load_sprite()
	
	# set indicator
	if(texture != null):
		indicator.position.x = main_sprite.position.x
		indicator.position.y = main_sprite.position.y - 50

func load_sprite():
	main_sprite.texture = texture

func turn_on_indicator():
	indicator.show()

func turn_off_indicator():
	indicator.hide()