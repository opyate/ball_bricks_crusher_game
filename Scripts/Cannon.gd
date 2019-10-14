extends Position2D

const ball_scene = preload("res://Scenes/Ball.tscn")
var in_flight = false
var new_velocity: Vector2
const ball_speed = 400
var ball_count = 0

func reset():
	# the cannon is a concept, a point, so we place a ball instance(s) here instead.
	for idx in range(10):
		var ball: RigidBody2D = ball_scene.instance()
		ball.visible = true
		add_child(ball)
		ball_count += 1
	
	in_flight = false

func _ready():
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

func ball_died():
	ball_count -= 1
	if ball_count == 0:
		reset()