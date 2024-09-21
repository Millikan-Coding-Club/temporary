extends Node2D

func restart():
	$background.star_death()
	$background.generate_stars()
	$UI/crashed.hide()
	$UI/RestartButton.hide()
	$Player.spawn_in()
	$Camera2D.zoom = Vector2(1,1)

func _on_restart_button_pressed():
	restart()

#restart key
func _input(event):
	if Input.is_key_pressed(KEY_R):
		restart()
