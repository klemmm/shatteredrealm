#!/usr/bin/lua

local zone = character_getzone(Character)
local x = character_getx(Character)
local y = character_gety(Character)

local fun = function (x, y)
	local tileset, tile = string.match(place_getaspect(zone, x, y), "(.*):(.*)")
	if tile == "wall_bot_written" then
		if place_gettag(zone, x, y, "text_type") == "chalk" then
			place_deltag(zone, x, y, "text")
			place_deltag(zone, x, y, "text_type")
			place_setaspect(zone, x, y, tileset..":wall_bot")
			local script = place_gettag(zone, x, y, "text_clear_trigger")
			if script and script ~= "" then
				loadstring(script)()
			end
		else
			character_message(Character, "Ce message n'est pas écrit à la craie et ne peut pas être /effacer.")
		end
		return true
	else
		return false
	end
end

if not fun(x, y)
and not fun(x, y-1)
and not fun(x, y+1)
and not fun(x-1, y)
and not fun(x+1, y)
then
	character_message(Character, "Il n'y a aucun écrit à /effacer.")
end
