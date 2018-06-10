extends MarginContainer

onready var vid_player = $VideoPlayer

export(String) var next_scene_path
export(float) var vid_length

var current_time = 0

func _process(delta):
	current_time += delta
	if current_time >= vid_length:
		get_tree().change_scene(next_scene_path)