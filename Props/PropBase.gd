@tool
extends XRToolsPickable
class_name PropBase

@export var cash_value: int = 10
@export var on_will: bool = false
@export_range(10, 1000, 0.5, "or_less") var durability: float = 15
var durability_sq: float

@export var break_effect: PackedScene
@onready var clank_sound_player: AudioStreamPlayer3D = $ClankSoundPlayer

@export var flying_target: Node3D
@export var flying_strength: float = 1000

func _ready() -> void:
	super._ready()
	durability_sq = durability*durability


func shatter() -> GPUParticles3D:
	var clone := break_effect.instantiate() as GPUParticles3D
	clone.position = position
	clone.get_node("ShatterSoundFX").stream = clank_sound_player.stream
	clone.emitting = true
	clone.finished.connect(clone.queue_free)
	add_sibling(clone)
	return clone


func _integrate_forces(state: PhysicsDirectBodyState3D) -> void:
	var i := 0
	while i < state.get_contact_count():
		var vec := state.get_contact_collider_velocity_at_position(i)
		var force := vec.length_squared()
		if force > durability_sq:
			GameData.score -= cash_value * (5 if on_will else 1)
			shatter()
			drop_and_free()
		elif force > 9:
			clank_sound_player.play()
		i += 1

	if flying_target:
		var diff := flying_target.global_position - global_position
		var dist2 := diff.length_squared()

		var diff_match := (diff - state.linear_velocity / 8) * 16
		var near_strength := smoothstep(0, 0.04, dist2) * flying_strength
		state.apply_central_force(diff_match.limit_length(near_strength))
		look_at(flying_target.global_position, Vector3.UP, true)
