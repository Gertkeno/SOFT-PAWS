extends Area3D


func _on_body_entered(body: Node3D) -> void:
	if body is PropBase:
		if body.on_will:
			$SuccessParticle.restart()
			GameData.score += body.cash_value
		else:
			$FailureParticle.restart()
			GameData.score -= body.cash_value
