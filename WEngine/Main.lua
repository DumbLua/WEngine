local Mlib = require("Modules/JustEnoughFunctions")
local Script = require("MainScript")
-- Settings
Mlib.rand()
local settings = Script.settings()
MapX = settings[1] or 50
MapY = settings[2] or 50
SpawnPos = settings[3] or {x = math.random(1,MapX),y = math.random(1,MapY)}
MaxHealth = settings[4] or 10.0
PlrHealth = settings[5] or 10.0
DCdamage = settings[6] or 2.0
HCheal = settings[7] or 5.0

-- Engine
local Area = {
}

-- Build map
for i = 1,MapY do
	local Y = {}
	for i2 = 1,MapX do
		Y[i2] = "-"
	end
	Script.buildmap(Y)
	Area[i] = Y
end
-- Any engine thing
local moves = 0
local Plr = {x = SpawnPos.x,y = SpawnPos.y, health = PlrHealth, lastcell = "",}
Plr.lastcell = Area[Plr.y][Plr.x]
Area[Plr.y][Plr.x] = "P"

function DisplayArea()
	for i, v in pairs(Area) do
		local string = ""
		for i1, v1 in pairs(v) do
			string = string..v1.." "
		end
		print(string)
	end
end
function Erase()
	if os.getenv("OS") == "Windows_NT" then
		os.execute("cls")
	else
		os.execute("clear")
	end
end

Script.load(Plr,Area)

while true do

	if Plr.health > 0 then
		Script.first_tick(Plr,Area)
		DisplayArea()
		print("HEALTH:"..Plr.health.." / MOVES:"..moves)
		print("[-]: NOTHING / [P]: PLAYER / [C]: CONSTRUCTION / [K]: KILL CELL / [D]: DAMAGE CELL / [H]: HEAL CELL")
		local Input = io.read();Input = string.lower(Input)
		if string.find(Input,"w") then
			if Plr.y - 1 ~= 0 and Area[Plr.y -1][Plr.x] ~= "C" then
				moves = moves +1
				Area[Plr.y][Plr.x] = Plr.lastcell
				Plr.y = Plr.y -1
				Plr.lastcell = Area[Plr.y][Plr.x] ~= "Z" and Area[Plr.y][Plr.x] or "N"
				Area[Plr.y][Plr.x] = "P"
			end
		elseif string.find(Input,"s") then
			if Plr.y + 1 ~= MapY + 1 and Area[Plr.y +1][Plr.x] ~= "C" then
				moves = moves +1
				Area[Plr.y][Plr.x] = Plr.lastcell
				Plr.y = Plr.y + 1
				Plr.lastcell = Area[Plr.y][Plr.x] ~= "Z" and Area[Plr.y][Plr.x] or "N"
				Area[Plr.y][Plr.x] = "P"
			end
		elseif string.find(Input,"a") then
			if Plr.x - 1 ~= 0 and Area[Plr.y][Plr.x -1] ~= "C" then
				moves = moves +1
				Area[Plr.y][Plr.x] = Plr.lastcell
				Plr.x = Plr.x - 1
				Plr.lastcell = Area[Plr.y][Plr.x] ~= "Z" and Area[Plr.y][Plr.x] or "N"
				Area[Plr.y][Plr.x] = "P"
			end
		elseif string.find(Input,"d") then
			if Plr.x + 1 ~= MapX + 1 and Area[Plr.y][Plr.x +1] ~= "C" then
				moves = moves +1
				Area[Plr.y][Plr.x] = Plr.lastcell
				Plr.x = Plr.x + 1
				Plr.lastcell = Area[Plr.y][Plr.x] ~= "Z" and Area[Plr.y][Plr.x] or "N"
				Area[Plr.y][Plr.x] = "P"
			end	
		end
		if Plr.lastcell == "K" then 
			Plr.health = 0 
		elseif Plr.lastcell == "D" then
			Plr.health = Plr.health - DCdamage
		elseif Plr.lastcell == "H" then
			if Plr.health < MaxHealth and Plr.health + HCheal <= MaxHealth then 
				Plr.health = Plr.health +HCheal
			elseif Plr.health < MaxHealth and Plr.health + HCheal > MaxHealth then
				local d = (Plr.health + HCheal) - MaxHealth
				d = HCheal - d
				Plr.health = Plr.health + d
			end
		end
		Erase()
		Script.last_tick(Plr,Area)
		Mlib.cleanrm()
	else

		break
	end

end
if Plr.health <= 0.0 then 
print(); 
print("PLAYER DIED WITH "..moves.." MOVES");
Plr = nil
Area = nil
Mlib.cleanrm(true)
end