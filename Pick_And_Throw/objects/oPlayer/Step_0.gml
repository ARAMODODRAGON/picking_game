/// @desc Player Controller

#region Input and ground check
//get input
input_h = keyboard_check(vk_right) - keyboard_check(vk_left);
input_v = keyboard_check(vk_down) - keyboard_check(vk_up);
input_jump_pressed = keyboard_check_pressed(vk_space);
input_jump = keyboard_check(vk_space);
input_throw_pressed = keyboard_check(vk_shift);

//check ground
grounded = place_meeting(x, y + 1, oWall);
#endregion

#region Movement
//move player along x
///first checks for reverse acceleration
///second checks for deceleration
///third if checks for acceleration
if (hsp != 0 && input_h != 0 && (sign(input_h) != sign(hsp))) {
	hsp -= sign(hsp) * h_revaccel;
} else if (input_h == 0 && hsp != 0) {
	hsp -= sign(hsp) * h_decel;
} else if (input_h != 0)  {
	hsp += h_accel * sign(input_h);
}

//set max speed
if (abs(hsp) > max_spd) {
	hsp = sign(hsp) * max_spd;
}

if (!grounded && vsp > 0 && input_jump) {
	is_floating = true;
} else if (grounded || !input_jump) {
	is_floating = false;
}

//y acceleration
if (input_jump && vsp > slowmax_vspd) {
	vsp = slowmax_vspd;
} else if (vsp > max_vspd) {
	vsp = max_vspd;
} else if (vsp < max_vspd && !grounded) {
	if (input_jump || vsp > 0) vsp += slowgrv;	
	else vsp += fastgrv;	
}


//jump
if (grounded && input_jump_pressed) {
	vsp = jspd;
}
#endregion

#region collision
if (place_meeting(x + hsp, y, oWall)) {
	while (!place_meeting(x + sign(hsp), y, oWall)) {
		x += sign(hsp);
	}
	hsp = 0;
}

x += hsp;

if (place_meeting(x, y + vsp, oWall)) {
	while (!place_meeting(x, y + sign(vsp), oWall)) {
		y += sign(vsp);
	}
	vsp = 0;
}

y += vsp;
#endregion

#region animations
//flip players sprite according to the facing direction
if (input_h != 0) {
	image_xscale = sign(input_h);	
}

if (grounded) {
	if (abs(hsp) >= 1) {
		sprite_index = sPlayer_Walk;
		image_speed = 1;
	} else {
		sprite_index = sPlayer_Walk;
		image_speed = 0;
		image_index = 0;
	}
} else {
	if (is_floating) {
		sprite_index = sPlayer_Jump;
		image_speed = 0;
		image_index = 1;
	} else if (vsp <= 0) {
		sprite_index = sPlayer_Jump;
		image_speed = 0;
		image_index = 0;
	} else {
		sprite_index = sPlayer_Jump;
		image_speed = 0;
		image_index = 2;
	}
}

#endregion

#region Item Handling
//if the player is holding an item
if (held_item != noone) {
	with (held_item) {
		//move the object to always be above the players head
		x = other.x;
		y = other.y - 30;
		
		//if throw is pressed, 
		//tell the object to throw in the givin direction
		if (other.input_throw_pressed) {
			//passes a normalized vector for the direction
			if ((other.input_h + other.input_v) != 0) {
				//sets to the direction that is held
				var mag = sqrt(sqr(other.input_h) + sqr(other.input_v));
				dir_x = other.input_h / mag;
				dir_y = other.input_v / mag;
			} else {
				//if there is no direction held
				print(string(image_xscale));
				dir_x = image_xscale;
				dir_y = 0;
			}
			//passes the initial speed of the item
			hsp = other.hsp;
			vsp = other.vsp;
			//calls the user event so the item can handle being thrown
			event_user(0);
			is_held = false;
			other.held_item = noone;
		}
	}
} 
#endregion