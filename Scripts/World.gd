extends Node2D

# credit: https://www.dafont.com/squarefont.font

const brick_scene = preload("res://Scenes/Brick.tscn")


func _ready():
	# set up a grid of bricks, and add them to a group
	# TODO load these values from a level file.
	var width = get_viewport_rect().size.x
	var height = get_viewport_rect().size.y
	for x in range(16, width, 32):
		for y in range(16, ceil(height * 0.7), 32):
			var brick: StaticBody2D = brick_scene.instance()
			brick.position = Vector2(x, y)
			brick.visible = true
			brick.set_value(10)
			add_child(brick)
