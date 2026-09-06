-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/audio/AudioBgmPlayer.lua

module(..., package.seeall)

local AudioBgmPlayer = class("AudioBgmPlayer")
local Time = UnityEngine.Time
local fadeInTime = 0.5
local fadeOutTime = 1
local fadeBgmVolumeTime = 0.5
local fmodAudioMgr = FmodAudioMgr.Instance

function AudioBgmPlayer:ctor()
	self._currBgmEvent = nil
	self._fadingOutBgmEvt = nil
	self._currBgmVolume = 0
	self._fadingOutBgmVolume = 0
	self._fadingInBgmTime = 0
	self._fadingOutBgmTime = 0
	self._bgmVolume = 1
	self._currVolume = 1
	self._fadeBgmVolumeTime = 0
end

function AudioBgmPlayer:_checkInit()
	fmodAudioMgr = fmodAudioMgr or FmodAudioMgr.Instance
end

function AudioBgmPlayer:startPlayEffect(effId)
	self:stopMusic()
	AudioPlayerEx.instance:playEffect(effId)
end

function AudioBgmPlayer:startPlayEffectWithFade(effId, effTime, fadeTime)
	if not effTime then
		::label_4_0::

		local len = AudioPlayerEx.instance:getAudioLength(effId) * 0.001

		self:startFadeBgmVolume(nil, fadeTime)
		removetimer(self._resumeBgmVolume, self)
		settimer(len, self._resumeBgmVolume, self)
	end
end

function AudioBgmPlayer:startFadeBgmVolume(destVolume, fadeTime)
	self._bgmVolume = AudioPlayerEx.instance:getMusicVolume()
	self._destVolume = destVolume or 0
	self._fadeBgmVolumeTime = 0

	removetimer(self._resumeBgmVolume, self)
	removetimer(self._fadingBgmVolume, self)

	if fadeTime and fadeTime > 0 then
		fadeBgmVolumeTime = fadeTime
		self._currVolume = self._bgmVolume

		settimer(0, self._fadingBgmVolume, self)
	else
		self._currVolume = self._destVolume

		AudioPlayerEx.instance:setMusicVolume(self._destVolume)
	end
end

function AudioBgmPlayer:stopFadeBgmVolume()
	if self._bgmVolume == self._currVolume then
		return
	end

	self._destVolume = self._bgmVolume
	self._bgmVolume = self._currVolume
	self._fadeBgmVolumeTime = 0
	fadeBgmVolumeTime = 0.5

	removetimer(self._fadingBgmVolume, self)
	settimer(0, self._fadingBgmVolume, self)
end

function AudioBgmPlayer:_fadingBgmVolume()
	self._fadeBgmVolumeTime = self._fadeBgmVolumeTime + Time.deltaTime

	local petcent = self:_easeSineIn(math.max(math.min(self._fadeBgmVolumeTime / fadeBgmVolumeTime, 1)))

	self._currVolume = self._bgmVolume + (self._destVolume - self._bgmVolume) * petcent

	AudioPlayerEx.instance:setMusicVolume(self._currVolume)

	if petcent > 0.99 then
		removetimer(self._fadingBgmVolume, self)
	end
end

function AudioBgmPlayer:_resumeBgmVolume()
	removetimer(self._resumeBgmVolume, self)
	self:stopFadeBgmVolume()
end

function AudioBgmPlayer:playMusicByEvt(evt)
	if self._currBgmEvent == evt then
		return
	end

	local bgm = self._currBgmEvent

	self._currBgmEvent = evt

	if bgm then
		self:_startFadeOut(bgm)
	end

	AudioPlayerEx.instance:playMusicByEvtName(self._currBgmEvent)
	self:_startFadeIn()
end

function AudioBgmPlayer:stopMusic()
	removetimer(self._doFadeInBgm, self)
	removetimer(self._doFadeOutBgm, self)

	if self._currBgmEvent then
		AudioPlayerEx.instance:stopMusicByEvtName(self._currBgmEvent)
	end

	if self._fadingOutBgmEvt then
		AudioPlayerEx.instance:stopMusicByEvtName(self._fadingOutBgmEvt)
	end

	self._currBgmEvent = nil
	self._fadingOutBgmEvt = nil
end

function AudioBgmPlayer:_startFadeOut(evt)
	if self._fadingOutBgmEvt == evt then
		return
	end

	if self._fadingOutBgmEvt then
		AudioPlayerEx.instance:stopMusicByEvtName(self._fadingOutBgmEvt)
	end

	self._fadingOutBgmEvt = evt
	self._fadingOutBgmVolume = 1
	self._fadingOutBgmTime = 0

	settimer(0, self._doFadeOutBgm, self)
end

function AudioBgmPlayer:_startFadeIn()
	if not self._currBgmEvent then
		return
	end

	self._currBgmVolume = 0
	self._fadingInBgmTime = 0

	self:_checkInit()

	if not fmodAudioMgr then
		return
	end

	fmodAudioMgr:SetEventVolume(self._currBgmEvent, self._currBgmVolume)
	settimer(0, self._doFadeInBgm, self)
end

function AudioBgmPlayer:_doFadeInBgm()
	if not self._currBgmEvent then
		removetimer(self._doFadeInBgm, self)

		return
	end

	self:_checkInit()

	if not fmodAudioMgr then
		return
	end

	if fmodAudioMgr:GetMusicPaused(self._currBgmEvent) then
		return
	end

	self._fadingInBgmTime = self._fadingInBgmTime + Time.deltaTime
	self._currBgmVolume = self:_exponentialIn(math.min(self._fadingInBgmTime / fadeInTime, 1))

	fmodAudioMgr:SetEventVolume(self._currBgmEvent, self._currBgmVolume)

	if self._currBgmVolume >= 1 then
		removetimer(self._doFadeInBgm, self)
	end
end

function AudioBgmPlayer:_doFadeOutBgm()
	if not self._fadingOutBgmEvt then
		removetimer(self._doFadeOutBgm, self)

		return
	end

	self:_checkInit()

	if not fmodAudioMgr then
		return
	end

	if fmodAudioMgr:GetMusicPaused(self._fadingOutBgmEvt) then
		return
	end

	self._fadingOutBgmTime = self._fadingOutBgmTime + Time.deltaTime

	local petcent = self:_easeSineIn(math.min(self._fadingOutBgmTime / fadeOutTime, 1))

	self._fadingOutBgmVolume = 1 - petcent

	fmodAudioMgr:SetEventVolume(self._fadingOutBgmEvt, self._fadingOutBgmVolume)

	if self._fadingOutBgmVolume < 0.01 then
		removetimer(self._doFadeOutBgm, self)
		AudioPlayerEx.instance:stopMusicByEvtName(self._fadingOutBgmEvt)

		self._fadingOutBgmEvt = nil
	end
end

function AudioBgmPlayer:_easeSineIn(time)
	return -1 * math.cos(time * math.pi * 0.5) + 1
end

function AudioBgmPlayer:_easeSineOut(time)
	return math.sin(time * math.pi * 0.5)
end

function AudioBgmPlayer:_exponentialIn(time)
	if time == 0 then
		return 0
	end

	return math.pow(2, 10 * (time / 1 - 1)) - 0.001
end

function AudioBgmPlayer:_exponentialOut(t)
	local time = t / 0.5

	time = time < 1 and 0.5 * math.pow(2, 10 * (time - 1)) or 0.5 * (-math.pow(2, -10 * (time - 1)) + 2)

	return time
end

AudioBgmPlayer.instance = AudioBgmPlayer.New()

return AudioBgmPlayer
