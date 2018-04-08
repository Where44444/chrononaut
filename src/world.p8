player_species=""

function init_world()
	actors = {}

	spawn_doors()
	reset_time()
	spawn_entities()
end

function spawn_entities()
	gen_dawg(40, 10)
	gen_duck(-1, 20)
end

function draw_world()
	draw_rooms()
	--foreach(actors, function(a) debug_actor_box(a, 9) end)
	for a in all(actors) do a.draw(a) end
	tbox_draw(7, 0, 2)
end

function update_world()
	if not room_switching and not tbox_active() then
		move_actors(actors, function(x, y) return fget(mget(x, y), 0) end)
		pl_room_update()
	end

	update_room_switch()
	if not room_switching then
		tbox_interact(tbox_callback)
	end
end

function tbox_callback(id, select_text, select_num)
	if id == "species_call" then
		player_species=select_text
		tbox("|alien1:ok. I would've preferred et but "..player_species.." is also nice.")
	end
end

function reset_time()
	gen_player(3, 3)
	set_room(0,0)
end

function gen_player(x, y)
	pl = make_col_actor(8,8)
	pl.spr = 0
	pl.spd = .05
	pl.w, pl.h = .3, .3
	pl.move = function(a) move_controller(a, a.spd) end
	pl.inertia = .6
	pl.bounce = 0
	pl.touchable = true
	pl.solid = true
	pl.draw = draw_player
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
