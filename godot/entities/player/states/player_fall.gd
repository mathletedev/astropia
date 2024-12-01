extends State

@export var player: Player


func physics_process(delta: float):
	if player.is_on_floor():
		transition.emit(self, "idle")

	player.move(delta, player.air_resistance)
