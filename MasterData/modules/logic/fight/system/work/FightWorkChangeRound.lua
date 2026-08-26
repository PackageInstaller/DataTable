-- chunkname: @modules/logic/fight/system/work/FightWorkChangeRound.lua

module("modules.logic.fight.system.work.FightWorkChangeRound", package.seeall)

local FightWorkChangeRound = class("FightWorkChangeRound", FightEffectBase)

function FightWorkChangeRound:onStart()
	local version = FightModel.instance:getVersion()

	if version < 3 then
		self:onDone(true)

		return
	end

	FightModel.instance._curRoundId = self.actEffectData.effectNum == 0 and (FightModel.instance._curRoundId or 1) + 1 or self.actEffectData.effectNum

	FightController.instance:dispatchEvent(FightEvent.ChangeRound)

	local mySubList = FightDataHelper.entityMgr:getMySubList()

	for i, v in ipairs(mySubList) do
		v.subCd = 0

		FightController.instance:dispatchEvent(FightEvent.ChangeEntitySubCd, v.uid)
	end

	local flow = self:com_registWorkDoneFlowSequence()

	flow:registWork(Work2FightWork, FightWorkFbStory, FightWorkFbStory.Type_ChangeRound, FightModel.instance._curRoundId)
	flow:start()
end

function FightWorkChangeRound:clearWork()
	return
end

return FightWorkChangeRound
