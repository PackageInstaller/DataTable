-- chunkname: @modules/logic/versionactivity2_2/tianshinana/model/TianShiNaNaMapUnitCo.lua

module("modules.logic.versionactivity2_2.tianshinana.model.TianShiNaNaMapUnitCo", package.seeall)

local TianShiNaNaMapUnitCo = pureTable("TianShiNaNaMapUnitCo")

function TianShiNaNaMapUnitCo:init(unit)
	self.id = unit[1]
	self.unitType = unit[2]
	self.x = unit[3]
	self.y = unit[4]
	self.unitPath = unit[5]
	self.offset = Vector3(unit[6][1], unit[6][2], unit[6][3])
	self.specialData = unit[7]
	self.dir = unit[8]
	self.walkable = unit[9]
	self.effects = {}

	for _, effect in ipairs(unit[10]) do
		table.insert(self.effects, {
			type = effect[1],
			param = effect[2]
		})
	end
end

return TianShiNaNaMapUnitCo
