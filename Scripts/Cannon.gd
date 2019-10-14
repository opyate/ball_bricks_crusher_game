extends Position2D

const ball_scene = preload("res://Scenes/Ball.tscn")

func _ready():
	var width = get_viewport_rect().size.x
	var height = get_viewport_rect().size.y
	
	# the cannon is a concept, a point, so we place a ball instance here instead.
	var ball: RigidBody2D = ball_scene.instance()
	
	# TODO perhaps in the Ball on-ready, we set the position to parent.position?
	ball.position = Vector2(width / 2, height - 20)
	ball.visible = true
	add_child(ball)