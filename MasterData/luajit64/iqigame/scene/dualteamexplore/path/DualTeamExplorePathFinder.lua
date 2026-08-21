-- chunkname: @IQIGame\\Scene\\DualTeamExplore\\Path\\DualTeamExplorePathFinder.lua

local DualTeamExploreRefPool = require("IQIGame.Scene.DualTeamExplore.Path.DualTeamExploreRefPool")
local MinHeap = require("IQIGame.Util.MinHeap")
local m = {}

function m.New()
	local obj = Clone(m)

	obj:Init()

	return obj
end

function m:Init()
	self.__ArrayPool = DualTeamExploreRefPool.New(100, function()
		return {}
	end)
	self.__MinHeap = MinHeap.new()
end

function m:InitMap(nodeDataMap)
	self.__NodeDataMap = nodeDataMap
end

function m:FindPath(startNodeId, endNodeId)
	if startNodeId == endNodeId then
		logError("寻路错误，开始节点id == 目标节点id，请在外层规避。")

		return nil
	end

	local startNodeData, endNodeData
	local nodeCount = 0

	for i, nodeData in pairs(self.__NodeDataMap) do
		if nodeData.id == startNodeId then
			startNodeData = nodeData
		end

		if nodeData.id == endNodeId then
			endNodeData = nodeData
		end

		nodeCount = nodeCount + 1
	end

	for i = 1, nodeCount do
		local path = self:__FindPath(startNodeData, endNodeData, i)

		if path ~= nil then
			return path
		end
	end

	return nil
end

function m:__FindPath(startNodeData, endNodeData, maxStep, step, path)
	local isInit = false

	if step == nil then
		isInit = true
		step = 1
	end

	if path == nil then
		isInit = true
		path = {}
	end

	for i = 1, #path do
		if path[i].id == startNodeData.id then
			self:ReleaseArray(path, isInit)

			return nil
		end
	end

	table.insert(path, startNodeData)

	local nextNodes = startNodeData.nextNodes

	if nextNodes == nil or #nextNodes == 0 then
		self:ReleaseArray(path, isInit)

		return nil
	end

	for i = 1, #nextNodes do
		local nodeData = nextNodes[i]

		if nodeData.id == endNodeData.id then
			table.insert(path, nodeData)

			return path
		end

		if step < maxStep then
			local branchPath = self:CloneArray(path)
			local path2 = self:__FindPath(nodeData, endNodeData, maxStep, step + 1, branchPath)

			if path2 ~= nil then
				self:ReleaseArray(path, isInit)

				return path2
			end
		end
	end

	self:ReleaseArray(path, isInit)

	return nil
end

function m:CloneArray(array)
	local newArray = self.__ArrayPool:Obtain()

	for i = 1, #array do
		newArray[i] = array[i]
	end

	return newArray
end

function m:ReleaseArray(array, isInit)
	if isInit then
		return
	end

	for i = 1, #array do
		array[i] = nil
	end

	self.__ArrayPool:Release(array)
end

function m:FastFindPath(startNodeId, endNodeId)
	local distances = {}
	local previous = {}
	local visited = {}
	local pq = self.__MinHeap

	for id, _ in pairs(self.__NodeDataMap) do
		distances[id] = math.huge
		previous[id] = nil
		visited[id] = false
	end

	distances[startNodeId] = 0

	pq:insert(startNodeId, 0)

	while pq.size > 0 do
		local nodeId = pq:extract_min().key

		visited[nodeId] = true

		if nodeId == endNodeId then
			break
		end

		for _, neighbor in ipairs(self.__NodeDataMap[nodeId].nextNodes) do
			if not visited[neighbor.id] then
				local alt = distances[nodeId] + 1

				if alt < distances[neighbor.id] then
					distances[neighbor.id] = alt
					previous[neighbor.id] = nodeId

					pq:insert(neighbor.id, alt)
				end
			end
		end
	end

	local path = {}
	local current = endNodeId

	while current do
		table.insert(path, 1, self.__NodeDataMap[current])

		current = previous[current]
	end

	pq:clear()

	return path
end

function m:Dispose()
	self.__NodeDataMap = nil

	self.__ArrayPool:Dispose()
	self.__MinHeap:clear()
end

return m
