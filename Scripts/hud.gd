extends Control

@onready var score = $Score
@onready var live_count = $LiveCount
func set_score_label(new_score):
	score.text = "SCORE: " + str(new_score)

func set_lives_left_label(new_lives):
	live_count.text = str(new_lives)
