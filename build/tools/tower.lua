#!/usr/bin/lua

local tileset, zone, x_shift, y_shift, id, directions = ...
local name = "Tour";

loadfile("build/tools/cube.lua")(tileset, zone, x_shift, y_shift, 5, 9, 4);

local hatch_x = x_shift+2;
local hatch_y = y_shift+2;
place_setaspect(zone, hatch_x, hatch_y, tileset..":hatch");

-- Floor 1.
local floor1 = id.."_floor_1";
loadfile("build/tools/interior.lua")(tileset, floor1, name, 9, 10);

-- Way to hatch.
place_setaspect(floor1, 4, 4, tileset..":stairs_up");
loadfile("build/tools/link.lua")(floor1, 4, 4, zone, hatch_x, hatch_y);

-- North.
if string.match(directions, "north") then
	place_setaspect(zone, x_shift+2, y_shift-1, tileset..":mosaic_a");
	loadfile("build/tools/door.lua")(tileset, floor1, 4, 1);
	loadfile("build/tools/link.lua")(zone, x_shift+2, y_shift-1, floor1, 4, 1);
else -- North windows.
	place_setaspect(floor1, 2, 0, tileset..":wall_window");
	place_setaspect(floor1, 6, 0, tileset..":wall_window");
end

-- South.
if string.match(directions, "south") then
	loadfile("build/tools/door.lua")(tileset, floor1, 4, 9);
	place_setaspect(floor1, 4, 9, tileset..":mosaic_a");
	place_setaspect(floor1, 4, 9-1, tileset..":path");
	loadfile("build/tools/door.lua")(tileset, zone, x_shift+2, y_shift+6);
	loadfile("build/tools/link.lua")(floor1, 4, 9, zone, x_shift+2, y_shift+6);
	
	-- Rebuild rampart.
	for j=7,8 do
		place_setaspect(zone, x_shift+1, y_shift+j, tileset..":roof_lft");
		place_setaspect(zone, x_shift+2, y_shift+j, tileset..":roof");
		place_setaspect(zone, x_shift+3, y_shift+j, tileset..":roof_rgt");
	end
else -- South windows.
	place_setaspect(zone, x_shift+1, y_shift+6, tileset..":wall_window");
	place_setaspect(zone, x_shift+3, y_shift+6, tileset..":wall_window");
	place_setaspect(floor1, 2, 8, tileset..":wall_window");
	place_setaspect(floor1, 6, 8, tileset..":wall_window");
end

-- West.
if string.match(directions, "west") then
	place_setaspect(floor1, 0, 3, tileset..":pillar_bot");
	place_setaspect(floor1, 0, 4, tileset..":mosaic_a");
	place_setaspect(zone, x_shift-1, y_shift+4, tileset..":mosaic_a");
	loadfile("build/tools/link.lua")(floor1, 0, 4, zone, x_shift-1, y_shift+4);
end

-- East.
if string.match(directions, "east") then
	place_setaspect(floor1, 8, 3, tileset..":pillar_bot");
	place_setaspect(floor1, 8, 4, tileset..":mosaic_a");
	place_setaspect(zone, x_shift+5, y_shift+4, tileset..":mosaic_a");
	loadfile("build/tools/link.lua")(floor1, 8, 4, zone, x_shift+5, y_shift+4);
end


-- Ground floor.
if string.match(directions, "ground") then
	if string.match(directions, "south") then
		warning("Tower try to generate with both south and ground entrances.");
		return;
	end

	local floor0 = id.."_floor_0";
	loadfile("build/tools/interior.lua")(tileset, floor0, name, 9, 10);

	-- Door to ground.
	loadfile("build/tools/door.lua")(tileset, floor0, 4, 9);
	place_setaspect(floor0, 4, 9, tileset..":mosaic_a");
	place_setaspect(floor0, 4, 9-1, tileset..":path");
	loadfile("build/tools/door.lua")(tileset, zone, x_shift+2, y_shift+8, 9);
	loadfile("build/tools/link.lua")(zone, x_shift+2, y_shift+8, floor0, 4, 9);

	-- Internal stairs.
	local stairs_x = 4;
	local stairs_y = 2;
	if string.match(directions, "north") then
		stairs_x = 2;
		stairs_y = 3;
	end
	place_setaspect(floor0, stairs_x, stairs_y, tileset..":stairs_up");
	place_setaspect(floor1, stairs_x, stairs_y, tileset..":stairs_down");
	loadfile("build/tools/link.lua")(floor0, stairs_x, stairs_y, floor1, stairs_x, stairs_y);
end
