-- chunkname: @modules/logic/sodache/util/SodachePathFindUtil.lua

module("modules.logic.sodache.util.SodachePathFindUtil", package.seeall)

local SodachePathFindUtil = class("SodachePathFindUtil")

function SodachePathFindUtil.dijkstra(graph, start, target)
	local distances = {}
	local visited = {}
	local previous = {}
	local nodes = {}

	for node, _ in pairs(graph) do
		distances[node] = math.huge
		previous[node] = nil

		table.insert(nodes, node)
	end

	distances[start] = 0

	while #nodes > 0 do
		local minDistance = math.huge
		local minNode
		local minIndex = 0

		for i, node in ipairs(nodes) do
			if not visited[node] and minDistance > distances[node] then
				minDistance = distances[node]
				minNode = node
				minIndex = i
			end
		end

		if not minNode then
			break
		end

		visited[minNode] = true

		table.remove(nodes, minIndex)

		if minNode == target then
			break
		end

		if graph[minNode] then
			for neighbor, weight in pairs(graph[minNode]) do
				if not visited[neighbor] then
					local alt = distances[minNode] + weight

					if alt < distances[neighbor] then
						distances[neighbor] = alt
						previous[neighbor] = minNode
					end
				end
			end
		end
	end

	if not distances[target] or distances[target] == math.huge then
		return false
	end

	local path = {}
	local current = target

	while previous[current] do
		table.insert(path, 1, current)

		current = previous[current]
	end

	if #path > 0 or start == target then
		table.insert(path, 1, start)
	end

	return {
		path = path,
		dis = distances[target]
	}
end

function SodachePathFindUtil.bfs(graph, start, target, lightNodes)
	local queue = {}
	local distances = {
		[start] = 0
	}
	local previous = {}
	local head, tail = 1, 1

	queue[tail] = start
	tail = tail + 1

	while head < tail do
		local current = queue[head]

		head = head + 1

		if current == target then
			break
		end

		if graph[current] then
			for neighbor in pairs(graph[current]) do
				if lightNodes[neighbor] and distances[neighbor] == nil then
					distances[neighbor] = distances[current] + 1
					previous[neighbor] = current
					queue[tail] = neighbor
					tail = tail + 1
				end
			end
		end
	end

	if distances[target] == nil then
		return false
	end

	local path = {}
	local current = target

	while previous[current] do
		table.insert(path, 1, current)

		current = previous[current]
	end

	table.insert(path, 1, start)

	return {
		path = path,
		dis = distances[target]
	}
end

return SodachePathFindUtil
