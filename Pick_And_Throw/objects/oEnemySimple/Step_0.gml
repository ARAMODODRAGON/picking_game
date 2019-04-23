/// @desc enemy controller

if (image_yscale == -1) {
	if (place_meeting(x, y+1, oColliderBase)) {
		image_alpha -= 0.1;
		if (image_alpha == 0) instance_destroy(self);
	} else {
		move_and_collide(oColliderBase);
		if (abs(vsp - max_vsp) < 0.5) vsp = max_vsp;
		else if (vsp < max_vsp) vsp += grv;
		else if (vsp > max_vsp) vsp -= grv;
	}
} else if (abs(x - oPlayer.x) < 304 && abs(y - oPlayer.y) < 400){
	hsp = image_xscale * spd;

	if (place_meeting(x, y+1, oColliderBase)) {
		vsp = 0;
	} else {
		if (abs(vsp - max_vsp) < 0.5) vsp = max_vsp;
		else if (vsp < max_vsp) vsp += grv;
		else if (vsp > max_vsp) vsp -= grv;
	}

	move_and_collide(oColliderBase);
	
	if (place_meeting(x+image_xscale, y-2, oColliderBase)) {
		image_xscale = -image_xscale;
	}
}