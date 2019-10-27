extends Node2D

# credit: https://www.dafont.com/squarefont.font
const game_scene = preload("res://Scenes/Game.tscn")
signal start_game

func _ready():
	var game: Node = game_scene.instance()
	add_child(game)
	connect("start_game", game, "_on_start_game")
	
	var bricks = game.get_child(2)
	connect("start_game", bricks, "_on_start_game")
	
	var level_number = 0
	emit_signal("start_game", level_number)


func _on_next_step():
	print("world: next step!")
