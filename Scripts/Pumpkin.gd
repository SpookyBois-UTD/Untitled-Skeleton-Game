extends KinematicBody2D


# Declare member variables here. Examples:
var light_tex = load("res://Sprites/pumpkin_light_bigger.png")
var lit = false
var velocity = Vector2()
export var direction = 1 # 1 = move right/down, -1 = move left/up
var degree = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	rotation_degrees = fmod(rotation_degrees, 360)
	if direction == -1:
		$Sprite.flip_h = true

	

func _on_Area2D_body_entered(body):
	$Sprite.texture = light_tex
	lit = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity.y += 20
	if lit == true:
		
		if is_on_wall():
			direction = direction * -1
			$Sprite.flip_h = not $Sprite.flip_h
			
		if degree == 360:
			degree = 0
		set_rotation_degrees(degree * direction)
		degree = degree + 5
		
		
		velocity.x = 70 * direction
		
	velocity = move_and_slide(velocity,Vector2.UP)



func _on_Player_Collision_body_entered(body):
	if body.get_collision_layer_bit(2) && body.has_method("take_damage"):
		body.take_damage(2)
