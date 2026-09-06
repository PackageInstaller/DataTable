-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/drawandguess/view/LineCompression.lua

module("logic.extensions.drawandguess.view.LineCompression", package.seeall)

local LineCompression = {}

function LineCompression.isCollinearEnough(p1, p2, p3, angleThresholdDeg)
	angleThresholdDeg = angleThresholdDeg or 5

	local ax = p2.x - p1.x
	local ay = p2.y - p1.y
	local bx = p3.x - p2.x
	local by = p3.y - p2.y
	local aSq = ax * ax + ay * ay
	local bSq = bx * bx + by * by

	if aSq == 0 or bSq == 0 then
		return true
	end

	local dot = ax * bx + ay * by

	if dot < 0 then
		return false
	end

	local cosThresh = math.cos(math.rad(angleThresholdDeg))
	local cosThreshSq = cosThresh * cosThresh
	local dotSq = dot * dot
	local rhs = cosThreshSq * aSq * bSq

	return rhs <= dotSq
end

function LineCompression.compressPoints(points, angleThreshold, minPoints)
	if not points or #points < 3 then
		return points
	end

	angleThreshold = angleThreshold or 5
	minPoints = minPoints or 2

	local compressed = {}

	table.insert(compressed, {
		x = points[1].x,
		y = points[1].y
	})

	local lastKeyPointIndex = 1

	for i = 2, #points - 1 do
		local p1 = points[lastKeyPointIndex]
		local p2 = points[i]
		local p3 = points[i + 1]
		local enough = LineCompression.isCollinearEnough(p1, p2, p3)

		if not enough then
			table.insert(compressed, {
				x = points[i].x,
				y = points[i].y
			})

			lastKeyPointIndex = i
		end
	end

	local lastCompressed = compressed[#compressed]
	local lastOriginal = points[#points]

	if #compressed == 1 or lastCompressed.x ~= lastOriginal.x or lastCompressed.y ~= lastOriginal.y then
		table.insert(compressed, {
			x = lastOriginal.x,
			y = lastOriginal.y
		})
	end

	if minPoints > #compressed then
		compressed = minPoints <= #points and {
			{
				x = points[1].x,
				y = points[1].y
			},
			{
				x = points[#points].x,
				y = points[#points].y
			}
		} or points
	end

	return compressed
end

return LineCompression
