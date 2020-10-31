extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var transitions = $Transitions

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Background_next_level(nlevel):
	transitions.next_scene(nlevel)
