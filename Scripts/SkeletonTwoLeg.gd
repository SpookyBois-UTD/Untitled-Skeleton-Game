extends "res://Scripts/SkeletonOneLeg.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (int) var run_speed = 450
var actual_speed = speed


# Called when the node enters the scene tree for the first time.
func _ready():
	._ready()

func move(direction : String):
	if(Input.is_action_pressed("player_run") && is_on_floor()):
		actual_speed = run_speed
	elif(!Input.is_action_pressed("player_run") && is_on_floor()):
		actual_speed = speed
	if(direction == "left"):
		velocity.x -= actual_speed
	if(direction == "right"):
		velocity.x += actual_speed
		
func jump():
	if(is_on_floor()):
		velocity.y = jump_power*1.75


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
