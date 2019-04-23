/// @desc initialize variables

#macro print show_debug_message
print("");

//PlayerState
enum playst {
	transi,
	contr,
	picking,
	holding
}
curst = playst.contr;

//Item
held_item = noone;
///can_pick = true;
grab_timer = 0;

//Input
input_h = 0;
input_v = 0;
input_jump = false;
input_jump_pressed = false;
input_throw_pressed = false;
input_throw = false;
//input_throw_released = false;

//Ground and Air
grounded = false;
is_floating = false;

//Movement
hsp = 0;
h_accel = 0.3;
h_decel = 0.2;
h_revaccel = 0.4;
h_arialdecel = 0.05;
vsp = 0;
max_spd = 3;
slowgrv = 0.4;
fastgrv = 1.4;
jspd = -8;
max_vspd = 7;
slowmax_vspd = 1;

//health and i frames
health = 4;
invi_frames = 0;