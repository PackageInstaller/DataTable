-- chunkname: @modules/logic/room/utils/pathfinding/BaseAStarFinder.lua

module("modules.logic.room.utils.pathfinding.BaseAStarFinder", package.seeall)

local BaseAStarFinder = class("BaseAStarFinder")

function BaseAStarFinder:ctor()
	return
end

function BaseAStarFinder:pathFinding(startPoint, targetPoint)
	if startPoint == targetPoint then
		return {}
	end

	if not self:isWalkable(startPoint) or not self:isWalkable(targetPoint) then
		return nil
	end

	local openNodeDict = {}
	local closeNodeDict = {}
	local startNode = {
		cost = 0,
		point = startPoint,
		heuristic = self:heuristic(startPoint, targetPoint)
	}

	openNodeDict[tostring(startNode.point)] = startNode

	return (self:_pathFinding(startPoint, targetPoint, openNodeDict, closeNodeDict))
end

function BaseAStarFinder:_pathFinding(startPoint, targetPoint, openNodeDict, closeNodeDict)
	while LuaUtil.tableNotEmpty(openNodeDict) do
		local node = self:_getNextNode(openNodeDict)
		local point = node.point
		local connectPoints, connectCosts = self:getConnectPointsAndCost(point)

		for i = 1, #connectPoints do
			local connectPoint = connectPoints[i]

			if not connectCosts[i] then
				local connectCost = 0

				if not closeNodeDict[tostring(connectPoint)] and self:isWalkable(connectPoint) then
					local cost = node.cost + connectCost
					local connectNode = openNodeDict[tostring(connectPoint)]

					if not connectNode or cost < connectNode.cost then
						connectNode = {
							point = connectPoint,
							cost = node.cost + connectCost,
							heuristic = self:heuristic(connectPoint, targetPoint),
							last = node
						}
						openNodeDict[tostring(connectNode.point)] = connectNode
					end

					if connectNode.point == targetPoint then
						return self:_makePath(connectNode)
					end
				end
			end
		end

		closeNodeDict[tostring(node.point)] = node
	end

	return nil
end

function BaseAStarFinder:_getNextNode(openNodeDict)
	local nextNode

	for _, node in pairs(openNodeDict) do
		if not nextNode or node.cost + node.heuristic < nextNode.cost + nextNode.heuristic then
			nextNode = node
		end
	end

	openNodeDict[tostring(nextNode.point)] = nil

	return nextNode
end

function BaseAStarFinder:_makePath(targetNode)
	local reversePathPointList = {}
	local node = targetNode

	while node.last ~= nil do
		table.insert(reversePathPointList, node.point)

		node = node.last
	end

	local pathPointList = {}

	for i = #reversePathPointList, 1, -1 do
		table.insert(pathPointList, reversePathPointList[i])
	end

	return pathPointList
end

function BaseAStarFinder:getConnectPointsAndCost(point)
	return
end

function BaseAStarFinder:heuristic(point, targetPoint)
	return
end

function BaseAStarFinder:isWalkable(point)
	return
end

return BaseAStarFinder
