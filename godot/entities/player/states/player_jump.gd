extends State

@export var player: Player
@export var jump_speed: float = 350
@export var gravity_multiplier: float = 0.3


func enter():
	player.velocity.y = -jump_speed


func physics_process(delta: float):
	if not Input.is_action_pressed("jump"):
		transition.emit(self, "fall")

	if player.velocity.y > 0:
		transition.emit(self, "fall")

	player.move(delta, player.air_resistance, gravity_multiplier)
