extends State

@export var player: Player
@export var coyote_time: float = 0.05

var coyote_timer := Timer.new()


func _ready():
	coyote_timer.one_shot = true
	coyote_timer.wait_time = coyote_time
	coyote_timer.connect("timeout", on_coyote_timer_timeout)

	add_child(coyote_timer)


func physics_process(delta: float):
	if abs(player.velocity.x) < player.deadzone_x:
		transition.emit(self, "idle")

	if Input.is_action_pressed("jump"):
		transition.emit(self, "jump")

	if not player.is_on_floor():
		coyote_timer.start()

	player.move(delta, player.friction)


func on_coyote_timer_timeout():
	transition.emit(self, "fall")
