extends Node

var ram_count = 0

var current_area_index = 1
var current_area
var areas
var event_rams

signal moved_left
signal moved_right

func _ready():
	areas = [
		load("res://Scenes/AreaNASA.tscn"),
		load("res://Scenes/AreaTown.tscn"),
		load("res://Scenes/AreaTown2.tscn"),
		load("res://Scenes/AreaFarm.tscn"),
	]
	
	# hardcode event rams
	event_rams = [
		load("res://Instances/EventNPC.tscn").instance(),
		load("res://Instances/EventNPC.tscn").instance(),
		load("res://Instances/EventNPC.tscn").instance(),
	]
	event_rams[0].position.x = -600
	event_rams[0].area = 0
	event_rams[0].dialogue_text = [
		"Install me",
		"I'm more ram"
	]
	event_rams[1].position.x = 500
	event_rams[1].area = 1
	event_rams[1].dialogue_text = [
		"I wish to join your party",
		"Ram has joined your party"
	]
	event_rams[2].position.x = 700
	event_rams[2].area = 3
	event_rams[2].dialogue_text = [
		"I wish to join your party",
		"Ram has joined your party"
	]
	
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


func _on_HUD_add_goat():
	ram_count += 1
