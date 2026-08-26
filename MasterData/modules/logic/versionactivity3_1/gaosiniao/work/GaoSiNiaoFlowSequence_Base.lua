-- chunkname: @modules/logic/versionactivity3_1/gaosiniao/work/GaoSiNiaoFlowSequence_Base.lua

module("modules.logic.versionactivity3_1.gaosiniao.work.GaoSiNiaoFlowSequence_Base", package.seeall)

local Base = _G.FlowSequence
local GaoSiNiaoFlowSequence_Base = class("GaoSiNiaoFlowSequence_Base", Base)

function GaoSiNiaoFlowSequence_Base:ctor(...)
	Base.ctor(self, ...)
end

function GaoSiNiaoFlowSequence_Base:onDestroyView()
	self:destroy()
end

function GaoSiNiaoFlowSequence_Base:addWork(work)
	if not work or not self._workList then
		return nil
	end

	Base.addWork(self, work)
	work:setRootInternal(self)

	return work
end

function GaoSiNiaoFlowSequence_Base:onDestroyInternal(...)
	GaoSiNiaoFlowSequence_Base.super.onDestroyInternal(self, ...)

	self._workList = {}
	self._curIndex = 0
end

function GaoSiNiaoFlowSequence_Base:insertWork(work)
	if not work or not self._workList then
		return nil
	end

	BaseFlow.addWork(self, work)
	work:setRootInternal(self)
	table.insert(self._workList, self:nextIndex(), work)

	return work
end

function GaoSiNiaoFlowSequence_Base:appendFlow(movableFlow)
	local workList = movableFlow:getWorkList()

	for _, work in ipairs(workList or {}) do
		self:addWork(work)
	end

	movableFlow._workList = {}
	movableFlow._curIndex = 0

	return self
end

function GaoSiNiaoFlowSequence_Base:curWork()
	return self._workList[self._curIndex]
end

function GaoSiNiaoFlowSequence_Base:nextIndex()
	return self._curIndex + 1
end

function GaoSiNiaoFlowSequence_Base:onStart()
	return
end

function GaoSiNiaoFlowSequence_Base:isDoneOrIdle()
	if not self._workList then
		return true
	end

	if #self._workList == 0 then
		return true
	end

	local work = self:curWork()

	if not work then
		return true
	end

	return work.status == WorkStatus.Done
end

function GaoSiNiaoFlowSequence_Base:clearWork()
	for _, work in ipairs(self._workList or {}) do
		work:clearWork()
	end

	Base.clearWork(self)

	self._workList = {}
	self._curIndex = 0
end

return GaoSiNiaoFlowSequence_Base
