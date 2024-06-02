extends PathFollow3D

@export var bonus_score: int = 1000
@export var start_alert: bool = true
@export_range(0, 5, 0.05) var speed: float = 0.5
@onready var animation_tree: AnimationTree = $AnimationTree

func _ready() -> void:
	set_process(start_alert)
	if start_alert:
		$Prop/mouse2/AnimationPlayer.play("run cycle")
	animation_tree.set("parameters/conditions/started_alert", start_alert)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	progress += speed * delta


func _on_prop_grabbed(pickable: Variant, by: Variant) -> void:
	set_process(false)
	animation_tree.set("parameters/conditions/picked_up", true)

func alert() -> void:
	set_process(true)
	animation_tree.set("parameters/conditions/alerted", true)


func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if anim_name == "pickedup":
		pass # TODO: particles and yipee!!
		GameData.score += bonus_score
