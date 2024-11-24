extends CPUParticles2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	one_shot = true

func _process(delta: float) -> void:
	if emitting == false:
		queue_free()
