extends Camera2D

@export var follow: Node2D
@export var tween_speed: float = 3


func _ready():
	position = follow.position


func _physics_process(delta: float):
	position += (follow.position - position) * tween_speed * delta
