/// @description Push player up

with (other) {
	if (is_floating && !grounded) {
		vsp += other.vaccel;
		if (vsp < other.max_vspd) vsp = other.max_vspd;
	}
}