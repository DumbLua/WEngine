-- Wait function and others
-- A to z functions library
-- Made by $!Ulosth

local Module = {
	Vector = {};
}
local MmCache = {}
local MdCache = {}
local Words = {
	"the";
	"of";
	"that";
	"orange";
	"apple";
	"lua";
	"does";
	"have";
	"moon";
	"graphic";
	"gpu";
	"randomness";
	"code";
	"minecraft";
	"terraria";
	"any";
	"noise";
	"not";
	"hot";
	"cpu";
}

local AnyStringTable = {
	Any1 = {
		"!";	
		"?";
		".";
	};
}
--local math = require("math") -- dont use this ifffffff you arent using "pure lua(only lua compiler)"

function Module.wait(n)
	-- função de espera (não use muito, lua é singlethread)
	local now = os.time()
	local future = n ~= nil and now + n or now + 0.1
	while os.time() <= future do end
	now = nil
	future = nil
	collectgarbage("collect")
	return
end

function Module.cleanrm(debug)
	if debug then
	print("MEMORY BEFORE:"..collectgarbage("count").." KB")
	end
	MdCache = nil
	MdCache = {}
	MmCache = nil
	MmCache = {}
	collectgarbage("collect")
	if debug then
	print("MEMORY AFTER:"..collectgarbage("count").."KB")
	end
end
function Module.rand()
	-- Randomiza a seed do código
	math.randomseed(os.time())
	return
end

function Module.mdc(a,b)
	if a > 0 and b > 0 and MdCache[a] and MdCache[a][b] then
		return MdCache[a][b]
	end
	while b ~= 0 do
		a, b = b, a % b
	end
	local aa = math.abs(a)
	local BCache = {}
	MdCache[a] = BCache
	BCache[b] = aa
	return aa
end

function Module.mmc(a,b)
	if a == 0 or b == 0 then 
		return 0 
	end
	if a > 0 and b > 0 and MmCache[a] and MmCache[a][b] then
		return MmCache[a][b]
	end
	local Result = math.abs(a * b) / Module.mdc(a, b)
	local BCache = {}
	MmCache[a] = BCache
	BCache[b] = Result
	return Result
end

function Module.Vector.new(a,b,c)
	local x1 = type(a) == "number" and a or 0
	local y2 = type(b) == "number" and b or 0
	local z3 = type(c) == "number" and c or 0
	return setmetatable({x = x1; y = y2; z = z3;},Module.Vector)
end

function Module.Vector.magnitude()
	return math.sqrt(self.x^2 + self.y^2 + self.z^2)
end

function Module.prime(n)
	if type(n) ~= "number" then return false end
	if n <= 1 then
		return false
	end
	-- Verifica divisibilidade até a raiz quadrada de n
	for i = 2, math.sqrt(n) do
		if n % i == 0 then
			return false -- Não é primo
		end
	end
	return true -- É primo
end

function Module.nperfect(n)
	if type(n) ~= "number" then return false end
	-- Números menores ou iguais a 1 não são perfeitos
	if n <= 1 then
		return false
	end

	local soma = 0

	-- Itera de 1 até a metade do número para encontrar divisores
	for i = 1, math.floor(n / 2) do
		if n % i == 0 then
			soma = soma + i
		end
	end

	-- Se a soma dos divisores for igual ao número, ele é perfeito
	return soma == n
end


function Module.round(n)
	if type(n) ~= "number" then return 1 end
	return math.floor(n + 0.5)
end

function Module.phrase(words)
	local string = ""
	local lastword = ""
	for i = 1, words do
		local word = Words[math.random(1,#Words)]
		while word == lastword do
			word = Words[math.random(1,#Words)]
		end
		string = string..word.." "
		lastword = word
	end

	return string..AnyStringTable.Any1[math.random(1,#AnyStringTable.Any1)]
end

function Module.pi()
	return 3.14159265358
end
function Module.rad(n)
	return n * (Module.pi()/180)
end

function noisefunc(num,seed)
	local a = (math.sin(num -1 * seed) * math.cos(num +1 * seed))/2
	local b = (math.sin(num +1 * seed) * math.cos(num -1 * seed))/2
	local t = (math.sin(num * seed) * math.cos(num * seed))/2
	t = ( ( (math.sin((a * b / t)^2 - seed) + math.sin((a / b * t)^2 - seed))/2 ) * ((math.cos((a * b / t)^2 + seed) + math.cos((a / b * t)^2 + seed))/2))/2
 	return t
end

function Module.noise(seed,a,b)
	local Fator = 0
	Fator = (noisefunc(a,seed) + noisefunc(b,seed))/2
	return Fator -- Retorna o fator
end

return Module