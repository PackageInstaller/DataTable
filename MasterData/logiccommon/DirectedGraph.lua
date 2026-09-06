-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/datastruct/DirectedGraph.lua

module("logiccommon.common.datastruct.DirectedGraph", package.seeall)

local DirectedGraph = class("DirectedGraph")

local function createVertex(data)
	return {
		data = data,
		outEdges = {},
		inEdges = {}
	}
end

function DirectedGraph:ctor()
	self._vertices = {}
	self._vertexCount = 0
	self._edgeCount = 0
end

function DirectedGraph:getVertexCount()
	return self._vertexCount
end

function DirectedGraph:getEdgeCount()
	return self._edgeCount
end

function DirectedGraph:isEmpty()
	return self._vertexCount == 0
end

function DirectedGraph:hasVertex(id)
	self:_checkId(id)

	return self._vertices[id] ~= nil
end

function DirectedGraph:getVertex(id)
	self:_checkId(id)

	local vertex = self._vertices[id]

	if vertex then
		return vertex.data
	else
		return nil
	end
end

function DirectedGraph:hasEdge(fromId, toId)
	if self._vertices[fromId] == nil then
		return false
	end

	return self._vertices[fromId].outEdges[toId] ~= nil
end

function DirectedGraph:addVertex(id, data)
	self:_checkId(id)

	if self._vertices[id] ~= nil then
		return false
	end

	self._vertices[id] = createVertex(data)
	self._vertexCount = self._vertexCount + 1

	return true
end

function DirectedGraph:removeVertex(id)
	self:_checkId(id)

	if self._vertices[id] == nil then
		return false
	end

	local vertex = self._vertices[id]

	for targetId, _ in pairs(vertex.outEdges) do
		if self._vertices[targetId] ~= nil then
			self._vertices[targetId].inEdges[id] = nil
			self._edgeCount = self._edgeCount - 1
		end
	end

	for sourceId, _ in pairs(vertex.inEdges) do
		if self._vertices[sourceId] ~= nil then
			self._vertices[sourceId].outEdges[id] = nil
			self._edgeCount = self._edgeCount - 1
		end
	end

	self._vertices[id] = nil
	self._vertexCount = self._vertexCount - 1

	return true
end

function DirectedGraph:addEdge(fromId, toId)
	if self._vertices[fromId] == nil or self._vertices[toId] == nil then
		return false
	end

	if self._vertices[fromId].outEdges[toId] ~= nil then
		return false
	end

	self._vertices[fromId].outEdges[toId] = true
	self._vertices[toId].inEdges[fromId] = true
	self._edgeCount = self._edgeCount + 1

	return true
end

function DirectedGraph:removeEdge(fromId, toId)
	if self._vertices[fromId] == nil or self._vertices[toId] == nil then
		return false
	end

	if self._vertices[fromId].outEdges[toId] == nil then
		return false
	end

	self._vertices[fromId].outEdges[toId] = nil
	self._vertices[toId].inEdges[fromId] = nil
	self._edgeCount = self._edgeCount - 1

	return true
end

function DirectedGraph:addDoubleEdge(id1, id2)
	if self._vertices[id1] == nil or self._vertices[id2] == nil then
		return false, false
	end

	local success1 = self:addEdge(id1, id2)
	local success2 = self:addEdge(id2, id1)

	return success1, success2
end

function DirectedGraph:removeDoubleEdge(id1, id2)
	if self._vertices[id1] == nil or self._vertices[id2] == nil then
		return false, false
	end

	local success1 = self:removeEdge(id1, id2)
	local success2 = self:removeEdge(id2, id1)

	return success1, success2
end

function DirectedGraph:removeAllEdges(id)
	self:_checkId(id)

	if self._vertices[id] == nil then
		return false
	end

	local vertex = self._vertices[id]

	for targetId, _ in pairs(vertex.outEdges) do
		if self._vertices[targetId] ~= nil then
			self._vertices[targetId].inEdges[id] = nil
			self._edgeCount = self._edgeCount - 1
		end
	end

	for sourceId, _ in pairs(vertex.inEdges) do
		if self._vertices[sourceId] ~= nil then
			self._vertices[sourceId].outEdges[id] = nil
			self._edgeCount = self._edgeCount - 1
		end
	end

	vertex.outEdges = {}
	vertex.inEdges = {}

	return true
end

function DirectedGraph:clear()
	self._vertices = {}
	self._vertexCount = 0
	self._edgeCount = 0
end

function DirectedGraph:getSuccessors(id)
	self:_checkId(id)

	local result = {}
	local vertex = self._vertices[id]

	if vertex == nil then
		return result
	end

	for targetId, _ in pairs(vertex.outEdges) do
		table.insert(result, targetId)
	end

	return result
end

function DirectedGraph:getPredecessors(id)
	self:_checkId(id)

	local result = {}
	local vertex = self._vertices[id]

	if vertex == nil then
		return result
	end

	for sourceId, _ in pairs(vertex.inEdges) do
		table.insert(result, sourceId)
	end

	return result
end

function DirectedGraph:getOutDegree(id)
	local vertex = self._vertices[id]

	if vertex == nil then
		return 0
	end

	local count = 0

	for _, _ in pairs(vertex.outEdges) do
		count = count + 1
	end

	return count
end

function DirectedGraph:getInDegree(id)
	local vertex = self._vertices[id]

	if vertex == nil then
		return 0
	end

	local count = 0

	for _, _ in pairs(vertex.inEdges) do
		count = count + 1
	end

	return count
end

function DirectedGraph:getVertices()
	local result = {}

	for id, _ in pairs(self._vertices) do
		table.insert(result, id)
	end

	return result
end

function DirectedGraph:traverse(startId, visitFunc)
	if not visitFunc then
		return
	end

	if self._vertices[startId] == nil then
		return
	end

	local visited = {}
	local queue = {}

	table.insert(queue, startId)

	visited[startId] = true

	while #queue > 0 do
		local current = table.remove(queue, 1)
		local vertex = self._vertices[current]
		local continueTraversal = visitFunc(current, vertex.data)

		if continueTraversal == false then
			break
		end

		for successorId, _ in pairs(vertex.outEdges) do
			if not visited[successorId] then
				visited[successorId] = true

				table.insert(queue, successorId)
			end
		end
	end
end

function DirectedGraph:isReachable(fromId, toId)
	if self._vertices[fromId] == nil or self._vertices[toId] == nil then
		return false
	end

	if fromId == toId then
		return true
	end

	local visited = {}
	local queue = {}

	table.insert(queue, fromId)

	visited[fromId] = true

	while #queue > 0 do
		local current = table.remove(queue, 1)

		for successorId, _ in pairs(self._vertices[current].outEdges) do
			if successorId == toId then
				return true
			end

			if not visited[successorId] then
				visited[successorId] = true

				table.insert(queue, successorId)
			end
		end
	end

	return false
end

function DirectedGraph:findPath(fromId, toId)
	if self._vertices[fromId] == nil or self._vertices[toId] == nil then
		return nil
	end

	if fromId == toId then
		return {
			fromId
		}
	end

	local visited = {}
	local queue = {}
	local parent = {}

	table.insert(queue, fromId)

	visited[fromId] = true
	parent[fromId] = nil

	local found = false

	while #queue > 0 do
		local current = table.remove(queue, 1)

		for successorId, _ in pairs(self._vertices[current].outEdges) do
			if not visited[successorId] then
				visited[successorId] = true
				parent[successorId] = current

				table.insert(queue, successorId)

				if successorId == toId then
					found = true

					break
				end
			end
		end

		if found then
			break
		end
	end

	if not found then
		return nil
	end

	local path = {}
	local current = toId

	while current ~= nil do
		table.insert(path, 1, current)

		current = parent[current]
	end

	return path
end

function DirectedGraph:_checkId(id)
	if id == nil then
		error("vertex id cannot be nil")
	end
end

return DirectedGraph
