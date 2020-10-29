extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var velocity = Vector2()
var ground = Vector2.UP
export (int) var speed = 50
export (int) var gravity = 1000
enum crawling_on{
	GROUND,
	CEILING,
	WALL_LEFT,
	WALL_RIGHT
}
var state
var start_on_ground = false


# Called when the node enters the scene tree for the first time.
func _ready():
	state = crawling_on.GROUND



#checks to see what vectors should be applied on the spider so it is always crawling on a surface
func check_for_direction():
	if(is_on_floor()):
		start_on_ground = !start_on_ground
	if(!is_on_floor() && start_on_ground):
		if(state == crawling_on.GROUND && !$Sprite.is_flipped_h()):
			state = crawling_on.WALL_RIGHT
			ground = Vector2.RIGHT
			$Sprite.set_rotation_degrees(270)
			gravity = abs(gravity)
			velocity.y += speed

func _physics_process(delta):
	velocity = Vector2()
	velocity.x -= speed
	check_for_direction()
	if(state == crawling_on.WALL_LEFT || state == crawling_on.WALL_RIGHT):
		velocity.x = gravity * delta
	else:
		velocity.y = gravity * delta
	velocity = move_and_slide(velocity, ground)
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

#Check if the spider collides with the player, or another enemy
func _on_EntityCollision_body_entered(body):
	if body.get_collision_layer_bit(1) && body.has_method("take_damage"):
		body.take_damage()
	if body.get_collision_layer_bit(2):
		pass
