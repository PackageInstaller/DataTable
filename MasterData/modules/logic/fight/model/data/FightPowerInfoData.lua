-- chunkname: @modules/logic/fight/model/data/FightPowerInfoData.lua

module("modules.logic.fight.model.data.FightPowerInfoData", package.seeall)

local FightPowerInfoData = FightDataClass("FightPowerInfoData")

function FightPowerInfoData:onConstructor(proto)
	self.powerId = proto.powerId
	self.num = proto.num
	self.max = proto.max
end

return FightPowerInfoData
