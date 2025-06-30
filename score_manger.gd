extends Node

var score := 0
var max_score := 10000

signal score_updated(new_score: int)

func add_score(amount: int):
	score += amount
	emit_signal("score_updated", score)

func get_score() -> int:
	return score

func reset():
	score = 0
	emit_signal("score_updated", score)
