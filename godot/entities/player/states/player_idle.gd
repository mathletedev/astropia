extends State

@export var player: Player


func physics_process(delta: float):
	if Input.is_action_pressed("jump"):
		transition.emit(self, "jump")

	if abs(player.velocity.x) > player.deadzone_x:
		transition.emit(self, "run")

	if not player.is_on_floor():
		transition.emit(self, "fall")

	player.move(delta, player.friction)
