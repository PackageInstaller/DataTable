-- chunkname: @modules/audio/AudioItem.lua

module("modules.audio.AudioItem", package.seeall)

local AudioItem = class("AudioItem")

function AudioItem.createPool()
	AudioItem._fadeStringId = AudioMgr.instance:getIdFromString("Fade_in_on_parameters")
	AudioItem._itemPool = LuaObjPool.New(6, AudioItem._poolNew, AudioItem._poolRelease, AudioItem._poolReset)

	return AudioItem._itemPool
end

function AudioItem._poolNew()
	return AudioItem.New()
end

function AudioItem._poolRelease(luaObj)
	luaObj:release()
end

function AudioItem._poolReset(luaObj)
	luaObj:reset()
end

function AudioItem:ctor()
	local go = UnityEngine.GameObject.New()

	go.name = "AudioItem"

	UnityEngine.GameObject.DontDestroyOnLoad(go)

	self._go = go

	self:reset()
end

function AudioItem:reset()
	self._callback = nil
	self._callbackTarget = nil

	transformhelper.setPos(self._go.transform, 0, 0, 0)
	self:killTween()

	self._volume = nil
end

function AudioItem:setVolume(value, transitionTime)
	self:_fade(value * 0.01, transitionTime or 0)
end

function AudioItem:stopAudio(audioId, fadeOutTime)
	transformhelper.setPos(self._go.transform, 0, 0, 0)

	self._fadeOutTime = fadeOutTime or 0

	if not self:_startDelayFadeOut(0) then
		self:_onStop()
	end
end

function AudioItem:setSwitch(switchGroup, switchState)
	if not self._emitter then
		return
	end

	self._emitter:SetSwitch(switchGroup, switchState)
end

function AudioItem:playAudio(audioId, audioParam)
	self._audioId = audioId
	self._playNum = 0
	self._loopNum = audioParam.loopNum or 1
	self._fadeInTime = audioParam.fadeInTime or 0
	self._fadeOutTime = audioParam.fadeOutTime or 0

	if not audioParam.volume then
		local volume = 100

		self._audioGo = audioParam.audioGo
		self._callback = audioParam.callback
		self._callbackTarget = audioParam.callbackTarget
		self._audioLang = audioParam.audioLang

		self:_play()
		self:_fadeIn(volume * 0.01)
	end
end

function AudioItem:seekPercent(percent)
	if self._playingId and self._emitter then
		self._emitter:SeekPercent(self._audioId, percent)
	end
end

function AudioItem:seekMilliSeconds(milliSeconds)
	if self._playingId and self._emitter then
		self._emitter:SeekMilliSeconds(self._audioId, milliSeconds)
	end
end

function AudioItem:_play()
	TaskDispatcher.cancelTask(self._play, self)

	self._startTime = Time.realtimeSinceStartup

	if self._audioGo then
		local posX, posY, posZ = transformhelper.getPos(self._audioGo.transform)

		transformhelper.setPos(self._go.transform, posX, posY, posZ)
	else
		transformhelper.setPos(self._go.transform, 0, 0, 0)
	end

	self._emitter = self._emitter or ZProj.AudioEmitter.Get(self._go)

	local function emitterCallback(callbackType, value)
		if callbackType == AudioEnum.AkCallbackType.AK_Duration then
			self:_setAudioDuration(value)
		elseif callbackType == AudioEnum.AkCallbackType.AK_EndOfEvent then
			self:_onAudioStop()
		end
	end

	if self._audioLang then
		local audioCfg = AudioConfig.instance:getAudioCOById(self._audioId)

		if not audioCfg then
			logError("audio cfg not config : " .. tostring(self._audioId))
		end

		if audioCfg then
			local bnkName = audioCfg.bankName

			ZProj.AudioManager.Instance:LoadBank(bnkName, self._audioLang)
			self._emitter:Emitter(self._audioId, self._audioLang, emitterCallback)
			ZProj.AudioManager.Instance:UnloadBank(bnkName)
		end
	else
		self._emitter:Emitter(self._audioId, emitterCallback)
	end

	AudioMgr.instance:addAudioLog(self._audioId, "yellow", "播放音效开始")

	self._playingId = self._emitter.playingId
end

function AudioItem:_fadeIn(volume)
	if self._fadeInTime > 0 then
		self:_fade(0, 0)
	end

	self:_fade(volume, self._fadeInTime)
end

function AudioItem:_fadeOut()
	if self._fadeOutTime > 0 then
		TaskDispatcher.cancelTask(self._onStop, self)
		TaskDispatcher.runDelay(self._onStop, self, self._fadeOutTime)
		self:_fade(0, self._fadeOutTime)
	end
end

function AudioItem:_fade(value, time)
	if not self._playingId then
		return
	end

	self:killTween()

	if time > 0 then
		self.tweenId = ZProj.TweenHelper.DOTweenFloat(self._volume or 1, value, time, self._tweenFrameCallback, nil, self, nil, EaseType.Linear)
	else
		self:_tweenFrameCallback(value)
	end
end

function AudioItem:_tweenFrameCallback(value)
	AudioMgr.instance:setGameObjectOutputBusVolume(self._go, value)

	self._volume = value
end

function AudioItem:killTween()
	if self.tweenId then
		ZProj.TweenHelper.KillById(self.tweenId)

		self.tweenId = nil
	end
end

function AudioItem:_setAudioDuration(value)
	self._duration = (value or 0) / 1000

	if self._playNum + 1 >= self._loopNum then
		self:_startDelayFadeOut()
	end
end

function AudioItem:_startDelayFadeOut(time)
	if self._fadeOutTime <= 0 then
		return false
	end

	if not time then
		if self._duration and self._duration > 0 then
			self._fadeOutTime = math.min(self._fadeOutTime, self._duration)
			time = self._duration - self._fadeOutTime
		else
			time = self._fadeOutTime
		end
	end

	time = math.max(time, 0)

	TaskDispatcher.cancelTask(self._fadeOut, self)

	if time == 0 then
		self:_fadeOut()
	else
		TaskDispatcher.runDelay(self._fadeOut, self, time)
	end

	return true
end

function AudioItem:_onAudioStop()
	if not self._audioId then
		return
	end

	self._playNum = self._playNum + 1

	if self._playNum < self._loopNum then
		TaskDispatcher.runDelay(self._play, self, 0)
	else
		self:_onStop()
	end
end

function AudioItem:_onStop()
	if not self._audioId then
		return
	end

	if self._callback then
		self._callback(self._callbackTarget, self._audioId)
	end

	if self._playingId then
		AudioMgr.instance:stopPlayingID(self._playingId)
	end

	if self._playNum == 0 then
		AudioMgr.instance:addAudioLog(self._audioId, "red", "播放音效停止")
	elseif self._playNum == 1 then
		AudioMgr.instance:addAudioLog(self._audioId, "green", "播放音效结束")
	end

	TaskDispatcher.cancelTask(self._fadeOut, self)
	TaskDispatcher.cancelTask(self._onStop, self)
	TaskDispatcher.cancelTask(self._play, self)
	AudioEffectMgr.instance:_onStopAudio(self._audioId)

	self._audioId = nil
	self._playingId = nil
end

function AudioItem:isPlaying()
	return self._playingId
end

function AudioItem:release()
	self:reset()
	UnityEngine.GameObject.Destroy(self._go)

	self._go = nil
	self._emitter = nil
end

return AudioItem
