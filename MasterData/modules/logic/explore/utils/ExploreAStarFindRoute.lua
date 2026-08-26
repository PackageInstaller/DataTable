-- chunkname: @modules/logic/explore/utils/ExploreAStarFindRoute.lua

module("modules.logic.explore.utils.ExploreAStarFindRoute", package.seeall)

local ExploreAStarFindRoute = class("ExploreAStarFindRoute")
local DIRECTIONS = {
	{
		-1,
		0
	},
	{
		0,
		-1
	},
	{
		0,
		1
	},
	{
		1,
		0
	}
}
local START_POS, END_POS, CURRENT_POS, NEAREST_POS, NEXT_POS, BARRIER_LIST, WALKABLE_LIST, OPEN_LIST, OPEN_MAP, CLOSEED_LIST, CLOSED_MAP, PATH_LIST

local function GET_KEY(p)
	return string.format("%d_%d", p.x, p.y)
end

local function getPoint(x, y)
	local point = {}

	point.x = x
	point.y = y
	point.last = nil
	point.g = 0
	point.h = 0
	point.f = 0
	point.key = GET_KEY(point)
	point.fromDir = nil

	return point
end

local function MANHTATAN_DIS(currPos, targetPos)
	return math.abs(targetPos.x - currPos.x) + math.abs(targetPos.y - currPos.y)
end

local function IS_SAME_P(p1, p2)
	return p1.x == p2.x and p1.y == p2.y
end

local function IS_WALKABLE(p, walkableList)
	return walkableList[p.key]
end

local function GET_VALUE_G(p)
	return p.g + 1
end

local function GET_VALUE_H(p1, p2)
	return MANHTATAN_DIS(p1, p2)
end

local function GET_VALUE_F(p)
	return p.g + p.h
end

local function CHECK_P_RANGE(p, xMax, yMax)
	assert(xMax >= p.x and yMax >= p.y, string.format("point error, (%d, %d) limit(%d, %d)", p.x, p.y, xMax, yMax))
end

local function COMPARE_FUNC(p1, p2)
	if p1.f == p2.f and p1.last == p2.last then
		if NEXT_POS then
			if ExploreHelper.isPosEqual(p1, NEXT_POS) then
				return true
			elseif ExploreHelper.isPosEqual(p2, NEXT_POS) then
				return false
			end
		end

		local p1DirValue = p1.last and p1.fromDir == p1.last.fromDir and -1 or 1
		local p2DirValue = p2.last and p2.fromDir == p2.last.fromDir and -1 or 1

		return p1DirValue < p2DirValue
	end

	return p1.f < p2.f
end

function ExploreAStarFindRoute:ctor()
	return
end

function ExploreAStarFindRoute:startFindPath(walkableList, startPos, endPos, nextPos)
	WALKABLE_LIST = walkableList
	START_POS = getPoint(startPos.x, startPos.y)
	END_POS = getPoint(endPos.x, endPos.y)
	NEXT_POS = nextPos
	NEAREST_POS = getPoint(startPos.x, startPos.y)
	OPEN_MAP = {}
	OPEN_LIST = {}
	CLOSEED_LIST = {}
	CLOSED_MAP = {}
	OPEN_MAP[START_POS.key] = START_POS

	table.insert(OPEN_LIST, START_POS)

	PATH_LIST = self:findPath() or {}

	return PATH_LIST, NEAREST_POS
end

function ExploreAStarFindRoute:getNextPoints(point)
	local nextPoints = {}

	for i = 1, #DIRECTIONS do
		local offset = DIRECTIONS[i]
		local nextPoint = getPoint(point.x + offset[1], point.y + offset[2])

		nextPoint.fromDir = offset
		nextPoint.last = point

		if IS_WALKABLE(nextPoint, WALKABLE_LIST) then
			nextPoint.g = GET_VALUE_G(point)
			nextPoint.h = GET_VALUE_H(point, END_POS)
			nextPoint.f = GET_VALUE_F(nextPoint)

			table.insert(nextPoints, nextPoint)
		end
	end

	return nextPoints
end

function ExploreAStarFindRoute:findPath()
	while #OPEN_LIST > 0 do
		CURRENT_POS = OPEN_LIST[1]

		if self:getDistance(CURRENT_POS, END_POS) < self:getDistance(NEAREST_POS, END_POS) then
			NEAREST_POS = getPoint(CURRENT_POS.x, CURRENT_POS.y)
		end

		table.remove(OPEN_LIST, 1)

		OPEN_MAP[CURRENT_POS.key] = nil

		if IS_SAME_P(CURRENT_POS, END_POS) then
			return self:makePath(CURRENT_POS)
		else
			CLOSED_MAP[CURRENT_POS.key] = CURRENT_POS

			local nextPoints = self:getNextPoints(CURRENT_POS)

			for i = 1, #nextPoints do
				local nextPoint = nextPoints[i]

				if OPEN_MAP[nextPoint.key] == nil and CLOSED_MAP[nextPoint.key] == nil and IS_WALKABLE(nextPoint, WALKABLE_LIST) then
					OPEN_MAP[nextPoint.key] = nextPoint

					table.insert(OPEN_LIST, nextPoint)
				end
			end

			table.sort(OPEN_LIST, COMPARE_FUNC)
		end
	end

	return nil
end

function ExploreAStarFindRoute:makePath(endPos)
	local path = {}
	local point = endPos

	while point.last ~= nil do
		table.insert(path, point)

		point = point.last
	end

	return path
end

function ExploreAStarFindRoute:getDistance(posA, posB)
	return math.abs(posA.x - posB.x) + math.abs(posA.y - posB.y)
end

return ExploreAStarFindRoute
