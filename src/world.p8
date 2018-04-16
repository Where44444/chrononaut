player_species=""

function init_world()
	reset_time()
end

function spawn_entities()
	for i=1,attempt do
		printh("duck spawn "..i)
		gen_duck(rnd(100)+20, rnd(60)+20)
	end
	gen_dawg(40, 10)
	gen_dawg(57.5, 10.5)
	gen_portal(63.5,23.5)
end

function draw_world()
	draw_rooms()
	--foreach(actors, function(a) debug_actor_box(a, 9) end)
	for a in all(actors) do a.draw(a) end
	ttbox_draw(7, 0)

	if attempt > 0 then
		print("ducks: "..attempt, 2, 2, 0)
	end
end

function update_world()
	if not room_switching and not g_tbox_active then
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
		tbox("|alien1:ok. i would've preferred et but "..player_species.." is also nice.")
	elseif id == "reason_leave" then
		if (select_num == 1) then
			tbox("|alien1:...if youre looking for arizona state your on the wrong planet.")
		else
			tbox("|alien1:that is understandable. im glad you arent just another reckless partier")
		end
	elseif id == "is_single" then
		if (select_num == 1) then
			tbox("|alien1:what? me!? i dont even know what to say.... *alien 1 begins smirking and blushing immensely*")
		else
			tbox("|alien1:...its just procedure but well move on")
		end
	elseif id == "abuse" then
		if (select_num == 1 or select_num == 2) then
			tbox("|alien1:specimen seems to not like abuse. thats good.")
		else
			tbox("|alien1:...what a savage")
		end
	end
end

function reset_time()
	attempt += 1
	actors = {}
	spawn_doors()
	gen_player(3, 3)
	spawn_entities()
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
