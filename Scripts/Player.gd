extends Position2D


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
var player_pos


# Called when the node enters the scene tree for the first time.
func _ready():
	if(status == limbs.HEAD):
		scene = load("res://Scenes/SkeletonHead.tscn")
		player_body = scene.instance()
		add_child(player_body)
		get_child(0).set_global_position(get_global_position())
	elif(status == limbs.ONE_LEG):
		scene = load("res://Scenes/SkeletonOneLeg.tscn")
		player_body = scene.instance()
		add_child(player_body)
		get_child(0).global_position = self.get_global_position()
	elif(status == limbs.TWO_LEGS):
		scene = load("res://Scenes/SkeletonTwoLeg.tscn")
		player_body = scene.instance()
		add_child(player_body)
		get_child(0).global_position = self.get_global_position()
	elif(status == limbs.ONE_ARM):
		scene = load("res://Scenes/SkeletonOneArm.tscn")
		player_body = scene.instance()
		add_child(player_body)
		get_child(0).global_position = self.get_global_position()
	elif(status == limbs.TWO_ARMS):
		scene = load("res://Scenes/SkeletonTwoArm.tscn")
		player_body = scene.instance()
		add_child(player_body)
		get_child(0).global_position = self.get_global_position()
	print_debug(get_child(0).global_position)

func get_input():
	if Input.is_action_just_pressed("debug_level_up"):
		aquire_bone()

func aquire_bone():
	if(status == limbs.HEAD):
			player_pos = get_child(0).get_global_position()
			scene = load("res://Scenes/SkeletonOneLeg.tscn")
			player_body = scene.instance()
			add_child(player_body)
			get_child(1).set_global_position(player_pos)
			status = limbs.ONE_LEG
			get_child(0).queue_free()
	elif(status == limbs.ONE_LEG):
		player_pos = get_child(0).get_global_position()
		scene = load("res://Scenes/SkeletonTwoLeg.tscn")
		player_body = scene.instance()
		add_child(player_body)
		get_child(1).set_global_position(player_pos)
		status = limbs.TWO_LEGS
		get_child(0).queue_free()
	elif(status == limbs.TWO_LEGS):
		player_pos = get_child(0).get_global_position()
		scene = load("res://Scenes/SkeletonOneArm.tscn")
		player_body = scene.instance()
		add_child(player_body)
		get_child(1).set_global_position(player_pos)
		status = limbs.ONE_ARM
		get_child(0).queue_free()
	elif(status == limbs.ONE_ARM):
		player_pos = get_child(0).get_global_position()
		scene = load("res://Scenes/SkeletonTwoArm.tscn")
		player_body = scene.instance()
		add_child(player_body)
		get_child(1).set_global_position(player_pos)
		status = limbs.TWO_ARMS
		get_child(0).queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
<<<<<<< HEAD
	get_input()
=======
	get_input()
>>>>>>> 98bb854f0182d5b4d2040ca2b89706d545336689
