-- chunkname: @modules/common/utils/MathUtil.lua

module("modules.common.utils.MathUtil", package.seeall)

local MathUtil = class("MathUtil")
local atan2 = math.atan2
local deg = math.deg

function MathUtil.vec2_lengthSqr(ax, ay, bx, by)
	if not ax or not ay or not bx or not by then
		logError("Error | vec2_length  Error |: Args: ", tostring(ax), tostring(ay), tostring(bx), tostring(by))

		return 99999
	end

	local dx = ax - bx
	local dy = ay - by

	return dx * dx + dy * dy
end

function MathUtil.vec2_length(ax, ay, bx, by)
	local lenSq = MathUtil.vec2_lengthSqr(ax, ay, bx, by)

	return math.sqrt(lenSq)
end

function MathUtil.vec2_normalize(ax, ay)
	local len = math.sqrt(ax * ax + ay * ay)

	if len < 1e-06 then
		len = 1
	end

	return ax / len, ay / len
end

function MathUtil.calculateV2Angle(ax, ay, bx, by)
	if not ax or not ay or not bx or not by then
		logError("Error | calculateV2Angle  Error |: Args: ", tostring(ax), tostring(ay), tostring(bx), tostring(by))

		return 0
	end

	local dx = ax - bx
	local dy = ay - by
	local radian = atan2(dy, dx)

	return (deg(radian))
end

function MathUtil.isPointInCircleRange(centerX, centerY, radius, pointX, pointY)
	if centerX == nil or centerY == nil or radius == nil or pointX == nil or pointY == nil then
		logError("Error | isPointInCircleRange  Error |: Args: ", tostring(centerX), tostring(centerY), tostring(radius), tostring(pointX), tostring(pointY))

		return false
	end

	local dx = pointX - centerX
	local dy = pointY - centerY
	local distanceSquared = dx * dx + dy * dy

	return distanceSquared <= radius * radius
end

function MathUtil.is_point_in_sector(px, py, ox, oy, radius, start_degree, sweep_degree)
	local dx = px - ox
	local dy = py - oy
	local distance_squared = dx * dx + dy * dy

	if distance_squared > radius * radius then
		return false
	end

	local start_rad = math.rad(start_degree)
	local sweep_rad = math.rad(sweep_degree)

	if math.abs(sweep_rad) >= 2 * math.pi then
		return true
	end

	start_rad = start_rad % (2 * math.pi)

	if start_rad < 0 then
		start_rad = start_rad + 2 * math.pi
	end

	local point_rad = math.atan2(dy, dx)

	if point_rad < 0 then
		point_rad = point_rad + 2 * math.pi
	end

	if sweep_rad >= 0 then
		local diff = (point_rad - start_rad) % (2 * math.pi)

		if diff < 0 then
			diff = diff + 2 * math.pi
		end

		return diff <= sweep_rad
	else
		local diff = (start_rad - point_rad) % (2 * math.pi)

		if diff < 0 then
			diff = diff + 2 * math.pi
		end

		return diff <= -sweep_rad
	end
end

function MathUtil.hasPassedPoint(movingX, movingY, targetX, targetY, moveDirX, moveDirY)
	local toTargetX = targetX - movingX
	local toTargetY = targetY - movingY
	local dotProduct = moveDirX * toTargetX + moveDirY * toTargetY

	return dotProduct <= 0
end

function MathUtil.calculateVisiblePoints(x1, y1, r1, x2, y2, r2)
	local dx = x2 - x1
	local dy = y2 - y1
	local length = math.sqrt(dx * dx + dy * dy)

	if length < 1e-10 then
		return x1, y1, x2, y2
	end

	local nx = dx / length
	local ny = dy / length
	local visible_start_x = x1 + nx * r1
	local visible_start_y = y1 + ny * r1
	local visible_end_x = x2 - nx * r2
	local visible_end_y = y2 - ny * r2

	return visible_start_x, visible_start_y, visible_end_x, visible_end_y
end

return MathUtil
