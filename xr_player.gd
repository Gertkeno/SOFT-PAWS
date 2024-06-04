extends Node3D

@onready var left_hand_pushbox: AnimatableBody3D = $XROrigin3D/LeftHand/LeftHandPushbox
@onready var right_hand_pushbox: AnimatableBody3D = $XROrigin3D/RightHand/RightHandPushbox
@onready var poke_restart_timer: Timer = $PokeRestartTimer


func _on_right_pickup_has_dropped() -> void:
	right_hand_pushbox.collision_layer = 0
	poke_restart_timer.start()


func _on_left_pickup_has_dropped() -> void:
	left_hand_pushbox.collision_layer = 0
	poke_restart_timer.start()


func _on_poke_restart_timer_timeout() -> void:
	left_hand_pushbox.set_collision_layer_value(18, true)
	right_hand_pushbox.set_collision_layer_value(18, true)


func _on_left_pickup_has_picked_up(_what: Variant) -> void:
	left_hand_pushbox.collision_layer = 0
	poke_restart_timer.stop()


func _on_right_pickup_has_picked_up(_what: Variant) -> void:
	right_hand_pushbox.collision_layer = 0
	poke_restart_timer.stop()
