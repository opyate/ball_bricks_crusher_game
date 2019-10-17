extends Position2D



var new_position
var tween_down = Tween.new()

const Level = preload("Level.gd")
var level = Level.new()
var width
var height

func reset(level_number = 0):
	new_position = Vector2(0, 0)
	
	# HACK: wait a second before we remove all the bricks so the tween can finish
	# otherwise the stationary ball "hits" one of the new bricks while the
	# container is still at the bottom of the screen
	yield(get_tree().create_timer(1.0), "timeout")
	remove_all_bricks()
	load_level(level_number)

func remove_all_bricks():
	for node in get_children():
		if node.is_in_group("bricks"):
			node.queue_free()

func load_level(level_number):
	level.set_level(self, level_number, width, height)

# debug just shows every level layout for 1 second
var debug = false
func _ready():
	width = get_viewport_rect().size.x
	height = get_viewport_rect().size.y
	add_child(tween_down)
	
	if debug:
		tween_down = false
		for i in range(20):
			print('level ', i)
			remove_all_bricks()
			load_level(i)
			yield(get_tree().create_timer(1.0), "timeout")
	else:
		reset()
	

func _process(delta):
	if tween_down and not tween_down.is_active() and new_position.y != get_position().y:
		tween_down.interpolate_property(self, "position", get_position(), new_position, 0.8, Tween.TRANS_BOUNCE, Tween.EASE_OUT)
		tween_down.start()

# move all the bricks down
func _on_next_step():
	new_position.y += 32

func _on_player_died():
	reset()
