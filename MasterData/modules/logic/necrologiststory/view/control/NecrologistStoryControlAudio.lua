-- chunkname: @modules/logic/necrologiststory/view/control/NecrologistStoryControlAudio.lua

module("modules.logic.necrologiststory.view.control.NecrologistStoryControlAudio", package.seeall)

local NecrologistStoryControlAudio = class("NecrologistStoryControlAudio", NecrologistStoryControlMgrItem)

function NecrologistStoryControlAudio:onPlayControl()
	if not self.isSkip then
		self:playAudio()
	end

	self:onPlayControlFinish()
end

function NecrologistStoryControlAudio:playAudio()
	local attr = string.split(self.controlParam, "#")
	local volume = tonumber(attr[2]) or 1
	local inTime = tonumber(attr[3]) or 0
	local outTime = tonumber(attr[4]) or 0
	local param = AudioParam.New()

	param.loopNum = 1
	param.fadeInTime = inTime
	param.fadeOutTime = outTime
	param.volume = volume * 100
	self.audioId = tonumber(attr[1])

	if self.audioId then
		AudioEffectMgr.instance:playAudio(self.audioId, param)
	end
end

function NecrologistStoryControlAudio:onDestory()
	if self.audioId then
		AudioEffectMgr.instance:stopAudio(self.audioId)
	end

	NecrologistStoryControlAudio.super.onDestory(self)
end

return NecrologistStoryControlAudio
