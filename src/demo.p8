function _init()
	-- sprite background for the game
	palt(0, false)
	palt(14, true)
	g_tl = tl_init( {
		{ update_title, draw_title, nil, init_title },
		{ update_message, print_message, nil },
		{ update_world, draw_world, nil, init_world },
	} )

	music(0)

	global_time = 0
end

function _update60()
	tl_update(g_tl)
	global_time += 1
end


function _draw()
	cls()
	tl_draw(g_tl)
end
