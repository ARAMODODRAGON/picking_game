/// @desc

if (image_yscale == -1) {
	if (place_meeting(x, y+1, oColliderBase)) {
		image_alpha -= 0.1;
		if (image_alpha == 0) instance_destroy(self);
	} else {
		if (abs(vsp - max_vsp) < 0.5) vsp = max_vsp;
		else if (vsp < max_vsp) vsp += grv;
		else if (vsp > max_vsp) vsp -= grv;
		move_and_collide(oColliderBase);
	}
} else if (abs(x - oPlayer.x) < 304 && abs(y - oPlayer.y) < 400) {
	if (place_meeting(x, y+1, oColliderBase)) {
		hsp = 0;
		vsp = 0;
		if (jump_timer == 0) {
			hsp = spd * image_xscale;
			vsp = jump_spd;
			jump_timer = wait_time;
			move_and_collide(oColliderBase);
			image_index = 0;
		} else {
			jump_timer--;
			image_index = 4;
		}
	} else {
		if (abs(vsp - max_vsp) < 0.5) vsp = max_vsp;
		else if (vsp < max_vsp) vsp += grv;
		else if (vsp > max_vsp) vsp -= grv;
		
		if (sign(hsp) >= 1) hsp -= sign(hsp) * hsp_drag;
		
		move_and_collide(oColliderBase);
		
		if (sign(oPlayer.x - x) != 0) {
			image_xscale = sign(oPlayer.x - x);
		}
	}
}