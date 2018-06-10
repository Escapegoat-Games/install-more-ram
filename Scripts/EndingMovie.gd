extends MarginContainer

onready var audio_player = $AudioStreamPlayer
onready var video_player = $VideoPlayer

export(String) var next_scene_path

export(Texture) var img_01
export(Texture) var img_02
export(Texture) var img_03
export(Texture) var img_04
export(Texture) var img_05
export(Texture) var img_06
export(Texture) var img_07


var current_time = 0
var audio_counter = 0
var video_counter = 0

export(AudioStream) var s

var buffer = 0.5

func _process(delta):
	current_time += delta
	
	# video control
	if current_time >= 0+buffer and video_counter == 0:
		show_img(img_01)
		video_counter += 1
		play_audio(s)
	elif current_time >= 3+buffer and video_counter == 1:
		show_img(img_02)
		video_counter += 1
		play_audio(s)
	elif current_time >= 6+buffer and video_counter == 2:
		show_img(img_03)
		video_counter += 1
		play_audio(s)
	elif current_time >= 9+buffer and video_counter == 3:
		show_img(img_04)
		video_counter += 1
		play_audio(s)
	elif current_time >= 12+buffer and video_counter == 4:
		show_img(img_05)
		video_counter += 1
		play_audio(s)
	elif current_time >= 14+buffer and video_counter == 5:
		show_img(img_06)
		video_counter += 1
		
	elif current_time >= 17+buffer and video_counter == 6:
		show_img(img_07)
		video_counter += 1
		play_audio(s)
	elif current_time >= 20+buffer and video_counter == 7:
		show_img(img_06)
		video_counter += 1
	
	# next scene
	if current_time >= 23+buffer:
		get_tree().change_scene(next_scene_path)
	

func play_audio(a):
	audio_player.stream = a
	audio_player.play()
func show_img(img):
	video_player.texture = img