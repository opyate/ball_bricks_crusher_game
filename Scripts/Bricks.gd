extends Position2D


const brick_scene = preload("res://Scenes/Brick.tscn")
var new_position
var tween_down = Tween.new()
var color_names = ["aliceblue", "antiquewhite", "aqua", "aquamarine", "azure", "beige", "bisque", "black", "blanchedalmond", "blue", "blueviolet", "brown", "burlywood", "cadetblue", "chartreuse", "chocolate", "coral", "cornflower", "cornsilk", "crimson", "cyan", "darkblue", "darkcyan", "darkgoldenrod", "darkgray", "darkgreen", "darkkhaki", "darkmagenta", "darkolivegreen", "darkorange", "darkorchid", "darkred", "darksalmon", "darkseagreen", "darkslateblue", "darkslategray", "darkturquoise", "darkviolet", "deeppink", "deepskyblue", "dimgray", "dodgerblue", "firebrick", "floralwhite", "forestgreen", "fuchsia", "gainsboro", "ghostwhite", "gold", "goldenrod", "gray", "webgray", "green", "webgreen", "greenyellow", "honeydew", "hotpink", "indianred", "indigo", "ivory", "khaki", "lavender", "lavenderblush", "lawngreen", "lemonchiffon", "lightblue", "lightcoral", "lightcyan", "lightgoldenrod", "lightgray", "lightgreen", "lightpink", "lightsalmon", "lightseagreen", "lightskyblue", "lightslategray", "lightsteelblue", "lightyellow", "lime", "limegreen", "linen", "magenta", "maroon", "webmaroon", "mediumaquamarine", "mediumblue", "mediumorchid", "mediumpurple", "mediumseagreen", "mediumslateblue", "mediumspringgreen", "mediumturquoise", "mediumvioletred", "midnightblue", "mintcream", "mistyrose", "moccasin", "navajowhite", "navyblue", "oldlace", "olive", "olivedrab", "orange", "orangered", "orchid", "palegoldenrod", "palegreen", "paleturquoise", "palevioletred", "papayawhip", "peachpuff", "peru", "pink", "plum", "powderblue", "purple", "webpurple", "rebeccapurple", "red", "rosybrown", "royalblue", "saddlebrown", "salmon", "sandybrown", "seagreen", "seashell", "sienna", "silver", "skyblue", "slateblue", "slategray", "snow", "springgreen", "steelblue", "tan", "teal", "thistle", "tomato", "turquoise", "violet", "wheat", "white", "whitesmoke", "yellow", "yellowgreen"]

func reset():
	new_position = Vector2(0, 0)
	
	# HACK: wait a second before we remove all the bricks so the tween can finish
	# otherwise the stationary ball "hits" one of the new bricks while the
	# container is still at the bottom of the screen
	yield(get_tree().create_timer(1.0), "timeout")
	remove_all_bricks()
	load_level()

func remove_all_bricks():
	for node in get_children():
		if node.is_in_group("bricks"):
			node.queue_free()

func load_level():
	var random_color = color_names[randi() % color_names.size()]
	# set up a grid of bricks, and add them to a group
	# TODO load these values from a level file.
	var width = get_viewport_rect().size.x
	var height = get_viewport_rect().size.y
	for x in range(16, width, 32):
		for y in range(16, ceil(height * 0.66), 32):
			var brick: StaticBody2D = brick_scene.instance()
			brick.position = Vector2(x, y)
			brick.visible = true
			brick.set_value(10)
			brick.set_color(random_color)
			add_child(brick)

func _ready():
	add_child(tween_down)
	reset()

func _process(delta):
	if not tween_down.is_active() and new_position.y != get_position().y:
		tween_down.interpolate_property(self, "position", get_position(), new_position, 0.8, Tween.TRANS_BOUNCE, Tween.EASE_OUT)
		tween_down.start()

# move all the bricks down
func _on_next_step():
	new_position.y += 32

func _on_player_died():
	reset()
