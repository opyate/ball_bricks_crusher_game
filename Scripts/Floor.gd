extends Area2D

onready var cannon = get_node("/root/World/Cannon")

func _ready():
	connect("body_entered", self, "_on_body_entered")

func _on_body_entered(body):
	cannon._ball_last_position(body.get_position())
