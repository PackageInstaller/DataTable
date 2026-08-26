-- chunkname: @modules/logic/fight/model/data/FightTaskValueData.lua

module("modules.logic.fight.model.data.FightTaskValueData", package.seeall)

local FightTaskValueData = FightDataClass("FightTaskValueData")

function FightTaskValueData:onConstructor(proto)
	self.index = proto.index
	self.progress = proto.progress
	self.maxProgress = proto.maxProgress
	self.finished = proto.finished
end

return FightTaskValueData
