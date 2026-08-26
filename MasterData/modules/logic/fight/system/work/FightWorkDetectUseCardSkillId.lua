-- chunkname: @modules/logic/fight/system/work/FightWorkDetectUseCardSkillId.lua

module("modules.logic.fight.system.work.FightWorkDetectUseCardSkillId", package.seeall)

local FightWorkDetectUseCardSkillId = class("FightWorkDetectUseCardSkillId", FightWorkItem)

function FightWorkDetectUseCardSkillId:onStart()
	local flow = self:com_registWorkDoneFlowSequence()

	flow:addWork(Work2FightWork.New(FightWorkNormalDialog, FightViewDialog.Type.DetectHaveCardAfterEndOperation))
	flow:start()
end

function FightWorkDetectUseCardSkillId:clearWork()
	return
end

return FightWorkDetectUseCardSkillId
