-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Common\\FrameBattle\\Lib\\Random.lua

local rand = {}
local math_floor = math.floor

local function normalize(n)
	return n % 2147483648
end

local function bit_and(a, b)
	local r = 0
	local m = 0

	for m = 0, 31 do
		if a % 2 == 1 and b % 2 == 1 then
			r = r + 2^m
		end

		if a % 2 ~= 0 then
			a = a - 1
		end

		if b % 2 ~= 0 then
			b = b - 1
		end

		a = a / 2
		b = b / 2
	end

	return normalize(r)
end

local function bit_or(a, b)
	local r = 0
	local m = 0

	for m = 0, 31 do
		if a % 2 == 1 or b % 2 == 1 then
			r = r + 2^m
		end

		if a % 2 ~= 0 then
			a = a - 1
		end

		if b % 2 ~= 0 then
			b = b - 1
		end

		a = a / 2
		b = b / 2
	end

	return normalize(r)
end

local function bit_xor(a, b)
	local r = 0
	local m = 0

	for m = 0, 31 do
		if a % 2 ~= b % 2 then
			r = r + 2^m
		end

		if a % 2 ~= 0 then
			a = a - 1
		end

		if b % 2 ~= 0 then
			b = b - 1
		end

		a = a / 2
		b = b / 2
	end

	return normalize(r)
end

local function seed()
	return normalize(os.time())
end

local mersenne_twister = {}

mersenne_twister.__index = mersenne_twister

function mersenne_twister:randomseed(s)
	s = s or seed()
	self.rSeed = s
	self.mt[0] = normalize(s)

	for i = 1, 623 do
		self.mt[i] = normalize(1812433253 * bit_xor(self.mt[i - 1], math_floor(self.mt[i - 1] / 1073741824)) + i)
	end

	if Const.openRandomSeed then
		Framework.Tools.LuaToolkit.LogEx(" create randomseed : " .. tostring(s))

		local value = "------------------------------- start randomseed " .. s .. "-------------------------------------"

		for index = 0, 623 do
			value = value .. index .. ":" .. self.mt[index] .. "\n"
		end

		DebugHelper.LogToFile(value)
	end
end

function mersenne_twister:random(a, b)
	local y

	if self.index == 0 then
		for i = 0, 623 do
			y = self.mt[(i + 1) % 624] % 2147483648
			self.mt[i] = bit_xor(self.mt[(i + 397) % 624], math_floor(y / 2))

			if y % 2 ~= 0 then
				self.mt[i] = bit_xor(self.mt[i], 2567483615)
			end
		end

		if Const.openRandomSeed then
			local value = "------------------------------- rerandom " .. self.rSeed .. " ----------------------------------"

			for index = 0, 623 do
				value = value .. index .. ":" .. self.mt[index] .. "\n"
			end

			DebugHelper.LogToFile(value)
		end
	end

	y = self.mt[self.index]
	y = bit_xor(y, math_floor(y / 2048))
	y = bit_xor(y, bit_and(normalize(y * 128), 2636928640))
	y = bit_xor(y, bit_and(normalize(y * 32768), 4022730752))
	y = bit_xor(y, math_floor(y / 262144))
	self.index = (self.index + 1) % 624
	self.count = self.count + 1

	local ret

	if not a then
		ret = y / 2147483648
	elseif not b then
		if a == 0 then
			ret = y
		else
			ret = 1 + y % a
		end
	else
		ret = a + y % (b - a + 1)
	end

	if Const.openRandomSeed then
		Framework.Tools.LuaToolkit.LogEx("random Count is : " .. self.count .. " , selected random is : " .. tostring(ret) .. " a:" .. (a or "nil") .. " b:" .. (b or "nil") .. " seed:" .. self.rSeed .. " index" .. self.index .. " y:" .. y .. debug.traceback())
	end

	return ret
end

function mersenne_twister:getRandomCount()
	return self.count
end

function mersenne_twister:randomChoice(dataTable, n, retListMode)
	local indexTable = {}

	for idx, value in pairs(dataTable) do
		table.insert(indexTable, idx)
	end

	table.sort(indexTable)

	local lengthT = #indexTable

	if lengthT <= n then
		return dataTable
	end

	local outTable = {}

	for i = 1, n do
		local nowSelect = self:random(i, lengthT)
		local nowIdx = indexTable[nowSelect]

		indexTable[i], indexTable[nowSelect] = indexTable[nowSelect], indexTable[i]

		if retListMode then
			table.insert(outTable, dataTable[nowIdx])
		else
			outTable[nowIdx] = dataTable[nowIdx]
		end
	end

	return outTable
end

function mersenne_twister:randomChoiceByRule(dataTable, n, lowestKey)
	local indexTable = {}

	for idx, value in pairs(dataTable) do
		if idx ~= lowestKey then
			table.insert(indexTable, idx)
		end
	end

	table.sort(indexTable)

	local lengthT = #indexTable

	if n >= lengthT + 1 then
		return dataTable
	end

	local outTable = {}

	for i = 1, n do
		local nowSelect = self:random(i, lengthT)
		local nowIdx = indexTable[nowSelect]

		indexTable[i], indexTable[nowSelect] = indexTable[nowSelect], indexTable[i]
		outTable[nowIdx] = dataTable[nowIdx]
	end

	return outTable
end

function rand:twister(s)
	local temp = {}

	setmetatable(temp, mersenne_twister)

	temp.mt = {}
	temp.index = 0
	temp.count = 0

	temp:randomseed(s)

	return temp
end

local linear_congruential_generator = {}

linear_congruential_generator.__index = linear_congruential_generator

function linear_congruential_generator:random(a, b)
	local y = (self.a * self.x + self.c) % self.m

	self.x = y
	self.count = self.count + 1

	if not a then
		return y / 65536
	elseif not b then
		if a == 0 then
			return y
		else
			return 1 + y % a
		end
	else
		return a + y % (b - a + 1)
	end
end

function linear_congruential_generator:randomseed(s)
	s = s or seed()
	self.x = normalize(s)
end

function linear_congruential_generator:getRandomCount()
	return self.count
end

function rand:lcg(s, r)
	local temp = {}

	setmetatable(temp, linear_congruential_generator)

	temp.a, temp.c, temp.m = 1103515245, 12345, 65536

	if r then
		if r == "nr" then
			temp.a, temp.c, temp.m = 1664525, 1013904223, 65536
		elseif r == "mvc" then
			temp.a, temp.c, temp.m = 214013, 2531011, 65536
		end
	end

	temp.count = 0

	temp:randomseed(s)

	return temp
end

local multiply_with_carry = {}

multiply_with_carry.__index = multiply_with_carry

function multiply_with_carry:random(a, b)
	local m = self.m
	local t = self.a * self.x + self.c
	local y = t % m

	self.x = y
	self.c = math_floor(t / m)
	self.count = self.count + 1

	if not a then
		return y / 65536
	elseif not b then
		if a == 0 then
			return y
		else
			print("random Count is : " .. self.count .. " , selected random is : " .. tostring(1 + y % a))

			return 1 + y % a
		end
	else
		print("random Count is : " .. self.count .. " , selected random is : " .. tostring(a + y % (b - a + 1)))

		return a + y % (b - a + 1)
	end
end

function multiply_with_carry:randomseed(s)
	s = s or seed()
	self.c = self.ic
	self.x = normalize(s)
end

function multiply_with_carry:getRandomCount()
	return self.count
end

function rand:mwc(s, r)
	local temp = {}

	setmetatable(temp, multiply_with_carry)

	temp.a, temp.c, temp.m = 1103515245, 12345, 65536

	if r then
		if r == "nr" then
			temp.a, temp.c, temp.m = 1664525, 1013904223, 65536
		elseif r == "mvc" then
			temp.a, temp.c, temp.m = 214013, 2531011, 65536
		end
	end

	temp.ic = temp.c
	temp.count = 0

	temp:randomseed(s)

	return temp
end

function rand:random(a, b)
	if self._globalRandomGenerator == nil then
		self._globalRandomGenerator = self:twister()
	end

	return self._globalRandomGenerator:random(a, b)
end

return rand
