/// @description Move The Item and split on wall

if (!is_held) {

	if (place_meeting(x + hsp, y, oWall)) {
		while (!place_meeting(x + sign(hsp), y, oWall)) {
			x += sign(hsp);
		}
		
		//create 3 split items
		var it = instance_create_layer(x, y, "Items", oItemSplit);
		it.hsp = -sign(hsp) * spd;
		it.vsp = -spd;
		it.is_held = false;
		it = instance_create_layer(x, y, "Items", oItemSplit);
		it.hsp = -sign(hsp) * spd;
		it.vsp = 0;
		it.is_held = false;
		it = instance_create_layer(x, y, "Items", oItemSplit);
		it.hsp = -sign(hsp) * spd;
		it.vsp = spd;
		it.is_held = false;
		
		instance_destroy(self);
	}
	
	x += hsp;
	
	if (place_meeting(x, y + vsp, oWall)) {
		while (!place_meeting(x, y + sign(vsp), oWall)) {
			y += sign(vsp);
		}
		
		//create 3 split items
		var it = instance_create_layer(x, y, "Items", oItemSplit);
		it.vsp = -sign(vsp) * spd;
		it.hsp = -spd;
		it.is_held = false;
		it = instance_create_layer(x, y, "Items", oItemSplit);
		it.vsp = -sign(vsp) * spd;
		it.hsp = 0;
		it.is_held = false;
		it = instance_create_layer(x, y, "Items", oItemSplit);
		it.vsp = -sign(vsp) * spd;
		it.hsp = spd;
		it.is_held = false;
		
		instance_destroy(self);
	}
	
	y += vsp;
}