-- chunkname: @modules/logic/fight/model/data/FightSummonedInfoData.lua

module("modules.logic.fight.model.data.FightSummonedInfoData", package.seeall)

local FightSummonedInfoData = FightDataClass("FightSummonedInfoData")

function FightSummonedInfoData:onConstructor(proto)
	self.summonedId = proto.summonedId
	self.level = proto.level
	self.uid = proto.uid
	self.fromUid = proto.fromUid
end

return FightSummonedInfoData
