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
		scr_spr(d.spr, d.x, d.y, 1, 1, false, false)
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

-- 57, 18
function gen_duck(x, y)
	local d = make_col_actor(x,y)
	d.spr = 40

	d.spd = .05
	d.w, d.h = 1, 1
	d.spr_w = 2
	d.spr_h = 2
	d.inertia = 0
	d.bounce = 0
	d.touchable = true
	d.solid = false
	d.static = true
	d.quack = 0

	d.draw = function(a)
		local flip = d.x - pl.x < 0
		scr_spr(d.spr, d.x-.5, d.y-.5, 2, 2, flip, false)

		if d.quack > 0 then
			scr_print("quack", d.x-7/8, d.y-10/8, 0)
		end
	end

	d.move = function(a)
		move_to_actor(a, pl, .05)
		d.quack -= 1
	end

	d.hit = function(other)
		if other == pl then
			d.quack = 15
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
	d.w, d.h = .5, 1

	d.draw = function(a)
		scr_spr(d.timer % 3 + 71, d.x, d.y, 1, 2, false, false)
			d.open = true
		end

	d.hit = function(other)
		if other == pl then
			reset_time()
		end
	end

	add(actors, d)
end
