-- [-] : NOTHING
-- [P] : PLAYER
-- [C] : CONSTRUCTION
-- [K] : KILL CELL
-- [D] : DAMAGE CELL
-- [H] : HEAL CELL
local Script = {}
local Mlib = require("Modules/JustEnoughFunctions")

function Script.settings()
	os.execute("title WEngine game") -- game title
	-- some settings engine thing
	local v = {
		9, -- max 98: resolution 1600x900
		9, -- max 51: resolution 1600x900
		0, -- dont modify
		10.0, -- max health
		10.0, -- plr health
		2.5, -- damage cell damage
		3.3, -- heal cell heal
	}
	v[3] = {x = math.random(1,v[1]),y = math.random(1,v[2])}
	return v
end
function Script.buildmap(Yline) -- function  to build the map 
-- example:
--	for i = 1,#Yline do
--		if math.random(1,#Yline) > #Yline/2 + #Yline/3 then
--			Yline[i] = "D"
--		elseif math.random(1,#Yline) < #Yline/4 then
--			Yline[i] = "H"
--		end
--	end
end
function Script.load(Plr,Area) -- execute once before the loop game logic
-- script here
end
function Script.first_tick(Plr,Area) -- execute before the player action
-- script here
end
function Script.last_tick(Plr,Area) -- execute after the player action
-- script here
end

return Script