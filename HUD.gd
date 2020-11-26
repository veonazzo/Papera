extends CanvasLayer

onready var Audio : AudioStreamPlayer = get_node("/root/Main").get_child(8)

signal start_game
var button_pressed = 1
var position = Vector2()
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func show_message(text):
	$MessageLabel.text = text
	$MessageLabel.show()
	$MessageTimer.start()

func show_game_over():
	show_message("Game Over")
	yield($MessageTimer, "timeout")
	$MessageLabel.text = "Riprova!"
	$MessageLabel.show()
	yield(get_tree().create_timer(1), 'timeout')
	$StartButton.show()
	$CreditButton.show()

func update_score(score):
	$ScoreLabel.text = str(score)

func _on_StartButton_pressed():
	$StartButton.hide()
	$CreditButton.hide()
	emit_signal("start_game")

func _on_MessageTimer_timeout():
	$MessageLabel.hide()
	$MessageTimer.stop()

func _on_CreditButton_toggled(button_pressed):
	if button_pressed == true:
		$ScoreLabel.visible = false
		$StartButton.visible = false
		$MessageLabel.text = "Veonazzo presenta \n Papera The Game \n\n tratto dalle storie di \n @adrianopetrucci \n\n musica Pixelland Kevin MacLeod (incompetech.com) \n Licensed under Creative Commons: \nBy Attribution 3.0 License \nhttp://creativecommons.org/licenses/by/3.0/"
		position.x = 0
		position.y = 200
		$MessageLabel.set_position(position)
		$MessageLabel.show()
	else:
		$ScoreLabel.visible = true
		$StartButton.visible = true
		$MessageLabel.text = ""
		position.y = 393
		$MessageLabel.set_position(position)


func _on_VolumeButton_toggled(button_pressed):
	Audio.stream_paused = button_pressed
#	if button_pressed == true:
#		Audio.playing = true
#	else:
#		Audio.playing = false
