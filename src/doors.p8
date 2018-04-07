function spawn_doors()
	for i=0,127 do
		for j=0,63 do
			if mget(i, j) == 69 then
				gen_door_1(i, j)
			elseif mget(i, j) == 70 then
				gen_door_2(i, j)
			end
		end
	end
end

function gen_door_1(x, y)
	local d = make_col_actor(x+1,y+1)
	d.spr = 64
	d.spd = .05
	d.w, d.h = 1, 1
	d.spr_h = 2
	d.inertia = 0
	d.bounce = 0
	d.touchable = true
	d.solid = true
	d.static = true
	d.open = false
	d.timer = 0

	d.draw = function(a)
		spr_off(64 + flr(d.timer), d.x-.5, d.y-.5, 1, d.spr_h, false, false)
		spr_off(64 + flr(d.timer), d.x+.5, d.y-.5, 1, d.spr_h, true, false)
	end

	d.move = function(a)
		if d.open then
			d.timer += .2
		end

		if d.timer >= 4 then
			d.timer = 4
			d.touchable = false
		end
	end

	d.hit = function(other)
		if other == pl then
			d.open = true
		end
	end
	add(actors,d)
end

function gen_door_2(x, y)
	gen_door_1(x, y)

	--local d = make_col_actor(x+.5,y+.5)
	--d.spr = 96
	--d.spd = .05
	--d.w, d.h = 2, 2
	--d.spr_h = 2
	--d.inertia = 0
	--d.bounce = 0
	--d.touchable = true
	--d.solid = true
	--d.static = true
	--add(actors,d)
end
