-- chunkname: @modules/logic/fight/model/data/FightMagicCircleInfoData.lua

module("modules.logic.fight.model.data.FightMagicCircleInfoData", package.seeall)

local FightMagicCircleInfoData = FightDataClass("FightMagicCircleInfoData")

function FightMagicCircleInfoData:onConstructor(proto)
	self.magicCircleId = proto.magicCircleId
	self.round = proto.round
	self.createUid = proto.createUid
	self.electricLevel = proto.electricLevel
	self.electricProgress = proto.electricProgress
	self.maxElectricProgress = proto.maxElectricProgress
end

return FightMagicCircleInfoData
