extends CanvasLayer

@onready var score_label: Label = $ScoreLabel
@onready var lives_label: Label = $LivesLabel
@onready var game_over_panel: PanelContainer = $GameOverPanel
@onready var game_manager: Node = get_node("/root/GameManager")

func _ready() -> void:
	game_manager.score_changed.connect(_on_score_changed)
	game_manager.lives_changed.connect(_on_lives_changed)
	game_over_panel.visible = false
	_on_score_changed(game_manager.score)
	_on_lives_changed(game_manager.lives)

func _on_score_changed(new_score: int) -> void:
	score_label.text = "SCORE: %d" % new_score

func _on_lives_changed(new_lives: int) -> void:
	lives_label.text = "BALLS: %d" % new_lives

func show_game_over() -> void:
	game_over_panel.visible = true

func _input(event: InputEvent) -> void:
	if game_over_panel.visible and event.is_action_pressed("launch"):
		game_over_panel.visible = false
		game_manager.reset_game()
		get_tree().reload_current_scene()
