extends Node2D




func _on_Area2D_body_entered(body: Node) -> void:
	get_tree().call_group("Gamestate","win_game")

