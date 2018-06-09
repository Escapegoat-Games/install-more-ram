extends "res://Scripts/NPC.gd"

export(SpriteFrames) var textures

func load_sprite():
	main_sprite.frames = textures