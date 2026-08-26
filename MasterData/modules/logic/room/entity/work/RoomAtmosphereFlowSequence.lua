-- chunkname: @modules/logic/room/entity/work/RoomAtmosphereFlowSequence.lua

module("modules.logic.room.entity.work.RoomAtmosphereFlowSequence", package.seeall)

local RoomAtmosphereFlowSequence = class("RoomAtmosphereFlowSequence", FlowSequence)
local DoneEvent = "done"

function RoomAtmosphereFlowSequence:ctor(doneParam)
	RoomAtmosphereFlowSequence.super.ctor(self)

	self._doneParam = doneParam
end

function RoomAtmosphereFlowSequence:setAllWorkAudioIsFade(isFade)
	for _, work in ipairs(self._workList) do
		work:setAudioIsFade(isFade)
	end
end

function RoomAtmosphereFlowSequence:onDone(isSuccess)
	self.isSuccess = isSuccess
	self.status = WorkStatus.Done

	self:clearWork()

	if self.parent then
		self.parent:onWorkDone(self)
	end

	if self._dispatcher then
		self._dispatcher:dispatchEvent(DoneEvent, isSuccess, self._doneParam)
	end
end

return RoomAtmosphereFlowSequence
