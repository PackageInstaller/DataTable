-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/System\\AudioManager.lua

local strClassName = "AudioManager"
local AudioManager = Class(strClassName)
local AudioHub = Framework.AudioSystem.AudioHub
local AudioFactory = Framework.AudioSystem.AudioFactory
local AudioType = Framework.AudioSystem.AudioType
local PingPongTable = require("Common/Tools/PingPongTable")
local ResMusic = require("ClientData/ResMusic")
local ResBgNoise = require("ClientData/ResBgNoise")
local ResVoiceConfig = require("ClientData/ResVoiceConfig")
local ResAudioGroup = require("ClientData/ResAudioGroup")
local LackVocal = require("ClientData/LackVocal")

AudioManager.MasterAudioMixerPath = "Audios/Mixer/AudioMixer.mixer"
AudioManager.AudioRootPath = "Audios/Mixer/AudioRoot.Prefab"
AudioManager.FootStepSubGroupId = 1

function AudioManager:ctor()
	assert(AudioManager._instance == nil, "[ERROR] The AudioManager instance is created already!")
	self:init()
end

function AudioManager:init()
	AudioHub.Init(self.AudioRootPath)

	AudioHub.LoadAudioSync = false

	AudioFactory.Init()

	self.audioSources = {}

	self:initLackVocalPaths()
	self:initAudioGroup()
	self:initPingPongTable()
end

function AudioManager:destroy()
	AudioFactory.CleanAllAudio()
	AudioHub.Destroy()
end

function AudioManager:loadAudio(audioPath)
	return AudioFactory.CreateAudioClipSync(audioPath)
end

function AudioManager:releaseAudio(audioPath)
	AudioFactory.ReleaseAudio(audioPath)
end

function AudioManager:cleanAllLoadedSFX()
	AudioFactory.ReleaseAudioByType(AudioType.SFX)
	AudioFactory.ReleaseAudioByType(AudioType.Vocal)
end

function AudioManager:playSFX(sfxPath, resVolume, pitch)
	if not self:shouldPlaySfx(sfxPath) then
		return
	end

	if not resVolume or resVolume < 0 or resVolume > 1 then
		resVolume = 1
	end

	self.curSFXResVolume = resVolume

	AudioHub.PlaySFXByPath(sfxPath, 0, resVolume)
end

function AudioManager:stopSFX()
	AudioHub.StopSfx()
end

function AudioManager:playMusic(musicPath, resVolume, pitch)
	if not resVolume or resVolume < 0 or resVolume > 1 then
		resVolume = 1
	end

	self.curMusicResVolume = resVolume

	AudioHub.PlayMusicByPath(musicPath, resVolume)
end

function AudioManager:stopMusic()
	AudioHub.StopMusic()

	self.curBgm = nil
end

function AudioManager:hasPlayingMusic()
	return AudioHub.HasMusic()
end

function AudioManager:pauseMusic()
	AudioHub.PauseAudio(AudioType.Music)
end

function AudioManager:unPauseMusic()
	AudioHub.UnPauseAudio(AudioType.Music)
end

function AudioManager:playNoise(noisePath, resVolume)
	if not resVolume or resVolume < 0 or resVolume > 1 then
		resVolume = 1
	end

	self.curNoiseResVolume = resVolume

	AudioHub.PlayFloorNoiseByPath(noisePath, resVolume)
end

function AudioManager:stopNoise()
	AudioHub.StopFloorNoise()
end

function AudioManager:playUISfx(path, properity, resVolume)
	properity = properity or 0

	if not resVolume or resVolume < 0 or resVolume > 1 then
		resVolume = 1
	end

	self.curUISfxResVolume = resVolume

	AudioHub.PlayUISfxByPath(path, properity, resVolume)
end

function AudioManager:playVocal(voicePath, priority, resVolume, fashionTag)
	priority = priority or 0

	if not resVolume or resVolume < 0 or resVolume > 1 then
		resVolume = 1
	end

	self.curVocalResVolume = resVolume
	voicePath = utils.fixFashionPath(voicePath, fashionTag)

	AudioHub.PlayVoiceByPath(voicePath, priority, resVolume)
end

function AudioManager:stopVocal()
	AudioHub.StopAudio(AudioType.Vocal)
	AudioFactory.ReleaseAudioByType(AudioType.Vocal)
end

function AudioManager:setMuteByPath(path, mute)
	AudioHub.SetMuteByPath(path, mute)
end

function AudioManager:_getAudioSource(audioType)
	if not self.audioSources[audioType] then
		self.audioSources[audioType] = AudioHub.GetAudioSource(audioType)
	end

	return self.audioSources[audioType]
end

function AudioManager:changeSettingVolume(volumeType, settingBaseVolume)
	local resVolume

	if volumeType == AudioType.Music then
		resVolume = self.curMusicResVolume
	elseif volumeType == AudioType.SFX then
		resVolume = self.curSFXResVolume
	elseif volumeType == AudioType.UISfx then
		resVolume = self.curUISfxResVolume
	elseif volumeType == AudioType.Noise then
		resVolume = self.curNoiseResVolume
	elseif volumeType == AudioType.Vocal then
		resVolume = self.curVocalResVolume
	end

	resVolume = resVolume or 1

	AudioHub.SetSettingVolume(volumeType, settingBaseVolume, resVolume)
end

local function _getVolumeValue(resData, defaultData)
	if not resData then
		return defaultData
	else
		resData = resData / 10000

		return resData
	end
end

local function _getFadeValue(resData, defaultData)
	if not resData then
		return defaultData
	else
		resData = resData / 1000

		return resData
	end
end

function AudioManager:setVocalLanguage(langStr)
	AudioHub.SetVocalMultilingualism(langStr or "")
end

function AudioManager:getCurBGMId()
	return self.curBgm
end

function AudioManager:playBGMById(bgmId)
	local cueData = ResMusic[bgmId]

	if not cueData or not cueData.path then
		return
	end

	local musicPath = cueData.path
	local resVolume = _getVolumeValue(cueData.volume, 1)

	self.cacheBGMInfo = {
		mode = 1,
		bgmId = bgmId,
		musicPath = musicPath,
		resVolume = resVolume
	}

	if self.delaySwitchCoroutine then
		coroutine.stop(self.delaySwitchCoroutine)

		self.delaySwitchCoroutine = nil
	end

	self.delaySwitchCoroutine = coroutine.start(self.delaySwitchBGM, self)
end

function AudioManager:switchBGM(bgmId)
	if self.curBgm and self.curBgm == bgmId then
		self:revertBGMVolumeImmediately()

		return
	end

	local preFadeout = 0
	local preFadeoutVolume = 0

	if self.curBgm then
		local preCueData = ResMusic[self.curBgm]

		if preCueData then
			preFadeout = _getFadeValue(preCueData.fadeout, 0)
			preFadeoutVolume = _getVolumeValue(preCueData.fadeoutvolume, 0)
		end
	end

	local nextCueData = ResMusic[bgmId]

	if not nextCueData or not nextCueData.path then
		return
	end

	local musicPath = nextCueData.path
	local resVolume = _getVolumeValue(nextCueData.volume, 1)
	local fadein = _getFadeValue(nextCueData.fadein, 0)
	local fadeEase = Const.TWEEN_EASE.InOutQuad

	self.cacheBGMInfo = {
		mode = 2,
		bgmId = bgmId,
		musicPath = musicPath,
		preFadeout = preFadeout,
		preFadeoutVolume = preFadeoutVolume,
		fadein = fadein,
		resVolume = resVolume,
		fadeEase = fadeEase
	}

	if self.delaySwitchCoroutine then
		coroutine.stop(self.delaySwitchCoroutine)

		self.delaySwitchCoroutine = nil
	end

	self.delaySwitchCoroutine = coroutine.start(self.delaySwitchBGM, self)
end

function AudioManager:delaySwitchBGM()
	coroutine.step()

	if not self.cacheBGMInfo then
		return
	end

	if self.cacheBGMInfo.bgmId ~= self.curBgm then
		if self.cacheBGMInfo.mode == 1 then
			self:setBGMVolume(self.cacheBGMInfo.resVolume, 0)
			self:playMusic(self.cacheBGMInfo.musicPath, self.cacheBGMInfo.resVolume)
		else
			self.curMusicResVolume = self.cacheBGMInfo.resVolume

			AudioHub.SwitchMusic(self.cacheBGMInfo.musicPath, self.cacheBGMInfo.preFadeout, self.cacheBGMInfo.preFadeoutVolume, self.cacheBGMInfo.fadein, self.cacheBGMInfo.resVolume, self.cacheBGMInfo.fadeEase)
		end

		self.curBgm = self.cacheBGMInfo.bgmId
	elseif self.cacheBGMInfo.bgmId == self.curBgm then
		self:revertBGMVolumeImmediately()
	end

	self.cacheBGMInfo = nil
end

function AudioManager:clearBGMCache()
	self.cacheBGMInfo = nil
end

function AudioManager:getBGMVolume()
	local source = self:_getAudioSource(AudioType.Music)

	if source then
		return source.volume
	end
end

function AudioManager:setBGMVolume(resVolume, duration, fadeMode)
	resVolume = resVolume or 1
	fadeMode = fadeMode or Const.TWEEN_EASE.InOutQuad
	self.curMusicResVolume = resVolume

	AudioHub.FadeOutBGM(duration, resVolume, fadeMode)
end

function AudioManager:revertBGMVolume(duration, fadeMode)
	if not self.curBgm then
		return
	end

	local cueData = ResMusic[self.curBgm]

	if not cueData then
		return
	end

	local resVolume = _getVolumeValue(cueData.volume, 1)

	fadeMode = fadeMode or Const.TWEEN_EASE.InOutQuad
	self.curMusicResVolume = resVolume

	AudioHub.FadeOutBGM(duration, resVolume, fadeMode)
end

function AudioManager:revertBGMVolumeImmediately()
	if not self.curBgm then
		return
	end

	local cueData = ResMusic[self.curBgm]

	if not cueData then
		return
	end

	local resVolume = _getVolumeValue(cueData.volume, 1)

	self.curMusicResVolume = resVolume

	AudioHub.SetSourceVolume(AudioType.Music, resVolume)
end

function AudioManager:setBGMLoop(isLoop)
	local source = self:_getAudioSource(AudioType.Music)

	if source then
		source.loop = isLoop
	end
end

function AudioManager:playNoiseById(noiseId)
	local cueData = ResBgNoise[noiseId]

	if not cueData or not cueData.path then
		return
	end

	local noisePath = cueData.path
	local resVolume = _getVolumeValue(cueData.volume, 1)

	self:playNoise(noisePath, resVolume)
end

function AudioManager:playVocalById(vocalId, logicPriority, fashionTag)
	local cueData = ResVoiceConfig[tonumber(vocalId)]

	if not cueData or not cueData.path then
		return
	end

	local voicePath = cueData.path
	local resVolume = _getVolumeValue(cueData.volume, 1)
	local priority = logicPriority or cueData.priority or 0

	self:playVocal(voicePath, priority, resVolume, fashionTag)
end

function AudioManager:initLackVocalPaths()
	AudioHub.SetLackVocals(LackVocal)
end

function AudioManager:initAudioGroup()
	self.groupIdDict = {}

	local clipList = {}
	local weightList = {}
	local volumeList = {}
	local priorityList = {}

	for groupId, groupInfo in pairs(ResAudioGroup) do
		self.groupIdDict[groupId] = true
		clipList = {}
		weightList = {}
		volumeList = {}
		priorityList = {}

		for index, audioInfo in ipairs(groupInfo) do
			table.insert(clipList, audioInfo.path or "")
			table.insert(weightList, audioInfo.weight or "0")
			table.insert(volumeList, audioInfo.volume or "10000")
			table.insert(priorityList, audioInfo.priority or "-1")
		end

		AudioHub.InitAudioGroups(groupId, clipList, weightList, volumeList, priorityList)
	end
end

function AudioManager:hasGroup(groupId)
	return self.groupIdDict[groupId] ~= nil
end

function AudioManager:playSFXGroup(groupId)
	if self.groupIdDict[groupId] then
		AudioHub.RandomPlayInAudioGroup(groupId, AudioType.SFX)
	end
end

function AudioManager:playVocalGroup(groupId)
	if self.groupIdDict[groupId] then
		AudioHub.RandomPlayInAudioGroup(groupId, AudioType.Vocal)
	end
end

function AudioManager:_getFootprintGroupId(heroId, footstepFix)
	return heroId * 10 + footstepFix
end

function AudioManager:getFootStepGroup(heroId)
	local fixedGroupId = self:_getFootprintGroupId(heroId, AudioManager.FootStepSubGroupId)

	if self.groupIdDict[fixedGroupId] then
		return fixedGroupId
	else
		return self:_getFootprintGroupId(1, AudioManager.FootStepSubGroupId)
	end
end

function AudioManager:initPingPongTable()
	self.sfxPingPongDict = {}
end

function AudioManager.judgeHit(oldValue, newValue)
	return newValue - oldValue > 0.1
end

function AudioManager:shouldPlaySfx(sfxPath)
	if not self.sfxPingPongDict[sfxPath] then
		self.sfxPingPongDict[sfxPath] = PingPongTable()
	end

	return self.sfxPingPongDict[sfxPath]:hitOne(Time.realtimeSinceStartup, AudioManager.judgeHit)
end

function AudioManager:setSfxSpeed(speed)
	AudioHub.SetPitch(AudioType.SFX, speed)
end

return AudioManager
