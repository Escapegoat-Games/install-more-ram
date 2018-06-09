extends "res://Scripts/AnimatedNPC.gd"

var is_talked_to = false
var area = 0

func activate():
	is_talked_to = true
	get_node("..").remove_child(self)