extends KinematicBody2D


var coinScore = 0

export (int) var speed = 200
export (int) var gravity = 1000
var velocity = Vector2()
var invincibility_frames = 1.5
var faceRight = true

var health = 3
signal collect_Coin(coinScore)
signal health_changed(health)
var level = "res://Scenes/Test.tscn" # Change scene for each skeleton phase
signal game_over(level)


# Called when the node enters the scene tree for the first time.
func _ready():
	var boneNode = get_tree().get_root().find_node("Bone", true, false)
	if(boneNode != null):
		boneNode.connect("bone_collected", self, "collected_bone")
	$Timer.set_paused(true)
	$Timer.set_wait_time(invincibility_frames)
	$AnimationPlayer.set_current_animation("Hopping")
	$AnimationPlayer.stop()

func get_input():
	velocity.x = 0
	if Input.is_action_pressed("player_left"):
		move("left")
		faceRight = false
		changeDir()
		$AnimationPlayer.play("Hopping")
	elif Input.is_action_pressed("player_right"):
		move("right")
		faceRight = true
		changeDir()
		$AnimationPlayer.play("Hopping")
	else:
		$AnimationPlayer.seek(0.0, true)
		$AnimationPlayer.stop()

func move(direction : String):
	if(direction == "left"):
		velocity.x -= speed
	if(direction == "right"):
		velocity.x += speed

func _physics_process(delta):
	get_input()
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity)
	

func _process(delta):
	if(!$Timer.is_stopped()):
		#Creates flashing effect when invincible
		$Sprite.set_visible(!$Sprite.is_visible())

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
		

func changeDir():
	if(faceRight):
		$Sprite.set_flip_h(false)
	else:
		$Sprite.set_flip_h(true)

func _on_Timer_timeout():
	$Timer.stop()
	$Sprite.set_visible(true)
	set_collision_layer_bit(1, true)

func collected_bone():
	get_parent().acquire_bone()


func _on_GUI_restart_level():
	get_tree().change_scene(level)


func collectCoin():
	coinScore = coinScore +1
	print_debug("printed")
	$GUI/Interface/TextureRect/RichTextLabel.collect_Coin(coinScore)

