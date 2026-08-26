-- chunkname: @modules/logic/fight/view/work/FlowCondition.lua

module("modules.logic.fight.view.work.FlowCondition", package.seeall)

local FlowCondition = class("FlowCondition", BaseFlow)

function FlowCondition:ctor()
	self._conditionWork = nil
	self._trueWork = nil
	self._falseWork = nil
end

function FlowCondition:addWork(conditionWork, trueWork, falseWork)
	FlowCondition.super.addWork(self, conditionWork)
	FlowCondition.super.addWork(self, trueWork)
	FlowCondition.super.addWork(self, falseWork)

	self._conditionWork = conditionWork
	self._trueWork = trueWork
	self._falseWork = falseWork
end

function FlowCondition:onWorkDone(work)
	if work == self._conditionWork then
		if work.isSuccess then
			self._trueWork:onStartInternal(self.context)
		else
			self._falseWork:onStartInternal(self.context)
		end
	else
		self.status = work.status

		self:onDone(work.isSuccess)
	end

	work:onResetInternal()
end

function FlowCondition:onStartInternal(context)
	FlowCondition.super.onStartInternal(self, context)
	self._conditionWork:onStartInternal(self.context)
end

function FlowCondition:onStopInternal()
	FlowCondition.super.onStopInternal(self)

	if self._trueWork.status == WorkStatus.Running then
		self._trueWork:onStopInternal()
	elseif self._falseWork.status == WorkStatus.Running then
		self._falseWork:onStopInternal()
	end
end

function FlowCondition:onResumeInternal()
	FlowCondition.super.onResumeInternal(self)

	if self._trueWork.status == WorkStatus.Stopped then
		self._trueWork:onResumeInternal()
	elseif self._falseWork.status == WorkStatus.Stopped then
		self._falseWork:onResumeInternal()
	end
end

function FlowCondition:onResetInternal()
	FlowCondition.super.onResetInternal(self)

	if self._trueWork.status == WorkStatus.Running or self._trueWork.status == WorkStatus.Stopped then
		self._trueWork:onResumeInternal()
	elseif self._falseWork.status == WorkStatus.Running or self._falseWork.status == WorkStatus.Stopped then
		self._falseWork:onResumeInternal()
	end
end

function FlowCondition:onDestroyInternal()
	FlowCondition.super.onDestroyInternal(self)

	if self._trueWork.status == WorkStatus.Running then
		self._trueWork:onStopInternal()
	elseif self._falseWork.status == WorkStatus.Running then
		self._falseWork:onStopInternal()
	end

	if self._trueWork.status == WorkStatus.Stopped then
		self._trueWork:onResetInternal()
	elseif self._falseWork.status == WorkStatus.Stopped then
		self._falseWork:onResetInternal()
	end

	self._conditionWork:onDestroyInternal()
	self._trueWork:onDestroyInternal()
	self._falseWork:onDestroyInternal()

	self._conditionWork = nil
	self._trueWork = nil
	self._falseWork = nil
end

return FlowCondition
