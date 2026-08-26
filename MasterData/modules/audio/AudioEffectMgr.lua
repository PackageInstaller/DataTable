-- chunkname: @modules/audio/AudioEffectMgr.lua

module("modules.audio.AudioEffectMgr", package.seeall)

local AudioEffectMgr = class("AudioEffectMgr")

AudioEffectMgr.OnPlayAudio = 101

function AudioEffectMgr:ctor()
	self._pool = AudioItem.createPool()
	self._playingList = {}

	LuaEventSystem.addEventMechanism(self)
end

function AudioEffectMgr:setVolume(audioId, value, transitionTime)
	local audioItem = self._playingList[audioId]

	if not audioItem then
		return
	end

	audioItem:setVolume(value, transitionTime)
end

function AudioEffectMgr:setSwitch(audioId, switchGroup, switchState)
	local audioItem = self._playingList[audioId]

	if not audioItem then
		return
	end

	audioItem:setSwitch(switchGroup, switchState)
end

function AudioEffectMgr:playAudio(audioId, audioParam, audioLang)
	if self._playingList[audioId] then
		return
	end

	audioParam = audioParam or self:_getDefaultAudioParam()
	audioParam.audioLang = audioLang

	local audioItem = self._pool:getObject()

	self._playingList[audioId] = audioItem

	audioItem:playAudio(audioId, audioParam)
	self:dispatchEvent(AudioEffectMgr.OnPlayAudio, audioId, audioItem)
end

function AudioEffectMgr:_getDefaultAudioParam()
	self._defaultAudioParam = self._defaultAudioParam or AudioParam.New()

	self._defaultAudioParam:clear()

	self._defaultAudioParam.loopNum = 1
	self._defaultAudioParam.fadeInTime = 0
	self._defaultAudioParam.fadeOutTime = 0

	return self._defaultAudioParam
end

function AudioEffectMgr:seekPercent(audioId, percent)
	local audioItem = self._playingList[audioId]

	if not audioItem then
		audioItem:seekPercent(percent)
	end
end

function AudioEffectMgr:seekMilliSeconds(audioId, milliSeconds)
	local audioItem = self._playingList[audioId]

	if audioItem then
		audioItem:seekMilliSeconds(milliSeconds)
	end
end

function AudioEffectMgr:stopAudio(audioId, fadeOutTime)
	if not self._playingList[audioId] then
		return
	end

	self._playingList[audioId]:stopAudio(audioId, fadeOutTime)
end

function AudioEffectMgr:removePlayingAudio(audioId)
	self._playingList[audioId] = nil
end

function AudioEffectMgr:isPlaying(audioId)
	return self._playingList[audioId]
end

function AudioEffectMgr:getPlayingItemDict()
	return self._playingList
end

function AudioEffectMgr:playAudioByEffectPath(effectPath, fadeInTime, fadeOutTime)
	local config = AudioConfig.instance:getAudioConfig(effectPath)

	if config then
		local param = self:_getEffectAudioParam(fadeInTime, fadeOutTime)

		self:playAudio(config.audioId, param)

		return config.audioId
	end
end

function AudioEffectMgr:_getEffectAudioParam(fadeInTime, fadeOutTime)
	self._effectAudioParam = self._effectAudioParam or AudioParam.New()

	self._effectAudioParam:clear()

	self._effectAudioParam.loopNum = 1
	self._effectAudioParam.fadeInTime = fadeInTime
	self._effectAudioParam.fadeOutTime = fadeOutTime

	return self._effectAudioParam
end

function AudioEffectMgr:stopAudioByEffectPath(effectPath, fadeOutTime)
	local config = AudioConfig.instance:getAudioConfig(effectPath)

	if config then
		self:stopAudio(config.audioId, fadeOutTime)
	end
end

function AudioEffectMgr:_onStopAudio(audioId)
	if not self._playingList[audioId] then
		return
	end

	local audioItem = self._playingList[audioId]

	self._pool:putObject(audioItem)

	self._playingList[audioId] = nil
end

AudioEffectMgr.instance = AudioEffectMgr.New()

return AudioEffectMgr
