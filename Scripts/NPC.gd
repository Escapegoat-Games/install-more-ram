extends Area2D

onready var indicator = $Indicator
onready var main_sprite = $Sprite

export(Array) var dialogue_text
export(Texture) var texture

func _ready():
	main_sprite.texture = texture
	
	# set indicator
	if(texture != null):
		indicator.position.x = main_sprite.position.x
		indicator.position.y = main_sprite.position.y - 50

func turn_on_indicator():
	indicator.show()

func turn_off_indicator():
	indicator.hide()