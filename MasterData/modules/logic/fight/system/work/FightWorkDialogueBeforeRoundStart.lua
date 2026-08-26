-- chunkname: @modules/logic/fight/system/work/FightWorkDialogueBeforeRoundStart.lua

module("modules.logic.fight.system.work.FightWorkDialogueBeforeRoundStart", package.seeall)

local FightWorkDialogueBeforeRoundStart = class("FightWorkDialogueBeforeRoundStart", FightWorkItem)

function FightWorkDialogueBeforeRoundStart:onStart()
	local flow = self:com_registWorkDoneFlowSequence()

	flow:addWork(Work2FightWork.New(FightWorkNormalDialog, FightViewDialog.Type.HaveBuffAndHaveDamageSkill_onlyCheckOnce))
	flow:start()
end

function FightWorkDialogueBeforeRoundStart:clearWork()
	return
end

return FightWorkDialogueBeforeRoundStart
