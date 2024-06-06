extends PathFollow3D

@export_range(0, 5, 0.05) var speed: float = 0.5

func _process(delta: float) -> void:
	progress += speed * delta
