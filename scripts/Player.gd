extends Area2D

signal hit

export var speed: int = 400
var screen_size: Vector2


func _ready() -> void:
	screen_size = get_viewport_rect().size
	hide()
	

func _process(delta: float) -> void:
	var velocity: Vector2 = Vector2()
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
		
	if velocity.x != 0:
		$AnimatedSprite.animation = "walk"
		$AnimatedSprite.flip_v = false
		$AnimatedSprite.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite.animation = "up"
		$AnimatedSprite.flip_v = velocity.y > 0

	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)


func _on_Player_body_entered(body: Node) -> void:
	hide()
	emit_signal("hit")
	$CollisionShape2D.set_deferred("disabled", true)


func start(pos: Vector2) -> void:
	position = pos
	show()
	$CollisionShape2D.disabled = false

