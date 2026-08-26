-- chunkname: @modules/logic/fight/model/data/FightDataModel.lua

module("modules.logic.fight.model.data.FightDataModel", package.seeall)

local FightDataModel = class("FightDataModel", BaseModel)

function FightDataModel:onInit()
	return
end

function FightDataModel:reInit()
	return
end

function FightDataModel:initDouQuQu()
	self.douQuQuMgr = FightDouQuQuDataMgr.New()

	return self.douQuQuMgr
end

function FightDataModel:initAiJiAoAutoSequenceForGM()
	self.aiJiAoAutoSequenceForGM = FightAiJiAoAutoSequenceForGM.New()

	return self.aiJiAoAutoSequenceForGM
end

FightDataModel.instance = FightDataModel.New()

return FightDataModel
