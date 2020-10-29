extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal health_changed(health)
onready var game_over_screen = $Interface/GameOver
signal restart_level()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _on_SkeletonOneLeg_health_changed(health):
	emit_signal("health_changed", health)


func _on_SkeletonOneLeg_game_over(level):
	game_over_screen.show()


func _on_Restart_Button_pressed():
	game_over_screen.hide()
	emit_signal("restart_level")
