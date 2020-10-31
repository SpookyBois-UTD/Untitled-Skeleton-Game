extends RichTextLabel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func collect_Coin(value):
	text = str (value)
	print_debug("here")
	
func _on_TextureRect_collect_Coin(value):
	collect_Coin(value)
	


