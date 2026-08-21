-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/audio/criwareAudio/CriwareAudioPlayerSettingListener.lua

module("logic.common.audio.criwareAudio.CriwareAudioPlayerSettingListener", package.seeall)

local CriwareAudioPlayerSettingListener = class("CriwareAudioPlayerSettingListener")

function CriwareAudioPlayerSettingListener:init()
	GlobalDispatcher:addEventListener(EventType.APPLICATION_PAUSE, self._onHandleOnApplicationPause, self)
	GlobalDispatcher:addEventListener(EventType.APPLICATION_RESUME, self._onHandleOnApplicationResume, self)
	GlobalDispatcher:addEventListener(EventType.ON_MUSIC_OPEN, self._onHandleMusicMuteUpdate, self)
	GlobalDispatcher:addEventListener(EventType.ON_MUSIC_CLOSE, self._onHandleMusicMuteUpdate, self)
	GlobalDispatcher:addEventListener(EventType.ON_SOUND_EFFECT_ON, self._onHandleSoundEffectUpdate, self)
	GlobalDispatcher:addEventListener(EventType.ON_SOUND_EFFECT_OFF, self._onHandleSoundEffectUpdate, self)
	GlobalDispatcher:addEventListener(EventType.CAMERA_FOLLOW_POSITION_UPDATE, self._moveListener, self)
	self:_updateMusicMute()
	self:_updateSoundEffectMute()
end

function CriwareAudioPlayerSettingListener:_onHandleMusicMuteUpdate()
	self:_updateMusicMute()
end

function CriwareAudioPlayerSettingListener:_onHandleSoundEffectUpdate()
	self:_updateSoundEffectMute()
end

function CriwareAudioPlayerSettingListener:_onHandleOnApplicationPause()
	if enableLog then
		printWarn("onHandleOnApplicationPause")
	end

	CriwareAudioPlayer.instance:setBgmVolume(0)
	CriwareAudioPlayer.instance:setSEVolume(0)
	CriwareAudioPlayer.instance:setVoiceVolume(0)
end

function CriwareAudioPlayerSettingListener:_onHandleOnApplicationResume()
	if enableLog then
		printWarn("onHandleOnApplicationResume")
	end

	local bgmVolume = Astral.LocalStorage.Instance:GetFloat("BgmVolume", 1)

	CriwareAudioPlayer.instance:setBgmVolume(bgmVolume)

	local seVolume = Astral.LocalStorage.Instance:GetFloat("SoundEffVolume", 1)

	CriwareAudioPlayer.instance:setSEVolume(seVolume)

	local voiceVolume = Astral.LocalStorage.Instance:GetFloat("DubVolume", 1)

	CriwareAudioPlayer.instance:setVoiceVolume(voiceVolume)
end

function CriwareAudioPlayerSettingListener:_updateMusicMute()
	return
end

function CriwareAudioPlayerSettingListener:_updateSoundEffectMute()
	return
end

function CriwareAudioPlayerSettingListener:_moveListener()
	CriwareAudioPlayer.instance:moveCriwareListenerPos()
end

return CriwareAudioPlayerSettingListener
