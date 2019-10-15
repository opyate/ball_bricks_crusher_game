extends Position2D


const brick_scene = preload("res://Scenes/Brick.tscn")
var new_position
var tween_down = Tween.new()

func load_level():
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

func _ready():
	new_position = get_position()
	add_child(tween_down)
	load_level()

func _process(delta):
	if not tween_down.is_active() and new_position.y != get_position().y:
		tween_down.interpolate_property(self, "position", get_position(), new_position, 0.8, Tween.TRANS_BOUNCE, Tween.EASE_OUT)
		tween_down.start()


func _on_next_step():
	new_position.y += 32