-- chunkname: @modules/logic/versionactivity2_2/tianshinana/model/TianShiNaNaMapCo.lua

module("modules.logic.versionactivity2_2.tianshinana.model.TianShiNaNaMapCo", package.seeall)

local TianShiNaNaMapCo = pureTable("TianShiNaNaMapCo")

function TianShiNaNaMapCo:init(rawCo)
	self.path = rawCo[1]
	self.unitDict = {}
	self.nodesDict = {}

	for _, unit in ipairs(rawCo[2]) do
		local unitCo = TianShiNaNaMapUnitCo.New()

		unitCo:init(unit)

		self.unitDict[unitCo.id] = unitCo
	end

	for _, node in ipairs(rawCo[3]) do
		local nodeCo = TianShiNaNaMapNodeCo.New()

		nodeCo:init(node)

		self.nodesDict[nodeCo.x] = self.nodesDict[nodeCo.x] or {}
		self.nodesDict[nodeCo.x][nodeCo.y] = nodeCo
	end
end

function TianShiNaNaMapCo:getUnitCo(unitId)
	return self.unitDict[unitId]
end

function TianShiNaNaMapCo:getNodeCo(x, y)
	if not self.nodesDict[x] then
		return
	end

	return self.nodesDict[x][y]
end

return TianShiNaNaMapCo
