extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (int) var speed = 200
export (int) var gravity = 4000
var _gravity
export (int) var jump_power = -3000

var onLadder = false

var velocity = Vector2()


# Called when the node enters the scene tree for the first time.
func _ready():
	_gravity = gravity
	
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
		
	print_debug(gravity)

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
		print_debug("Going up")
	elif(direction == "down"):
		velocity.y = 100
#Makes the skeleton jump. This is higher then the standard hop while moving
func jump():
	if(is_on_floor()):
		velocity.y = jump_power

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	get_input()
	
	if(!is_on_floor() && !onLadder):
		velocity.y += gravity * delta
	#Moves the character in the velocity direction, the second parameter specifies what direction the floor is
	print_debug(velocity.y)
	velocity = move_and_slide(velocity, Vector2.UP)
	
	
