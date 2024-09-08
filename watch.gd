extends CSGCylinder3D

@onready var second_hand: Node3D = $Face/SecondPivot
@onready var minute_hand: Node3D = $Face/MinutePivot
@onready var hour_hand: Node3D = $Face/HourPivot

const _SECOND_TRANS = Tween.TRANS_BOUNCE


func _ready() -> void:
	var second_tween := second_hand.create_tween().set_ease(Tween.EASE_OUT).set_trans(_SECOND_TRANS)
	second_tween.tween_property(second_hand, "rotation:y", TAU/60.0, 1).from(0)
	second_tween.finished.connect(_second_hand_loop)

	var minute_tween := minute_hand.create_tween().set_loops()
	minute_tween.tween_property(minute_hand, "rotation:y", TAU, 60 * 60).from(0)

	var hour_tween := hour_hand.create_tween()
	hour_tween.tween_property(hour_hand, "rotation:y", TAU, 60 * 60 * 12).from(0)
	hour_tween.finished.connect(_on_hour_hand_tween_finished)


func _second_hand_loop() -> void:
	# maybe a stupid way to loop with transition with total rotation.
	var second_tween := second_hand.create_tween().set_ease(Tween.EASE_OUT).set_trans(_SECOND_TRANS)
	second_tween.tween_property(second_hand, "rotation:y", TAU/60.0 + second_hand.rotation.y, 1)
	second_tween.finished.connect(_second_hand_loop)


func _on_hour_hand_tween_finished() -> void:
	print("time up? time bonus? game end?")
