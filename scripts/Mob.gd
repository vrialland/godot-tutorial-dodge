extends RigidBody2D

export var min_speed: int = 150
export var max_speed: int = 250


func _ready() -> void:
	var mob_types: Array = $AnimatedSprite.frames.get_animation_names()
	$AnimatedSprite.animation = mob_types[randi() % mob_types.size()]


func _on_VisibilityNotifier2D_screen_exited() -> void:
	queue_free()
