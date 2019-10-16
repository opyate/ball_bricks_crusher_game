extends Area2D

onready var bricks = get_node("/root/World/Bricks")
onready var cannon = get_node("/root/World/Cannon")
var bricks_hit_floor = false
signal player_died

func reset():
	bricks_hit_floor = false

func _ready():
	reset()
	connect("body_entered", self, "_on_body_entered")
	connect("player_died", self, "_on_player_died")
	connect("player_died", bricks, "_on_player_died")

func _on_body_entered(body: PhysicsBody2D):
	if body.is_in_group("bricks"):
		if not bricks_hit_floor:
			bricks_hit_floor = true
			# we just want to signal on the first brick
			emit_signal("player_died")
	elif body.is_in_group("balls"):
		cannon._ball_last_position(body.get_position())

func _on_player_died():
	yield(get_tree().create_timer(.5), "timeout")
	reset()