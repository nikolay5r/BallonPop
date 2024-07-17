extends Node2D

const SAW_BLADE_TELEGRAPHS: Array[PackedScene] = [
	preload("res://scenes/saw_blade_telegraph.tscn"),
	preload("res://scenes/small_saw_blade_telegraph.tscn"),
	preload("res://scenes/large_saw_blade_telegraph.tscn")
]

@onready var spawn_zone = $SpawnZone
@onready var saw_blade_spawn_timer = $SawBladeSpawnTimer
@onready var score = $UI/Score
@onready var high_score = $UI/HighScore
@onready var loser_screen = $LoserScreen
@onready var pop_sfx = $Sounds/PopSFX
@onready var random_saw_sound_timer = $Sounds/RandomSawSoundTimer
@onready var random_saw_sound = $Sounds/RandomSawSound

var saw_blade_counter: int = 0
var is_game_over = false
var is_first_blade_added = false

func _ready():
	Events.balloon_popped.connect(_on_balloon_popped)
	Events.saw_blade_added.connect(_on_saw_blade_added)


func _process(_delta):
	_check_for_game_over()
	_update_high_score()


func _check_for_game_over():
	if is_game_over and Input.is_action_pressed("reload"):
		get_tree().reload_current_scene()


func _update_high_score():
	if saw_blade_counter > Globals.high_score:
		Globals.high_score = saw_blade_counter
	high_score.text = "HighScore\n" + str(Globals.high_score)	


func _on_saw_blade_spawn_timer_timeout():
	var telegraph = SAW_BLADE_TELEGRAPHS[randi() % SAW_BLADE_TELEGRAPHS.size()].instantiate()
	var rect = spawn_zone.get_global_rect() as Rect2
	telegraph.position = Vector2(
		randf_range(rect.position.x, rect.end.x),
		randf_range(rect.position.y, rect.end.y)
	)
	$SawBlades.add_child(telegraph)


func _on_balloon_popped():
	saw_blade_spawn_timer.stop()
	is_game_over = true
	loser_screen.show_screen()
	pop_sfx.play()


func _on_saw_blade_added():
	saw_blade_counter += 1
	score.text = "Score\n" + str(saw_blade_counter)
	if not is_first_blade_added:
		random_saw_sound_timer.start()
		is_first_blade_added = true


func _on_random_saw_sound_timer_timeout():
	random_saw_sound.play()
