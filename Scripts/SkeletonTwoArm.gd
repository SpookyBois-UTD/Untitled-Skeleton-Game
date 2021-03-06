extends "res://Scripts/SkeletonOneArm.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var onLadder = false
var torso = false
# Called when the node enters the scene tree for the first time.
func _ready():
	._ready()
	set_collision_layer_bit(2,true)

func get_input():
	velocity.x = 0
	if Input.is_action_pressed("player_jump"):
		jump()
	if Input.is_action_pressed("player_pickup"):
		pass
	if Input.is_action_pressed("player_use"):
		pass
	if Input.is_action_pressed("player_left"):
		move("left")
		faceRight = false
		if(is_on_floor()):
			isWalking = true
			state = Anim.Walking
			Animate()
		changeDir()
	elif Input.is_action_pressed("player_right"):
		move("right")
		faceRight = true
		if(is_on_floor()):
			isWalking = true
			state = Anim.Walking
			Animate()
		changeDir()
	elif (!state == Anim.Climbing):
		state = Anim.Idle
		Animate()
		
	
	if(onLadder == true):
		gravity = 0
		if Input.is_action_pressed("player_up"):
			climb("up")
		elif Input.is_action_pressed("player_down"):
			climb("down")
		else:
			velocity.y = 0
			if (!is_on_floor()):
				state = Anim.ClimbingIdle
				Animate()
	if(onLadder == false):
		gravity = _gravity

func climb(direction : String):
	
	if(direction == "up"):
		velocity.y = -100
	elif(direction == "down"):
		velocity.y = 100
	state = Anim.Climbing
	Animate()

func _physics_process(delta):
	get_input()
	
	if(!is_on_floor() && !onLadder):
		velocity.y += gravity * delta
	#Moves the character in the velocity direction, the second parameter specifies what direction the floor is
	velocity = move_and_slide(velocity, Vector2.UP)

func Animate():
	if(state == Anim.Climbing):
		$AnimationPlayer.play("Climbing")
	if(state == Anim.Walking):
		$AnimationPlayer.play("Two_Arm_Walking")
	elif(state == Anim.ClimbingIdle):
		$AnimationPlayer.play("IdleBack")
	else:
		$AnimationPlayer.play("Two_Arm_Side_Idle")

func is_on_ladder(status : bool):
	onLadder = status

func collected_bone():
	$Sprite.collected_bone()
	torso = true
	
func win():
	$GUI/Interface/Win.visible = true



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
