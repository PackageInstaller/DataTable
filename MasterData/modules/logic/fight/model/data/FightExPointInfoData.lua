-- chunkname: @modules/logic/fight/model/data/FightExPointInfoData.lua

module("modules.logic.fight.model.data.FightExPointInfoData", package.seeall)

local FightExPointInfoData = FightDataClass("FightExPointInfoData")

function FightExPointInfoData:onConstructor(proto)
	self.uid = proto.uid
	self.exPoint = proto.exPoint
	self.powerInfos = {}

	for i, v in ipairs(proto.powerInfos) do
		table.insert(self.powerInfos, FightPowerInfoData.New(v))
	end

	self.currentHp = proto.currentHp
end

return FightExPointInfoData
