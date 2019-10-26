extends Node2D

func _ready():
	# TODO this doesn't work, but it works if we connect from World.gd
	# REPORT BUG????
	# connect("start_game", self, "_on_start_game")
	pass

func _on_start_game(level_number):
	print("Game _on_start_game ", level_number)
	