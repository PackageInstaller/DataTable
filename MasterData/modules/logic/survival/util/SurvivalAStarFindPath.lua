-- chunkname: @modules/logic/survival/util/SurvivalAStarFindPath.lua

module("modules.logic.survival.util.SurvivalAStarFindPath", package.seeall)

local SurvivalAStarFindPath = class("SurvivalAStarFindPath")

function SurvivalAStarFindPath:retracePath(startNode, endNode)
	local path = {}
	local currentNode = endNode

	while currentNode ~= startNode do
		table.insert(path, 1, currentNode)

		currentNode = currentNode.parent
	end

	return path
end

function SurvivalAStarFindPath:findPath(startNode, targetNode, walkableNodes, isMoveNear)
	if startNode == targetNode or not SurvivalHelper.instance:getValueFromDict(walkableNodes, startNode) then
		return nil
	end

	local openSet = {}
	local closedSet = {}
	local closestNode = startNode
	local closestDistance = SurvivalHelper.instance:getDistance(startNode, targetNode)

	if SurvivalHelper.instance:getValueFromDict(walkableNodes, targetNode) then
		closestNode = targetNode
		closestDistance = 0
	end

	SurvivalHelper.instance:addNodeToDict(openSet, startNode)

	while true do
		local currentNode

		for _, dict in pairs(openSet) do
			for _, node in pairs(dict) do
				if not currentNode then
					currentNode = node
				elseif node:fCost() < currentNode:fCost() or node:fCost() == currentNode:fCost() and node.hCost < currentNode.hCost then
					currentNode = node
				end
			end
		end

		if not currentNode then
			if closestNode == startNode or not isMoveNear then
				return nil
			else
				return self:retracePath(startNode, closestNode)
			end
		end

		SurvivalHelper.instance:removeNodeToDict(openSet, currentNode)
		SurvivalHelper.instance:addNodeToDict(closedSet, currentNode)

		local currentDistance = SurvivalHelper.instance:getDistance(currentNode, targetNode)

		if currentDistance < closestDistance then
			closestNode = currentNode
			closestDistance = currentDistance
		end

		if currentNode == targetNode then
			return self:retracePath(startNode, currentNode)
		end

		for _, direction in pairs(SurvivalEnum.DirToPos) do
			local neighborCoords = currentNode + direction
			local isWalkable = SurvivalHelper.instance:getValueFromDict(walkableNodes, neighborCoords)

			if isWalkable then
				local newMovementCostToNeighbor = currentNode.gCost + 1
				local openNode = SurvivalHelper.instance:getValueFromDict(openSet, neighborCoords)
				local isNotInOpenSet = not openNode
				local isNotInCloseSet = not SurvivalHelper.instance:getValueFromDict(closedSet, neighborCoords)

				if openNode and newMovementCostToNeighbor < openNode.gCost or isNotInOpenSet and isNotInCloseSet then
					neighborCoords.gCost = newMovementCostToNeighbor
					neighborCoords.hCost = SurvivalHelper.instance:getDistance(neighborCoords, targetNode)
					neighborCoords.parent = currentNode

					if isNotInOpenSet or newMovementCostToNeighbor < openNode.gCost then
						SurvivalHelper.instance:addNodeToDict(openSet, neighborCoords)
					end
				end
			end
		end
	end
end

function SurvivalAStarFindPath:findNearestPath(startNode, targetNodes, walkableNodes, isMoveNear)
	if not startNode or not targetNodes or #targetNodes == 0 then
		return nil
	end

	local nearestPath
	local minDistance = math.huge

	for _, targetNode in ipairs(targetNodes) do
		local path = self:findPath(startNode, targetNode, walkableNodes, isMoveNear)

		if path then
			local distance = SurvivalHelper.instance:getDistance(startNode, targetNode)

			if distance < minDistance then
				minDistance = distance
				nearestPath = path
			end
		else
			return nil
		end
	end

	return nearestPath
end

SurvivalAStarFindPath.instance = SurvivalAStarFindPath.New()

return SurvivalAStarFindPath
