extends RigidBody2D

@export var speed: int = 120

func _ready():
	Events.saw_blade_added.emit()
