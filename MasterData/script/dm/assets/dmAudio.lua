-- chunkname: @/tmp/or_script/lua_compile/dm/assets/dmAudio.lua

local relativePath = "sound/"
local soundTableName = "Sound"
local soundExtension = ".acb"

AudioType = {
	CVEffect = 3,
	Effect = 2,
	Music = 1
}

local AudioPlayer = {}
local audioPackages = {}

AudioPlayer[AudioType.Music] = nil
AudioPlayer[AudioType.Effect] = nil
AudioPlayer[AudioType.CVEffect] = nil

local audioDirector
local audioPlaybackMap = {}

AudioPackage = AudioPackage or {}

function AudioPackage:new(audioPackHnInfo)
	local audioPackage = setmetatable({}, {
		__index = AudioPackage
	})

	audioPackage:initialize(audioPackHnInfo)

	return audioPackage
end

function AudioPackage:getAudioPackHnInfo()
	return self._audioPackHnInfo
end

function AudioPackage:getRefCount()
	return self._refCount
end

function AudioPackage:getResident()
	return self._resident
end

function AudioPackage:setResident(value)
	self._resident = value
end

function AudioPackage:initialize(audioPackHnInfo)
	self._audioPackHnInfo = audioPackHnInfo
	self._refCount = 0
	self._resident = false
end

function AudioPackage:dispose()
	super.dispose(self)
end

function AudioPackage:retain()
	if self._refCount then
		self._refCount = self._refCount + 1
	end
end

function AudioPackage:release()
	if self._refCount then
		self._refCount = self._refCount - 1
	end
end

dmAudio = dmAudio or {}

function dmAudio.startupWithAcfFile(filepath)
	if dmAudio._isStarted then
		return
	end

	if filepath == nil then
		return
	end

	local crilibConfig = {
		max_audio_streams = 128,
		max_virtual_voices = 64
	}

	if DEBUG ~= 2 and app.pkgConfig.showLuaError == 1 then
		crilibConfig.enable_atom_monitor = true
	end

	cri.createLibraryContext(crilibConfig)

	local voicePoolConfig = {
		num_voices = 32,
		player_config = {
			max_sampling_rate = 96000
		}
	}

	audioDirector = cri.AudioDirector:getInstance()

	audioDirector:createStandardVoicePool(voicePoolConfig)

	local musicConfig = {}
	local effectConfig = {}
	local cveffectConfig = {}

	AudioPlayer[AudioType.Music] = audioDirector:createAudioPlayer(musicConfig)

	AudioPlayer[AudioType.Music]:retain()

	AudioPlayer[AudioType.Effect] = audioDirector:createAudioPlayer(effectConfig)

	AudioPlayer[AudioType.Effect]:retain()

	AudioPlayer[AudioType.CVEffect] = audioDirector:createAudioPlayer(cveffectConfig)

	AudioPlayer[AudioType.CVEffect]:retain()

	dmAudio._isStarted = true

	return audioDirector:registerAcfFile(filepath)
end

function dmAudio.destroy()
	if not dmAudio._isStarted then
		return
	end

	AudioPlayer[AudioType.Music]:release()

	AudioPlayer[AudioType.Music] = nil

	AudioPlayer[AudioType.Effect]:release()

	AudioPlayer[AudioType.Effect] = nil

	AudioPlayer[AudioType.CVEffect]:release()

	AudioPlayer[AudioType.CVEffect] = nil

	audioDirector:unregisterAcf()
	audioDirector:destroyInstance()

	dmAudio._isStarted = nil
end

function dmAudio.play(configId, param, listener, type)
	if not dmAudio._isStarted then
		return
	end

	if DEBUG ~= nil and DEBUG > 1 then
		assert(configId ~= nil, "dmAudio.play, configId is nil")
	elseif configId == nil then
		return
	end

	local record = ConfigReader:getRecordById(soundTableName, configId)

	if DEBUG ~= nil and DEBUG > 1 then
		assert(record ~= nil and record.PkgName ~= nil and record.PkgName ~= "" and record.CueName ~= nil and record.PkgName ~= "", "dmAudio.play config is error! configId=" .. tostring(configId))
	elseif record == nil or record.PkgName == nil or record.PkgName == "" or record.CueName == nil or record.PkgName == "" then
		return
	end

	local fileUtils = cc.FileUtils:getInstance()
	local filePath = table.concat({
		relativePath,
		record.PkgName,
		soundExtension
	}, "")

	if not fileUtils:isFileExist(filePath) then
		return
	end

	local uriStrArr = {}

	uriStrArr[1] = record.PkgName
	uriStrArr[2] = "?cueName="
	uriStrArr[3] = record.CueName

	if record.Param and record.Param ~= "" and param then
		uriStrArr[4] = "&"

		local tempArr = {}

		for k, v in pairs(record.Param) do
			tempArr[#tempArr + 1] = k .. "=" .. v
		end

		uriStrArr[5] = table.concat(tempArr, "&")
	end

	local uri = table.concat(uriStrArr, "")

	if type == AudioType.Music then
		if uri == dmAudio.currentMusicUri then
			return
		else
			dmAudio.stop(dmAudio.currentMusicPlaybackId)
		end
	end

	local audioPlayer = AudioPlayer[type]
	local acbHn = dmAudio.loadAcbFile(record.PkgName)
	local audioPlayback = audioPlayer:playCueByNameFromBlock(acbHn, record.CueName, (record.Param and record.Param.blockIndex or nil) and record.Param.blockIndex)

	if audioPlayback then
		if type == AudioType.Music then
			dmAudio.currentMusicPlaybackId = audioPlayback
			dmAudio.currentMusicUri = uri
		end
	elseif DEBUG ~= nil and DEBUG > 1 then
		assert(audioPlayback ~= nil, "dmAudio.play(configId, param, listener), audioPlayback is nil, configId: " .. tostring(configId))
	elseif audioPlayback == nil then
		dmAudio.releaseAcb(record.PkgName)

		return
	end

	audioPlayback:setListener(function(playback, event)
		audioPlayback:setListener(nil)

		audioPlaybackMap[audioPlayback] = nil

		if event == cri.AUDIO_EVENT_ERROR or event == cri.AUDIO_EVENT_STOPPED or event == cri.AUDIO_EVENT_BROKEN or event == cri.AUDIO_EVENT_REJECTED then
			dmAudio.releaseAcb(record.PkgName)

			if listener then
				listener(playback, event)
			end
		end
	end)

	if audioPlayback then
		audioPlayback._pkgName = record.PkgName
	end

	if GameConfigs.showAudioId then
		print("AudioConfigId::", configId)
	end

	audioPlaybackMap[audioPlayback] = true

	return audioPlayback
end

function dmAudio.stop(audioPlayback)
	if audioPlayback == nil then
		return
	end

	if audioPlayback == dmAudio.currentMusicPlaybackId then
		dmAudio.currentMusicPlaybackId = nil
		dmAudio.currentMusicUri = nil
	end

	if audioPlayback and audioPlayback._pkgName then
		audioPlayback:setListener(function(playback, event)
			audioPlaybackMap[audioPlayback] = nil

			if (event == cri.AUDIO_EVENT_ERROR or event == cri.AUDIO_EVENT_STOPPED or event == cri.AUDIO_EVENT_BROKEN or event == cri.AUDIO_EVENT_REJECTED) and dmAudio and dmAudio.releaseAcb then
				audioPlayback:setListener(nil)
				dmAudio.releaseAcb(audioPlayback._pkgName)
			end
		end)
	end

	audioPlayback:stop()
end

function dmAudio.pause(audioPlayback)
	if audioPlayback == nil then
		return
	end

	audioPlayback:pause()
end

function dmAudio.resume(audioPlayback)
	if audioPlayback == nil then
		return
	end

	audioPlayback:resume()
end

function dmAudio.setAisac(audioPlayback, key, value)
	if audioPlayback == nil then
		return
	end

	audioPlayback:setAisacControlByName(key, value)
end

function dmAudio.setAisacByID(configId, playbackId)
	playbackId = playbackId or dmAudio.currentMusicPlaybackId

	if DEBUG > 0 then
		assert(playbackId, "playbackId不能为空")
	elseif not playbackId then
		return
	end

	local record = ConfigReader:getRecordById("SoundAISAC", configId)

	dmAudio.setAisac(playbackId, record.AisacKey, record.AisacValue)
end

function dmAudio.setBlockIndex(audioPlayback, blockIndex)
	audioPlayback = audioPlayback or dmAudio.currentMusicPlaybackId

	if DEBUG > 0 then
		assert(audioPlayback, "playbackId不能为空")
	elseif not audioPlayback then
		return
	end

	if audioPlayback == nil then
		return
	end

	audioPlayback:setNextBlockIndex(blockIndex)
end

function dmAudio.setLoop(audioPlayback, value)
	if audioPlayback == nil then
		return
	end

	local loop = value == true and -3 or -1
	local audioPlayer = audioPlayback:getPlayer()

	if audioPlayer then
		audioPlayer:limitLoopCount(loop)
	end
end

function dmAudio.setVolume(value, audioType)
	if audioType and AudioPlayer[audioType] then
		AudioPlayer[audioType]:setVolume(value)
	else
		for _, v in pairs(AudioPlayer) do
			v:setVolume(value)
		end
	end
end

function dmAudio.stopAll(audioType)
	if audioType then
		if audioType == AudioType.Music then
			dmAudio.currentMusicPlaybackId = nil
			dmAudio.currentMusicUri = nil
		end

		AudioPlayer[audioType]:stop()
	else
		for _, v in pairs(AudioPlayer) do
			if v == AudioType.Music then
				dmAudio.currentMusicPlaybackId = nil
				dmAudio.currentMusicUri = nil
			end

			v:stop()
		end
	end
end

function dmAudio.pauseAll(audioType)
	if audioType and AudioPlayer[audioType] then
		AudioPlayer[audioType]:pause()
	else
		for _, v in pairs(AudioPlayer) do
			v:pause()
		end
	end
end

function dmAudio.resumeAll(audioType)
	if audioType and AudioPlayer[audioType] then
		AudioPlayer[audioType]:resume()
	else
		for _, v in pairs(AudioPlayer) do
			v:resume()
		end
	end
end

function dmAudio.setAcbFileIsResident(packageName, resident)
	if packageName == nil then
		if DEBUG ~= nil and DEBUG > 1 then
			assert(packageName ~= nil, "dmAudio.setAcbFileIsResident(packageName, resident), packageName is nil")
		elseif packageName == nil then
			return
		end
	end

	local audioPackage = audioPackages[packageName]

	if DEBUG ~= nil and DEBUG > 1 then
		assert(audioPackage ~= nil, "dmAudio.setAcbFileIsResident(packageName, resident), audioPackage is nil")
	elseif audioPackage == nil then
		return
	end

	if DEBUG ~= nil and DEBUG > 1 then
		assert(resident ~= nil, "dmAudio.setAcbFileIsResident(packageName, resident), resident is nil")
	else
		resident = resident or false
	end

	audioPackage:setResident(resident)
end

function dmAudio.loadAcbFile(packageName)
	if packageName == nil then
		return
	end

	local filePath = table.concat({
		relativePath,
		packageName,
		soundExtension
	}, "")
	local acbHn
	local audioPackage = audioPackages[packageName]

	if audioPackage == nil then
		acbHn = audioDirector:loadAcbFile(filePath)
		audioPackage = AudioPackage:new(acbHn)
		audioPackages[packageName] = audioPackage
	else
		acbHn = audioPackage:getAudioPackHnInfo()
	end

	audioPackage:retain()

	return acbHn
end

function dmAudio.releaseAllAcbs()
	audioPackages = {}

	audioDirector:releaseAllAcbs()
end

function dmAudio.releaseAcb(packageName)
	if DEBUG ~= nil and DEBUG > 1 then
		assert(packageName ~= nil, "dmAudio.releaseAcb(packageName), packageName is nil")
	elseif packageName == nil then
		return
	end

	local audioPackage = audioPackages[packageName]

	if audioPackage == nil then
		return
	end

	audioPackage:release()

	if audioPackage:getRefCount() == 0 and audioPackage:getResident() == false then
		if openGCLog then
			print("release audio package:" .. tostring(packageName) .. ", ref=" .. tostring(audioPackage:getRefCount()) .. ", resident=" .. tostring(audioPackage:getResident()))
		end

		audioDirector:releaseAcb(audioPackage:getAudioPackHnInfo())

		audioPackages[packageName] = nil
	end
end

function dmAudio.unregisterAcf()
	audioDirector:unregisterAcf()
end

function dmAudio.isPlaying(audioPlayback)
	if audioPlayback == nil then
		return false
	end

	return audioDirector:getStatus() == 2
end
