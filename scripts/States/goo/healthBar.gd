extends Control

func update_health(current_health: int, max_health: int):
	$ProgressBar.max_value = max_health
	$ProgressBar.value = current_health
