extends Node2D

@export var saw_scene: PackedScene = preload("res://scenes/saw_blade.tscn")
@onready var arrow_sprite_2d = $ArrowSprite2D
@onready var timer = $Timer

var direction = Vector2.RIGHT.rotated(randf_range(0, TAU))

func _ready():
	arrow_sprite_2d.rotation = direction.angle()
	Events.balloon_popped.connect(timer.stop)

func _on_timer_timeout():
	var saw = saw_scene.instantiate()
	saw.global_position = global_position
	saw.linear_velocity = direction.normalized() * saw.speed
	get_tree().current_scene.add_child(saw)
	queue_free()
