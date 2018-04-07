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

		room_switching = true
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
	map(0, 0, -room_x*16*8, -room_y*16*8, 64, 128)
end
