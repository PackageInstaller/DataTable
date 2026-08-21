-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/util/MathUtil.lua

module("logic.common.util.MathUtil", package.seeall)

function preciseDecimal(value, numDigits)
	local num = 10^numDigits

	return math.round(value * num) / num
end

function floorPreciseDecimal(value, numDigits)
	local num = 10^numDigits

	return math.floor(value * num) / num
end

function fixIntegerBits(value, preNum)
	local valueStr = tostring(value)

	for i = preNum - 1, 1, -1 do
		if value < math.pow(10, i) then
			valueStr = string.format("0%s", valueStr)
		else
			break
		end
	end

	return valueStr
end

function roundingBy456(v)
	local a, b = math.modf(v)

	if b < 0.5 then
		return a
	elseif b == 0.5 then
		return a % 2 == 0 and a or a + 1
	else
		return a + 1
	end
end

function getCoinValue(value, numDigits, firstMarkValue, firstTail, secondTail)
	numDigits = numDigits or 1

	local head = tonumber(value)

	if not head then
		return "0"
	end

	if firstMarkValue and value < firstMarkValue then
		return value
	end

	local tail = ""
	local firstMax = firstMarkValue or 1000000
	local secondeMax = 1000000000
	local firstDev = math.ceil(firstMax / 10000)

	if firstMax <= head and head < secondeMax then
		tail = firstTail or "万"
		head = floorPreciseDecimal(head / (firstMax / firstDev), numDigits)
	elseif secondeMax <= head then
		tail = secondTail or "亿"
		head = floorPreciseDecimal(head / (secondeMax / 10), numDigits)
	end

	return head .. tail
end

function normalizeAngle(angle)
	angle = math.fmod(angle, 360)
	angle = angle < 0 and 360 + angle or angle

	return angle
end

function isAngleInRange(angle, minAngle, maxAngle)
	angle = MathUtil.normalizeAngle(angle)
	minAngle = MathUtil.normalizeAngle(minAngle)
	maxAngle = MathUtil.normalizeAngle(maxAngle)

	if minAngle < maxAngle then
		return minAngle < angle and angle < maxAngle
	elseif maxAngle < minAngle then
		return minAngle < angle and angle < 360 or angle >= 0 and angle < maxAngle
	end

	return false
end

function numToRoman(num)
	local symbols = {
		{
			value = 1000,
			symbol = "M"
		},
		{
			value = 900,
			symbol = "CM"
		},
		{
			value = 500,
			symbol = "D"
		},
		{
			value = 400,
			symbol = "CD"
		},
		{
			value = 100,
			symbol = "C"
		},
		{
			value = 90,
			symbol = "XC"
		},
		{
			value = 50,
			symbol = "L"
		},
		{
			value = 40,
			symbol = "XL"
		},
		{
			value = 10,
			symbol = "X"
		},
		{
			value = 9,
			symbol = "IX"
		},
		{
			value = 5,
			symbol = "V"
		},
		{
			value = 4,
			symbol = "IV"
		},
		{
			value = 1,
			symbol = "I"
		}
	}
	local romanStr = ""

	for _, v in ipairs(symbols) do
		while num >= v.value do
			num = num - v.value
			romanStr = romanStr .. v.symbol
		end

		if num <= 0 then
			break
		end
	end

	return romanStr
end

function intersectCircleAndLine(circleCenter, circleRadius, point)
	local dir = Vector2.New(point.x - circleCenter.x, point.y - circleCenter.y)
	local mod = Vector2.Magnitude(dir)

	if mod < circleRadius then
		return false
	end

	local angle = Vector2.Angle(Vector2(1, 0), dir)

	if dir.y < 0 then
		angle = 360 - angle
	end

	local angleRad = math.rad(angle)
	local xOffset = math.cos(angleRad) * circleRadius
	local yOffset = math.sin(angleRad) * circleRadius

	return Vector2.New(circleCenter.x + xOffset, circleCenter.y + yOffset)
end
