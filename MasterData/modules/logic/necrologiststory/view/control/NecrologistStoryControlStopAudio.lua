-- chunkname: @modules/logic/necrologiststory/view/control/NecrologistStoryControlStopAudio.lua

module("modules.logic.necrologiststory.view.control.NecrologistStoryControlStopAudio", package.seeall)

local NecrologistStoryControlStopAudio = class("NecrologistStoryControlStopAudio", NecrologistStoryControlMgrItem)

function NecrologistStoryControlStopAudio:onPlayControl()
	self:stopAudio()
	self:onPlayControlFinish()
end

function NecrologistStoryControlStopAudio:stopAudio()
	local attr = string.split(self.controlParam, "#")
	local outTime = tonumber(attr[2]) or 0
	local audioId = tonumber(attr[1])

	if audioId then
		AudioEffectMgr.instance:stopAudio(audioId, outTime)
	end
end

return NecrologistStoryControlStopAudio
