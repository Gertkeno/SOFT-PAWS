extends Node3D

@onready var left_hand: XRToolsPhysicsHand = $XROrigin3D/LeftHand/LeftHand
@onready var right_hand: XRToolsPhysicsHand = $XROrigin3D/RightHand/RightHand
@onready var poke_restart_timer: Timer = $PokeRestartTimer


func _on_right_pickup_has_dropped() -> void:
	right_hand.collision_layer = 0
	poke_restart_timer.start()


func _on_left_pickup_has_dropped() -> void:
	left_hand.collision_layer = 0
	poke_restart_timer.start()


func _on_poke_restart_timer_timeout() -> void:
	left_hand.collision_layer = 131072
	right_hand.collision_layer = 131072
