-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/audio/AudioVoicePlayer.lua

module(..., package.seeall)

local AudioVoicePlayer = class("AudioVoicePlayer")
local Time = UnityEngine.Time
local fadeInTime = 0.2
local fadeOutTime = 0.4
local gapTime = 0.3
local bgmFadeTime = 0.3
local bgmFadeRate = 0.2
local fmodAudioMgr = FmodAudioMgr.Instance

function AudioVoicePlayer:ctor()
	self._currVoiceEvent = nil
	self._fadingOutVoiceEvt = nil
	self._currVoiceVolume = 0
	self._fadingOutVoiceVolume = 0
	self._fadingInVoiceTime = 0
	self._fadingOutVoiceTime = 0

	GlobalDispatcher:addListener(GlobalNotify.OnViewOpen, self._onViewOpened, self)
end

function AudioVoicePlayer:isPlayingCv()
	return self._currVoiceEvent ~= nil
end

function AudioVoicePlayer:_checkInit()
	fmodAudioMgr = fmodAudioMgr or FmodAudioMgr.Instance
end

function AudioVoicePlayer:playVoiceByEvt(evt, finishCallback, finishCallbackObj, autoResumeBgm)
	if self._currVoiceEvent == evt then
		return
	end

	if evt == nil then
		self:_startFadeOut(evt)

		return
	end

	self.CurVoiceMax = AudioPlayerEx.instance:getVoiceVolume()

	local beforeEvent = self._currVoiceEvent

	if autoResumeBgm == nil then
		autoResumeBgm = true
	end

	self._autoResumeBgm = autoResumeBgm
	self._currVoiceEvent = evt
	self._finishCallback = finishCallback
	self._finishCallbackObj = finishCallbackObj

	removetimer(self._onPlayCvFinished, self)

	if beforeEvent then
		self:_startFadeOut(beforeEvent)
		removetimer(self._startPlay, self)
		settimer(fadeOutTime + gapTime, self._startPlay, self, false)
	else
		self:_startPlay(true)
	end
end

function AudioVoicePlayer:setAutoResumeBgm(autoResumeBgm)
	self._autoResumeBgm = autoResumeBgm

	if not self._currVoiceEvent and self._autoResumeBgm then
		self:_tweenBGMVolume(false)
	end
end

function AudioVoicePlayer:stopVoice(stopCurrVoice, withoutMuiscVolume)
	removetimer(self._doFadeOutVoice, self)

	if self._tween ~= nil then
		self._tween:Kill()
	end

	if self._fadingOutVoiceEvt then
		AudioPlayerEx.instance:stopVoiceByEvtName(self._fadingOutVoiceEvt)

		self._fadingOutVoiceEvt = nil
	end

	self._finishCallback = nil
	self._finishCallbackObj = nil

	if stopCurrVoice then
		removetimer(self._doFadeInVoice, self)

		if not withoutMuiscVolume then
			self:_tweenBGMVolume(false)
		end

		if self._currVoiceEvent then
			removetimer(self._onPlayCvFinished, self)

			local currVoice = self._currVoiceEvent

			self:_startFadeOut(currVoice)

			self._currVoiceEvent = nil
		end
	end
end

function AudioVoicePlayer:_startPlay(noFade)
	if self._currVoiceEvent == nil then
		return
	end

	AudioPlayerEx.instance:playVoiceByEvtName(self._currVoiceEvent)

	local voiceLength = AudioPlayerEx.instance:getAudioLengthByEvt(self._currVoiceEvent) * 0.001

	if checknumber(voiceLength) <= 0 then
		self:stopVoice(true)

		return
	end

	if not noFade then
		self:_startFadeIn()
	end

	settimer(voiceLength, self._onPlayCvFinished, self, false)
	self:_tweenBGMVolume(true)
end

function AudioVoicePlayer:_onPlayCvFinished()
	local callback = self._finishCallback
	local finishCallbackObj = self._finishCallbackObj

	self._currVoiceEvent = nil
	self._finishCallback = nil
	self._finishCallbackObj = nil

	if self._autoResumeBgm then
		self:_tweenBGMVolume(false)

		self._autoResumeBgm = nil
	end

	if callback then
		if finishCallbackObj then
			self._finishCallback(finishCallbackObj)
		else
			callback()
		end
	end
end

function AudioVoicePlayer:_startFadeOut(evt)
	if self._currVoiceEvent == nil or self._fadingOutVoiceEvt == evt then
		return
	end

	if self._fadingOutVoiceEvt then
		AudioPlayerEx.instance:stopVoiceByEvtName(self._fadingOutVoiceEvt)
	end

	self._fadingOutVoiceEvt = evt
	self._fadingOutVoiceVolume = 1
	self._fadingOutVoiceTime = 0

	settimer(0, self._doFadeOutVoice, self)
end

function AudioVoicePlayer:_startFadeIn()
	if not self._currVoiceEvent then
		return
	end

	self._currVoiceVolume = 0
	self._fadingInVoiceTime = 0

	self:_checkInit()

	if not fmodAudioMgr then
		return
	end

	fmodAudioMgr:SetEventVolume(self._currVoiceEvent, self._currVoiceVolume)
	settimer(0, self._doFadeInVoice, self)
end

function AudioVoicePlayer:_doFadeInVoice()
	if not self._currVoiceEvent then
		removetimer(self._doFadeInVoice, self)

		return
	end

	self._fadingInVoiceTime = self._fadingInVoiceTime + Time.deltaTime
	self._currVoiceVolume = self:_exponentialIn(math.min(self._fadingInVoiceTime / fadeInTime, 1))

	self:_checkInit()

	if not fmodAudioMgr then
		return
	end

	fmodAudioMgr:SetEventVolume(self._currVoiceEvent, self._currVoiceVolume * self.CurVoiceMax)

	if self._currVoiceVolume >= 0.99 then
		removetimer(self._doFadeInVoice, self)
	end
end

function AudioVoicePlayer:_doFadeOutVoice()
	if not self._fadingOutVoiceEvt then
		removetimer(self._doFadeOutVoice, self)

		return
	end

	self._fadingOutVoiceTime = self._fadingOutVoiceTime + Time.deltaTime

	local petcent = self:_easeSineIn(math.min(self._fadingOutVoiceTime / fadeOutTime, 1))

	self._fadingOutVoiceVolume = 1 - petcent

	self:_checkInit()

	if not fmodAudioMgr then
		return
	end

	fmodAudioMgr:SetEventVolume(self._fadingOutVoiceEvt, self._fadingOutVoiceVolume * self.CurVoiceMax)

	if self._fadingOutVoiceVolume < 0.01 then
		removetimer(self._doFadeOutVoice, self)
		AudioPlayerEx.instance:stopVoiceByEvtName(self._fadingOutVoiceEvt)

		self._fadingOutVoiceEvt = nil
	end
end

function AudioVoicePlayer:_tweenBGMVolume(isDown)
	local volume = AudioPlayerEx.instance:getMusicVolume()
	local volumeUI = AudioPlayerEx.instance:getAudioVolume()

	if self._initVolume == nil then
		self._initVolume = volume
	end

	if self._initVolumeUI == nil then
		self._initVolumeUI = volumeUI
	end

	if self._tween ~= nil then
		self._tween:Kill()
	end

	if self._tweenUI ~= nil then
		self._tweenUI:Kill()
	end

	if isDown then
		if self._initVolume ~= 0 then
			self._tween = TweenUtil.ValueTo(volume, self._initVolume * bgmFadeRate, bgmFadeTime, function(val)
				AudioPlayerEx.instance:setMusicVolume(val)
			end, nil, self)
		end

		self._tweenUI = TweenUtil.ValueTo(volumeUI, self._initVolumeUI * bgmFadeRate, bgmFadeTime, function(val)
			AudioPlayerEx.instance:setAudioVolume(val)
		end, nil, self)
	end

	if not isDown then
		if self._initVolume ~= 0 then
			self._tween = TweenUtil.ValueTo(volume, self._initVolume, bgmFadeTime, function(val)
				AudioPlayerEx.instance:setMusicVolume(val)
			end, function()
				self._initVolume = nil
			end, self)
		end

		self._tweenUI = TweenUtil.ValueTo(volumeUI, self._initVolumeUI, bgmFadeTime, function(val)
			AudioPlayerEx.instance:setAudioVolume(val)
		end, function()
			self._initVolumeUI = nil
		end, self)
	end
end

function AudioVoicePlayer:_easeSineIn(time)
	return -1 * math.cos(time * math.pi * 0.5) + 1
end

function AudioVoicePlayer:_easeSineOut(time)
	return math.sin(time * math.pi * 0.5)
end

function AudioVoicePlayer:_exponentialIn(time)
	if time == 0 then
		return 0
	end

	return math.pow(2, 10 * (time / 1 - 1)) - 0.001
end

function AudioVoicePlayer:_exponentialOut(t)
	local time = t / 0.5

	time = time < 1 and 0.5 * math.pow(2, 10 * (time - 1)) or 0.5 * (-math.pow(2, -10 * (time - 1)) + 2)

	return time
end

function AudioVoicePlayer:_onViewOpened(view)
	if view.viewName == ViewName.MainUI then
		self:stopVoice(true)
	end
end

AudioVoicePlayer.instance = AudioVoicePlayer.New()

return AudioVoicePlayer
