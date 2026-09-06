-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/firepowercontest/game/hittest/ObbSAT.lua

module("logic.extensions.firepowercontest.game.ObbSAT", package.seeall)

local ObbSAT = class("ObbSAT")

function ObbSAT._normalize(vec)
	return vec:SetNormalize()
end

function ObbSAT._dot(pointA, pointB)
	return Vector2.Dot(pointB, pointA)
end

function ObbSAT._edgeDirection(pointA, pointB)
	return pointB - pointA
end

function ObbSAT._orthogonal(vec)
	return Vector2.New(vec.y, vec.x)
end

function ObbSAT._vertices2Edges(vertices)
	local length = #vertices
	local results = {}

	for i = 1, length do
		local result = ObbSAT._edgeDirection(vertices[i], vertices[(i + 1) % length + 1])

		table.insert(results, result)
	end

	return results
end

function ObbSAT._project(vertices, axis)
	local length = #vertices
	local minDot = 999999
	local maxDot = 0

	for i = 1, length do
		local dotValue = ObbSAT._dot(vertices[i], axis)

		minDot = math.min(minDot, dotValue)
		maxDot = math.max(maxDot, dotValue)
	end

	return {
		minDot,
		maxDot
	}
end

function ObbSAT._overlap(projection1, projection2)
	return projection1[1] <= projection2[2] and projection2[1] <= projection1[2]
end

function ObbSAT.insect(verticesA, verticesB)
	if #verticesA == 0 or #verticesB == 0 then
		printError("verticesA verticesB length can't empty")
	end

	local edges = {}

	table.insertto(edges, ObbSAT._vertices2Edges(verticesA), ObbSAT._vertices2Edges(verticesB))

	local axes = {}

	for i = 1, #edges do
		table.insert(axes, ObbSAT._normalize(ObbSAT._orthogonal(edges[i])))
	end

	for i = 1, #axes do
		projectionA = ObbSAT._project(verticesA, axes[i])
		projectionB = ObbSAT._project(verticesB, axes[i])

		if not ObbSAT._overlap(projectionA, projectionB) then
			return false
		end
	end

	return true
end

return ObbSAT
