-- chunkname: @modules/logic/fight/model/data/FightAiJiAoAutoSequenceForGM.lua

module("modules.logic.fight.model.data.FightAiJiAoAutoSequenceForGM", package.seeall)

local FightAiJiAoAutoSequenceForGM = FightDataClass("FightAiJiAoAutoSequenceForGM")

function FightAiJiAoAutoSequenceForGM:onConstructor()
	self.autoSequence = {}
	self.index = 0
end

return FightAiJiAoAutoSequenceForGM
