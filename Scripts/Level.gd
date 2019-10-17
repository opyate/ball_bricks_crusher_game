extends Node2D

class_name Level

const brick_scene = preload("res://Scenes/Brick.tscn")
var rng = RandomNumberGenerator.new()
const all_color_names = ["aliceblue", "antiquewhite", "aqua", "aquamarine", "azure", "beige", "bisque", "black", "blanchedalmond", "blue", "blueviolet", "brown", "burlywood", "cadetblue", "chartreuse", "chocolate", "coral", "cornflower", "cornsilk", "crimson", "cyan", "darkblue", "darkcyan", "darkgoldenrod", "darkgray", "darkgreen", "darkkhaki", "darkmagenta", "darkolivegreen", "darkorange", "darkorchid", "darkred", "darksalmon", "darkseagreen", "darkslateblue", "darkslategray", "darkturquoise", "darkviolet", "deeppink", "deepskyblue", "dimgray", "dodgerblue", "firebrick", "floralwhite", "forestgreen", "fuchsia", "gainsboro", "ghostwhite", "gold", "goldenrod", "gray", "webgray", "green", "webgreen", "greenyellow", "honeydew", "hotpink", "indianred", "indigo", "ivory", "khaki", "lavender", "lavenderblush", "lawngreen", "lemonchiffon", "lightblue", "lightcoral", "lightcyan", "lightgoldenrod", "lightgray", "lightgreen", "lightpink", "lightsalmon", "lightseagreen", "lightskyblue", "lightslategray", "lightsteelblue", "lightyellow", "lime", "limegreen", "linen", "magenta", "maroon", "webmaroon", "mediumaquamarine", "mediumblue", "mediumorchid", "mediumpurple", "mediumseagreen", "mediumslateblue", "mediumspringgreen", "mediumturquoise", "mediumvioletred", "midnightblue", "mintcream", "mistyrose", "moccasin", "navajowhite", "navyblue", "oldlace", "olive", "olivedrab", "orange", "orangered", "orchid", "palegoldenrod", "palegreen", "paleturquoise", "palevioletred", "papayawhip", "peachpuff", "peru", "pink", "plum", "powderblue", "purple", "webpurple", "rebeccapurple", "red", "rosybrown", "royalblue", "saddlebrown", "salmon", "sandybrown", "seagreen", "seashell", "sienna", "silver", "skyblue", "slateblue", "slategray", "snow", "springgreen", "steelblue", "tan", "teal", "thistle", "tomato", "turquoise", "violet", "wheat", "white", "whitesmoke", "yellow", "yellowgreen"]
# prefered colors for the game:
# yellow, green, blue, purple, red
const colors_indeces = [60, 79, 120, 30, 103]

# if level_number is low, place fewer blocks, with lower values.
# every few levels, the block layout can cycle, but the values go up
# block physical sizes can also go up, and they'd have larger values
func set_level(parent: Node, level_number: int, width: int, height: int):
	rng.set_seed(1)
	# 0.66 to leave some space for the ball at the bottom
	var blocks_height = ceil(height * 0.66)
	var every20 = level_number % 20
	var number_of_blocks = randi() % (level_number + 10)

	# set up a grid of bricks, and add them to a group
	for x in range(16, width, 32):
		for y in range(16, blocks_height, 32):
			# skip bricks for these conditions
			var is_x_edge: bool = x == 16 or x == width - 16
			var is_y_edge: bool = y == 16 or y == blocks_height - 16
			# skip the edges for 10 turns, every 10 turns
			if is_x_edge and every20 < 10:
				continue
			if is_y_edge and every20 < 10:
				continue
			
			# checkered pattern
			if x % (16 + 32+32+32) == 0 and every20 % 2 == 0:
				continue
			
			var brick: StaticBody2D = brick_scene.instance()
			brick.position = Vector2(x, y)
			brick.visible = true
			brick.set_value(10)
			var color_idx = colors_indeces[rng.randi() % colors_indeces.size()]
			brick.set_color(all_color_names[color_idx])
			parent.add_child(brick)