-- chunkname: @modules/logic/fight/system/work/FightWorkDoneFlowSequence.lua

module("modules.logic.fight.system.work.FightWorkDoneFlowSequence", package.seeall)

local FightWorkDoneFlowSequence = class("FightWorkDoneFlowSequence", FightWorkFlowSequence)

function FightWorkDoneFlowSequence:start(context)
	if self.PARENT_ROOT_OBJECT then
		if self.PARENT_ROOT_OBJECT and self.PARENT_ROOT_OBJECT.cancelFightWorkSafeTimer then
			self.PARENT_ROOT_OBJECT:cancelFightWorkSafeTimer()
		end

		return FightWorkDoneFlowSequence.super.start(self, context)
	end
end

return FightWorkDoneFlowSequence
