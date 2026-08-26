-- chunkname: @modules/logic/fight/model/data/FightEmitterInfoData.lua

module("modules.logic.fight.model.data.FightEmitterInfoData", package.seeall)

local FightEmitterInfoData = FightDataClass("FightEmitterInfoData")

function FightEmitterInfoData:onConstructor(proto)
	self.energy = proto.energy
end

return FightEmitterInfoData
