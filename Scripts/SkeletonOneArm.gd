extends "res://Scripts/SkeletonTwoLeg.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"



# Called when the node enters the scene tree for the first time.
func _ready():
	._ready()

func get_input():
	.get_input()
	if Input.is_action_pressed("player_pickup"):
		pass
	if Input.is_action_pressed("player_use"):
		pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
