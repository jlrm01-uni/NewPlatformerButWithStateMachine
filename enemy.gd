extends CharacterBody2D

@export var SPEED: float = 800
@export var RETURN_SPEED: float = 300

@onready var state_chart = $StateChart

var initial_position: Vector2 = Vector2.ZERO
var body_detected: CharacterBody2D = null

# Called when the node enters the scene tree for the first time.
func _ready():
	initial_position = position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func check_for_player_collision():
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		
		if collider.name == "Player":
			collider.die()
			state_chart.send_event("Frozen")
			
func _on_idle_state_physics_processing(delta):
	if body_detected:
		print("Detected a body!")
		state_chart.send_event("Chasing")

	velocity = Vector2.ZERO
	
	move_and_slide()
	check_for_player_collision()
	
func _on_chasing_state_physics_processing(delta):
	pass # Replace with function body.


func _on_returning_home_state_physics_processing(delta):
	pass # Replace with function body.


func _on_area_2d_body_entered(body):
	if body.name == "Player":
		body_detected = body
		print("Should chase ", body.name)

func _on_area_2d_body_exited(body):
	if body.name == "Player":
		body_detected = null
		print("Should stop chasing ", body.name)
		
