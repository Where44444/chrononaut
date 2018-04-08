function gen_dawg(x, y)
	local d = make_col_actor(x,y)
	d.spr = 10
	d.anim_l = 1

	d.spd = .05
	d.w, d.h = .3, .3
	d.inertia = 0
	d.bounce = 0
	d.touchable = true
	d.solid = true
	d.static = false

	d.draw = function(a)
		spr_off(d.spr, d.x, d.y, 1, 1, false, false)
	end

	d.move = function(a)
		if global_time % 50 == 0 then
			if d.spr == 10 then
				d.spr = 11
			else
				d.spr = 10
			end
		end
	end

	d.hit = function(other)
		if other == pl then
			d.open = true
		end
	end

	add(actors, d)
end

function gen_portal(x, y)
	local d = make_col_actor(x,y)
	d.spr = 71
  d.timer = 0
	d.move = function(a) d.timer += 1 end
	d.spd = .05
	d.w, d.h = .3, .3
	d.inertia = 0
	d.bounce = 0
	d.touchable = true
	d.solid = false
	d.static = true

	d.draw = function(a)
		spr_off(d.timer % 3 + 71, d.x, d.y, 1, 2, false, false)
	end

	d.hit = function(other)
		if other == pl then
			d.open = true
		end
end

	add(actors, d)
end
