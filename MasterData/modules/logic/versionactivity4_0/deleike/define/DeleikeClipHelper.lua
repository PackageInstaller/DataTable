-- chunkname: @modules/logic/versionactivity4_0/deleike/define/DeleikeClipHelper.lua

module("modules.logic.versionactivity4_0.deleike.define.DeleikeClipHelper", package.seeall)

local DeleikeClipHelper = class("DeleikeClipHelper")

function DeleikeClipHelper.ClipPolygons(subject, clip)
	local result = {}

	if not subject or #subject < 3 or not clip or #clip < 3 then
		return result
	end

	local output = {}

	for i = 1, #subject do
		output[i] = subject[i]
	end

	for i = 1, #clip do
		if #output < 3 then
			break
		end

		local eS = clip[i]
		local eE = clip[i % #clip + 1]
		local input = {}

		for j = 1, #output do
			input[j] = output[j]
		end

		output = {}

		for j = 1, #input do
			local cur = input[j]
			local prevIdx = (j - 2 + #input) % #input + 1
			local prev = input[prevIdx]
			local cIn = DeleikeClipHelper._IsOutside(cur, eS, eE)
			local pIn = DeleikeClipHelper._IsOutside(prev, eS, eE)

			if cIn then
				if not pIn then
					table.insert(output, DeleikeClipHelper._Intersect(prev, cur, eS, eE))
				end

				table.insert(output, cur)
			elseif pIn then
				table.insert(output, DeleikeClipHelper._Intersect(prev, cur, eS, eE))
			end
		end
	end

	if #output >= 3 then
		local clean = {}

		for i = 1, #output do
			local a = output[i]
			local b = output[i % #output + 1]
			local dx = a.x - b.x
			local dy = a.y - b.y

			if dx * dx + dy * dy > 0.0001 then
				table.insert(clean, a)
			end
		end

		if #clean >= 3 then
			table.insert(result, clean)
		end
	end

	return result
end

function DeleikeClipHelper._IsOutside(p, eS, eE)
	return (eE.x - eS.x) * (p.y - eS.y) - (eE.y - eS.y) * (p.x - eS.x) <= 0
end

function DeleikeClipHelper._Intersect(p1, p2, e1, e2)
	local a1 = p2.y - p1.y
	local b1 = p1.x - p2.x
	local c1 = a1 * p1.x + b1 * p1.y
	local a2 = e2.y - e1.y
	local b2 = e1.x - e2.x
	local c2 = a2 * e1.x + b2 * e1.y
	local det = a1 * b2 - a2 * b1

	if math.abs(det) < 0.0001 then
		return {
			x = (p1.x + p2.x) * 0.5,
			y = (p1.y + p2.y) * 0.5
		}
	end

	return {
		x = (c1 * b2 - c2 * b1) / det,
		y = (a1 * c2 - a2 * c1) / det
	}
end

function DeleikeClipHelper.Area(poly)
	if not poly or #poly < 3 then
		return 0
	end

	local s = 0
	local n = #poly

	for i = 1, n do
		local j = i % n + 1

		s = s + poly[i].x * poly[j].y - poly[j].x * poly[i].y
	end

	return math.abs(s) * 0.5
end

function DeleikeClipHelper.Perimeter(poly)
	if not poly or #poly < 2 then
		return 0
	end

	local s = 0
	local n = #poly

	for i = 1, n do
		local j = i % n + 1
		local dx = poly[i].x - poly[j].x
		local dy = poly[i].y - poly[j].y

		s = s + math.sqrt(dx * dx + dy * dy)
	end

	return s
end

local FRAGMENT_AREA_RATIO = 0.05
local FRAGMENT_SLENDERNESS = 0.025

function DeleikeClipHelper.FilterFragments(polys)
	if not polys or #polys == 0 then
		return {}
	end

	local originalArea = DeleikeEnum.GridUnit * DeleikeEnum.GridUnit
	local remaining = {}

	for _, p in ipairs(polys) do
		if p and #p >= 3 then
			local area = DeleikeClipHelper.Area(p)

			if area >= originalArea * FRAGMENT_AREA_RATIO then
				local peri = DeleikeClipHelper.Perimeter(p)

				if peri > 0 then
					if not (area / (peri * peri)) then
						local slenderness = 0

						if slenderness >= FRAGMENT_SLENDERNESS then
							table.insert(remaining, p)
						end
					end
				end
			end
		end
	end

	return remaining
end

function DeleikeClipHelper.ClipTile(comp, leftClipQuad, rightClipQuad, useFilter)
	if not comp or not comp.go or gohelper.isNil(comp.go) or not comp.mo then
		return
	end

	if not leftClipQuad or #leftClipQuad < 4 or not rightClipQuad or #rightClipQuad < 4 then
		return
	end

	if useFilter == nil then
		useFilter = true
	end

	local mo = comp.mo
	local worldPos = mo.pos
	local worldPoly = comp:getWorldPolygon()
	local cosR, sinR = mo.cosR, mo.sinR
	local allLocalPolys = {}
	local clipQuads = {
		leftClipQuad,
		rightClipQuad
	}

	for _, clipQuad in ipairs(clipQuads) do
		local clipResult = DeleikeClipHelper.ClipPolygons(worldPoly, clipQuad)

		for _, wp in ipairs(clipResult) do
			local lp = {}

			for i = 1, #wp do
				local ox = wp[i].x - worldPos.x
				local oy = wp[i].y - worldPos.y

				lp[i] = {
					x = ox * cosR + oy * sinR,
					y = -ox * sinR + oy * cosR
				}
			end

			table.insert(allLocalPolys, lp)
		end
	end

	local tileName = comp.go.name

	if #allLocalPolys == 0 then
		local skillMidQuad = {
			leftClipQuad[3],
			rightClipQuad[2],
			rightClipQuad[1],
			leftClipQuad[4]
		}
		local innerCheck = DeleikeClipHelper.ClipPolygons(worldPoly, skillMidQuad)

		if #innerCheck > 0 then
			gohelper.destroy(comp.go)
			DeleikeGameMgr.instance.unitCoord:unregisterUnit(comp)
		end

		return
	end

	if useFilter then
		local t = mo.tileType

		if t == DeleikeEnum.TileType.Normal or t == DeleikeEnum.TileType.Anchor then
			allLocalPolys = DeleikeClipHelper.FilterFragments(allLocalPolys)
		end
	end

	gohelper.destroy(comp.go)
	DeleikeGameMgr.instance.unitCoord:unregisterUnit(comp)

	if #allLocalPolys == 0 then
		return
	end

	for i, lp in ipairs(allLocalPolys) do
		local fragName = #allLocalPolys > 1 and string.format("%s_clip_%d", tileName, i) or tileName .. "_clip"

		DeleikeGameMgr.instance:addPolygonTile(mo.tileType, mo.x, mo.y, worldPos, mo.rotation, lp, fragName, mo.rect)
	end
end

return DeleikeClipHelper
