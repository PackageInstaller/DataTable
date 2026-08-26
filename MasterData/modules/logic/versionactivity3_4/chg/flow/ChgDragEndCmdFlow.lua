-- chunkname: @modules/logic/versionactivity3_4/chg/flow/ChgDragEndCmdFlow.lua

module("modules.logic.versionactivity3_4.chg.flow.ChgDragEndCmdFlow", package.seeall)

local Base = ChgCmdFlowBase
local ChgDragEndCmdFlow = class("ChgDragEndCmdFlow", Base)

function ChgDragEndCmdFlow:ctor(...)
	Base.ctor(self, ...)
end

function ChgDragEndCmdFlow:onStart()
	self:resetToIdle()

	if self._displayFrame:isValid() then
		local fromEnergy = self._displayFrame.detectFinalEnergy
		local toEnergy = self:curEnergy()

		self:addWork(ChgDragging_EditEnergyWork.s_create(fromEnergy, toEnergy))
	end

	if self:checkIsCompleted() then
		self:setCompleted()
	end
end

return ChgDragEndCmdFlow
