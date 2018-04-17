-- x and y are in room coordinates (x < g_rosw_w, y < g_rosw_h)
function rosw_set(x, y, w, h, spd)
	g_rosw_w, g_rosw_h = w, h
	g_rosw_spd = spd
	g_rosw_switching = false
	g_rosw_x_spd, g_rosw_y_spd = 0, 0
	g_x, g_y, g_rosw_x_nxt, g_rosw_y_nxt = x, y, x, y
end

-- returns nil, or the room number switching to.
function rosw_move(dir)
	if not g_rosw_switching then
		if dir == 0 then
			g_rosw_x_nxt = max(0, g_x-16)
			g_rosw_x_spd = -g_rosw_spd
		elseif dir == 1 then
			g_rosw_x_nxt = min(g_rosw_w, g_x+16)
			g_rosw_x_spd = g_rosw_spd
		elseif dir == 2 then
			g_rosw_y_nxt = max(0, g_y-16)
			g_rosw_y_spd = -g_rosw_spd
		elseif dir == 3 then
			g_rosw_y_nxt = min(g_rosw_h, g_y+16)
			g_rosw_y_spd = g_rosw_spd
		end
		g_rosw_switching = true
		return g_rosw_x_nxt, g_rosw_y_nxt
	end
end

function rosw_update()
	if g_rosw_switching then
		g_x += g_rosw_x_spd
		g_y += g_rosw_y_spd

		if g_rosw_x_spd > 0 then
			g_x = min(g_x, g_rosw_x_nxt)
			g_rosw_switching = not (g_x == g_rosw_x_nxt)
		elseif g_rosw_x_spd < 0 then
			g_x = max(g_x, g_rosw_x_nxt)
			g_rosw_switching = not (g_x == g_rosw_x_nxt)
		end

		if g_rosw_y_spd > 0 then
			g_y = min(g_y, g_rosw_y_nxt)
			g_rosw_switching = not (g_y == g_rosw_y_nxt)
		elseif g_rosw_y_spd < 0 then
			g_y = max(g_y, g_rosw_y_nxt)
			g_rosw_switching = not (g_y == g_rosw_y_nxt)
		end

		if not g_rosw_switching then
			g_rosw_x_spd, g_rosw_y_spd = 0, 0
		end
	end
end

function rosw_draw()
	map(0, 0, scr_x(0), scr_y(0), g_rosw_w, g_rosw_h)
end
