function update_message()
	if btnp(4) then
		tl_next(g_tl)
	end
end

function print_center(text, y, col)
	print(text, 64 - #text/2*4, y, col)
end

function print_message()
	print_center("your name is", 46, 7)
	print_center("commander shepbird", 52, 7)
	print_center("you are exploring", 58, 7)
	print_center("a new solar system when", 64, 7)
	print_center("suddenly you hear a thunk", 70, 7)
	print_center("and everything goes black", 76, 7)

	if global_time % 60 < 30 then
		print_center("press z to continue", 100, 6)
	end
end
