function draw_player(a)
	a.timer += 1
	ind_add = a.timer % 3

	if btn(0) or btn(1) or btn(2) or btn(3) then
		if btn(0) then
			a.spr = 3
			a.flip_x = true
		end

		if btn(1) then
			a.spr = 3
			a.flip_x = false
		end

		if btn(2) then
			a.spr = 6
		end

		if btn(3) then
			a.spr = 0
		end
	else
		ind_add = 0
	end

	a.spr += ind_add

	draw_actor(a)
end

function draw_actor(a)
	scr_spr(a.spr, a.x, a.y, a.spr_w, a.spr_h, a.flip_x, a.flip_y)
end

