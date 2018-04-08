anitime = 0
dir = 0
function draw_player(a)
	local xoff = room_x*8*16
	local yoff = room_y*8*16
	local x1 = (a.x-.5) * 8
	local y1 = (a.y-.5)*8
	anitime += 1

	if (a.spr >= 0 and a.spr <= 8) then --if its the astronaut sprite

if (btn(0) or btn(1) or btn(2) or btn(3))
then

		if btn(0) --left
		then
			dir = 0
			spr(anitime % 3 + 3, x1-xoff, y1-yoff, 1, 1, true, false)
		end

		if btn(1) --right
		then
			dir = 1
			spr(anitime % 3 + 3, x1-xoff, y1-yoff)
		end

		if btn(2) --up
		then
			dir = 2
			spr(anitime % 3 + 6, x1-xoff, y1-yoff)
		end

		if btn(3) --down
		then
			dir = 3
			spr(anitime % 3, x1-xoff, y1-yoff)
		end

	else

		if (dir == 0) spr(3, x1-xoff, y1-yoff, 1, 1, true, false)
		if (dir == 1) spr(3, x1-xoff, y1-yoff, 1, 1)
		if (dir == 2) spr(6, x1-xoff, y1-yoff, 1, 1)
	  if (dir == 3) spr(0, x1-xoff, y1-yoff, 1, 1)
	end

	end

end

-- todo, remove this for final game.
function debug_actor_box(a, col)
	local xoff = room_x*8*16
	local yoff = room_y*8*16
	local x1 = (a.x-.5) * 8
	local x2 = (a.x+.5)*8 - 1
	local y1 = (a.y-.5)*8
	local y2 = (a.y+.5)*8 - 1
	rect(x1-xoff, y1-yoff, x2-xoff, y2-yoff, col)
end

function draw_actor(a)
	spr_off(a.spr, a.x, a.y, a.spr_w, a.spr_h)
end

function spr_off(spr_ind, x, y, w, h, flip_x, flip_y)
	local xoff = room_x*8*16
	local yoff = room_y*8*16
	x = (x-.5)*8 - xoff
	y = (y-.5)*8 - yoff
	spr(spr_ind, x, y, w, h, flip_x, flip_y)
end
