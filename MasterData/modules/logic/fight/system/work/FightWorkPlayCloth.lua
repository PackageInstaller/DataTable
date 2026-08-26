-- chunkname: @modules/logic/fight/system/work/FightWorkPlayCloth.lua

module("modules.logic.fight.system.work.FightWorkPlayCloth", package.seeall)

local FightWorkPlayCloth = class("FightWorkPlayCloth", FightWorkItem)

function FightWorkPlayCloth:onStart()
	self.roundData = FightDataHelper.roundMgr:getRoundData()

	local flow = self:com_registFlowSequence()

	flow:addWork(FunctionWork.New(function()
		FightController.instance:dispatchEvent(FightEvent.StartPlayClothSkill)
	end))

	local stepWorkList = FightStepBuilder.buildStepWorkList(self.roundData and self.roundData.fightStep)

	if stepWorkList then
		for _, work in ipairs(stepWorkList) do
			flow:addWork(work)
		end
	end

	flow:addWork(FunctionWork.New(function()
		local roundData = FightDataHelper.roundMgr:getRoundData()

		FightDataMgr.instance:afterPlayRoundData(roundData)
	end))
	flow:addWork(FunctionWork.New(function()
		FightController.instance:dispatchEvent(FightEvent.AfterPlayClothSkill)
	end))
	flow:registFinishCallback(self.onClothFinish, self)
	self:playWorkAndDone(flow, {})
end

function FightWorkPlayCloth:onClothFinish()
	FightDataHelper.stageMgr:exitFightState(FightStageMgr.FightStateType.ClothSkill)
	FightController.instance:dispatchEvent(FightEvent.OnClothSkillRoundSequenceFinish)
end

return FightWorkPlayCloth
