-- chunkname: @modules/logic/fight/view/work/WorkFlow.lua

module("modules.logic.fight.view.work.WorkFlow", package.seeall)

local WorkFlow = class("WorkFlow", BaseFlow)

function WorkFlow:ctor()
	self._work = nil
end

function WorkFlow:deserialize(data)
	if data then
		local root = self:_parse(data)

		self:addChild(root)
	end
end

function WorkFlow:_parse(data)
	local cls = _G[data.type]

	if cls then
		local root = cls.New(data.paramTable)
		local node = self:_parse(data)

		self:addChild(root)
	end
end

function WorkFlow:addWork(work)
	WorkFlow.super.addWork(self, work)

	self._work = work
end

function WorkFlow:onWorkDone(work)
	self:onDone(self._work.isSuccess)
	self._work:onResetInternal()
end

function WorkFlow:onStartInternal(context)
	WorkFlow.super.onStartInternal(self, context)
	self._work:onStartInternal(self.context)
end

function WorkFlow:onStopInternal()
	WorkFlow.super.onStopInternal(self)

	if self._work.status == WorkStatus.Running then
		self._work:onStopInternal()
	end
end

function WorkFlow:onResumeInternal()
	WorkFlow.super.onResumeInternal(self)

	if self._work.status == WorkStatus.Stopped then
		self._work:onResumeInternal()
	end
end

function WorkFlow:onResetInternal()
	WorkFlow.super.onResetInternal(self)

	if self._work.status == WorkStatus.Running or self._work.status == WorkStatus.Stopped then
		self._work:onResetInternal()
	end
end

function WorkFlow:onDestroyInternal()
	WorkFlow.super.onDestroyInternal(self)

	if self._work.status == WorkStatus.Running then
		self._work:onStopInternal()
	end

	self._work:onResetInternal()

	self._work = nil
end

return WorkFlow
