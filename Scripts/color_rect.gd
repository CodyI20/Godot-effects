extends ColorRect

@export var time_until_it_disappears := 0.5
@onready var timer: Timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	Events.ball_hit_non_tile.connect(_turn_on_with_timer)
	timer.timeout.connect(_turn_off_with_timer)

func _turn_on_with_timer() -> void:
	visible = true
	if timer.is_stopped():
		timer.start(time_until_it_disappears)
	else:
		timer.stop()  # Stop the timer to reset it
		timer.start(time_until_it_disappears)
	
func _turn_off_with_timer() -> void:
	visible = false
