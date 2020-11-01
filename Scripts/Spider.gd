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
export (crawling_on) var state = crawling_on.GROUND
var start_on_ground = false
var stopped = true
export (bool) var flip = false


# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite.set_flip_h(flip)
	if(state == crawling_on.GROUND && !$Sprite.is_flipped_h()):
		ground = Vector2.UP
		$Sprite.set_rotation_degrees(0)
	elif(state == crawling_on.CEILING && !$Sprite.is_flipped_h()):
		ground = Vector2.DOWN
		$Sprite.set_rotation_degrees(180)
	elif(state == crawling_on.WALL_RIGHT && !$Sprite.is_flipped_h()):
		ground = Vector2.RIGHT
		$Sprite.set_rotation_degrees(90)
	elif(state == crawling_on.WALL_LEFT && !$Sprite.is_flipped_h()):
		ground = Vector2.LEFT
		$Sprite.set_rotation_degrees(270)



#checks to see what vectors should be applied on the spider so it is always crawling on a surface
func check_for_direction():
	if(is_on_floor()):
		start_on_ground = true
	if(!is_on_floor() && start_on_ground && stopped):
		stopped = false
		$FlipBuffer.set_paused(stopped)
		$FlipBuffer.start(0.1)
		if(state == crawling_on.GROUND && !$Sprite.is_flipped_h()):
			$Sprite.set_rotation_degrees(270)
			state = crawling_on.WALL_LEFT
			ground = Vector2.LEFT
		elif(state == crawling_on.GROUND):
			$Sprite.set_rotation_degrees(90)
			state = crawling_on.WALL_RIGHT
			ground = Vector2.RIGHT
		elif(state == crawling_on.WALL_LEFT && !$Sprite.is_flipped_h()):
			$Sprite.set_rotation_degrees(180)
			state = crawling_on.CEILING
			ground = Vector2.DOWN
		elif(state == crawling_on.WALL_LEFT):
			$Sprite.set_rotation_degrees(0)
			state = crawling_on.GROUND
			ground = Vector2.UP
		elif(state == crawling_on.CEILING && !$Sprite.is_flipped_h()):
			$Sprite.set_rotation_degrees(90)
			state = crawling_on.WALL_RIGHT
			ground = Vector2.RIGHT
		elif(state == crawling_on.CEILING):
			$Sprite.set_rotation_degrees(270)
			state = crawling_on.WALL_LEFT
			ground = Vector2.LEFT
		elif(state == crawling_on.WALL_RIGHT && !$Sprite.is_flipped_h()):
			$Sprite.set_rotation_degrees(0)
			state = crawling_on.GROUND
			ground = Vector2.UP
		else:
			$Sprite.set_rotation_degrees(180)
			state = crawling_on.CEILING
			ground = Vector2.DOWN
	elif(is_on_wall() && stopped):
		stopped = false
		$FlipBuffer.set_paused(stopped)
		$FlipBuffer.start(0.1)
		if(state == crawling_on.GROUND && !$Sprite.is_flipped_h()):
			$Sprite.set_rotation_degrees(90)
			state = crawling_on.WALL_RIGHT
			ground = Vector2.RIGHT
		elif(state == crawling_on.GROUND):
			$Sprite.set_rotation_degrees(270)
			state = crawling_on.WALL_LEFT
			ground = Vector2.LEFT
		elif(state == crawling_on.WALL_LEFT && !$Sprite.is_flipped_h()):
			$Sprite.set_rotation_degrees(0)
			state = crawling_on.GROUND
			ground = Vector2.UP
		elif(state == crawling_on.WALL_LEFT):
			$Sprite.set_rotation_degrees(180)
			state = crawling_on.CEILING
			ground = Vector2.DOWN
		elif(state == crawling_on.CEILING && !$Sprite.is_flipped_h()):
			$Sprite.set_rotation_degrees(270)
			state = crawling_on.WALL_LEFT
			ground = Vector2.LEFT
		elif(state == crawling_on.CEILING):
			$Sprite.set_rotation_degrees(90)
			state = crawling_on.WALL_RIGHT
			ground = Vector2.RIGHT
		elif(state == crawling_on.WALL_RIGHT && !$Sprite.is_flipped_h()):
			$Sprite.set_rotation_degrees(180)
			state = crawling_on.CEILING
			ground = Vector2.DOWN
		else:
			$Sprite.set_rotation_degrees(0)
			state = crawling_on.GROUND
			ground = Vector2.UP

#moves the spider in the directions set by check_for_direction. Uses delta from _physics_process to calculate gravity
func move(delta):
	check_for_direction()
	if(state == crawling_on.GROUND && !$Sprite.is_flipped_h()):
		velocity.x = -speed
		velocity.y = gravity * delta
	elif(state == crawling_on.GROUND):
		velocity.x = speed
		velocity.y = gravity * delta
	elif(state == crawling_on.WALL_LEFT && !$Sprite.is_flipped_h()):
		velocity.y = speed
		velocity.x = gravity * delta
	elif(state == crawling_on.WALL_LEFT):
		velocity.y = -speed
		velocity.x = gravity * delta
	elif(state == crawling_on.CEILING && !$Sprite.is_flipped_h()):
		velocity.x = speed
		velocity.y = -gravity * delta
	elif(state == crawling_on.CEILING):
		velocity.x = -speed
		velocity.y = -gravity * delta
	elif(state == crawling_on.WALL_RIGHT && !$Sprite.is_flipped_h()):
		velocity.y = -speed
		velocity.x = -gravity * delta
	else:
		velocity.y = speed
		velocity.x = -gravity * delta
	velocity = move_and_slide(velocity, ground)

func _physics_process(delta):
	move(delta)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

#Check if the spider collides with the player, or another enemy
func _on_EntityCollision_body_entered(body):
	if body.get_collision_layer_bit(1) && body.has_method("take_damage"):
		body.take_damage(1)
	if body.get_collision_layer_bit(2) && body != self:
		$Sprite.set_flip_h(!$Sprite.is_flipped_h())


func _on_FlipBuffer_timeout():
	stopped = true
	$FlipBuffer.set_paused(stopped)
