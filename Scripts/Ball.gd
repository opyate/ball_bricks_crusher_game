extends RigidBody2D

# TODO screen scaling:
# https://www.reddit.com/r/godot/comments/aasqf0/fullscreen_scaling_with_multiple_resolutions/ed4hkfy/

var Mouse_Position
var width
var height
var in_flight = false

# Called when the node enters the scene tree for the first time.
func _ready():
	width = get_viewport_rect().size.x
	height = get_viewport_rect().size.y
	set_physics_process(true)
	print('adding ball')

func _physics_process(delta):
	Mouse_Position = get_local_mouse_position()
	rotation += Mouse_Position.angle()
	
	var bodies = get_colliding_bodies()
	for body in bodies:
		if body.is_in_group("bricks"):
			body.hit()
	
	if get_position().y > get_viewport_rect().end.y:
		queue_free()
		in_flight = false

func _input(event):
	# Mouse in viewport coordinates
	if event is InputEventMouseButton:
		if event.is_pressed():
			if not in_flight:
				in_flight = true
				var x = event.position.x - (width / 2)
				var y = event.position.y - height
				var impulse = Vector2(x, y)
				# TODO normalise impulse
				apply_central_impulse(impulse)
