-- chunkname: @modules/logic/fight/system/work/FightWorkDoneFlowParallel.lua

module("modules.logic.fight.system.work.FightWorkDoneFlowParallel", package.seeall)

local FightWorkDoneFlowParallel = class("FightWorkDoneFlowParallel", FightWorkFlowParallel)

function FightWorkDoneFlowParallel:start(context)
	if self.PARENT_ROOT_OBJECT then
		if self.PARENT_ROOT_OBJECT and self.PARENT_ROOT_OBJECT.cancelFightWorkSafeTimer then
			self.PARENT_ROOT_OBJECT:cancelFightWorkSafeTimer()
		end

		return FightWorkDoneFlowParallel.super.start(self, context)
	end
end

return FightWorkDoneFlowParallel
