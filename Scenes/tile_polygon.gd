extends Polygon2D
class_name TilePolygon

@export var new_color : Color
@export var new_size : Vector2
var initial_size : Vector2
var current_color : Color

func _ready() -> void:
	initial_size = scale
	var parent = get_parent()
	if parent is Tile:
		parent.on_collision.connect(change_size)

func change_size() -> void:
	var tween = get_tree().create_tween()
	await tween.tween_property(self, "scale", new_size, .1)
	await tween.tween_property(self, "scale", initial_size, .1)
	

#region NEW EFFECT 1
func change_color() -> void:
	var tween = get_tree().create_tween()
	await tween.tween_property(self, "color", new_color, .25)
	await tween.tween_property(self, "color", current_color, .25)
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("ball"):
		change_color()

#endregion
