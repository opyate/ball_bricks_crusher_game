extends Position2D

const ball_scene = preload("res://Scenes/Ball.tscn")
var in_flight = false
var new_velocity: Vector2
const ball_speed = 400
var ball_count = 0
signal next_step

var number_of_balls = 10

# this is set to Vector2(0,0) for starters so that when reset() is run for the first time,
# it gets a valid ball_last_position.x
var ball_last_position = Vector2(0,0)

# this is called after every "try" and should be the single place where everything is reset.
func reset():
	# ball count was not zero - leak?
	assert(ball_count == 0)
	ball_count = 0
	# the cannon is a concept, a point, so we place a ball instance(s) here instead.
	for idx in range(number_of_balls):
		var ball: RigidBody2D = ball_scene.instance()
		ball.visible = true
		add_child(ball)
		ball_count += 1
	
	var my_position = get_position()
	my_position.x += ball_last_position.x
	set_position(my_position)
		
	in_flight = false
	ball_last_position = Vector2(0,0)

func _ready():
	var width = get_viewport_rect().size.x
	var height = get_viewport_rect().size.y
	# height - 32 is also the position where the floor is
	set_position(Vector2(width / 2, height - 32))
	
	connect("next_step", get_parent(), "_on_next_step", [])
	connect("next_step", get_node("/root/World/Bricks"), "_on_next_step", [])
	set_physics_process(true)
	reset()

func _input(event):
	# Mouse in viewport coordinates
	if event is InputEventMouseButton:
		if event.is_pressed():
			if not in_flight:
				var shoot_direction: Vector2 = event.position - position
				new_velocity = shoot_direction.normalized() * ball_speed
				in_flight = true
				for ball in get_children():
					yield(get_tree().create_timer(.1), "timeout")
					ball.apply_central_impulse(new_velocity)

# this is called whenever a ball dies, via a signal
func _on_ball_died():
	ball_count -= 1
	if ball_count == 0:
		emit_signal("next_step")
		reset()

func _ball_last_position(position: Vector2):
	if ball_last_position != position:
		ball_last_position = Vector2(position.x, position.y)