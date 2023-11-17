extends Node



static func intercept_position(origin : Vector3, speed : float, target : Vector3, target_velocity := Vector3.ZERO):
	if target_velocity == Vector3.ZERO:
		return target
	
	var time : float = intercept_time(origin, speed, target, target_velocity)
	
	if not is_nan(time):
		return target + (target_velocity * time)

	return null


static func intercept_time(origin : Vector3, speed : float, target : Vector3, target_velocity := Vector3.ZERO) -> float:
	if target_velocity == Vector3.ZERO:
		return origin.distance_to(target) / speed if speed > 0.0 else NAN
	else:
		var Pti : Vector3 = target
		var Pbi : Vector3 = origin
		var D   : float   = Pti.distance_to(Pbi)
		var Vt  : Vector3 = target_velocity
		var St  : float   = Vt.length()
		var Sb  : float   = speed
		
		var cos_theta : float = Pti.direction_to(Pbi).dot(Vt.normalized())
		var root      : float = sqrt(2*D*St*cos_theta + 4*(Sb*Sb - St*St)*D*D )
		var t1        : float = (-2*D*St*cos_theta + root) / (2*(Sb*Sb - St*St))
		var t2        : float = (-2*D*St*cos_theta - root) / (2*(Sb*Sb - St*St))
		var t         : float = min(t1, t2)
		
		if t < 0:
			t = max(t1, t2)
		if t < 0:
			return NAN # can't intercept, target too fast

		return t
