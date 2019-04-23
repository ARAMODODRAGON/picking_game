/// @desc death

var dir = sign(other.hsp);

hsp = spd * dir;
vsp = -max_vsp;
image_yscale = -1;

other.hsp = -other.hsp;