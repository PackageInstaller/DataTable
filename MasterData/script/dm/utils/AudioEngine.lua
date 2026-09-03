-- chunkname: @/tmp/or_script/lua_compile/dm/utils/AudioEngine.lua

AudioEngine = class("AudioEngine", objectlua.Object, _M)

function AudioEngine:initialize()
	super.initialize(self)

	self._simpleAudioEngine = cc.SimpleAudioEngine:getInstance()
	self._effectEnable = true
	self._bgmId = nil
	self.bgm = nil
	self._forceElide = false

	local volume = cc.UserDefault:getInstance():getStringForKey(UserDefaultKey.kMusicVolumeKey)

	volume = volume == "" and SoundVolumeMax or tonumber(volume)

	self:setMusicVolume(volume)

	local volume = cc.UserDefault:getInstance():getStringForKey(UserDefaultKey.kEffectVolumeKey)

	volume = volume == "" and SoundVolumeMax or tonumber(volume)

	self:setEffectsVolume(volume)

	local volume = cc.UserDefault:getInstance():getStringForKey(UserDefaultKey.kRoleEffectVolumeKey)

	volume = volume == "" and SoundVolumeMax or tonumber(volume)

	self:setCVEffectsVolume(volume)
end

function AudioEngine.class:getInstance()
	if __audioEngineInst == nil then
		__audioEngineInst = AudioEngine:new()
	end

	return __audioEngineInst
end

function AudioEngine:setElide(isElide)
	self._forceElide = isElide
end

function AudioEngine:getElide()
	return self._forceElide
end

function AudioEngine:setMusicOff(isOff)
	cc.UserDefault:getInstance():setBoolForKey(UserDefaultKey.kMusicOffKey, isOff)

	if not dmAudio.isMusicOff and self.bgm then
		self:playBackgroundMusic(self.bgm)
	else
		self:stopBackgroundMusic()
	end
end

function AudioEngine:setEffectOff(isOff)
	cc.UserDefault:getInstance():setBoolForKey(UserDefaultKey.kEffectOffKey, isOff)
end

function AudioEngine:getMusicOff()
	return (cc.UserDefault:getInstance():getBoolForKey(UserDefaultKey.kMusicOffKey))
end

function AudioEngine:setEffectEnable(enbale)
	self._effectEnable = enbale

	self:setEffectOff(self._effectEnable)

	if enbale then
		self:stopAllEffects()
	end
end

function AudioEngine:getEffectOff()
	return (cc.UserDefault:getInstance():getBoolForKey(UserDefaultKey.kEffectOffKey))
end

function AudioEngine:setRoleEffectOff(isOff)
	cc.UserDefault:getInstance():setBoolForKey(UserDefaultKey.kRoleEffectOffKey, isOff)
end

function AudioEngine:getRoleEffectOff()
	return (cc.UserDefault:getInstance():getBoolForKey(UserDefaultKey.kRoleEffectOffKey))
end

function AudioEngine:playBackgroundMusic(id, callback)
	self.bgm = id

	if self:getMusicOff() then
		return
	end

	if self._forceElide then
		return
	end

	local param = {}

	param.loop = false
	self._bgmId = dmAudio.play(id, param, callback, 1)

	return self._bgmId
end

function AudioEngine:setAisac(playbackId, key, value)
	if self:getMusicOff() then
		return
	end

	dmAudio.setAisac(playbackId, key, value)
end

function AudioEngine:setAisacByID(id, playbackId)
	if self:getMusicOff() then
		return
	end

	dmAudio.setAisacByID(id, playbackId)
end

function AudioEngine:getBgmId()
	return self._bgmId
end

function AudioEngine:setBlockIndex(playbackId, value)
	dmAudio.setBlockIndex(playbackId, value)
end

function AudioEngine:setBlockIndexByID(playbackId, id)
	local info = ConfigReader:requireRecordById("SoundBlock", id)

	dmAudio.setBlockIndex(playbackId, info.Block)
end

function AudioEngine:pauseBackgroundMusic()
	dmAudio.pauseAll(AudioType.Music)
end

function AudioEngine:resumeBackgroundMusic()
	dmAudio.resumeAll(AudioType.Music)
end

function AudioEngine:isBackgroundMusicPlaying()
	return dmAudio.isPlaying(dmAudio.currentMusicPlaybackId)
end

function AudioEngine:setMusicVolume(volume)
	dmAudio.setVolume(volume, AudioType.Music)
end

function AudioEngine:stopBackgroundMusic()
	dmAudio.stopAll(AudioType.Music)
end

function AudioEngine:playEffect(id, bLoop, callback)
	if self:getEffectOff() then
		if callback then
			callback()
		end

		return
	end

	local param = {}

	param.loop = bLoop

	local info = ConfigReader:requireRecordById("Sound", id)
	local includem = info.IncludeMusic

	return dmAudio.play((includem or nil) and includem[math.random(1, #includem)], param, callback, AudioType.Effect)
end

function AudioEngine:playAction(id, bLoop)
	if self:getMusicOff() then
		return
	end

	if self._forceElide then
		return
	end

	local param = {}

	param.loop = bLoop

	local info = ConfigReader:requireRecordById("Sound", id)
	local includem = info.IncludeMusic

	return dmAudio.play((includem or nil) and includem[math.random(1, #includem)], param, nil, AudioType.Effect)
end

function AudioEngine:playRoleEffect(id, bLoop, callback)
	if self:getRoleEffectOff() then
		return
	end

	if self._forceElide then
		return
	end

	local param = {}

	param.loop = bLoop

	local _id = id
	local info = ConfigReader:requireRecordById("Sound", id)
	local includem = info.IncludeMusic

	if includem then
		_id = includem[math.random(1, #includem)]
	end

	return dmAudio.play(_id, param, callback, AudioType.CVEffect), _id
end

function AudioEngine:stopEffect(id)
	dmAudio.stop(id)
end

function AudioEngine:stopAllEffects()
	dmAudio.stopAll()
end

function AudioEngine:stopEffectsByType(audioType)
	dmAudio.stopAll(audioType or AudioType.Effect)
end

function AudioEngine:setEffectsVolume(volume)
	dmAudio.setVolume(volume, AudioType.Effect)
end

function AudioEngine:setCVEffectsVolume(volume)
	dmAudio.setVolume(volume, AudioType.CVEffect)
end

function AudioEngine:getFilePathById(id)
	local info = ConfigReader:getRecordById("Sound", id)

	if info then
		return info.SoundPath
	else
		return id
	end
end
