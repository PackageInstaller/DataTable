-- chunkname: @modules/logic/versionactivity3_4/chg/flow/ChgFlowParallel_Base.lua

module("modules.logic.versionactivity3_4.chg.flow.ChgFlowParallel_Base", package.seeall)

local Base = _G.FlowParallel
local ChgFlowParallel_Base = class("ChgFlowParallel_Base", Base)

function ChgFlowParallel_Base:ctor(...)
	Base.ctor(self, ...)
end

function ChgFlowParallel_Base:onDestroyView()
	self:destroy()
end

function ChgFlowParallel_Base:addWork(work)
	if not work or not self._workList then
		return nil
	end

	Base.addWork(self, work)
	work:setRootInternal(self)

	return work
end

function ChgFlowParallel_Base:onStart()
	return
end

function ChgFlowParallel_Base:clearWork()
	for _, work in ipairs(self._workList or {}) do
		work:clearWork()
	end

	Base.clearWork(self)
end

return ChgFlowParallel_Base
