extends CharacterBody2D

@export var max_speed: float = 500
@export var acceleration: float = 10
@export var jump_speed: float = 600
@export var gravity_multiplier: float = 2
@export var friction: float = 4
@export var drag: float = 0.8
## Time in milliseconds to persist jump input
@export var jump_buffer: int = 200
## Time in milliseconds before initiating a fall
@export var coyote_time: int = 200
## Gravity multiplier when falling
@export var fall_multiplier: float = 1.5
## Gravity multiplier when jump is held
@export var jump_multiplier: float = 0.4

var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity") * gravity_multiplier

var last_jump: float = 0
var last_ground: float = 0


func _physics_process(delta: float):
	var time := Time.get_ticks_msec()

	if is_on_floor():
		last_ground = time
	else:
		var curr_gravity := gravity * delta
		if velocity.y > 0:
			curr_gravity *= fall_multiplier
		if Input.is_action_pressed("jump") and velocity.y < 0:
			curr_gravity *= jump_multiplier

		velocity.y += curr_gravity

	if Input.is_action_just_pressed("jump"):
		last_jump = time

	if time < last_ground + coyote_time and time < last_jump + jump_buffer:
		velocity.y = -jump_speed
		last_jump = 0
		last_ground = 0

	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x += acceleration * (max_speed * direction - velocity.x) * delta
	else:
		velocity.x = move_toward(
			velocity.x, 0, (friction if is_on_floor else drag) * max_speed * delta
		)

	move_and_slide()
