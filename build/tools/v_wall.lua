#!/usr/bin/lua

local tileset, zone, x_shift, y_shift, w, h = ...

for y=0,h-1 do
	place_setaspect(zone, x_shift, y_shift+y, tileset..":roof_lft")
	for x=0,w-2 do
		place_setaspect(zone, x_shift+1, y_shift+y, tileset..":roof")
	end
	place_setaspect(zone, x_shift+w-1, y_shift+y, tileset..":roof_rgt")
end
