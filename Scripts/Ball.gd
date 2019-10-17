extends RigidBody2D

# TODO screen scaling:
# https://www.reddit.com/r/godot/comments/aasqf0/fullscreen_scaling_with_multiple_resolutions/ed4hkfy/

onready var cannon = get_parent()
var timer = Timer.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("balls")
	set_physics_process(true)
	$VisibilityNotifier.connect("screen_exited", self, "_on_screen_exited")
	$VisibilityNotifier.connect("screen_exited", cannon, "_on_ball_died")
	
	# timer to speed up in 2 seconds
	timer.set_wait_time(10.0)
	timer.connect("timeout", self, "speed_up")
	add_child(timer)

func shoot(new_velocity):
	apply_central_impulse(new_velocity)
	timer.start()

func _physics_process(delta):
	var bodies = get_colliding_bodies()
	for body in bodies:
		if body.is_in_group("bricks"):
			body.hit()

func _on_screen_exited():
	queue_free()

func speed_up():
	var current_linear_velocity = get_linear_velocity()
	set_linear_velocity(current_linear_velocity * 1.5)