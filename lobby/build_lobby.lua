#!/usr/bin/lua

local zone = "lobby"
local w = 31
local h = 31

new_zone(zone, "Lobby", w, h, "void")

-- Tutorial

local x = 16
local y = 20
zone_settile(zone, x, y, "violetcastle:mosaic_a")
local tuto_zone, tuto_x, tuto_y = loadfile("lobby/build_tutorial.lua")(zone, x, y)
zone_setlandon(zone, x, y, "player_changezone(Player, \""..tuto_zone.."\", "..tuto_x..", "..tuto_y..")")

-- Start choices

local build_choice = function(x, y, tileset, name, dummy)
	local x, y = loadfile("build/tools/building.lua")(tileset, zone, x, y, 5)
	zone_setlandon(zone, x, y, "dofile(\"lobby/choice_"..string.lower(name)..".lua\")")
	zone_settile(zone, x-1, y+2, dummy)
	zone_settile(zone, x+1, y+2, tileset..":book_a_open")
	zone_settag(zone, x+1, y+2, "text", name)
end

build_choice(1, 1, "redruins", "Demon", "demon_trident_flame_wings")
build_choice(8, 1, "violetcastle", "Human", "white_armor")

verbose("[WORLDGEN] Lobby finished.")
