-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/component/pathfinder/lua/LuaPathfinderBase.lua

module("logicscene.scene.component.pathfinder.lua.LuaPathfinderBase", package.seeall)

local LuaPathfinderBase = class("LuaPathfinderBase")
local insert = table.insert
local abs = math.abs
local min = math.min
local sqrt = math.sqrt
local clamp = Mathf.Clamp

function LuaPathfinderBase:ctor()
	return
end

function LuaPathfinderBase:isConfigReady()
	return self._nodesMap ~= nil
end

function LuaPathfinderBase:reload(src, width, height, costFlag, heuristicFlag)
	self._nodesMap = src
	self._width = width
	self._height = height
	self._nodesList = {}

	for i = 0, self._width - 1 do
		local srcT = src[i]

		for j = 0, self._height - 1 do
			local node = srcT[j]

			if node then
				insert(self._nodesList, node)
			end
		end
	end

	self._costFlag = costFlag or LuaPathfinder_Const.CostFlag_Dir_8
	self._heuristicFlag = heuristicFlag or LuaPathfinder_Const.HeuristicFlag_Manhattan
end

function LuaPathfinderBase:printData()
	local title = "\t"

	for i = 0, #self._nodesMap[0] - 1 do
		title = string.format("%s\t%s", title, i)
	end

	print(title)

	for i = 0, self._width - 1 do
		local str = "\t" .. i

		for j = 0, self._height - 1 do
			local node = self._nodesMap[i][j]

			str = string.format("%s\t%s", str, node.dynamicBlockType or node.blockType)
		end

		printInfo(str)
	end
end

function LuaPathfinderBase:search(startNode, endNode, isClosest, isComplicated)
	return
end

function LuaPathfinderBase:setBlockState(x, y, value)
	local node = self:getNode(x, y)

	if node then
		node.dynamicBlockType = value
	end
end

function LuaPathfinderBase:getNode(x, y)
	if self._nodesMap[x] then
		return self._nodesMap[x][y]
	end
end

function LuaPathfinderBase:calHeuristic(a, b, flag)
	flag = flag or self._heuristicFlag

	local d1 = abs(a.x - b.x)
	local d2 = abs(a.y - b.y)

	if flag == LuaPathfinder_Const.HeuristicFlag_Manhattan then
		return abs(d1) + abs(d2)
	elseif flag == LuaPathfinder_Const.HeuristicFlag_Diagonal then
		return d1 + d2 + (LuaPathfinder_Const.Sqrt2 - 2) * min(d1, d2)
	elseif flag == LuaPathfinder_Const.HeuristicFlag_Euclidean then
		return sqrt(d1 * d1 + d2 * d2)
	else
		printError("未实现类型")
	end
end

function LuaPathfinderBase:isValid(currentNode)
	return currentNode ~= nil
end

function LuaPathfinderBase:isWalkable(currentNode)
	return currentNode.blockType == LuaPathfinder_Const.BlockType_None and currentNode.dynamicBlockType ~= true
end

function LuaPathfinderBase:isPassable(a, b)
	local d1 = a.x - b.x
	local d2 = a.y - b.y

	if d1 == 0 and d2 == 0 then
		return true
	end

	if abs(d1) <= 1 and abs(d2) <= 1 then
		local index = LuaPathfinder_Const.Directions2Index[d1][d2]
		local costMap = LuaPathfinder_Const.Cost[self._costFlag]

		if costMap then
			if self._costFlag == LuaPathfinder_Const.CostFlag_Dir_8to6 then
				local offset = a.x % 2

				costMap = costMap[offset]
			end

			return costMap[index] > 0
		else
			printError("未实现类型")

			return false
		end
	else
		return true
	end
end

function LuaPathfinderBase:isReachable(fromNode, toNode)
	return self:isValid(toNode) and self:isValid(fromNode) and self:isWalkable(fromNode) and self:isWalkable(toNode) and self:isPassable(fromNode, toNode) and not self:isSameGrid(fromNode, toNode)
end

function LuaPathfinderBase:isReachableIgnorePassable(fromNode, toNode)
	return self:isValid(toNode) and self:isValid(fromNode) and self:isWalkable(fromNode) and self:isWalkable(toNode) and not self:isSameGrid(fromNode, toNode)
end

function LuaPathfinderBase:isReachableIgnoreWalkable(fromNode, toNode)
	return self:isValid(toNode) and self:isValid(fromNode) and self:isPassable(fromNode, toNode) and not self:isSameGrid(fromNode, toNode)
end

function LuaPathfinderBase:isSameGrid(a, b)
	return a and b and a.x == b.x and a.y == b.y
end

function LuaPathfinderBase:normalDirection(fromNode, toNode)
	local dx, dy = fromNode.x - toNode.x, fromNode.y - toNode.y

	return clamp(dx, -1, 1), clamp(dy, -1, 1)
end

function LuaPathfinderBase:isNeighbour(a, b)
	local dx, dy = a.x - b.x, a.y - b.y

	return (dx ~= 0 or dy ~= 0) and abs(dx) <= 1 and abs(dy) <= 1
end

function LuaPathfinderBase:_resetAllNode()
	return
end

function LuaPathfinderBase:_resetNode(node)
	return
end

function LuaPathfinderBase:_createNodeInfo()
	local nodeInfo = {}

	for i = 1, #self._nodesList do
		nodeInfo[self._nodesList[i]] = {
			_visited = false,
			_h = 0,
			_f = 0,
			_g = 0,
			_closed = false
		}
	end

	return nodeInfo
end

function LuaPathfinderBase:findNeighbours(currentNode)
	local result = {}
	local x, y, direction, node
	local directions = LuaPathfinder_Const.Directions

	for i = 1, #directions do
		node = self:getNode(currentNode.x + directions[i][1], currentNode.y + directions[i][2])

		if self:isReachableIgnorePassable(currentNode, node) then
			insert(result, node)
		end
	end

	return result
end

function LuaPathfinderBase:_pathTo(currentNode, nodeInfoMap, isComplicated)
	local result = {}
	local info

	while nodeInfoMap[currentNode]._parent do
		insert(result, 1, currentNode.y)
		insert(result, 1, currentNode.x)

		currentNode = nodeInfoMap[currentNode]._internalParent or nodeInfoMap[currentNode]._parent
	end

	return result
end

function LuaPathfinderBase:_calCost(fromNode, toNode)
	assert(fromNode)
	assert(toNode)

	local costMap = LuaPathfinder_Const.Cost[self._costFlag]

	if costMap then
		local dx = fromNode.x - toNode.x
		local dy = fromNode.y - toNode.y
		local index = 2 + dx + (1 - dy) * 3

		if self._costFlag == LuaPathfinder_Const.CostFlag_Dir_8to6 then
			local offset = fromNode.x % 2

			costMap = costMap[offset]
		end

		if costMap[index] then
			return costMap[index] + (toNode.weight or 0)
		else
			return 1
		end
	else
		printError("未实现类型")

		return 0
	end
end

return LuaPathfinderBase
