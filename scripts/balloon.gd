extends CharacterBody2D

@export var speed: int = 100

func _physics_process(_delta):
	var direction: Vector2 = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed
	move_and_slide()


func _on_hurt_box_body_entered(_body):
	Events.balloon_popped.emit()
	queue_free()
