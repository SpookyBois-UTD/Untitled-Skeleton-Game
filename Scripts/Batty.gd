extends KinematicBody2D


# Member variables
var velocity = Vector2()
export var direction = -1 # 1 = move right/down, -1 = move left/up
var height = -20
var vDir = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	if direction == 1:
		$Sprite.flip_h = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_on_wall():
		direction = direction * -1
		$Sprite.flip_h = not $Sprite.flip_h
		
	if height == -20:
		vDir = vDir * -1
		velocity.y = 50 * vDir
		height = 20
	
	height = height - 1
	velocity.x = 50 * direction
	
	velocity = move_and_slide(velocity,Vector2.UP)

#Checks to see if the player collision node has collided with a node on the player layer
func _on_PlayerCollision_body_entered(body : KinematicBody2D):
	if body.get_collision_layer_bit(1) && body.has_method("take_damage"):
		body.take_damage()
