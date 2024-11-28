extends CharacterBody2D
class_name Ball

const BOUNCE_EFFECT = preload("res://Scenes/Effects/bounce_effect.tscn")
@onready var polygon_2d: Polygon2D = $Polygon2D


@export var is_ball_one := false
@export var colour_ball_one := Color('#D8D8F6')
@export var colour_ball_two := Color('#B18FCF')
@export var speed := 75.0

const TRAIL = preload("res://Scenes/Effects/trail.tscn")

func _ready() -> void:
	# Set the position
	global_position.y = (get_viewport_rect().size.y/2)
	if is_ball_one:
		global_position.x = (get_viewport_rect().size.x/4) + (get_viewport_rect().size.y/2)
	else:
		global_position.x = (get_viewport_rect().size.x/4)

	# Set velocity
	velocity.x = -speed
	velocity.y = randi_range(-15, 15) # randomize that starting velocity a bit.

	# Set the correct colours
	polygon_2d.color = colour_ball_one if is_ball_one else colour_ball_two
	var new_trail = TRAIL.instantiate()
	add_child(new_trail)


func _physics_process(delta: float) -> void:
	var collision : KinematicCollision2D = move_and_collide(velocity * delta)
	# If there is a collision, bounce the ball and toggle the collided tile
	if collision:
		# Bounce the velocity to the ball collides
		velocity = velocity.bounce(collision.get_normal())
		
		# Spawn the bounce effect when collision happens
		var bounce_effect = BOUNCE_EFFECT.instantiate()
		bounce_effect.position += Vector2(4,4)
		add_child(bounce_effect)
		
		

		# If the collision is with a tile, toggle it
		if collision.get_collider() is Tile:
			collision.get_collider().toggle(self)
			# And shake the screen...
			Events.ball_hit_tile.emit()
		else:
			Events.ball_hit_non_tile.emit()
			

func _get_collision_layer() -> int:
	return collision_layer
