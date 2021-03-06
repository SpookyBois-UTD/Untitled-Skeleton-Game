extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_ladder_body_entered(body):
	if body.get_collision_layer_bit(1) && body.has_method("is_on_ladder") && !(Input.is_action_pressed("player_up")||Input.is_action_pressed("player_down")):
		print_debug("Entered")
		body.is_on_ladder(true)


func _on_ladder_body_exited(body):
		if body.get_collision_layer_bit(1) &&body.has_method("is_on_ladder"):
			body.is_on_ladder(false)
