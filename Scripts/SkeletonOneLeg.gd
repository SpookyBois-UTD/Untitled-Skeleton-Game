extends KinematicBody2D

enum Anim{
	Walking,
	Running,
	Climbing,
	ClimbingIdle,
	Idle
}
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (int) var speed = 200
export (int) var gravity = 3000
var _gravity
export (int) var jump_power = -500
var invincibility_frames = 1.5
var faceRight = true
var state
#var onLadder = false
var isWalking = false
var velocity = Vector2()

var health = 3
signal health_changed(health)
var level = "res://Scenes/Test.tscn" # Change scene for each skeleton phase
signal game_over(level)

# Called when the node enters the scene tree for the first time.
func _ready():
	var boneNode = get_tree().get_root().find_node("Bone", true, false)
	if(boneNode != null):
		boneNode.connect("bone_collected", self, "collected_bone")
	_gravity = gravity
	$Timer.set_paused(true)
	$Timer.set_wait_time(invincibility_frames)

func get_input():
	velocity.x = 0
	if Input.is_action_pressed("player_jump"):
		jump()
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
	#elif (!state == Anim.Climbing):
	else:
		state = Anim.Idle
		Animate()
		
	
	"""if(onLadder == true):
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
		gravity = _gravity"""
		

#Moves the character left or right
#Animation will make the skeleton look like it's hopping
#The direction paramater specifies what direction the skeleton will move
func move(direction : String):
	if(direction == "left"):
		velocity.x -= speed
	if(direction == "right"):
		velocity.x += speed

"""func climb(direction : String):
	
	if(direction == "up"):
		velocity.y = -100
	elif(direction == "down"):
		velocity.y = 100
	
	state = Anim.Climbing
	Animate()"""
#Makes the skeleton jump.
func jump():
	if(is_on_floor()):
		velocity.y = jump_power

#Called when player makes contact with an enemy
#Invicibility will be activated if still "alive"
func take_damage():
	health -= 1
	emit_signal("health_changed", health)
	if health == 0:
		emit_signal("game_over", level)
	elif health > 0:
		$Timer.set_paused(false)
		$Timer.start(invincibility_frames)
		set_collision_layer_bit(1, false)
		
func heal():
	if health < 3:
		health += 1
		emit_signal("health_changed", health)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(!$Timer.is_stopped()):
		#Creates flashing effect when invincible
		$Sprite.set_visible(!$Sprite.is_visible())

# Called every frame. 'delta' is the elapsed time since the previous frame. This is for the physics engine
func _physics_process(delta):
	get_input()
	
	if(!is_on_floor()):
	#if(!is_on_floor() && !onLadder):
		velocity.y += gravity * delta
	#Moves the character in the velocity direction, the second parameter specifies what direction the floor is
	velocity = move_and_slide(velocity, Vector2.UP)
	
	
func collected_bone():
	get_parent().acquire_bone()

#Resets collision and sprite visibility when invincibility frames end.
func _on_Timer_timeout():
	$Timer.stop()
	$Sprite.set_visible(true)
	set_collision_layer_bit(1, true)

func Animate():
	if(state == Anim.Walking):
		$AnimationPlayer.play("One_Leg_Walk")
	else:
		$AnimationPlayer.seek(0.0, true)
		$AnimationPlayer.stop(true)

func changeDir():
	if(faceRight):
		$Sprite.set_flip_h(false)
	else:
		$Sprite.set_flip_h(true)




func _on_GUI_restart_level():
	get_tree().change_scene(level)


func _on_Batty_stomped():
	velocity.y = jump_power
