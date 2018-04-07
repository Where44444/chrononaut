function init_title()
	title_parts = {}
end



function draw_title()
	local t = global_time + 250 / 4
	local tx, ty = cos(-t/300) * 20 + 44, sin(-t/300) * 20 + 61
	local ax, ay = cos(t/300) * 30, sin(t/300) * 30

	spr(0, ax+tx+16, ay+ty-1)
	print("chrononaut", tx, ty, 7)
end

function spawn_parts()

end

function update_title()

	if btnp(4) or btnp(5) then
		tl_next(g_tl)
	end

	foreach(title_parts, update_title_part)
	if global_time % 10 then
	end
end

function create_title_part(x, y)
	local buf = 30
	local p = {
		x = x - buf + rnd(buf*2),
		y = y - buf + rnd(buf*2),
		dx = rnd(.2) - .1,
		dy = rnd(.2) - .1,
		r = rnd(6)+.5,
		age = rnd(90) + 30
	}

	return p
end

function update_title_part(p)
	p.x += p.dx
	p.y += p.dy
	p.age -= 1
end

function draw_title_part(p)
	--circfill(p.x, p.y, p.r, 2)
end
