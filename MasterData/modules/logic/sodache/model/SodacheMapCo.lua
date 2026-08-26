-- chunkname: @modules/logic/sodache/model/SodacheMapCo.lua

module("modules.logic.sodache.model.SodacheMapCo", package.seeall)

local SodacheMapCo = pureTable("SodacheMapCo")

function SodacheMapCo:init(data)
	self.mapPath = data[1]
	self.nodes = {}

	for i, v in ipairs(data[2]) do
		local offsetList = {}

		if v[3] then
			for _, vv in ipairs(v[3]) do
				table.insert(offsetList, Vector3(unpack(vv)))
			end
		end

		self.nodes[v[1]] = {
			pos = Vector3(unpack(v[2])),
			id = v[1],
			offsetList = offsetList
		}
	end

	self.paths = {}
	self.lineDict = {}

	for i, v in ipairs(data[3]) do
		local path = {}

		path.id = v[1]
		path.fromId = v[2]
		path.toId = v[3]
		path.exPoints = {}
		path.exPointsRev = {}

		GameUtil.setTbValue(self.lineDict, path.fromId, path.toId, path.id)
		GameUtil.setTbValue(self.lineDict, path.toId, path.fromId, path.id)

		for _, vv in pairs(v[4]) do
			local point = Vector3(unpack(vv))

			table.insert(path.exPoints, point)
			table.insert(path.exPointsRev, 1, point)
		end

		self.paths[v[1]] = path
	end
end

function SodacheMapCo:getPath(nodeId1, nodeId2)
	local lightNodes = SodacheModel.instance:getInsideMo().allShowNodes

	return SodachePathFindUtil.bfs(self.lineDict, nodeId1, nodeId2, lightNodes)
end

function SodacheMapCo:getLineId(nodeId1, nodeId2)
	return GameUtil.getTbValue(self.lineDict, nodeId1, nodeId2)
end

function SodacheMapCo:getLineExPoints(nodeId1, nodeId2)
	local lineId = self:getLineId(nodeId1, nodeId2)
	local lineInfo = self.paths[lineId]

	if not lineInfo then
		return
	end

	if lineInfo.fromId == nodeId1 and lineInfo.toId == nodeId2 then
		return lineInfo.exPoints
	else
		return lineInfo.exPointsRev
	end
end

return SodacheMapCo
