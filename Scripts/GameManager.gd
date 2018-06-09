extends Node

var current_area_index = 1
var current_area
var areas
var event_rams

signal moved_left
signal moved_right

func _ready():
	areas = [
		load("res://Scenes/AreaNASA.tscn"),
		load("res://Scenes/AreaTown.tscn")
	]
	
	# hardcode event rams
	event_rams = [
		load("res://Instances/EventNPC.tscn").instance(),
	]
	event_rams[0].position.x = -600
	event_rams[0].area = 0
	event_rams[0].dialogue_text = ["hello guyos"]
	
	load_current_area()

func load_current_area():
	current_area = areas[current_area_index].instance()
	add_child(current_area)
	
	load_event_rams()

func load_event_rams():
	for ram in event_rams:
		if ram.area == current_area_index and not ram.is_talked_to:
			add_child(ram)
		else:
			remove_child(ram)

func _on_Player_move_left_area():
	if current_area.left_id >= 0:
		
		current_area.queue_free()
		
		current_area_index = current_area.left_id
		load_current_area()
		emit_signal("moved_left")

func _on_Player_move_right_area():
	if current_area.right_id >= 0:
		
		current_area.queue_free()
		
		current_area_index = current_area.right_id
		load_current_area()
		emit_signal("moved_right")
