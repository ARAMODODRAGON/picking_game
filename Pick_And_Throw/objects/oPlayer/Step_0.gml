/// @desc Player Controller

#region Input and ground check

input_h = keyboard_check(vk_right) - keyboard_check(vk_left);
input_v = keyboard_check(vk_down) - keyboard_check(vk_up);

input_jump_pressed = keyboard_check_pressed(ord("C")) || keyboard_check_pressed(vk_space);
input_jump = keyboard_check(ord("C")) || keyboard_check(vk_space);

input_throw_pressed = keyboard_check_pressed(ord("X")) || keyboard_check_pressed(vk_shift);
input_throw = keyboard_check(ord("X")) || keyboard_check(vk_shift);
//input_throw_released = keyboard_check_released(ord("X")) || keyboard_check_released(vk_shift);

//check directly below
grounded = place_meeting(x, y + 1, oColliderBase);

#endregion

#region Item Handling
//if the player is holding an item

if (grab_timer != 0) {
	grab_timer--;
	held_item.x = x - sign(hsp) * 1.3;
	held_item.y = y + 20 - sign(hsp) * 1.3;
	if (grab_timer == 0) curst = playst.holding;
} else if (held_item != noone) {
	with (held_item) {
		//move the object to always be above the players head
		x = other.x;
		y = other.y - 20;
		
		//if throw is pressed, 
		//tell the object to throw in the givin direction
		if ((other.grounded && other.input_throw_pressed) || (!other.grounded && other.input_throw)) {
			//passes a normalized vector for the direction
			if (other.input_h != 0 || other.input_v != 0) {
				//sets to the direction that is held
				var mag = sqrt(sqr(other.input_h) + sqr(other.input_v));
				dir_x = other.input_h / mag;
				dir_y = other.input_v / mag;
			} else {
				//if there is no direction held
				dir_x = other.image_xscale;
				dir_y = 0;
			}
			//passes the initial speed of the item
			hsp = other.hsp;
			vsp = other.vsp;
			//calls the user event so the item can handle being thrown
			event_user(0);
			is_held = false;
			other.held_item = noone;
			input_throw_pressed = false;
		}
	}
} else if (held_item == noone) {
	curst = playst.contr;
}

#endregion

if (curst != playst.picking) {
	#region Movement
	// test for if floating
	if (!grounded && vsp >= 0 && input_jump) { 
		is_floating = true;									
	} else if (grounded || !input_jump) {
		is_floating = false;
	}

	if (input_h > 0) {											////////// pressing right
		if (abs(hsp - max_spd) < 0.5) hsp = max_spd;			// lock player at max speed
		else if (hsp > max_spd) hsp -= h_revaccel;				// decelerate if going too fast
		else if (hsp < -max_spd) hsp += h_revaccel;				//
		else if (hsp >= 0 && hsp < max_spd) hsp += h_accel;		// accelerate
		else if (hsp < 0) hsp += h_revaccel;					// reverse accelerate
	} else if (input_h < 0) {									////////// pressing left
		if (abs(hsp + max_spd) < 0.5) hsp = -max_spd;			// lock player at max speed
		else if (hsp > max_spd) hsp -= h_revaccel;				// decelerate if going too fast
		else if (hsp < -max_spd) hsp += h_revaccel;				//
		else if (hsp <= 0 && hsp > -max_spd) hsp -= h_accel;	// accelerate
		else if (hsp > 0) hsp -= h_revaccel;					// reverse accelerate
	} else if (grounded) {										////////// not pressing anything and on ground
		if (abs(hsp) < 0.5) hsp = 0;							// lock speed at 0
		else if (hsp > max_spd) hsp -= h_revaccel;				// decelerate if going too fast
		else if (hsp < -max_spd) hsp += h_revaccel;				//
		else if (hsp > 0) hsp -= h_decel;						// decelerate from positive velocity
		else if (hsp < 0) hsp += h_decel;						// decelreate from negative velocity
	} else if (is_floating) {
		if (hsp != 0 && abs(hsp) < 0.5) hsp = 0;
		else if (hsp > 0) hsp -= h_arialdecel;
		else if (hsp < 0) hsp += h_arialdecel;
	}

	if (is_floating) {											////////// if floating
		if (abs(vsp - slowmax_vspd) < 0.5) vsp = slowmax_vspd;	// lock at max speed
		else if (vsp < slowmax_vspd) vsp += slowgrv;			// accelerate down
		else if (vsp > slowmax_vspd) vsp -= slowgrv;			// deccelerate to max speed
	} else if (vsp < 0) {										////////// if the player is rising
		if (input_jump) vsp += slowgrv;							// jump heigher if holding jump
		else vsp += fastgrv;									// jump lower if not
	} else if (vsp >= 0 && !grounded) {							////////// if falling down
		if (vsp > max_vspd) vsp = max_vspd;						// lock at max fall speed
		else if (vsp < max_vspd) vsp += slowgrv;				// accelerate down
	} else if (grounded) {										////////// if grounded
		vsp = 0;												// set vsp to 0
	}

	if (grounded && input_jump_pressed) {
		vsp = jspd;
	}
	#endregion
	
	move_and_collide(oColliderBase);
}

#region Animations and invincibility frames
//invinciblity frames
if (invi_frames > 0) invi_frames--;

if (invi_frames == 0) image_alpha = 1;
else {
	if (image_alpha <= 0.3) image_alpha = 1;
	else image_alpha -= 0.1;
}

//flip players sprite according to the facing direction
if (input_h != 0) {
	image_xscale = sign(input_h);	
}

if (grounded) {
	if (curst == playst.picking) {
		sprite_index = sPlayer_Pick;
	} else if (abs(hsp) >= 1) {
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

