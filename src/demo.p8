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

function gen_player(x, y)
	pl = make_col_actor(8,8)
	pl.spd = .05
	pl.w, pl.h = .5, .5
	pl.move = function(a) move_controller(a, a.spd) end
	pl.inertia = .6
	pl.bounce = 0
	pl.touchable = true
	pl.solid = false
	add(actors,pl)
end

function reset_time()
	gen_player(3, 3)
	set_room(0,0)
end

function _init()
	global_time = 0
	reset_time()
	-- frozen while text box is going
	tbox("|bob@he%baou%bni:4 5 6 7 8 9 0 1 2 3 4")
end

function _update60()
	move_actors(actors, function(x, y) return fget(mget(x, y), 1) end)
	
	if btnp(0) then
		switch_room(0)
	elseif btnp(1) then
		switch_room(1)
	elseif btnp(2) then
		switch_room(2)
	elseif btnp(3) then
		switch_room(3)
	end

	update_room_switch()
	tbox_interact(function(id, pick, select) tbox("|miii:okay i wil lguess "..pick) end)
	global_time += 1
end

function _draw()
	cls()

	draw_rooms()
	foreach(actors, function(a) debug_actor_box(a, 9) end)

	tbox_draw(7, 0, 2)
end
