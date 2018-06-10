extends "res://Scripts/AnimatedNPC.gd"

# hacky solution for an ending
var is_end_NPC = true

var is_playing_fail_text = false
export(Array, String) var fail_dialogue_text