extends KinematicBody2D

var value = 1

func hit():
	set_value(value - 1)
	if value == 0:
		# wait half a second for particle effect
		# yield(get_tree().create_timer(.5), "timeout")
		self.queue_free()

func set_value(val):
	var label: Label = self.get_child(2)
	value = val
	label.text = str(val)

func set_color(color):
	var colorRect: ColorRect = self.get_child(1)
	colorRect.set_frame_color(ColorN(color))

func _ready():
    add_to_group("bricks")