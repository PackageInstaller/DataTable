-- chunkname: @modules/logic/story/view/StoryAudioItem.lua

module("modules.logic.story.view.StoryAudioItem", package.seeall)

local StoryAudioItem = class("StoryAudioItem")

function StoryAudioItem:init(audioId)
	self._audioId = audioId
	self._playCount = 1
end

function StoryAudioItem:pause(pause)
	return
end

function StoryAudioItem:stop(outTime)
	AudioEffectMgr.instance:stopAudio(self._audioId, outTime)
	self:onDestroy()
end

function StoryAudioItem:play(inTime, outTime, volume)
	self._hasDestroy = false

	local isPlaying = AudioEffectMgr.instance:isPlaying(self._audioId)

	if isPlaying then
		self:_resetAudio()

		return
	end

	local param = AudioParam.New()

	param.loopNum = self._playCount
	param.fadeInTime = inTime
	param.fadeOutTime = outTime
	param.volume = 100 * volume

	AudioEffectMgr.instance:playAudio(self._audioId, param)
	self:_setSwitch(true)
end

function StoryAudioItem:setLoop()
	self._playCount = 999999
end

function StoryAudioItem:setCount(count)
	self._playCount = count
end

function StoryAudioItem:isPause()
	return
end

function StoryAudioItem:_resetAudio()
	AudioEffectMgr.instance:setVolume(self._audioId, 100 * self._audioParam.volume, self._audioParam.transTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
	self:_setSwitch()
end

function StoryAudioItem:_setSwitch(init)
	if self._audioParam.orderType == StoryEnum.AudioOrderType.SetSwitch then
		local switchCo = StoryConfig.instance:getStoryAudioSwitchConfig(self._audioParam.audioState)

		if switchCo then
			local groupId = AudioMgr.instance:getIdFromString(switchCo.switchgroup)
			local stateId = AudioMgr.instance:getIdFromString(switchCo.switchstate)

			if groupId and stateId then
				AudioEffectMgr.instance:setSwitch(self._audioId, groupId, stateId)
			end
		end
	else
		if not init then
			return
		end

		local groupId = AudioMgr.instance:getIdFromString("plot_music_stae_strength")
		local stateId = AudioMgr.instance:getIdFromString("strength0" .. tostring(self._audioParam.audioState))

		if groupId and stateId then
			AudioEffectMgr.instance:setSwitch(self._audioId, groupId, stateId)
		end
	end
end

function StoryAudioItem:setAudio(audioParam)
	if audioParam.orderType == StoryEnum.AudioOrderType.Destroy and self._hasDestroy then
		return
	end

	self._hasDestroy = false

	local delayTime = audioParam.delayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()]

	if delayTime < 0.1 then
		self:_startAudio(audioParam)
	else
		TaskDispatcher.runDelay(function()
			if not ViewMgr.instance:isOpen(ViewName.StoryView) then
				return
			end

			if self._hasDestroy then
				return
			end

			self:_startAudio(audioParam)
		end, self, delayTime)
	end
end

function StoryAudioItem:_startAudio(audioParam)
	self._audioParam = audioParam

	if self._audioParam.orderType == StoryEnum.AudioOrderType.Continuity then
		self:_playLoop()
	elseif self._audioParam.orderType == StoryEnum.AudioOrderType.Single then
		self:_playSingle()
	elseif self._audioParam.orderType == StoryEnum.AudioOrderType.Destroy then
		self:_stopAudio()
	elseif self._audioParam.orderType == StoryEnum.AudioOrderType.Adjust then
		self:_resetAudio()
	elseif self._audioParam.orderType == StoryEnum.AudioOrderType.SetSwitch then
		self:play(self._audioParam.transTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()], self._audioParam.transTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()], self._audioParam.volume)
	end
end

function StoryAudioItem:_playSingle()
	self:setCount(self._audioParam.count)
	self:play(self._audioParam.transTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()], self._audioParam.transTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()], self._audioParam.volume)
end

function StoryAudioItem:_playLoop()
	self:setLoop()
	self:play(self._audioParam.transTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()], self._audioParam.transTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()], self._audioParam.volume)
end

function StoryAudioItem:_stopAudio()
	self:stop(self._audioParam.transTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
end

function StoryAudioItem:onDestroy()
	self._hasDestroy = true

	TaskDispatcher.cancelTask(self._playLoop, self)
	TaskDispatcher.cancelTask(self._playSingle, self)
	TaskDispatcher.cancelTask(self._stopAudio, self)
	TaskDispatcher.cancelTask(self._resetAudio, self)
end

return StoryAudioItem
