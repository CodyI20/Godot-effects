extends Camera2D

@export var shake_intensity_limit := 30.0
@export var shake_fade_speed := 5.0

var rng = RandomNumberGenerator.new()

var shake_intensity := 0.0

var initial_offset := Vector2.ZERO

func _ready() -> void:
	initial_offset = offset
	Events.ball_hit_tile.connect(apply_shake)

func apply_shake() -> void:
	shake_intensity = shake_intensity_limit
	
func get_random_offset() -> Vector2:
	return Vector2(
		rng.randf_range(-shake_intensity, shake_intensity),
		rng.randf_range(-shake_intensity, shake_intensity)
	)
	
func _process(delta: float) -> void:
	if shake_intensity > 0:
		shake_intensity = lerp (shake_intensity, 0.0, shake_fade_speed * delta)
	offset = initial_offset + get_random_offset()
