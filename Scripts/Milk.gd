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


func _on_Milk_body_entered(body):
	if body.get_collision_layer_bit(1) && body.has_method("heal"):
		body.heal()
	
	set_collision_layer_bit(3, false)
	set_collision_mask_bit(1, false)
	queue_free()
