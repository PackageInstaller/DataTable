-- chunkname: @Util\\Math.lua

local floor = math.floor
local abs = math.abs

function math.round(num)
	return floor(num + 0.5)
end

function math.sign(num)
	num = num > 0 and 1 or num < 0 and -1 or 0

	return num
end

function math.clamp(num, min, max)
	if num < min then
		num = min
	elseif max < num then
		num = max
	end

	return num
end

local clamp = math.clamp

function math.lerp(from, to, t)
	return from + (to - from) * clamp(t, 0, 1)
end

function math.Repeat(t, length)
	return t - floor(t / length) * length
end

function math.LerpAngle(a, b, t)
	local num = math.Repeat(b - a, 360)

	if num > 180 then
		num = num - 360
	end

	return a + num * clamp(t, 0, 1)
end

function math.MoveTowards(current, target, maxDelta)
	if maxDelta >= abs(target - current) then
		return target
	end

	return current + mathf.sign(target - current) * maxDelta
end

function math.DeltaAngle(current, target)
	local num = math.Repeat(target - current, 360)

	if num > 180 then
		num = num - 360
	end

	return num
end

function math.MoveTowardsAngle(current, target, maxDelta)
	target = current + math.DeltaAngle(current, target)

	return math.MoveTowards(current, target, maxDelta)
end

function math.Approximately(a, b)
	return abs(b - a) < math.max(1e-06 * math.max(abs(a), abs(b)), 1.121039e-44)
end

function math.InverseLerp(from, to, value)
	if from < to then
		if value < from then
			return 0
		end

		if to < value then
			return 1
		end

		value = value - from
		value = value / (to - from)

		return value
	end

	if from <= to then
		return 0
	end

	if value < to then
		return 1
	end

	if from < value then
		return 0
	end

	return 1 - (value - to) / (from - to)
end

function math.PingPong(t, length)
	t = math.Repeat(t, length * 2)

	return length - abs(t - length)
end

math.deg2Rad = math.pi / 180
math.rad2Deg = 180 / math.pi
math.epsilon = 1.401298e-45

function math.Random(n, m)
	local range = m - n

	return math.random() * range + n
end

function math.isnan(number)
	return number ~= number
end

local PI = math.pi
local TWO_PI = 2 * math.pi
local HALF_PI = math.pi / 2

function math.sin16(a)
	local s

	if a < 0 or a >= TWO_PI then
		a = a - floor(a / TWO_PI) * TWO_PI
	end

	if a < PI then
		if a > HALF_PI then
			a = PI - a
		end
	elseif a > PI + HALF_PI then
		a = a - TWO_PI
	else
		a = PI - a
	end

	s = a * a

	return a * (((((-2.39e-08 * s + 2.7526e-06) * s - 0.000198409) * s + 0.0083333315) * s - 0.1666666664) * s + 1)
end

function math.atan16(a)
	local s

	if abs(a) > 1 then
		a = 1 / a
		s = a * a
		s = -((((((((0.0028662257 * s - 0.0161657367) * s + 0.0429096138) * s - 0.07528964) * s + 0.1065626393) * s - 0.1420889944) * s + 0.1999355085) * s - 0.3333314528) * s + 1) * a

		if FLOATSIGNBITSET(a) then
			return s - HALF_PI
		else
			return s + HALF_PI
		end
	else
		s = a * a

		return ((((((((0.0028662257 * s - 0.0161657367) * s + 0.0429096138) * s - 0.07528964) * s + 0.1065626393) * s - 0.1420889944) * s + 0.1999355085) * s - 0.3333314528) * s + 1) * a
	end
end
