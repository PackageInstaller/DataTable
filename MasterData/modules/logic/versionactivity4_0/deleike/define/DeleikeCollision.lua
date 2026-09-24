-- chunkname: @modules/logic/versionactivity4_0/deleike/define/DeleikeCollision.lua

module("modules.logic.versionactivity4_0.deleike.define.DeleikeCollision", package.seeall)

local DeleikeCollision = class("DeleikeCollision")

function DeleikeCollision.pointInConvexPoly(px, py, poly, slack)
	if not poly or #poly < 3 then
		return false
	end

	local n = #poly
	local sign = false
	local eps = slack or 0

	for i = 1, n do
		local a = poly[i]
		local b = poly[i % n + 1]
		local ex, ey = b.x - a.x, b.y - a.y
		local cross = ex * (py - a.y) - ey * (px - a.x)
		local inside = cross >= 0

		if eps > 0 then
			inside = inside or cross >= -eps * math.sqrt(ex * ex + ey * ey)
		end

		if i == 1 then
			sign = inside
		elseif inside ~= sign then
			return false
		end
	end

	return true
end

local function closestPointOnSegment(px, py, ax, ay, bx, by)
	local abx, aby = bx - ax, by - ay
	local lenSq = abx * abx + aby * aby

	if lenSq < 1e-06 then
		return ax, ay
	end

	local t = ((px - ax) * abx + (py - ay) * aby) / lenSq

	if t < 0 then
		t = 0
	elseif t > 1 then
		t = 1
	end

	return ax + abx * t, ay + aby * t
end

function DeleikeCollision.circlePushOutOfPoly(cx, cy, radius, poly)
	if not poly or #poly < 3 then
		return cx, cy
	end

	local n = #poly
	local bestQx, bestQy = 0, 0
	local bestDistSq = math.huge

	for i = 1, n do
		local a = poly[i]
		local b = poly[i % n + 1]
		local qx, qy = closestPointOnSegment(cx, cy, a.x, a.y, b.x, b.y)
		local dx, dy = cx - qx, cy - qy
		local distSq = dx * dx + dy * dy

		if distSq < bestDistSq then
			bestDistSq = distSq
			bestQy = qy
			bestQx = qx
		end
	end

	local dist = math.sqrt(bestDistSq)
	local inside = DeleikeCollision.pointInConvexPoly(cx, cy, poly)

	if inside then
		local dx, dy = bestQx - cx, bestQy - cy
		local len = math.sqrt(dx * dx + dy * dy)

		if len < 1e-06 then
			return cx, cy
		end

		return cx + dx / len * (dist + radius), cy + dy / len * (dist + radius)
	end

	if dist < radius and dist > 1e-06 then
		local dx, dy = cx - bestQx, cy - bestQy

		return bestQx + dx / dist * radius, bestQy + dy / dist * radius
	end

	return cx, cy
end

function DeleikeCollision.getPolyAABB(poly)
	local minX, minY = poly[1].x, poly[1].y
	local maxX, maxY = minX, minY

	for i = 2, #poly do
		local p = poly[i]

		if minX > p.x then
			minX = p.x
		end

		if minY > p.y then
			minY = p.y
		end

		if maxX < p.x then
			maxX = p.x
		end

		if maxY < p.y then
			maxY = p.y
		end
	end

	return minX, minY, maxX, maxY
end

function DeleikeCollision.aabbOverlap(minAx, minAy, maxAx, maxAy, minBx, minBy, maxBx, maxBy)
	return minAx <= maxBx and minBx <= maxAx and minAy <= maxBy and minBy <= maxAy
end

function DeleikeCollision.convexPolysOverlap(a, b)
	if not a or #a < 3 or not b or #b < 3 then
		return false
	end

	local aMinX, aMinY, aMaxX, aMaxY = DeleikeCollision.getPolyAABB(a)
	local bMinX, bMinY, bMaxX, bMaxY = DeleikeCollision.getPolyAABB(b)

	if not DeleikeCollision.aabbOverlap(aMinX, aMinY, aMaxX, aMaxY, bMinX, bMinY, bMaxX, bMaxY) then
		return false
	end

	local polys = {
		a,
		b
	}

	for _, poly in ipairs(polys) do
		local n = #poly

		for i = 1, n do
			local p1 = poly[i]
			local p2 = poly[i % n + 1]
			local axisX = -(p2.y - p1.y)
			local axisY = p2.x - p1.x
			local aMin, aMax = math.huge, -math.huge

			for k = 1, #a do
				local proj = a[k].x * axisX + a[k].y * axisY

				if proj < aMin then
					aMin = proj
				end

				if aMax < proj then
					aMax = proj
				end
			end

			local bMin, bMax = math.huge, -math.huge

			for k = 1, #b do
				local proj = b[k].x * axisX + b[k].y * axisY

				if proj < bMin then
					bMin = proj
				end

				if bMax < proj then
					bMax = proj
				end
			end

			if aMax < bMin or bMax < aMin then
				return false
			end
		end
	end

	return true
end

function DeleikeCollision.circleClampInsidePoly(cx, cy, radius, poly)
	if not poly or #poly < 3 then
		return cx, cy
	end

	local n = #poly
	local pushX, pushY = 0, 0

	for i = 1, n do
		local a = poly[i]
		local b = poly[i % n + 1]
		local ex, ey = b.x - a.x, b.y - a.y
		local nx, ny = -ey, ex
		local len = math.sqrt(nx * nx + ny * ny)

		if len > 1e-06 then
			ny = ny / len
			nx = nx / len

			local dist = nx * (cx - a.x) + ny * (cy - a.y)

			if dist < radius then
				pushX = pushX + nx * (radius - dist)
				pushY = pushY + ny * (radius - dist)
			end
		end
	end

	return cx + pushX, cy + pushY
end

return DeleikeCollision
