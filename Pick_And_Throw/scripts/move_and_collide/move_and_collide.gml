/// @desc move_and_collide(object)
/// @arg object The object to collide with

var grounded = place_meeting(x, y + 1, argument0)

//horizontal
repeat(abs(hsp)){
	if (!place_meeting(x + sign(hsp), y + 2, argument0) && grounded){
		x += sign(hsp);
		y += 2;
	} else if (!place_meeting(x + sign(hsp), y + 1, argument0) && grounded){
		x += sign(hsp);
		y += 1;
	} else if (!place_meeting(x + sign(hsp), y, argument0)){
		x += sign(hsp);	
	} else if (!place_meeting(x + sign(hsp), y - 1, argument0)){
		x += sign(hsp);
		y -= 1;
	} else if (!place_meeting(x + sign(hsp), y - 2, argument0)){
		x += sign(hsp);
		y -= 2;
	} else {
		hsp = 0;	
	}
}	

repeat (abs(vsp)) {
	if (!place_meeting(x, y + sign(vsp), argument0)) {
		y += sign(vsp);
	} else {
		vsp = 0;
	}
}