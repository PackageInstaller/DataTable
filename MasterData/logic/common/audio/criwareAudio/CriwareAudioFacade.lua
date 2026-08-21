-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/audio/criwareAudio/CriwareAudioFacade.lua

module("logic.common.audio.criwareAudio.CriwareAudioFacade", package.seeall)

local M = class("CriwareAudioFacade", BaseFacade)

M.AudioType = {
	SE = 2,
	BGM = 1,
	VOICE = 3,
	NONE = 0
}

function M:playBgmInnerById(bgmId, callBack, handler)
	local currentBgmId = CriwareAudioPlayer.instance:getCurrentBgmId()

	if currentBgmId and currentBgmId ~= 0 then
		if currentBgmId ~= bgmId then
			CriwareAudioPlayer.instance:stopSoundById(currentBgmId)
			CriwareAudioPlayer.instance:playBgm(bgmId, callBack, handler)
		end
	else
		CriwareAudioPlayer.instance:playBgm(bgmId, callBack, handler)
	end
end

function M:PlayBgmInnerBgName(bgmName, callBack, handler)
	local audioCO = CriwareAudioConfig.instance:getCOByName(bgmName)

	if audioCO then
		local bgmId = audioCO.code

		self:playBgmInnerById(bgmId, callBack, handler)
	end
end

function M:setBgmNextBlockIndex(index)
	CriwareAudioPlayer.instance:setBgmNextBlockIndex(index)
end

function M:setEnvironmentNextBlockIndex(index)
	CriwareAudioPlayer.instance:setEnvironmentNextBlockIndex(index)
end

function M:stopBgm()
	CriwareAudioPlayer.instance:stopAllBgm()
end

function M:playSEById(seId, gameObject, seName, callBack, handler)
	if not seId then
		printWarn("cloud not play nil sound id")

		return
	end

	local isAmb = false
	local isVoice = false

	if not seName then
		local audioCO = CriwareAudioConfig.instance:getAudioCOById(seId)

		if audioCO then
			seName = audioCO.cueName
		end
	end

	if type(seName) == "string" and not string.nilorempty(seName) then
		isAmb = string.starts(seName, "amb_")
		isVoice = string.starts(seName, "speech_")
	end

	if isAmb then
		self:playEnvironmentById(seId, callBack, handler)
	elseif isVoice then
		self:playVoiceById(seId, callBack, handler)
	else
		CriwareAudioPlayer.instance:playSESound(seId, gameObject, callBack, handler)
	end
end

function M:playSEByName(seName, gameObject, callBack, handler)
	local audioCO = CriwareAudioConfig.instance:getCOByName(seName)

	if audioCO then
		local seId = audioCO.code

		self:playSEById(seId, gameObject, callBack, handler)
	end
end

function M:playVoiceById(voiceId, gameObject, callBack, handler)
	self:stopVoice()
	CriwareAudioPlayer.instance:playVoiceSound(voiceId, callBack, handler)
	self:_onVoicePlay(nil, voiceId)
end

function M:playVoiceByKeyAndCode(key, code, gameObject, callBack, handler)
	local voiceName = string.format(key, code)

	self:playVoiceByName(voiceName, gameObject, callBack, handler)
end

function M:playVoiceByName(voiceName, gameObject, callBack, handler)
	local audioCO = CriwareAudioConfig.instance:getCOByName(voiceName)

	if audioCO then
		local voiceId = audioCO.code

		self:playVoiceById(voiceId, gameObject, callBack, handler)
	end

	return audioCO and true or false
end

function M:playEnvironmentById(soundId, callBack, handler)
	local currentEnvironmentId = CriwareAudioPlayer.instance:getCurrentEnvironmentId()

	if currentEnvironmentId and currentEnvironmentId ~= 0 then
		if currentEnvironmentId ~= soundId then
			CriwareAudioPlayer.instance:stopSoundById(currentEnvironmentId)
			CriwareAudioPlayer.instance:playEnvironmentSound(soundId, callBack, handler)
		end
	else
		CriwareAudioPlayer.instance:playEnvironmentSound(soundId, callBack, handler)
	end
end

function M:playEnvironmentByName(voiceName, callBack, handler)
	local audioCO = CriwareAudioConfig.instance:getCOByName(voiceName)

	if audioCO then
		local soundId = audioCO.code

		self:playEnvironmentById(soundId, callBack, handler)
	end
end

function M:stopCurrentEnvironment()
	local currentEnvironmentId = CriwareAudioPlayer.instance:getCurrentEnvironmentId()

	if currentEnvironmentId and currentEnvironmentId ~= 0 then
		CriwareAudioPlayer.instance:stopSoundById(currentEnvironmentId)
	end
end

function M:playOnceSEbyId(seId, gameObject, callBack, handler)
	CriwareAudioPlayer.instance:stopSoundById(seId)
	self:playSEById(seId, gameObject, callBack, handler)
end

function M:stopSoundById(id)
	CriwareAudioPlayer.instance:stopSoundById(id)
end

function M:stopSoundByByName(cueName)
	local audioCO = CriwareAudioConfig.instance:getCOByName(cueName)

	if audioCO then
		self:stopSoundById(audioCO.code)
	end
end

function M.playSESimpleByName(seName)
	local audioCO = CriwareAudioConfig.instance:getCOByName(seName)

	if audioCO then
		local seId = audioCO.code

		CriwareAudioFacade.instance:playOnceSEbyId(seId, nil, nil, nil)
	end
end

function M:playOnceSEByName(seName, gameObject, callBack, handler)
	local audioCO = CriwareAudioConfig.instance:getCOByName(seName)

	if audioCO then
		local seId = audioCO.code

		self:playOnceSEbyId(seId, gameObject, callBack, handler)
	end
end

function M:stopSoundByName(name)
	local audioCO = CriwareAudioConfig.instance:getCOByName(name)

	if audioCO then
		local seId = audioCO.code

		CriwareAudioPlayer.instance:stopSoundById(seId)
	end
end

function M:playVoiceByAudioId(audioId, heroId, callBack, handler)
	local isPlaySuc = false
	local voiceRes = CharacterInfoEnum.VoiceRes[audioId]

	if not voiceRes then
		local audioCO = CharacterAudioConfig.instance:getCharacterAudioCOByHeroIdAndAudioId(heroId, audioId)

		if audioCO then
			voiceRes = audioCO.voiceId
		end
	else
		voiceRes = string.format(voiceRes, heroId)
	end

	if voiceRes then
		self:stopVoice()

		isPlaySuc = self:playVoiceByName(voiceRes, nil, callBack, handler)
	end

	return isPlaySuc
end

function M:stopVoice()
	CriwareAudioPlayer.instance:stopAllVoiceSound()
	GlobalDispatcher:dispatchEvent(EventType.ON_VOICE_STOP)
end

function M:_onVoicePlay(voiceRes, voiceId)
	local time = 0

	if not string.nilorempty(voiceRes) then
		time = self:getCueTotalTimeByName(voiceRes)
	elseif voiceId then
		time = self:getCueTotalTimeById(voiceId)
	end

	GlobalDispatcher:dispatchEvent(EventType.ON_VOICE_PLAY, voiceRes, voiceId, time)
end

function M:setVolumeValue()
	return
end

function M:setState(stateGroup, state)
	return
end

function M:loadCueSheet(name, acbFile, awbFile)
	local newAwbFiler = ""

	if not string.nilorempty(awbFile) then
		newAwbFiler = GameUrl.getAudioFileUrl(awbFile)
	end

	local newAcbFile = GameUrl.getAudioFileUrl(acbFile)

	CriwareAudioPlayer.instance:loadCueSheet(name, newAcbFile, newAwbFiler)
end

function M:unloadCueSheet(name)
	CriwareAudioPlayer.instance:removeCueSheet(name)
end

function M:setBgmVolume(volume)
	volume = math.max(0, volume)
	volume = math.min(1, volume)

	CriwareAudioPlayer.instance:setBgmVolume(volume)
	Astral.LocalStorage.Instance:SetFloat("BgmVolume", volume)
end

function M:setSEVolume(volume)
	volume = math.max(0, volume)
	volume = math.min(1, volume)

	CriwareAudioPlayer.instance:setSEVolume(volume)
	Astral.LocalStorage.Instance:SetFloat("SoundEffVolume", volume)
end

function M:setVoiceVolume(volume)
	volume = math.max(0, volume)
	volume = math.min(1, volume)

	CriwareAudioPlayer.instance:setVoiceVolume(volume)
	Astral.LocalStorage.Instance:SetFloat("DubVolume", volume)
end

function M:initAllVolume()
	local bgmVolume = PlayerLocalStorageModel.instance:getBgmVolume()

	CriwareAudioPlayer.instance:setBgmVolume(bgmVolume)

	local seVolume = PlayerLocalStorageModel.instance:getSoundEffVolume()

	CriwareAudioPlayer.instance:setSEVolume(seVolume)

	local voiceVolume = PlayerLocalStorageModel.instance:getDubVolume()

	CriwareAudioPlayer.instance:setVoiceVolume(voiceVolume)
end

function M:initCriware()
	CriwareAudioPlayer.instance:init()

	local acfFile = GameUrl.getAudioFileUrl("criwareproject.acf")
	local dspBusSetting = ""

	CriwareAudioPlayer.instance:RegisterAcf(acfFile, dspBusSetting)
	self:initAllVolume()
end

function M:getVolume(type)
	if type == M.AudioType.BGM then
		local bgmVolume = PlayerLocalStorageModel.instance:getBgmVolume()

		return bgmVolume
	elseif type == M.AudioType.SE then
		local seVolume = PlayerLocalStorageModel.instance:getSoundEffVolume()

		return seVolume
	elseif type == M.AudioType.VOICE then
		local voiceVolume = PlayerLocalStorageModel.instance:getDubVolume()

		return voiceVolume
	elseif enableErrorLog then
		printError("unhandle audio type", tostring(type))
	end
end

function M:setVolume(type, volume)
	if type == M.AudioType.BGM then
		self:setBgmVolume(volume)
	elseif type == M.AudioType.SE then
		self:setSEVolume(volume)
	elseif type == M.AudioType.VOICE then
		self:setVoiceVolume(volume)
	elseif enableErrorLog then
		printError("unhandle audio type", tostring(self._audioType))
	end
end

function M:getCriwareIdBySoundId(soundId)
	CriwareAudioPlayer.instance:getCriwareIdBySoundId(soundId)
end

function M:getCriwareIdByName(name)
	CriwareAudioPlayer.instance:getCriwareIdByName(name)
end

function M:getCueTotalTimeByName(soundName)
	return CriwareAudioPlayer.instance:getCueTotalTimeByName(soundName)
end

function M:getCueTotalTimeById(soundId)
	return CriwareAudioPlayer.instance:getCueTotalTimeById(soundId)
end

function M:setStartTimeById(cueId, time)
	CriwareAudioPlayer.instance:SetStartTimeById(cueId, time)
end

function M:setStartTimeByName(cueName, time)
	CriwareAudioPlayer.instance:SetStartTimeByName(cueName, time)
end

function M:setAisacControl(name, controlName, value)
	CriwareAudioPlayer.instance:setAisacControl(name, controlName, value)
end

function M:setSkillAudioSpeed(value)
	self:setAisacControl("skill_playrate", "skill_playrate", value)
end

function M:unloadOldCueSheet()
	CriwareAudioPlayer.instance:unloadOldCueSheet()
end

M.instance = M.New()

return M
