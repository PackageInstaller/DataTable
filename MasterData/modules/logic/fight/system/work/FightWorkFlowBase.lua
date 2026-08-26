-- chunkname: @modules/logic/fight/system/work/FightWorkFlowBase.lua

module("modules.logic.fight.system.work.FightWorkFlowBase", package.seeall)

local FightWorkFlowBase = class("FightWorkFlowBase", FightWorkItem)
local deepLimit = 10

function FightWorkFlowBase:start(context)
	if self.PARENT_ROOT_OBJECT then
		if isTypeOf(self.PARENT_ROOT_OBJECT, FightWorkFlowSequence) or isTypeOf(self.PARENT_ROOT_OBJECT, FightWorkFlowBase) then
			self.ROOTFLOW = self.PARENT_ROOT_OBJECT.ROOTFLOW
			self.ROOTFLOW.COUNTERDEEP = self.ROOTFLOW.COUNTERDEEP + 1
			self.COUNTERDEEP = self.ROOTFLOW.COUNTERDEEP
		else
			self.ROOTFLOW = self
			self.COUNTERDEEP = 0
		end
	else
		self.ROOTFLOW = self
		self.COUNTERDEEP = 0
	end

	if self.COUNTERDEEP == 0 then
		return FightWorkItem.start(self, context)
	elseif self.COUNTERDEEP % deepLimit == 0 then
		return self:com_registTimer(FightWorkItem.start, 0.01, context)
	else
		return FightWorkItem.start(self, context)
	end
end

function FightWorkFlowBase:onDestructorFinish()
	if not self.COUNTERDEEP then
		return FightWorkItem.onDestructorFinish(self)
	end

	if self.COUNTERDEEP == 0 then
		return FightWorkItem.onDestructorFinish(self)
	elseif self.COUNTERDEEP % deepLimit == 0 then
		return FightTimer.registTimer(FightWorkItem.onDestructorFinish, self, 0.01)
	else
		return FightWorkItem.onDestructorFinish(self)
	end
end

return FightWorkFlowBase
