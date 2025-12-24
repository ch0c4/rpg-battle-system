class_name DamageLabel extends RigidBody2D

@onready var label: Label = $Label
@onready var timer: Timer = $Timer
@onready var collision_shape: CollisionShape2D = $CollisionShape2D

func _ready() -> void:
	timer.timeout.connect(_on_timer_timeout)
	var angle = clamp(randf() * PI + PI, PI / 4.0 * 5.0, PI / 4.0 * 7.0)
	apply_central_impulse(Vector2(cos(angle), sin(angle)) * 450.0)


func set_number(damage: int, color: Color) -> void:
	label.text = str(damage)
	label.add_theme_color_override("font_color", color)


func _on_timer_timeout() -> void:
	var alpha: Color = label.modulate
	alpha.a = 0
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(label, "modulate", alpha, 0.6)
	collision_shape.queue_free()
	tween.tween_callback(_on_tween_finished)


func _on_tween_finished() -> void:
	queue_free()
	
	

