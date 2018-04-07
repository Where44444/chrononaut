function init_world()
	reset_time()
	tbox("|bob@he%baou%bni:4 5 6 7 8 9 0 1 2 3 4")
end

function draw_world()
	draw_rooms()
	foreach(actors, function(a) debug_actor_box(a, 9) end)
	tbox_draw(7, 0, 2)
end

function update_world()
	if not room_switching and not tbox_active() then
		move_actors(actors, function(x, y) return fget(mget(x, y), 0) end)
		pl_room_update()
	end
	
	update_room_switch()
	tbox_interact(function(id, pick, select) tbox("|miii:okay i wil lguess "..pick) end)
end

function reset_time()
	gen_player(3, 3)
	set_room(0,0)
end

function gen_player(x, y)
	pl = make_col_actor(8,8)
	pl.spd = .05
	pl.w, pl.h = .3, .3
	pl.move = function(a) move_controller(a, a.spd) end
	pl.inertia = .6
	pl.bounce = 0
	pl.touchable = true
	pl.solid = true
	add(actors,pl)
end

function gen_debug_enemy(x, y)
	local e = make_col_actor(x, y)
	e.bounce = .6
	e.inertia = 1
	e.w, e.h = .4, .4
	e.move =
	function(a)
		move_to_actor(a, pl, .05)
	end
	add(actors,e)
	return e
end

function gen_debug_enem2(x, y)
	local e = make_col_actor(x, y)
	e.bounce = 1
	e.inertia = 1
	e.w, e.h = .4, .4
	e.move =
	function(a)
		move_counter(a, 4, 5, 5, global_time)
	end
	add(actors,e)
	return e
end
