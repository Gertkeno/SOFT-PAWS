@tool
extends XRToolsPickable
class_name PropBase

@export var cash_value: int = 10
@export var on_will: bool = false
@export_range(100,10_000) var durability: float = 1000
var durability_sq: float

func _ready() -> void:
	super()
	durability_sq = durability*durability


func _integrate_forces(state: PhysicsDirectBodyState3D) -> void:
	var i := 0
	while i < state.get_contact_count():
		var vec := state.get_contact_collider_velocity_at_position(i)
		var force := vec.length_squared()
		if force > 10:
			print(name, "> ", force)
		if force > durability_sq:
			pass # shatter
			GameData.score -= cash_value * (5 if on_will else 1)
			queue_free()
		elif force > 64:
			pass # todo clank sound
		i += 1
