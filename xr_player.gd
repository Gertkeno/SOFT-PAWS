extends Node3D

@onready var left_poke: XRToolsPoke = $XROrigin3D/LeftHand/LeftHand/Hand_Glove_L/Armature/Skeleton3D/BoneAttachment3D/Poke
@onready var right_poke: XRToolsPoke = $XROrigin3D/RightHand/RightHand/Hand_Glove_R/Armature/Skeleton3D/BoneAttachment3D/Poke
@onready var poke_restart_timer: Timer = $PokeRestartTimer


# might not need these
func _on_left_pickup_has_picked_up(what: Variant) -> void:
	pass

func _on_right_pickup_has_picked_up(what: Variant) -> void:
	pass



func _on_right_pickup_has_dropped() -> void:
	right_poke.enabled = false
	poke_restart_timer.start()


func _on_left_pickup_has_dropped() -> void:
	left_poke.enabled = false
	poke_restart_timer.start()


func _on_poke_restart_timer_timeout() -> void:
	left_poke.enabled = true
	right_poke.enabled = true
