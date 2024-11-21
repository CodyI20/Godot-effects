extends Polygon2D

@export var new_color : Color
@export var new_size : Vector2
var initial_size : Vector2
var current_color : Color

func _ready() -> void:
	initial_size = scale
	var parent = get_parent()
	if parent is Tile:
		parent.on_collision.connect(feedback)

func change_color() -> void:
	pass
	

func change_size() -> void:
	var tween = get_tree().create_tween()
	await tween.tween_property(self, "scale", new_size, .1)
	await tween.tween_property(self, "scale", initial_size, .1)
	
	
func feedback() -> void:
	change_color()
	change_size()
