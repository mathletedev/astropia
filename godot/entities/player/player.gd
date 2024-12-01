class_name Player
extends CharacterBody2D

@export var max_speed: float = 200
@export var acceleration: float = 10
@export var deadzone_x: float = 0.1
@export var default_gravity_multiplier: float = 2
@export var friction: float = 2000
@export var air_resistance: float = 400

var gravity: float = (
	ProjectSettings.get_setting("physics/2d/default_gravity") * default_gravity_multiplier
)


func move(delta: float, resistance: float, gravity_multiplier := 1.0):
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x += acceleration * (max_speed * direction - velocity.x) * delta
	else:
		velocity.x = move_toward(velocity.x, 0, resistance * delta)

	velocity.y += gravity * gravity_multiplier * delta


func _physics_process(_delta: float):
	move_and_slide()

	if velocity.x > deadzone_x and not $AnimatedSprite2D.flip_h:
		$AnimatedSprite2D.flip_h = true
	if velocity.x < -deadzone_x and $AnimatedSprite2D.flip_h:
		$AnimatedSprite2D.flip_h = false

	var animation_name: String = $StateMachine.current_state.name.to_lower()

	# TODO: add jump and fall animations
	match animation_name:
		"jump":
			animation_name = "idle"
		"fall":
			animation_name = "idle"

	$AnimatedSprite2D.play(animation_name)
