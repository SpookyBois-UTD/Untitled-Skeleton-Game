extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var nlevel = "res://Scenes/VillageLevel.tscn"
signal next_level(nlevel)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_toNextLevel_body_entered(body):
	emit_signal("next_level", nlevel)
