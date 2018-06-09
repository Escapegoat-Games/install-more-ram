extends CanvasLayer

onready var dialogue_box = $UI/VBoxContainer/DialogueBox
onready var dialogue_text = $UI/VBoxContainer/DialogueBox/DialogueText

var current_NPC

var current_text = []
var current_array_index = 0
var current_text_index = 0
var is_playing = false
var can_play = false

signal start_talk
signal end_talk

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	if is_playing:
		if current_text_index < len(current_text[current_array_index]):
			dialogue_text.text = current_text[current_array_index].substr(0, current_text_index+1)
			current_text_index += 1
		elif Input.is_action_just_pressed("select"):
			if current_array_index < len(current_text)-1:
				current_text_index = 0
				current_array_index += 1
			else:
				turn_off_dialogue()
				if current_NPC.get("is_talked_to") != null:
					current_NPC.activate()
				
func turn_on_dialogue():
	current_array_index = 0
	current_text_index = 0
	dialogue_box.show()
	is_playing = true
	
func turn_off_dialogue():
	is_playing = false
	dialogue_box.hide()
	emit_signal("end_talk")

# check if player touching npc
func _on_TalkingArea2D_area_entered( area ):
	if not area.get("dialogue_text") == null:
		current_NPC = area
		current_text = area.dialogue_text
		can_play = true
		
		# turn on indicator
		area.turn_on_indicator()

func _on_TalkingArea2D_area_exited( area ):
	can_play = false
	area.turn_off_indicator()

func _on_Player_talk():
	if can_play and not current_NPC.get("is_talked_to"):
		turn_on_dialogue()
		emit_signal("start_talk")
