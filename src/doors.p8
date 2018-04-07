function spawn_doors()
	for i=0,127 do
		for i=0,63 do
			if mget(i, j) == 69 then
			end
		end
	end
end

function gen_door(x, y)
	pl = make_col_actor(x,y)
	pl.spr = 0
	pl.spd = .05
	pl.w, pl.h = .3, .3
	pl.move = function(a) move_controller(a, a.spd) end
	pl.inertia = .6
	pl.bounce = 0
	pl.touchable = true
	pl.solid = true
	add(actors,pl)
end
