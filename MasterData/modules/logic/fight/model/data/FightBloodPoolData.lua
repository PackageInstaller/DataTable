-- chunkname: @modules/logic/fight/model/data/FightBloodPoolData.lua

module("modules.logic.fight.model.data.FightBloodPoolData", package.seeall)

local FightBloodPoolData = FightDataClass("FightBloodPoolData")

function FightBloodPoolData:onConstructor(proto)
	self.value = proto.value
	self.max = proto.max
end

return FightBloodPoolData
