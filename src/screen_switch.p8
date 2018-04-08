-- checks the player's position and switches the room if needed.
function pl_room_update()
	if     pl.x <  room_x*16    then switch_room(0)
	elseif pl.x >  room_x*16+16 then switch_room(1)
	elseif pl.y <  room_y*16    then switch_room(2)
	elseif pl.y >  room_y*16+16 then switch_room(3) end
end

-- x and y are in room coordinates (x < wld_w, y < wld_h)
function set_room(x, y)
	wld_w, wld_h = 8, 4
	wld_spd = .1
	room_x_spd = 0
	room_y_spd = 0
	room_switching = false

	room_x, room_y = x, y
	room_nxt_x = room_x
	room_nxt_y = room_y

	tbox("|alien1 & alien2:*snickering*")
	tbox("|alien2:i think he is awake")
	tbox("|alien1:yes hello?")
	tbox("|alien2:hi there! welcome to our planet!")
	tbox("|alien1:do not feel alarmed. we are scientists here to help.")
	tbox("|alien1:we want to learn more about your species.")
	tbox("|alien2@species_call%human%shepbird%buttface%daddy:tell us. what does your species call itself?")
end

function switch_room(dir)
	if not room_switching then
		if dir == 0 then
			room_nxt_x = max(0, room_x-1)
			room_x_spd = -wld_spd
		elseif dir == 1 then
			room_nxt_x = min(wld_w-1, room_x+1)
			room_x_spd = wld_spd
		elseif dir == 2 then
			room_nxt_y = max(0, room_y-1)
			room_y_spd = -wld_spd
		elseif dir == 3 then
			room_nxt_y = min(wld_h, room_y+1)
			room_y_spd = wld_spd
		end
		switch_dialogue(room_nxt_x, room_nxt_y)
		room_switching = true
	end	
end

function switch_dialogue(nextx, nexty) 
	if nextx == 0 then

	elseif nextx == 1 then
		tbox("|alien1:we want to learn more about your background")
		tbox("|alien2@reason_leave%it was a great party%my ship malfunctioned:why did you crash on our planet?")
	elseif nextx == 2 then
		tbox("|alien1:we want to make sure you're psychological conditioning")
		tbox("|alien1:we need to see how you react to different forms of abuse.")
		tbox("|alien2:in the center of this room we have a lifeform known in your world as a puppy")
		tbox("|alien1:we will now commence in the attacking of this puppy")
		tbox("|alien1:hey puppy, thats a nice collar.")
		tbox("|alien2:did your mom make it for you?")
		tbox("|alien1&alien2:ahahahahahaahahahaha!")
		tbox("|alien2:ok "..player_species.." we are done abusing the puppy.")
		tbox("|alien1@abuse%you guys are evil %i hated that%2002 wants their joke back%that was hilarious%:how did you feel?")
	elseif nextx == 3 and nexty == 0 then	
		tbox("|alien1:we have some more questions.")
		tbox("|alien1:we want to run a few tests to evaluate your long-term memory")
		tbox("|alien2@is_single%no ;)%we are done here:question 1, are you single?")
	elseif nextx == 3 and nexty == 1 then	
		tbox("|alien1:theres no time! run into the portal!")
		tbox("|alien2:do it because we told you to!")
	end
end

function update_room_switch()
	if room_switching then
		room_x += room_x_spd
		room_y += room_y_spd

		if room_x_spd > 0 then
			room_x = min(room_x, room_nxt_x)
			room_switching = not (room_x == room_nxt_x)
		elseif room_x_spd < 0 then
			room_x = max(room_x, room_nxt_x)
			room_switching = not (room_x == room_nxt_x)
		end

		if room_y_spd > 0 then
			room_y = min(room_y, room_nxt_y)
			room_switching = not (room_y == room_nxt_y)
		elseif room_y_spd < 0 then
			room_y = max(room_y, room_nxt_y)
			room_switching = not (room_y == room_nxt_y)
		end

		if not room_switching then
			room_x_spd, room_y_spd = 0, 0
		end
	end
end

function draw_rooms()
	-- draw 9x9 at start
	map(0, 0, -room_x*16*8, -room_y*16*8, 128, 64)
end
