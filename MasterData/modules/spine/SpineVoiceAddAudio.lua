-- chunkname: @modules/spine/SpineVoiceAddAudio.lua

module("modules.spine.SpineVoiceAddAudio", package.seeall)

local SpineVoiceAddAudio = class("SpineVoiceAddAudio")

function SpineVoiceAddAudio:ctor()
	return
end

function SpineVoiceAddAudio:init(audioId, delayTime)
	self._audioId = audioId

	if delayTime < 0.1 then
		self:_playAddAudio()

		return
	end

	TaskDispatcher.runDelay(self._playAddAudio, self, delayTime)
end

function SpineVoiceAddAudio:_playAddAudio()
	if self._audioId and self._audioId > 0 then
		AudioMgr.instance:trigger(self._audioId)
	end
end

function SpineVoiceAddAudio:onDestroy()
	if self._audioId and self._audioId > 0 then
		AudioMgr.instance:stopPlayingID(self._audioId)
	end

	self._audioId = nil

	TaskDispatcher.cancelTask(self._playAddAudio, self)
end

return SpineVoiceAddAudio
