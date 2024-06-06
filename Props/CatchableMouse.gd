extends PropBase

@export var start_alert: bool = true
@onready var animation_tree: AnimationTree = $AnimationTree

func _ready() -> void:
	super._ready()
	set_process(start_alert)
	animation_tree.set("parameters/conditions/started_alert", start_alert)
	if not start_alert and flying_target:
		flying_target.set_process(false)


func _on_prop_grabbed(_pickable: Variant) -> void:
	flying_target = null
	animation_tree.set("parameters/conditions/picked_up", true)

func alert() -> void:
	if flying_target:
		flying_target.set_process(true)
	animation_tree.set("parameters/conditions/alerted", true)


func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if anim_name == "pickedup":
		pass # TODO: particles and yipee!!
		GameData.score += cash_value
		shatter()
		drop()
		queue_free()
