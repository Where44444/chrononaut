function init_title()
	title_parts = {}
end

function draw_title()
	foreach(title_parts, draw_title_part)

	spr(0, title_ax+title_tx-4, title_ay+title_ty-4)

	print("chrononaut", title_tx-19, title_ty-2, 1)
	print("chrononaut", title_tx-20, title_ty-3, 7)
	print_center("press z to start", title_ty+40, 7)
end

function update_title()
	local t = global_time + 250 / 4
	title_tx, title_ty = cos(-t/300) * 20 + 64, sin(-t/300) * 20 + 64
	title_ax, title_ay = cos(t/300) * 30, sin(t/300) * 30

	if btnp(4) then
		tl_next(g_tl)
	end

	foreach(title_parts, update_title_part)
	if global_time % 2 == 0 then
		add(title_parts, create_title_part(title_tx, title_ty))
	end

	for p in all(title_parts) do
		if p.age < 0 then
			del(title_parts, p)
		end
	end
end

function create_title_part(x, y)
	local buf = 50
	local p = {
		x = x - buf + rnd(buf*2),
		y = y - buf + rnd(buf*2),
		dx = rnd(.5) - .25,
		dy = rnd(.5) - .25,
		r = rnd(1)+1,
		age = rnd(90)+30
	}

	return p
end

function update_title_part(p)
	p.x += p.dx
	p.y += p.dy
	p.age -= 1
	p.r -= .05
end

function draw_title_part(p)
	circfill(p.x, p.y, p.r, 10)
end
