extends CanvasLayer

@onready var animation_player = $AnimationPlayer

func show_screen():
	animation_player.play("show")
	await animation_player.play
