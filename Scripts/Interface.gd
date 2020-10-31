extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal health_changed(health)
signal collect_Coin(value)
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
	
func _on_SkeletonHead_collect_Coin(value):
	print_debug("here")
	emit_signal("collect_Coin", value)


func _on_SkeletonOneLeg_game_over(level):
	game_over_screen.show()


func _on_Restart_Button_pressed():
	game_over_screen.hide()
	emit_signal("restart_level")


func _on_KinematicBody2D_health_changed(health):
	emit_signal("health_changed", health)


func _on_KinematicBody2D_game_over(level):
	game_over_screen.show()



func _on_Player_health_changed(health):
	emit_signal("health_changed", health)


func _on_Player_game_over(level):
	game_over_screen.show()


func _on_SkeletonHead_health_changed(health):
	emit_signal("health_changed", health)


func _on_SkeletonHead_game_over(level):
	game_over_screen.show()


func _on_SkeletonOneArm_health_changed(health):
	emit_signal("health_changed", health)


func _on_SkeletonOneArm_game_over(level):
	game_over_screen.show()


func _on_SkeletonTwoArm_health_changed(health):
	emit_signal("health_changed", health)


func _on_SkeletonTwoArm_game_over(level):
	game_over_screen.show()


func _on_SkeletonTwoLeg_health_changed(health):
	emit_signal("health_changed", health)


func _on_SkeletonTwoLeg_game_over(level):
	game_over_screen.show()
