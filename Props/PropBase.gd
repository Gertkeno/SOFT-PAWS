@tool
extends XRToolsPickable
class_name PropBase

@export var cash_value: int = 10
@export var on_will: bool = false
@export_range(10, 1000, 0.5, "or_less") var durability: float = 15
var durability_sq: float

const PROP_BREAK_EFFECT = preload("res://Props/PropBreakEffect.tscn")
@onready var clank_sound_player: AudioStreamPlayer3D = $ClankSoundPlayer

func _ready() -> void:
	super()
	durability_sq = durability*durability


func shatter() -> GPUParticles3D:
	var clone := PROP_BREAK_EFFECT.instantiate()
	clone.position = position
	clone.get_node("ShatterSoundFX").stream = clank_sound_player.stream
	clone.emitting = true
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
		elif force > 16:
			clank_sound_player.play()
		i += 1
