-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/audio/AudioPlayerEx.lua

module(..., package.seeall)

local AudioPlayerEx = class("AudioPlayerEx")

AudioPlayerEx.isInitialized = false

function AudioPlayerEx:ctor()
	self._audioCfg = nil

	local versionCode = checknumber(BootstrapUtil.getGameVersionCode())

	if (Framework.OSDef.RunOS == Framework.OSDef.Android and versionCode >= 1100 or Framework.OSDef.RunOS == Framework.OSDef.IOS and versionCode >= 1100 or Framework.OSDef.isEditor or nil) and true or BootstrapLauncher.instance.__VERSION and BootstrapLauncher.instance.__VERSION >= 1 then
		usingnow("bootstrap.BootstrapOnlineResMgr", "BootstrapOnlineResMgr")

		self._hasUpdateAndReload = false

		if BootstrapOnlineResMgr.instance.CheckAndDownloadBankAssetsWithEvtName then
			self._hasUpdateAndReload = true
		end
	end
end

function AudioPlayerEx:init()
	if AudioPlayerEx.isInitialized then
		return
	end

	if Framework.OSDef.isEditor then
		FMODUnity.Settings.Instance.LoggingLevel = FMOD.DEBUG_FLAGS.ERROR or FMOD.DEBUG_FLAGS.NONE
	end

	FMODUnity.Settings.Instance.BankLoadType = FMODUnity.BankLoadType.None

	local starterGO = goutil.find("AoUnityStarter")
	local fmodMgr = FmodAudioMgr.Get(starterGO)

	self._fmodMgr = fmodMgr
	AudioPlayerEx.isInitialized = true

	ConfigMgr.instance:requestConfig("audio", self)

	self._isNewVersion = false

	local versionCode = checknumber(BootstrapUtil.getGameVersionCode())

	if Framework.OSDef.RunOS == Framework.OSDef.Android and versionCode > GameEnum.VERSION_ANDROID_20240513 or Framework.OSDef.RunOS == Framework.OSDef.IOS and versionCode > GameEnum.VERSION_IOS_20240513 or Framework.OSDef.isEditor then
		self._isNewVersion = true
		self._fmodMgr.framesToWait = 2
	end

	local evt2bankDicJson = CommonPreloader.instance:getConfigAsset("config/event2bank_dict.txt")

	fmodMgr:InitEvent2BankDict(evt2bankDicJson.text)
	GlobalDispatcher:addListener(GlobalNotify.ApplicationPause, self._onHandleOnApplicationPause, self)
	GlobalDispatcher:addListener(GlobalNotify.ApplicationResume, self._onHandleOnApplicationResume, self)
end

function AudioPlayerEx:handleConfig(name, content)
	if name == "audio" then
		self._audioCfg = content
	end
end

function AudioPlayerEx:getAudioEvtNameById(audioId)
	local co = self._audioCfg[audioId]

	if co then
		return co.evtName
	end
end

function AudioPlayerEx:playEffect(audioId)
	if not self._audioCfg then
		return
	end

	local co = self._audioCfg[audioId]

	if not co then
		printError("音效表中没有该音效配置,audioId=", audioId)
	else
		if isInEditorMode then
			printWarn("AudioPlayerEx playEffect:", co.evtName)
		end

		if self._hasUpdateAndReload and not BootstrapOnlineResMgr.instance:CheckAndDownloadBankAssetsWithEvtName(self._fmodMgr, co.evtName) then
			return
		end

		return (self._fmodMgr:PlayOneShot(co.evtName))
	end
end

function AudioPlayerEx:playEffectByEvtName(evtName, scale, callBack, callBackObj)
	if self._hasUpdateAndReload and not BootstrapOnlineResMgr.instance:CheckAndDownloadBankAssetsWithEvtName(self._fmodMgr, evtName) then
		return
	end

	local volum = AudioPlayerEx.instance:getAudioVolume()

	if self._isNewVersion and volum > 0.01 then
		self._fmodMgr:PlayOneShotAttachWithCallBack(evtName, volum, nil, false, scale or 1, callBack)
	else
		local evt = self._fmodMgr:PlayOneShot(evtName, scale or 1)

		if callBack then
			if callBackObj then
				callBack(callBackObj, evt)
			else
				callBack(evt)
			end
		end
	end
end

function AudioPlayerEx:playOneShotAttach(evtName, volume, scale, callBack, callBackObj)
	if self._hasUpdateAndReload and not BootstrapOnlineResMgr.instance:CheckAndDownloadBankAssetsWithEvtName(self._fmodMgr, evtName) then
		return
	end

	if self._isNewVersion and volume > 0.01 then
		self._fmodMgr:PlayOneShotAttachWithCallBack(evtName, volume, nil, false, scale or 1, callBack)
	else
		local evt = self._fmodMgr:PlayOneShotAttach(evtName, volume, nil, false, scale or 1)

		if callBack then
			if callBackObj then
				callBack(callBackObj, evt)
			else
				callBack(evt)
			end
		end
	end
end

function AudioPlayerEx:stopEvent(evt)
	if not evt then
		return
	end

	self._fmodMgr:StopEvent(evt)
end

function AudioPlayerEx:CheckLoadBankAfterFrame(bankName)
	if self._hasUpdateAndReload and not BootstrapOnlineResMgr.instance:CheckAndDownloadBankAssets(bankName) then
		return
	end

	if self.isInitialized then
		if self._isNewVersion then
			self._fmodMgr:CheckLoadBankAfterFrame(bankName)
		else
			self._fmodMgr:CheckLoadBank(bankName)
		end
	end
end

function AudioPlayerEx:playVoice(audioId, finishCallback, finishCallbackObj, autoResumeBgm)
	local co = self._audioCfg[audioId]

	if not co then
		printError("音效表中没有该音效配置,audioId=", audioId)
	else
		if isInEditorMode then
			printWarn("AudioPlayerEx playVoice:", co.evtName)
		end

		if self._hasUpdateAndReload and not BootstrapOnlineResMgr.instance:CheckAndDownloadBankAssetsWithEvtName(self._fmodMgr, co.evtName) then
			return
		end

		AudioVoicePlayer.instance:playVoiceByEvt(co.evtName, finishCallback, finishCallbackObj, autoResumeBgm)
	end
end

function AudioPlayerEx:stopVoice(audioId)
	local co = self._audioCfg[audioId]

	if not co then
		printError("音效表中没有该音效配置,audioId=", audioId)
	else
		if isInEditorMode then
			printWarn("AudioPlayerEx stopVoice:", co.evtName)
		end

		self:stopVoiceByEvtName(co.evtName)
	end
end

function AudioPlayerEx:playVoiceByEvtName(evtName)
	if self._hasUpdateAndReload and not BootstrapOnlineResMgr.instance:CheckAndDownloadBankAssetsWithEvtName(self._fmodMgr, evtName) then
		return
	end

	self._fmodMgr:PlayVoice(evtName)
end

function AudioPlayerEx:stopVoiceByEvtName(evtName)
	self._fmodMgr:StopVoice(evtName)
end

function AudioPlayerEx:playMusic(audioId)
	local co = self._audioCfg[audioId]

	if not co then
		printError("音效表中没有该音效配置,audioId=", audioId)
	else
		if isInEditorMode then
			printWarn("AudioPlayerEx playBgm:", co.evtName)
		end

		AudioBgmPlayer.instance:playMusicByEvt(co.evtName)
	end
end

function AudioPlayerEx:playMusicByEvtName(evtName)
	if self._hasUpdateAndReload and not BootstrapOnlineResMgr.instance:CheckAndDownloadBankAssetsWithEvtName(self._fmodMgr, evtName) then
		return
	end

	if self._isNewVersion then
		self._fmodMgr:PlayMusicAfterFrame(evtName)
	else
		self._fmodMgr:PlayMusic(evtName)
	end
end

function AudioPlayerEx:stopMusic(audioId)
	local co = self._audioCfg[audioId]

	if not co then
		printError("不存在的背景音乐配置,audioId=", audioId)
	else
		if isInEditorMode then
			printWarn("AudioPlayerEx stopMusic:", co.evtName)
		end

		self:stopMusicByEvtName(co.evtName)
	end
end

function AudioPlayerEx:stopMusicByEvtName(evtName)
	self._fmodMgr:StopMusic(evtName)
end

function AudioPlayerEx:pauseMusic(audioId, isPaused)
	local co = self._audioCfg[audioId]

	if not co then
		printError("不存在的背景音乐配置,audioId=", audioId)
	else
		if isInEditorMode then
			printWarn("AudioPlayerEx stopMusic:", co.evtName)
		end

		self._fmodMgr:SetMusicPaused(co.evtName, isPaused)
	end
end

function AudioPlayerEx:setAudioVolume(value)
	self._fmodMgr:SetBusVolume("bus:/sound/UI", value)
	self._fmodMgr:SetBusVolume("bus:/sound/weapon", value)
	self._fmodMgr:SetAudioVolume(value)
end

function AudioPlayerEx:setVoiceVolume(value)
	self._fmodMgr:SetBusVolume("bus:/speech/CV", value)
	self._fmodMgr:SetBusVolume("bus:/speech/battle_voc", value)
	self._fmodMgr:SetVoiceVolume(value)
end

function AudioPlayerEx:setMusicVolume(value)
	self._fmodMgr:SetBusVolume("bus:/music/BGM_Scenes", value)
	self._fmodMgr:SetBusVolume("bus:/music/BGM_Fight", value)
	self._fmodMgr:SetMusicVolume(value)
end

function AudioPlayerEx:setVolume(value)
	self._fmodMgr:SetVolume(value)
	VideoFacade.instance:setVideoVolume(self:getMusicVolume())
end

function AudioPlayerEx:getMusicVolume()
	return self._fmodMgr:GetMusicVolume()
end

function AudioPlayerEx:getAudioVolume()
	return self._fmodMgr:GetAudioVolume()
end

function AudioPlayerEx:getVoiceVolume()
	return self._fmodMgr:GetVoiceVolume()
end

function AudioPlayerEx:getAudioLength(audioId)
	local co = self._audioCfg[audioId]

	if not co then
		printError("音效表中没有该音效配置,audioId=", audioId)

		return 0
	else
		return self._fmodMgr:GetAudioLength(co.evtName)
	end
end

function AudioPlayerEx:getAudioLengthByEvt(evtName)
	local res, audioLen = pcall(self._fmodMgr.GetAudioLength, self._fmodMgr, evtName)

	if not res then
		return 0
	end

	return audioLen
end

function AudioPlayerEx:saveToLocalStorage()
	self._fmodMgr:SaveToLocalStorage()
	VideoFacade.instance:setVideoVolume(self:getMusicVolume())
end

function AudioPlayerEx:pause(pause)
	if self._fmodMgr then
		self._fmodMgr:Pause(pause)
	else
		printWarn("AudioPlayerEx:pause() - Fmod还未初始化好。")
	end
end

function AudioPlayerEx:_onHandleOnApplicationPause()
	self:pause(true)
end

function AudioPlayerEx:_onHandleOnApplicationResume()
	self:pause(false)
end

AudioPlayerEx.instance = AudioPlayerEx.New()

return AudioPlayerEx
