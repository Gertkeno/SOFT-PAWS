extends PathFollow3D

@export var start_alert: bool = true
@export_range(0, 5, 0.05) var speed: float = 0.5

func _ready() -> void:
	set_process(start_alert)
	if start_alert:
		$Prop/mouse2/AnimationPlayer.play("run cycle")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	progress += speed * delta


func _on_prop_grabbed(pickable: Variant, by: Variant) -> void:
	set_process(false)
	# TODO: fucking explode

func alert() -> void:
	# TODO: Play alert animation
	set_process(true)
