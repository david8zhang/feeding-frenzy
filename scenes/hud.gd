extends CanvasLayer

signal start_game

func _ready():
	$ScoreText.hide()

func show_message(text):
	$Message.text = text
	$Message.show()


func show_game_over():
	show_message("Game Over")
	$StartButton.text = "Play Again"
	$StartButton.show()


func show_win():
	show_message("You Win!")
	$ScoreText.hide()
	$StartButton.text = "Play Again"
	$StartButton.show()


func update_score(score):
	$ScoreText.text = "Score: %s" % score


func _on_message_timer_timeout():
	$Message.hide()


func _on_start_button_pressed():
	$Message.hide()
	$StartButton.hide()
	$ScoreText.show()
	start_game.emit()
