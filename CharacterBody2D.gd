extends CharacterBody2D

var target:Vector2 = Vector2.ZERO
@onready var agent:NavigationAgent2D = $NavigationAgent2D
var time:float = 0.0
func _physics_process(delta):
	const speed:float = 1000.0
	const acceleration:float = 7
	time+= delta
	if time>= 1:
		time = 0
		_navi_update()
	var vec:Vector2 = (agent.get_next_path_position()-global_position).normalized()*speed
	velocity = velocity.lerp(vec, delta * acceleration)
	move_and_slide()
	
	
@onready var camera:Camera2D = $Camera2D
func _unhandled_input(event):
	if event.is_action_pressed("click"):
		target = get_global_mouse_position()
		_navi_update()
	if event.is_action_pressed("zoom_in"):
		camera.zoom *= 1.1
	if event.is_action_pressed("zoom_out"):
		camera.zoom /= 1.1
#@onready var line:Line2D = $"../Line2D"
func _navi_update():
	#line.points = agent.get_current_navigation_path()
	agent.target_position = target
		
