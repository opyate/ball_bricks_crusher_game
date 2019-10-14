extends Position2D

const ball_scene = preload("res://Scenes/Ball.tscn")
var in_flight = false
var balls = []
var new_velocity: Vector2

const ball_speed = 400

func _ready():
	set_physics_process(true)
	
	# the cannon is a concept, a point, so we place a ball instance here instead.
	for idx in range(50):
		var ball: RigidBody2D = ball_scene.instance()
		ball.visible = true
		add_child(ball)
		balls.append(ball)

func _input(event):
	# Mouse in viewport coordinates
	if event is InputEventMouseButton:
		if event.is_pressed():
			if not in_flight:
				var shoot_direction: Vector2 = event.position - position
				new_velocity = shoot_direction.normalized() * ball_speed
				in_flight = true
				for ball in balls:
					yield(get_tree().create_timer(.1), "timeout")
					ball.apply_central_impulse(new_velocity)
