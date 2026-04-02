extends Node

signal score_changed(new_score: int)
signal lives_changed(new_lives: int)
signal game_over
signal ball_launched

enum GameMode { CLASSIC, LEVEL }

var mode: GameMode = GameMode.CLASSIC
var score: int = 0
var lives: int = 3
var max_lives: int = 3
var is_game_over: bool = false
var ball_in_play: bool = false

func _ready() -> void:
	reset_game()

func reset_game() -> void:
	score = 0
	lives = max_lives if mode == GameMode.CLASSIC else 5
	is_game_over = false
	ball_in_play = false
	score_changed.emit(score)
	lives_changed.emit(lives)

func add_score(points: int) -> void:
	if is_game_over:
		return
	score += points
	score_changed.emit(score)

func ball_drained() -> void:
	if is_game_over:
		return
	ball_in_play = false
	lives -= 1
	lives_changed.emit(lives)
	if lives <= 0:
		is_game_over = true
		game_over.emit()

func launch_ball() -> void:
	ball_in_play = true
	ball_launched.emit()
