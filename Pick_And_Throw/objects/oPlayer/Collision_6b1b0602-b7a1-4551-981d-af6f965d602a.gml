/// @desc pick item

if (input_throw_pressed && grounded && curst == playst.contr)  {
	
	var disth = abs((other.x + other.sprite_width/2) - x);
	
	if (disth < 8) {
		grab_timer = other.grab_timer;
		held_item = instance_create_layer(x, y - 16, "Items", other.item);
		
		x = other.x + other.sprite_width/2;
		
		grab_timer = other.grab_timer;
		
		instance_destroy(other);
		curst = playst.picking;
	}
	
}