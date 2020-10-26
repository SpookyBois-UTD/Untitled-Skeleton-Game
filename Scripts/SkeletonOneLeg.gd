extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (int) var speed = 200
export (int) var gravity = 4000
export (int) var jump_power = -3000
var velocity = Vector2()


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func get_input():
	velocity.x = 0
	if Input.is_action_pressed("player_jump"):
		jump()
	if Input.is_action_pressed("player_left"):
		move("left")
	if Input.is_action_pressed("player_right"):
		move("right")

#Moves the character left or right
#Animation will make the skeleton look like it's hopping
#The direction paramater specifies what direction the skeleton will move
func move(direction : String):
	if(direction == "left"):
		velocity.x -= speed
	if(direction == "right"):
		velocity.x += speed

#Makes the skeleton jump. This is higher then the standard hop while moving
func jump():
	if(is_on_floor()):
		velocity.y = jump_power


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	get_input()
	velocity.y += gravity * delta
	#Moves the character in the velocity direction, the second parameter specifies what direction the floor is
	move_and_slide(velocity, Vector2(0, -1))
	
