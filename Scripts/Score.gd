extends Label

@onready var score = $Score


func set_score_label(new_score):
	score.text = new_score as String
