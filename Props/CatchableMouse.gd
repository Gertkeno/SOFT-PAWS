extends PathFollow3D


@export_range(0, 5, 0.05) var speed: float = 0.5

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	progress += speed * delta


func _on_prop_grabbed(pickable: Variant, by: Variant) -> void:
	set_process(false)
	# TODO: fucking explode
