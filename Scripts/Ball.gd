extends RigidBody2D

# TODO screen scaling:
# https://www.reddit.com/r/godot/comments/aasqf0/fullscreen_scaling_with_multiple_resolutions/ed4hkfy/

onready var cannon = get_parent()

# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(true)
	position = Vector2(0,0)

func _physics_process(delta):	
	var bodies = get_colliding_bodies()
	for body in bodies:
		if body.is_in_group("bricks"):
			body.hit()
	
	if get_position().y > get_viewport_rect().end.y:
		queue_free()
