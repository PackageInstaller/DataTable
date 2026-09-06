-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/component/pathfinder/lua/LuaJPSPathfinder.lua

module("logicscene.scene.component.pathfinder.lua.LuaJPSPathfinder", package.seeall)

local LuaJPSPathfinder = class("LuaJPSPathfinder", LuaPathfinderBase)
local insert = table.insert

function LuaJPSPathfinder:ctor()
	LuaJPSPathfinder.super.ctor(self)
end

function LuaJPSPathfinder:search(startNode, endNode, isClosest, isComplicated)
	assert(startNode)
	assert(endNode)

	local nodeInfoMap = self:_createNodeInfo()
	local openHeap = LuaBinaryHeap.New(function(a, b)
		return nodeInfoMap[a]._f < nodeInfoMap[b]._f
	end)
	local closestNode = startNode

	nodeInfoMap[startNode]._h = self:calHeuristic(startNode, endNode, self._heuristicFlag)

	openHeap:push(startNode)

	local currentNode, successors, score, isVisited, successor, successorInfo, closestNodeInfo

	while openHeap:size() > 0 do
		currentNode = openHeap:pop()

		if self:isSameGrid(currentNode, endNode) then
			return self:_pathTo(currentNode, nodeInfoMap, isComplicated)
		end

		nodeInfoMap[currentNode]._closed = true
		successors = self:_identifySuccessors(currentNode, nodeInfoMap[currentNode]._parent, endNode, nodeInfoMap)

		for i = 1, #successors do
			if not nodeInfoMap[successors[i]]._closed then
				score = nodeInfoMap[successors[i]]._g + self:_calCost(currentNode, successors[i])

				if not nodeInfoMap[successors[i]]._visited or score < nodeInfoMap[successors[i]]._g then
					nodeInfoMap[successors[i]]._visited = true

					if nodeInfoMap[successors[i]]._h == 0 then
						nodeInfoMap[successors[i]]._h = self:calHeuristic(successors[i], endNode)
					end

					nodeInfoMap[successors[i]]._g = score
					nodeInfoMap[successors[i]]._f = nodeInfoMap[successors[i]]._g + nodeInfoMap[successors[i]]._h

					if isClosest then
						if nodeInfoMap[successors[i]]._h < nodeInfoMap[closestNode]._h or nodeInfoMap[successors[i]]._h == nodeInfoMap[closestNode]._h and nodeInfoMap[successors[i]]._g < nodeInfoMap[closestNode]._g then
							closestNode = successors[i]
						end
					end

					if not nodeInfoMap[successors[i]]._visited then
						openHeap:push(successors[i])
					else
						openHeap:rescoreElement(successors[i])
					end
				end
			end
		end
	end

	if isClosest then
		return self:_pathTo(closestNode, nodeInfoMap, isComplicated)
	else
		return {}
	end
end

function LuaJPSPathfinder:_isForce(currentNode, parent, travelDx, travelDy)
	local dx, dy = self:normalDirection(currentNode, parent)

	if travelDx ~= 0 and travelDy ~= 0 then
		if dx == travelDx and dy == -travelDy or dx == -travelDx and dy == travelDy then
			return true
		end
	elseif dx ~= 0 and dy ~= 0 then
		return true
	end

	return false
end

function LuaJPSPathfinder:_identifySuccessors(currentNode, parent, endNode, nodeInfoMap)
	local result = {}
	local neighbours = self:_findNeighboursWithParent(currentNode, parent)
	local jumpPoint, dx, dy

	for i = 1, #neighbours do
		dx, dy = self:normalDirection(neighbours[i], currentNode)

		local newNode = self:getNode(currentNode.x + dx, currentNode.y + dy)

		if self:isValid(newNode) and self:isWalkable(newNode) then
			jumpPoint = self:_jump(currentNode, dx, dy, endNode, nodeInfoMap)

			if self:isValid(jumpPoint) then
				insert(result, jumpPoint)
			end
		end
	end

	return result
end

function LuaJPSPathfinder:_smoothSetParent(currentNode, newNode, nodeInfoMap, dx, dy)
	nodeInfoMap[newNode]._parent = currentNode

	if not self:isReachable(currentNode, newNode) then
		if self._costFlag == LuaPathfinder_Const.CostFlag_Dir_8to6 then
			local dirs = {
				{
					dx,
					0
				},
				{
					0,
					dy
				}
			}

			for i = 1, #dirs do
				local tempNode = self:getNode(currentNode.x + dirs[i][1], currentNode.y + dirs[i][2])

				if self:isReachable(currentNode, tempNode) and self:isReachable(tempNode, newNode) then
					nodeInfoMap[newNode]._internalParent = tempNode
					nodeInfoMap[tempNode]._internalParent = currentNode

					return true
				end
			end
		end

		return false
	end

	return true
end

function LuaJPSPathfinder:_jump(currentNode, dx, dy, endNode, nodeInfoMap)
	local newNode = self:getNode(currentNode.x + dx, currentNode.y + dy)

	if not self:isValid(newNode) or not self:isWalkable(newNode) then
		return currentNode
	end

	if not self:_smoothSetParent(currentNode, newNode, nodeInfoMap, dx, dy) then
		return currentNode
	end

	if self:isSameGrid(newNode, endNode) then
		return newNode
	end

	local neighbours = self:_findNeighboursWithParent(newNode, currentNode)

	for i = 1, #neighbours do
		if self:_isForce(neighbours[i], newNode, dx, dy) then
			return newNode
		end
	end

	if dx ~= 0 and dy ~= 0 then
		local dirs = {
			{
				dx,
				0
			},
			{
				0,
				dy
			}
		}

		for i = 1, #dirs do
			local jumpPoint = self:_jump(newNode, dirs[i][1], dirs[i][2], endNode, nodeInfoMap)

			if self:isValid(jumpPoint) and self:isWalkable(newNode) then
				return newNode
			end
		end
	end

	return self:_jump(newNode, dx, dy, endNode, nodeInfoMap)
end

function LuaJPSPathfinder:_findNeighboursWithParent(currentNode, parent)
	if self:isValid(parent) then
		local result = {}
		local x, y = currentNode.x, currentNode.y
		local px, py = parent.x, parent.y
		local dx, dy = self:normalDirection(currentNode, parent)
		local node, preNode, tNode

		if dx ~= 0 and dy ~= 0 then
			local naturalNeighbours = {
				{
					dx,
					dy
				},
				{
					dx,
					0
				},
				{
					0,
					dy
				}
			}

			for i = 1, #naturalNeighbours do
				node = self:getNode(naturalNeighbours[i][1] + x, naturalNeighbours[i][2] + y)

				if self:isReachableIgnorePassable(currentNode, node) then
					insert(result, node)
				end
			end

			local forceNeighbours = {
				{
					dx,
					0
				},
				{
					0,
					dy
				}
			}

			for i = 1, #forceNeighbours do
				preNode = self:getNode(forceNeighbours[i][1] + px, forceNeighbours[i][2] + py)
				node = self:getNode(2 * forceNeighbours[i][1] + px, 2 * forceNeighbours[i][2] + py)

				if not self:isReachableIgnorePassable(currentNode, preNode) and self:isReachableIgnorePassable(currentNode, node) then
					insert(result, node)
				end
			end
		else
			node = self:getNode(dx + x, dy + y)

			if self:isReachableIgnorePassable(currentNode, node) then
				insert(result, node)
			end

			local dxInverted = dy
			local dyInverted = dx

			preNode = self:getNode(dxInverted + x, dyInverted + y)
			node = self:getNode(dxInverted + dx + x, dyInverted + dy + y)

			if not self:isReachableIgnorePassable(currentNode, preNode) and self:isReachableIgnorePassable(currentNode, node) then
				insert(result, node)
			end

			preNode = self:getNode(x - dxInverted, y - dyInverted)
			node = self:getNode(x - dxInverted + dx, y - dyInverted + dy)

			if not self:isReachableIgnorePassable(currentNode, preNode) and self:isReachableIgnorePassable(currentNode, node) then
				insert(result, node)
			end
		end

		return result
	else
		return self:findNeighbours(currentNode)
	end
end

return LuaJPSPathfinder
