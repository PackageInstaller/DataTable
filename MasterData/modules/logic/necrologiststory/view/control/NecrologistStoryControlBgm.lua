-- chunkname: @modules/logic/necrologiststory/view/control/NecrologistStoryControlBgm.lua

module("modules.logic.necrologiststory.view.control.NecrologistStoryControlBgm", package.seeall)

local NecrologistStoryControlBgm = class("NecrologistStoryControlBgm", NecrologistStoryControlMgrItem)

function NecrologistStoryControlBgm:onPlayControl()
	self:playAudio()
	self:onPlayControlFinish()
end

function NecrologistStoryControlBgm:playAudio()
	local attr = string.split(self.controlParam, "#")
	local volume = tonumber(attr[2]) or 1
	local inTime = tonumber(attr[3]) or 0
	local outTime = tonumber(attr[4]) or 0
	local param = AudioParam.New()

	param.loopNum = 999999
	param.fadeInTime = inTime
	param.fadeOutTime = outTime
	param.volume = volume * 100
	self.audioId = tonumber(attr[1])

	if self.audioId then
		AudioEffectMgr.instance:playAudio(self.audioId, param)
	end
end

function NecrologistStoryControlBgm:onDestory()
	if self.audioId then
		AudioEffectMgr.instance:stopAudio(self.audioId)
	end

	NecrologistStoryControlBgm.super.onDestory(self)
end

return NecrologistStoryControlBgm
