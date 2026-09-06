-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddessshop/data/MmUtil.lua

module("logic.extensions.goddessshop.data.MmUtil", package.seeall)

local MmUtil = {}
local typePrefixes = {
	table = "t:",
	string = "s:",
	["nil"] = "u:nil",
	boolean = "b:",
	number = "n:"
}

MmUtil.State_Preparing = "State_Preparing"
MmUtil.State_Runing = "State_Runing"
MmUtil.State_Stoping = "State_Stoping"
MmUtil.State_Ended = "State_Ended"
MmUtil.GameResult_GameOverOfSuccess = "GameResult_GameOverOfSuccess"
MmUtil.GameResult_GameOverOfFail = "GameResult_GameOverOfFail"
MmUtil.GameResult_GameOverOfDropOut = "GameResult_GameOverOfDropOut"
MmUtil.GameResult_GameOverFailAndReset = "GameResult_GameOverFailAndReset"

function MmUtil.getUniqueKey(...)
	local args = {
		...
	}
	local parts = {}
	local length = math.max(#args, 1)

	for i = 1, length do
		local value = args[i]
		local value_type = type(value)

		if not typePrefixes[value_type] then
			parts[#parts + 1] = typePrefixes[value_type]

			if value_type ~= "nil" then
				parts[#parts + 1] = tostring(value)
			end

			if i < length then
				parts[#parts + 1] = "#"
			end
		end
	end

	return table.concat(parts)
end

function MmUtil.coverList(tableA, tableB)
	for k, v in pairs(tableA) do
		tableA[k] = nil
	end

	for i, v in ipairs(tableB) do
		table.insert(tableA, v)
	end
end

function MmUtil.coverDictionary(tableA, tableB)
	for k, v in pairs(tableA) do
		tableA[k] = nil
	end

	for key, value in pairs(tableB) do
		tableA[key] = value
	end
end

function MmUtil.isPlainSearchMatch(text, searchText)
	local isMatched = string.nilorempty(searchText)

	if not isMatched and text ~= nil then
		isMatched = string.find(tostring(text), searchText, 1, true) ~= nil
	end

	return isMatched
end

function MmUtil.isSequentialFuzzySearchMatch(text, searchText)
	local isMatched = string.nilorempty(searchText)

	if not isMatched and text ~= nil then
		local startIndex = 1
		local searchChars = StringUtil.utf8split(searchText)
		local targetText = tostring(text)

		isMatched = true

		for _, char in ipairs(searchChars) do
			local findIndex = string.find(targetText, char, startIndex, true)

			isMatched = findIndex ~= nil

			if not isMatched then
				break
			end

			startIndex = findIndex + string.len(char)
		end
	end

	return isMatched
end

function MmUtil.fillTableByValues(tableA, tableB, isCover)
	if isCover then
		for k, v in pairs(tableA) do
			tableA[k] = nil
		end
	end

	for _, value in pairs(tableB) do
		tableA[value] = value
	end
end

function MmUtil.checkTable(tb, ...)
	local keys = {
		...
	}

	if tb == nil then
		tb = {}
	end

	local current = tb

	for _, key in ipairs(keys) do
		current[key] = current[key] or {}
		current = current[key]
	end

	return tb
end

function MmUtil.binarySearchInSingleKey(tb, field, value)
	local result

	if tb then
		value = checknumber(value)

		local low, high = 0, #tb

		if tb[low] == nil then
			low = 1
		end

		local isUp = tb[low][field] <= tb[high][field]
		local mid, midValue = 0, 0

		while low <= high do
			mid = math.floor((low + high) / 2)

			if midValue == nil then
				break
			end

			midValue = checknumber(tb[mid][field])

			if isUp and midValue <= value or not isUp and value <= midValue then
				result = tb[mid]
				low = mid + 1
			else
				high = mid - 1
			end
		end
	end

	return result
end

function MmUtil.binarySearchInArrayKey(tb, field, value)
	local result

	if tb then
		value = checknumber(value)

		local low, high = 0, #tb

		if tb[low] == nil then
			low = Mathf.Min(1, high)
		end

		local isUp = tb[low][field][1] <= tb[high][field][1]
		local mid, lower, upper, midValue = 0, 0, 0

		while low <= high do
			mid = math.floor((low + high) / 2)

			if tb[mid] == nil then
				do break end

				upper = checknumber(tb[mid][field][2])
			end

			lower = checknumber(tb[mid][field][1])

			if isUp and value < lower or not isUp and upper < value then
				high = mid - 1
			elseif isUp and upper < value or not isUp and value < lower then
				low = mid + 1
			else
				result = tb[mid]

				break
			end
		end
	end

	return result
end

function MmUtil.unorderedSearchInSingleKey(tb, field, value)
	if tb == nil then
		return nil
	end

	local result

	for i, data in pairs(tb) do
		if value >= data[field] and (result == nil or data[field] > result[field]) then
			result = data
		end
	end

	return result
end

function MmUtil.unorderedSearchInArrayKey(tb, field, value)
	if tb == nil then
		return nil
	end

	local result

	for i, data in pairs(tb) do
		if value >= data[field][1] and value <= data[field][2] then
			result = data

			break
		end
	end

	return result
end

function MmUtil.FormatTimeWords(timeStamp)
	local day, hour, min, sec = GameUtil.getTimeDDHHMMSS(timeStamp)

	if day >= 1 then
		return string.format("%02d天%02d时%02d分", day, hour, min)
	elseif hour >= 1 then
		return string.format("%02d时%02d分%02d秒", hour, min, sec)
	elseif min >= 1 then
		return string.format("%02d分%02d秒", min, sec)
	else
		return string.format("%02d秒", sec)
	end
end

function MmUtil.signedAngleVector2(from, to)
	local angle = Vector2.Angle(from, to)
	local sign = Mathf.Sign(from.x * to.y - from.y * to.x)
	local result = angle * sign

	return math.floor(result * 100 + 0.5) / 100
end

function MmUtil.rotateVector2(vector, angle)
	local rad = checknumber(angle) * Mathf.Deg2Rad
	local x, y = checknumber(vector.x), checknumber(vector.y)
	local vx = x * Mathf.Cos(rad) - y * Mathf.Sin(rad)
	local vy = x * Mathf.Sin(rad) + y * Mathf.Cos(rad)

	return Vector2.New(vx, vy)
end

function MmUtil.randomPick(arr, count, isNotRepeat)
	local result = {}
	local length = #arr

	isNotRepeat = isNotRepeat or false

	if not isNotRepeat then
		for idx = 1, count do
			local randomIndex = math.random(1, length)

			table.insert(result, arr[randomIndex])
		end
	else
		if length < count then
			printError(string.format("non-repeat模式下，选择数量不能超过数组长度: count=%s, length=%s", count, length))

			count = length
		end

		local tempArr = {}

		for i = 1, length do
			tempArr[i] = arr[i]
		end

		MmUtil.shuffle(tempArr)

		for i = 1, count do
			table.insert(result, tempArr[i])
		end
	end

	return result
end

function MmUtil.shuffle(list)
	for i = 1, #list do
		local ranIdx = math.random(i, #list)

		list[i], list[ranIdx] = list[ranIdx], list[i]
	end

	return list
end

function MmUtil.createClientKey()
	return math.random(1, 100000)
end

local _condCallbacks = {}

function MmUtil.createCondCallback(key, callBack)
	_condCallbacks[key] = {
		callback = callBack,
		conditions = {}
	}
end

function MmUtil.clearCondCallback(key)
	_condCallbacks[key] = nil
end

function MmUtil.addCondCallback(key, condKey)
	if _condCallbacks[key] then
		_condCallbacks[key].conditions[condKey] = true
	end
end

function MmUtil.finishCondCallback(key, condKey)
	if _condCallbacks[key] then
		_condCallbacks[key].conditions[condKey] = nil

		local allDone = true

		for _, v in pairs(_condCallbacks[key].conditions) do
			if v then
				allDone = false

				break
			end
		end

		if allDone then
			_condCallbacks[key].callback()
			MmUtil.clearCondCallback(key)
		end
	end
end

MmUtil.Towards = {}
MmUtil.Towards.Up = 1
MmUtil.Towards.Right = 2
MmUtil.Towards.Down = 3
MmUtil.Towards.Left = 4
MmUtil.Directions = {
	[MmUtil.Towards.Up] = Vector2.New(0, 1),
	[MmUtil.Towards.Right] = Vector2.New(1, 0),
	[MmUtil.Towards.Down] = Vector2.New(0, -1),
	[MmUtil.Towards.Left] = Vector2.New(-1, 0)
}
MmUtil.RotationAngles = {
	[MmUtil.Towards.Up] = 0,
	[MmUtil.Towards.Right] = -90,
	[MmUtil.Towards.Down] = 180,
	[MmUtil.Towards.Left] = 90
}

function MmUtil.getPosIndex(x, y, width, height)
	return (x and y and MmUtil.isInRange(x, y, width, height) or nil) and y * width + x + 1
end

function MmUtil.getPos(index, width, height)
	local x = (index - 1) % width
	local y = math.floor((index - 1) / width)

	return x, y
end

function MmUtil.getNeighborPos(x, y, width, height, toward)
	local nbrX, nbrY = x, y
	local dir = MmUtil.Directions[toward]

	if dir then
		nbrX = x + dir.x
		nbrY = y + dir.y

		if not MmUtil.isInRange(x + dir.x, y + dir.y, width, height) then
			nbrY = nil
			nbrX = nil
		end
	end

	return nbrX, nbrY
end

function MmUtil.getNeighborPosByIndex(index, width, height, toward)
	local x, y = MmUtil.getPos(index, width, height)

	return MmUtil.getNeighborPos(x, y, width, height, toward)
end

function MmUtil.isInRange(x, y, width, height)
	return x >= 0 and x < width and y >= 0 and y < height
end

function MmUtil.isInRangeByIndex(index, width, height)
	local x = (index - 1) % width
	local y = math.floor((index - 1) / width)

	return x >= 0 and x < width and y >= 0 and y < height
end

function MmUtil.getToward(x1, y1, x2, y2)
	if x1 == x2 then
		if y1 < y2 then
			return MmUtil.Towards.Up
		elseif y2 < y1 then
			return MmUtil.Towards.Down
		end
	elseif y1 == y2 then
		if x1 < x2 then
			return MmUtil.Towards.Right
		elseif x2 < x1 then
			return MmUtil.Towards.Left
		end
	end

	return nil
end

MmUtil.Units_CN = {
	{
		1000000000000,
		"万亿"
	},
	{
		100000000,
		"亿"
	},
	{
		10000,
		"万"
	},
	{
		1000,
		"千"
	}
}
MmUtil.Units_EN = {
	{
		1000000000000,
		"T"
	},
	{
		1000000000,
		"B"
	},
	{
		1000000,
		"M"
	},
	{
		1000,
		"K"
	}
}
MmUtil.Units_OnlyW = {
	{
		10000,
		"W"
	}
}
MmUtil.Units_OnlyWB = {
	{
		1000000000,
		"B"
	},
	{
		10000,
		"W"
	}
}

function MmUtil.formatNumber(num, formapList, decimalCount)
	num = checknumber(num)
	decimalCount = decimalCount or 1

	local sign = ""

	if num < 0 then
		sign = "-"
		num = math.abs(num)
	end

	local result = num

	for _, unit in ipairs(formapList or MmUtil.Units_EN) do
		if num >= unit[1] then
			result = MmUtil.floorDecimal(num / unit[1], decimalCount)

			local fmt_str = string.format("%.0" .. decimalCount .. "f", result)

			fmt_str = fmt_str:gsub("(%..*%d)0+$", "%1")
			fmt_str = fmt_str:gsub("%.0*$", "")

			return string.format("%s%s%s", sign, fmt_str, unit[2])
		end
	end

	result = MmUtil.floorDecimal(result, decimalCount)

	local fmt_str = string.format("%.0" .. decimalCount .. "f", result)

	fmt_str = fmt_str:gsub("(%..*%d)0+$", "%1")
	fmt_str = fmt_str:gsub("%.0*$", "")

	return string.format("%s%s", sign, fmt_str)
end

function MmUtil.floorDecimal(n, decimal)
	local factor = 10^decimal

	return math.floor(n * factor) / factor
end

function MmUtil.formatNumberWithComma(num)
	num = checknumber(num) or 0

	local numStr = tostring(math.floor(math.abs(num)))
	local result = ""
	local len = string.len(numStr)

	for i = len, 1, -1 do
		result = string.sub(numStr, i, i) .. result

		if i > 1 and (len - i + 1) % 3 == 0 then
			result = "," .. result
		end
	end

	return ((num < 0 or nil) and "-") .. result
end

function MmUtil.getPolygonCentroid(points)
	local area = 0
	local cx, cy = 0, 0
	local count = #points

	for i = 1, count do
		local p1 = points[i]
		local p2 = points[i % count + 1]
		local cross = p1.x * p2.y - p2.x * p1.y

		area = area + cross
		cx = cx + (p1.x + p2.x) * cross
		cy = cy + (p1.y + p2.y) * cross
	end

	area = area / 2
	cx = cx / (6 * area)
	cy = cy / (6 * area)

	return cx, cy
end

function MmUtil.isPointInPolygon(polygonPoints, testPoint)
	if not polygonPoints or not testPoint then
		return false
	end

	local pointCount = #polygonPoints

	if pointCount < 3 then
		return false
	end

	local isInside = false
	local j = pointCount

	for i = 1, pointCount do
		local pi = polygonPoints[i]
		local pj = polygonPoints[j]

		if pi.y > testPoint.y ~= (pj.y > testPoint.y) and testPoint.x < (pj.x - pi.x) * (testPoint.y - pi.y) / (pj.y - pi.y) + pi.x then
			isInside = not isInside
		end

		j = i
	end

	return isInside
end

function MmUtil.getBitSet(number, bitPosition)
	return (bit.band(number, bit.lshift(1, bitPosition)) ~= 0 or nil) and 1
end

function MmUtil.setBitSetAndGetReturnNum(number, bitPosition, setNum)
	if bitPosition <= 0 then
		printError("乱输入bitPosition！！！！ bitPosition: ", bitPosition)

		return
	end

	number = setNum == 1 and bit.bor(number, bit.lshift(1, bitPosition)) or bit.band(number, bit.bnot(bit.lshift(1, bitPosition)))

	return number
end

return MmUtil
