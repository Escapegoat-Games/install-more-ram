extends CanvasLayer

onready var dialogue_box = $UI/VBoxContainer/DialogueBox
onready var dialogue_text = $UI/VBoxContainer/DialogueBox/DialogueText
onready var sfx_player = $SFXPlayer

var current_NPC

var current_text = []
var current_array_index = 0
var current_text_index = 0
var is_playing = false
var can_play = false

var sfx_01 = load("res://Assets/SFX/blip.wav")
var sfx_02 = load("res://Assets/SFX/next.wav")
var sfx_03 = load("res://Assets/SFX/ding.wav")
var sfx_04 = load("res://Assets/SFX/openTextBox.wav")
var sfx_05 = load("res://Assets/SFX/save.wav")

signal start_talk
signal end_talk
signal add_goat
signal check_end_game

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	if is_playing:
		if current_text_index < len(current_text[current_array_index]):
			dialogue_text.text = current_text[current_array_index].substr(0, current_text_index+1)
			current_text_index += 1
			
			# play celebration
			if current_text_index-1 == 0 and current_text[current_array_index][current_text_index-1] == ">":
				sfx_player.stream = sfx_05
				sfx_player.play()
			
		elif Input.is_action_just_pressed("select"):
			if current_array_index < len(current_text)-1:
				current_text_index = 0
				current_array_index += 1
				
				# sfx
				sfx_player.stream = sfx_03
				sfx_player.play()
				
			else:
				turn_off_dialogue()
				
				# check if event NPC
				if current_NPC.get("is_talked_to") != null:
					current_NPC.activate()
					emit_signal("add_goat")
					
				# check if ending NPC
				elif current_NPC.get("is_end_NPC"):
					if not current_NPC.is_playing_fail_text:
						emit_signal("check_end_game")
					else:
						current_NPC.is_playing_fail_text = false
						current_text = current_NPC.dialogue_text
					
				
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
		
		# sfx
		sfx_player.stream = sfx_04
		sfx_player.play()


func _on_GameManager_play_fail_text():
	current_text = current_NPC.fail_dialogue_text
	current_NPC.is_playing_fail_text = true
	turn_on_dialogue()
