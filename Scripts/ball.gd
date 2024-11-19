extends CharacterBody2D
class_name Ball

@onready var cpu_particles_2d: CPUParticles2D = $CPUParticles2D
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
	cpu_particles_2d.color = colour_ball_one if is_ball_one else colour_ball_two
	var new_trail = TRAIL.instantiate()
	add_child(new_trail)


func _physics_process(delta: float) -> void:
	# Set the direction for the particles effect
	cpu_particles_2d.direction = -velocity.normalized()

	var collision : KinematicCollision2D = move_and_collide(velocity * delta)
	# If there is a collision, bounce the ball and toggle the collided tile
	if collision:
		# Bounce the velocity to the ball collides
		velocity = velocity.bounce(collision.get_normal())

		# If the collision is with a tile, toggle it
		if collision.get_collider() is Tile:
			# ADD EFFECT HERE:
			
			#
			collision.get_collider().toggle(self)
			cpu_particles_2d.emitting = true

func _get_collision_layer() -> int:
	return collision_layer
