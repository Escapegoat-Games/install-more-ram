extends CanvasLayer

onready var dialogueBox = $UI/VBoxContainer/DialogueBox
onready var dialogueText = $UI/VBoxContainer/DialogueBox/DialogueText

var currentText = []
var currentArrayIndex = 0
var currentTextIndex = 0
var isPlaying = false
var canPlay = false

signal start_talk
signal end_talk

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	if isPlaying:
		if currentTextIndex < len(currentText[currentArrayIndex]):
			dialogueText.text = currentText[currentArrayIndex].substr(0, currentTextIndex+1)
			currentTextIndex += 1
		elif Input.is_action_just_pressed("select"):
			if currentArrayIndex < len(currentText)-1:
				currentTextIndex = 0
				currentArrayIndex += 1
			else:
				turn_off_dialogue()
				
func turn_on_dialogue():
	currentArrayIndex = 0
	currentTextIndex = 0
	dialogueBox.show()
	isPlaying = true
	
func turn_off_dialogue():
	isPlaying = false
	dialogueBox.hide()
	emit_signal("end_talk")

# check if player touching npc
func _on_TalkingArea2D_area_entered( area ):
	if not area.get("dialogue_text") == null:
		currentText = area.dialogue_text
		canPlay = true

func _on_TalkingArea2D_area_exited( area ):
	canPlay = false

func _on_Player_talk():
	if canPlay:
		turn_on_dialogue()
		emit_signal("start_talk")
