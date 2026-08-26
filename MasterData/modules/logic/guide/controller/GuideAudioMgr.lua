-- chunkname: @modules/logic/guide/controller/GuideAudioMgr.lua

module("modules.logic.guide.controller.GuideAudioMgr", package.seeall)

local GuideAudioMgr = class("GuideAudioMgr")
local LowVoiceValue = 0.33

function GuideAudioMgr:ctor()
	return
end

function GuideAudioMgr:playAudio(audioId)
	if AudioEffectMgr.instance:isPlaying(audioId) then
		return
	end

	if self._audioId then
		self:stopAudio(self._audioId)
	end

	local playingItemDict = AudioEffectMgr.instance:getPlayingItemDict()

	self._setBusVolumeDict = {}

	for _, audioItem in pairs(playingItemDict) do
		self._setBusVolumeDict[audioItem] = true

		ZProj.AudioManager.Instance:SetGameObjectOutputBusVolume(audioItem._go, LowVoiceValue)
	end

	self._audioId = audioId

	AudioEffectMgr.instance:registerCallback(AudioEffectMgr.OnPlayAudio, self._onPlayAudio, self)
	AudioEffectMgr.instance:playAudio(self._audioId)
end

function GuideAudioMgr:_onPlayAudio(audioId, audioItem)
	if self._audioId and self._setBusVolumeDict and audioId ~= self._audioId then
		self._setBusVolumeDict[audioItem] = true

		ZProj.AudioManager.Instance:SetGameObjectOutputBusVolume(audioItem._go, LowVoiceValue)
	end
end

function GuideAudioMgr:stopAudio()
	AudioEffectMgr.instance:unregisterCallback(AudioEffectMgr.OnPlayAudio, self._onPlayAudio, self)

	if self._setBusVolumeDict then
		for audioItem, _ in pairs(self._setBusVolumeDict) do
			if not gohelper.isNil(audioItem._go) then
				ZProj.AudioManager.Instance:ResetListenersToDefault(audioItem._go)
			end
		end

		self._setBusVolumeDict = nil
	end

	if self._audioId then
		AudioEffectMgr.instance:stopAudio(self._audioId)

		self._audioId = nil
	end
end

GuideAudioMgr.instance = GuideAudioMgr.New()

return GuideAudioMgr
