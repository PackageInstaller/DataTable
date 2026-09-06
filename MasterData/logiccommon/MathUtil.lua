-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/util/MathUtil.lua

module("logiccommon.common.util.MathUtil", package.seeall)

local MathUtil = {}

function MathUtil.fillNum(m, n)
	local j, k

	if n then
		j = m
		k = n
	else
		j = 1
		k = m
	end

	local t = {}

	for i = j, k do
		table.insert(t, i)
	end

	return t
end

function MathUtil.randomEx(m, n, c)
	local tmp = MathUtil.fillNum(m, n)

	if c > n - m + 1 then
		return tmp
	end

	local x = 0
	local t = {}

	while c > 0 do
		x = math.random(1, n - m + 1)

		table.insert(t, tmp[x])
		table.remove(tmp, x)

		c = c - 1
		m = m + 1
	end

	return t
end

function MathUtil.randomWithWeightHashtable(hashtable)
	local totalWeight = 0

	for key, weight in pairs(hashtable) do
		totalWeight = totalWeight + checknumber(weight)
	end

	local randomPoint = math.random() * totalWeight
	local lastKey

	for key, weight in pairs(hashtable) do
		if randomPoint < weight then
			return key
		else
			randomPoint = randomPoint - weight
			lastKey = key
		end
	end

	return lastKey
end

function MathUtil.randArray(array)
	local temp, randNum

	for i = #array, 1, -1 do
		randNum = math.random(1, i)
		array[i] = array[randNum]
		array[randNum] = array[i]
	end
end

function MathUtil.clamp(num, min, max)
	max = checknumber(max)
	min = checknumber(min)
	num = checknumber(num)

	if max < min then
		min = max
		max = min
	end

	if max < num then
		return max
	elseif num < min then
		return min
	else
		return num
	end
end

return MathUtil
