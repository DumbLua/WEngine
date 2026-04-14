#DOCS

Script.settings() -- **configure the game**
*example*
-- script file
function Script.settings()
	os.execute("title WEngine game") -- game title
	-- some settings engine thing
	local v = {
		10, -- max 98: resolution 1600x900 -- x
		10, -- max 51: resolution 1600x900 -- y
		0, -- dont modify -- spawnpos
		10.0, -- max health -- player max health
		7.5, -- plr health -- default player health
		2.5, -- damage cell damage -- how much damage will damage cell do
		4.3, -- heal cell heal -- how much heal will heal cell do
	}
	v[3] = {x = math.random(1,v[1]),y = math.random(1,v[2])}
	return v
end
Script.buildmap(yline) -- **build the map**
*example*
-- script file
function Script.buildmap(Yline)
	for i = 1,#Yline do
		if math.random(1,#Yline) > #Yline/2 + #Yline/3 then 
		-- if a random number between 1 and #Yline is bigger than #Yline/2 + #Yline/3 then the cell is a damage cell
			Yline[i] = "D"
		elseif math.random(1,#Yline) < #Yline/4 then
		-- elseif a random number between 1 and #Yline is less than #Yline/4 then the cell is a heal cell
			Yline[i] = "H"
		end
	end
end
Script.load(Plr,Area) -- **execute once before the game loop logic**
*example*
function Script.load(Plr,Area)
-- idk
end
Script.first_tick(Plr,Area) -- **execute before the player action**
*example*
function Script.first_tick(Plr,Area) -- execute before the player action
Plr.lastcell = "K" -- creates a trail of kill cells behind the player
end
Script.last_tick(Plr,Area) -- **execute after the player action**
*example*
function Script.last_tick(Plr,Area) -- execute after the player action
-- creating a new function cell
if Plr.lastcell == "T" then
print("T cell has been touched")
end
end
