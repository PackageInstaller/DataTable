-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/component/pathfinder/lua/LuaAStarPathfinder.lua

module("logicscene.scene.component.pathfinder.lua.LuaAStarPathfinder", package.seeall)

local LuaAStarPathfinder = class("LuaAStarPathfinder", LuaPathfinderBase)

function LuaAStarPathfinder:ctor()
	LuaAStarPathfinder.super.ctor(self)
end

function LuaAStarPathfinder:search(startNode, endNode, isClosest, isComplicated)
	assert(startNode)
	assert(endNode)

	local nodeInfoMap = self:_createNodeInfo()
	local openHeap = LuaBinaryHeap.New(function(a, b)
		return nodeInfoMap[a]._f < nodeInfoMap[b]._f
	end)
	local closestNode = startNode
	local startNodeInfo = nodeInfoMap[startNode]

	startNodeInfo._h = self:calHeuristic(startNode, endNode)
	startNodeInfo._f = startNodeInfo._h
	startNodeInfo._visited = true

	openHeap:push(startNode)

	local currentNode, neighbours, neighbour, score, isVisited, neighbourInfo, closestNodeInfo

	while openHeap:size() > 0 do
		currentNode = openHeap:pop()

		if self:isSameGrid(currentNode, endNode) then
			return (self:_pathTo(currentNode, nodeInfoMap, isComplicated))
		end

		nodeInfoMap[currentNode]._closed = true
		neighbours = self:findNeighbours(currentNode)

		for i = 1, #neighbours do
			if self:isReachable(currentNode, neighbours[i]) then
				if not nodeInfoMap[neighbours[i]]._closed then
					score = nodeInfoMap[currentNode]._g + self:_calCost(currentNode, neighbours[i])

					if not nodeInfoMap[neighbours[i]]._visited or score < nodeInfoMap[neighbours[i]]._g then
						nodeInfoMap[neighbours[i]]._visited = true
						nodeInfoMap[neighbours[i]]._parent = currentNode

						if nodeInfoMap[neighbours[i]]._h == 0 then
							nodeInfoMap[neighbours[i]]._h = self:calHeuristic(neighbours[i], endNode)
						end

						nodeInfoMap[neighbours[i]]._g = score
						nodeInfoMap[neighbours[i]]._f = nodeInfoMap[neighbours[i]]._g + nodeInfoMap[neighbours[i]]._h

						if isClosest then
							if nodeInfoMap[neighbours[i]]._h < nodeInfoMap[closestNode]._h or nodeInfoMap[neighbours[i]]._h == nodeInfoMap[closestNode]._h and nodeInfoMap[neighbours[i]]._g < nodeInfoMap[closestNode]._g then
								closestNode = neighbours[i]
							end
						end

						if not nodeInfoMap[neighbours[i]]._visited then
							openHeap:push(neighbours[i])
						else
							openHeap:rescoreElement(neighbours[i])
						end
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

return LuaAStarPathfinder
