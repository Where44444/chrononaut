function init_world()
	reset_time()

	id_funcs = {
		species_call=function(n, t)
			player_species = t
			tbox("|alien1:ok. i would've preferred et but "..player_species.." is also nice.")
		end,
		reason_leave=function(n) 
			if n == 1 then tbox("|alien1:...if youre looking for arizona state your on the wrong planet.")
			else tbox("|alien1:that is understandable. im glad you arent just another reckless partier") end
		end,
		is_single=function(n)
			if n == 1 then tbox("|alien1:what? me!? i dont even know what to say.... *alien 1 begins smirking and blushing immensely*")
			else tbox("|alien1:...its just procedure but well move on") end
		end,
		abuse=function(n)
			if n == 1 or n == 2 then tbox("|alien1:specimen seems to not like abuse. thats good.")
			else tbox("|alien1:...what a savage") end
		end
	}
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
	rosw_draw()

	for a in all(actors) do a.draw(a) end
	ttbox_draw(7, 0)

	if attempt > 0 then
		print("ducks: "..attempt, 2, 2, 0)
	end
end

function update_world()
	if not g_rosw_switching and not g_tbox_active then
		move_actors(actors, function(x, y) return fget(mget(x, y), 0) end)
		pl_rosw_update()
	end

	rosw_update()
	if not g_rosw_switching then
		tbox_interact(id_funcs)
	end
end

function reset_time()
	attempt += 1
	actors = {}
	spawn_doors()
	gen_player(3, 3)
	spawn_entities()
	rosw_set(0,0, 8*16, 4*16, 1)

	tbox("|alien1 & alien2:*snickering*")
	tbox("|alien2:i think he is awake")
	tbox("|alien1:yes hello?")
	tbox("|alien2:hi there! welcome to our planet!")
	tbox("|alien1:do not feel alarmed. we are scientists here to help.")
	tbox("|alien1:we want to learn more about your species.")
	tbox("|alien2@species_call%human%shepbird%buttface%daddy:tell us. what does your species call itself?")
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
	pl.dir = 3
	pl.timer = 3
	pl.flip_x = false
	pl.flip_y = false
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

function switch_dialogue(nextx, nexty) 
	if not nextx then return end
	if nextx == 0*16 then

	elseif nextx == 1*16 then
		tbox("|alien1:we want to learn more about your background")
		tbox("|alien2@reason_leave%it was a great party%my ship malfunctioned:why did you crash on our planet?")
	elseif nextx == 2*16 then
		tbox("|alien1:we want to make sure you're psychological conditioning")
		tbox("|alien1:we need to see how you react to different forms of abuse.")
		tbox("|alien2:in the center of this room we have a lifeform known in your world as a puppy")
		tbox("|alien1:we will now commence in the attacking of this puppy")
		tbox("|alien1:hey puppy, thats a nice collar.")
		tbox("|alien2:did your mom make it for you?")
		tbox("|alien1&alien2:ahahahahahaahahahaha!")
		tbox("|alien2:ok "..player_species.." we are done abusing the puppy.")
		tbox("|alien1@abuse%you guys are evil %i hated that%2002 wants their joke back%that was hilarious%:how did you feel?")
	elseif nextx == 3*16 and nexty == 0*16 then	
		tbox("|alien1:we have some more questions.")
		tbox("|alien1:we want to run a few tests to evaluate your long-term memory")
		tbox("|alien2@is_single%no ;)%we are done here:question 1, are you single?")
	elseif nextx == 3*16 and nexty == 1*16 then	
		tbox("|alien1:theres no time! run into the portal!")
		tbox("|alien2:do it because we told you to!")
	end
end

-- checks the player's position and switches the room if needed.
function pl_rosw_update()
	local dir

	if     pl.x < g_x    then dir=0
	elseif pl.x > g_x+16 then dir=1
	elseif pl.y < g_y    then dir=2
	elseif pl.y > g_y+16 then dir=3 end

	if dir then switch_dialogue(rosw_move(dir)) end
end

