extends StaticBody2D

var value = 1

func hit():
	set_value(value - 1)
	if value == 0:
		print('brick die')
		self.queue_free()

func set_value(val):
	var label: Label = self.get_child(2)
	value = val
	label.text = str(val)

func _ready():
    add_to_group("bricks")

