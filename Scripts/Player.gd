extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
enum limbs{
	HEAD,
	ONE_LEG
	TWO_LEGS
	ONE_ARM
	TWO_ARMS
}
export (limbs) var status = limbs.HEAD
var scene
var player_body


# Called when the node enters the scene tree for the first time.
func _ready():
	if(status == limbs.HEAD):
		scene = load("res://Scenes/SkeletonHead.tscn")
		player_body = scene.instance()
		add_child(player_body)
	elif(status == limbs.ONE_LEG):
		scene = load("res://Scenes/SkeletonOneLeg.tscn")
		player_body = scene.instance()
		add_child(player_body)
	elif(status == limbs.TWO_LEGS):
		scene = load("res://Scenes/SkeletonTwoLeg.tscn")
		player_body = scene.instance()
		add_child(player_body)
	elif(status == limbs.ONE_ARM):
		scene = load("res://Scenes/SkeletonOneArm.tscn")
		player_body = scene.instance()
		add_child(player_body)
	elif(status == limbs.TWO_ARMS):
		scene = load("res://Scenes/SkeletonTwoArm.tscn")
		player_body = scene.instance()
		add_child(player_body)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
