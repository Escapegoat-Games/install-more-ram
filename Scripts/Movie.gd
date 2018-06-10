extends MarginContainer

# I really hate you godot :|

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
export(AudioStream) var sound_01
var sound_02 = load("res://Assets/Video/intro_frames/camera-shutter-click-08.wav")

var current_time = 0
var audio_counter = 0
var video_counter = 0

var buffer = 0.5

func _process(delta):
	current_time += delta
	
	# audio control
	if current_time >= 0+buffer and audio_counter == 0:
		play_audio(sound_02)
		audio_counter += 1
	elif current_time >= 0.1+buffer and audio_counter == 1:
		play_audio(sound_02)
		audio_counter += 1
	elif current_time >= 2.9+buffer and audio_counter == 2:
		play_audio(sound_01)
		audio_counter += 1
	elif current_time >= 6+buffer and audio_counter == 3:
		play_audio(sound_02)
		audio_counter += 1
	elif current_time >= 8.9+buffer and audio_counter == 4:
		play_audio(sound_01)
		audio_counter += 1
	elif current_time >= 12+buffer and audio_counter == 5:
		play_audio(sound_02)
		audio_counter += 1
	elif current_time >= 13.9+buffer and audio_counter == 6:
		play_audio(sound_01)
		audio_counter += 1
	elif current_time >= 17+buffer and audio_counter == 7:
		play_audio(sound_02)
		audio_counter += 1
	elif current_time >= 19.8+buffer and audio_counter == 8:
		play_audio(sound_02)
		audio_counter += 1
	
	# video control
	if current_time >= 0+buffer and video_counter == 0:
		show_img(img_01)
		video_counter += 1
	elif current_time >= 3+buffer and video_counter == 1:
		show_img(img_02)
		video_counter += 1
	elif current_time >= 6+buffer and video_counter == 2:
		show_img(img_03)
		video_counter += 1
	elif current_time >= 9+buffer and video_counter == 3:
		show_img(img_04)
		video_counter += 1
	elif current_time >= 12+buffer and video_counter == 4:
		show_img(img_05)
		video_counter += 1
	elif current_time >= 14+buffer and video_counter == 5:
		show_img(img_06)
		video_counter += 1
	elif current_time >= 17+buffer and video_counter == 6:
		show_img(img_07)
		video_counter += 1
	
	# next scene
	if current_time >= 20+buffer:
		get_tree().change_scene(next_scene_path)
	

func play_audio(a):
	audio_player.stream = a
	audio_player.play()
func show_img(img):
	video_player.texture = img