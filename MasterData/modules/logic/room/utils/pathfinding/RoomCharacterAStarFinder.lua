-- chunkname: @modules/logic/room/utils/pathfinding/RoomCharacterAStarFinder.lua

module("modules.logic.room.utils.pathfinding.RoomCharacterAStarFinder", package.seeall)

local RoomCharacterAStarFinder = class("RoomCharacterAStarFinder", BaseAStarFinder)

function RoomCharacterAStarFinder:ctor(canMoveDict, canMoveMaskDict)
	RoomCharacterAStarFinder.super.ctor(self)

	self.canMoveDict = canMoveDict
	self.canMoveMaskDict = canMoveMaskDict
end

function RoomCharacterAStarFinder:getConnectPointsAndCost(point)
	local connectPoints = point:getConnects()
	local connectCosts = {}

	for i = 1, #connectPoints do
		table.insert(connectCosts, 1)
	end

	return connectPoints, connectCosts
end

function RoomCharacterAStarFinder:heuristic(point, targetPoint)
	return RoomAStarHelper.heuristic(point, targetPoint)
end

function RoomCharacterAStarFinder:isWalkable(point)
	local var_4_0 = self.canMoveDict[point.x]

	if self.canMoveDict[point.x] then
		var_4_0 = self.canMoveDict[point.x][point.y]

		if self.canMoveDict[point.x][point.y] then
			local canMove = self.canMoveDict[point.x][point.y][point.direction]

			canMove = canMove and self.canMoveMaskDict[canMove]

			return canMove
		end
	end
end

return RoomCharacterAStarFinder
