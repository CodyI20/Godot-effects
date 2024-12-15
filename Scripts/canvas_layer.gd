extends CanvasLayer
class_name MainCanvasLayer

const SHINY = preload("res://Scenes/Effects/shiny.tscn")

func _ready() -> void:
	Events.ball_hit_tile.connect(spawn_shiny)
	
func spawn_shiny() -> void:
	var new_shiny_effect = SHINY.instantiate()
	add_child(new_shiny_effect)
	var shiny_animation_player = new_shiny_effect.get_child(0) as AnimationPlayer
	await shiny_animation_player.animation_finished
	new_shiny_effect.queue_free()
