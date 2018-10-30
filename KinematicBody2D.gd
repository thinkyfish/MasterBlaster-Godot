extends KinematicBody2D

export (int) var speed = 0
export (float) var rotation_speed = 1.5
var force = Vector2()
var velocity = Vector2()
var acceleration = Vector2(0,0)
var rotation_dir = 0
var drag = 0.008
var thrust = 100
var mass = 0.01
func _ready():
	position = Vector2(300,300)
	
func get_input():
	rotation_dir = 0
	velocity = Vector2()
	if Input.is_action_pressed('ui_right'):
		rotation_dir += 1
	if Input.is_action_pressed('ui_left'):
		rotation_dir -= 1
	if Input.is_action_pressed('ui_up'):
		speed = thrust
	else :
		speed = 0
	if Input.is_action_pressed('ui_down'):
		drag = 0.9

func checkwrap():
	if position.x > 1024 :
		position.x -= 1024
	if position.x < 0 :
		position.x += 1024
	if position.y > 600 :
		position.y -= 600
	if position.y < 0 :
		position.y += 600
	
	
func _physics_process(delta):
	get_input()
	rotation += rotation_dir * rotation_speed * delta
	force = Vector2(speed, 0).rotated(rotation)
	acceleration = force / mass
	velocity += acceleration * delta
	velocity *= 1.0 - drag
	move_and_slide(velocity)
	checkwrap()