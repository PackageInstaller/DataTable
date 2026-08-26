-- chunkname: @modules/logic/gm/controller/sequencework/WaitRecordDoneWork.lua

module("modules.logic.gm.controller.sequencework.WaitRecordDoneWork", package.seeall)

local WaitRecordDoneWork = class("WaitRecordDoneWork", BaseWork)

function WaitRecordDoneWork:ctor()
	return
end

function WaitRecordDoneWork:onStart()
	local isRecording = PerformanceRecorder.instance:isRecording()

	if not isRecording then
		self:onDone(true)

		return
	end

	PerformanceRecorder.instance:registerCallback(PerformanceRecordEvent.onRecordDone, self.onRecordDone, self)
end

function WaitRecordDoneWork:onRecordDone()
	PerformanceRecorder.instance:unregisterCallback(PerformanceRecordEvent.onRecordDone, self.onRecordDone, self)
	self:onDone(true)
end

function WaitRecordDoneWork:clearWork()
	PerformanceRecorder.instance:unregisterCallback(PerformanceRecordEvent.onRecordDone, self.onRecordDone, self)
end

return WaitRecordDoneWork
