extends Node

@warning_ignore_start("unused_signal")

signal battle_ended(win_result: String)
signal create_damage_label(amount: int, position: Vector2, color: Color)

signal remove_combattant_from_queue(combattant: Combattant)
signal remove_combattant_ui(combattant: Combattant)

@warning_ignore_restore("unused_signal")