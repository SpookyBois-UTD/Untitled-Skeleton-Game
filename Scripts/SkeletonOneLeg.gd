extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (int) var speed = 200
export (int) var gravity = 4000
var _gravity
export (int) var jump_power = -3000
var invincibility_frames = 1.5


var onLadder = false

var velocity = Vector2()


# Called when the node enters the scene tree for the first time.
func _ready():
	_gravity = gravity
	$Timer.set_paused(true)
	$Timer.set_wait_time(invincibility_frames)

func get_input():
	velocity.x = 0
	if Input.is_action_pressed("player_jump"):
		jump()
	if Input.is_action_pressed("player_left"):
		move("left")
	if Input.is_action_pressed("player_right"):
		move("right")
	
	if(onLadder == true):
		gravity = 0
		if Input.is_action_pressed("player_up"):
			climb("up")
		elif Input.is_action_pressed("player_down"):
			climb("down")
		else:
			velocity.y = 0
	if(onLadder == false):
		gravity = _gravity
		

#Moves the character left or right
#Animation will make the skeleton look like it's hopping
#The direction paramater specifies what direction the skeleton will move
func move(direction : String):
	if(direction == "left"):
		velocity.x -= speed
	if(direction == "right"):
		velocity.x += speed

func climb(direction : String):
	
	if(direction == "up"):
		velocity.y = -100
	elif(direction == "down"):
		velocity.y = 100
#Makes the skeleton jump.
func jump():
	if(is_on_floor()):
		velocity.y = jump_power

#Called when player makes contact with an enemy
#Invicibility will be activated if still "alive"
func take_damage():
	$Timer.set_paused(false)
	$Timer.start(invincibility_frames)
	set_collision_layer_bit(1, false)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(!$Timer.is_stopped()):
		#Creates flashing effect when invincible
		$Sprite.set_visible(!$Sprite.is_visible())

# Called every frame. 'delta' is the elapsed time since the previous frame. This is for the physics engine
func _physics_process(delta):
	get_input()
	
	if(!is_on_floor() && !onLadder):
		velocity.y += gravity * delta
	#Moves the character in the velocity direction, the second parameter specifies what direction the floor is
	velocity = move_and_slide(velocity, Vector2.UP)
	
	


#Resets collision and sprite visibility when invincibility frames end.
func _on_Timer_timeout():
	$Timer.stop()
	$Sprite.set_visible(true)
	set_collision_layer_bit(1, true)
