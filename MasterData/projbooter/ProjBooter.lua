-- chunkname: @projbooter/ProjBooter.lua

module("projbooter.ProjBooter", package.seeall)

local ProjBooter = class("ProjBooter")

addGlobalModule("projbooter.utils.VersionUtil", "VersionUtil")
addGlobalModule("projbooter.native.BootNativeUtil", "BootNativeUtil")
addGlobalModule("projbooter.screen.GameAdaptionBgMgr", "GameAdaptionBgMgr")
addGlobalModule("projbooter.config.BooterLoadingConfig", "BooterLoadingConfig")
addGlobalModule("projbooter.BootResMgr", "BootResMgr")
addGlobalModule("projbooter.config.UrlConfig", "UrlConfig")
addGlobalModule("projbooter.config.GameUrlConfig", "GameUrlConfig")
addGlobalModule("projbooter.config.GameChannelConfig", "GameChannelConfig")
addGlobalModule("projbooter.config.BooterLanguageConfig", "BooterLanguageConfig")
addGlobalModule("projbooter.ui.BootMsgBox", "BootMsgBox")
addGlobalModule("projbooter.ui.BootLoadingView", "BootLoadingView")
addGlobalModule("projbooter.ui.BootNoticeView", "BootNoticeView")
addGlobalModule("projbooter.ui.BootVoiceView", "BootVoiceView")
addGlobalModule("projbooter.ui.BootVoiceNewView", "BootVoiceNewView")
addGlobalModule("projbooter.ui.BootVersionView", "BootVersionView")
addGlobalModule("projbooter.hotupdate.HotUpdateProgress", "HotUpdateProgress")
addGlobalModule("projbooter.hotupdate.HotUpdateMgr", "HotUpdateMgr")
addGlobalModule("projbooter.hotupdate.VersionValidator", "VersionValidator")
addGlobalModule("projbooter.hotupdate.VoiceHttpGetter", "VoiceHttpGetter")
addGlobalModule("projbooter.hotupdate.VoiceDownloader", "VoiceDownloader")
addGlobalModule("projbooter.hotupdate.HotUpdateVoiceMgr", "HotUpdateVoiceMgr")
addGlobalModule("projbooter.hotupdate.optionpackage.OptionPackageHttpGetter", "OptionPackageHttpGetter")
addGlobalModule("projbooter.hotupdate.optionpackage.OptionPackageDownloader", "OptionPackageDownloader")
addGlobalModule("projbooter.hotupdate.optionpackage.OptionPackageHttpWorker", "OptionPackageHttpWorker")
addGlobalModule("projbooter.hotupdate.optionpackage.HotUpateOptionPackageAdapter", "HotUpateOptionPackageAdapter")
addGlobalModule("projbooter.hotupdate.HotUpdateOptionPackageMgr", "HotUpdateOptionPackageMgr")
addGlobalModule("projbooter.hotupdate.HotUpdateTipsHttpGetter", "HotUpdateTipsHttpGetter")
addGlobalModule("projbooter.reschecker.MassHotUpdateMgr", "MassHotUpdateMgr")
addGlobalModule("projbooter.reschecker.ResCheckMgr", "ResCheckMgr")
addGlobalModule("projbooter.audio.BootAudioMgr", "BootAudioMgr")
addGlobalModule("projbooter.sdk.SDKNativeUtil", "SDKNativeUtil")
addGlobalModule("projbooter.sdk.SDKMgr", "SDKMgr")
addGlobalModule("projbooter.sdk.SDKDataTrackMgr", "SDKDataTrackMgr")
addGlobalModule("projbooter.gamepad.GamepadBooter", "GamepadBooter")

function ProjBooter:start()
	self:setCrashsightUid()
	self:intGamepad()
	self:setSkipHotUpdate()

	SLFramework.GameUpdate.UpdateListInfo.UseBigZip = self:_checkUseBigZip()

	if isDebugBuild then
		local logRepoertUrl = GameUrlConfig.getLogReportUrl()

		SLFramework.DebugView.Instance:SetLogReportUrl(logRepoertUrl)
	end

	self:checkWidowsBackGroundSound()
	GameResMgr:InitAbDependencies(self.onAbDependenciesInited, self)
end

function ProjBooter:isUseBigZip()
	return SLFramework.GameUpdate.UpdateListInfo.UseBigZip
end

function ProjBooter:checkWidowsBackGroundSound()
	if BootNativeUtil.isWindows() then
		local key = "WWise_SL_ActivateDuringFocusLoss"

		if UnityEngine.PlayerPrefs.HasKey(key) then
			return
		end

		UnityEngine.PlayerPrefs.SetFloat(key, 1)
	end
end

function ProjBooter:_checkUseBigZip()
	local key = "UpdateListInfo_UseBigZip"

	return UnityEngine.PlayerPrefs.GetFloat(key, 0) == 1
end

function ProjBooter:UseBigZipDownload()
	local key = "UpdateListInfo_UseBigZip"

	UnityEngine.PlayerPrefs.SetFloat(key, 1)
end

function ProjBooter:onAbDependenciesInited()
	logNormal("ProjBooter:onAbDependenciesInited")
	BootResMgr.instance:startLoading(self.onBootResLoaded, self)
end

function ProjBooter:setCrashsightUid()
	local lastPlayerUid = UnityEngine.PlayerPrefs.GetString("PlayerUid")

	if not string.nilorempty(lastPlayerUid) then
		CrashSightAgent.SetUserId(lastPlayerUid)
	end
end

function ProjBooter:intGamepad()
	GamepadBooter.instance:init()
end

function ProjBooter:setSkipHotUpdate()
	SLFramework.GameUpdate.HotUpdateInfoMgr.LoadLocalVersion()

	self._skipHotUpdate = not GameConfig.CanHotUpdate
end

function ProjBooter:onBootResLoaded()
	logNormal("ProjBooter:onBootResLoaded")
	GameAdaptionBgMgr.instance:loadAdaptionBg()
	BootMsgBox.instance:init()
	math.randomseed(tonumber(tostring(os.time()):reverse():sub(1, 7)))
	BootLoadingView.instance:init()
	SDKMgr.instance:initSDK(self.onSdkInited, self)
end

function ProjBooter:onSdkInited()
	logNormal("ProjBooter:onSdkInited")

	local deviceId = tostring(SDKMgr.instance:getDeviceInfo().deviceId)

	UnityEngine.PlayerPrefs.SetString("deviceId", deviceId)
	logNormal("deviceId=" .. deviceId)

	if BootNativeUtil.isAndroid() or BootNativeUtil.isIOS() then
		SDKMgr.instance:setScreenLightingOff(true)
	end

	HotUpdateVoiceMgr.instance:init()
	HotUpdateOptionPackageMgr.instance:init()

	if self._skipHotUpdate then
		self._hotupdateDownloadFinished = true
		self._hotupdateFinished = true
		self._needCopyAb = BootNativeUtil.isAndroid() and GameResMgr:CopyInnerAbToPersistPath(self.onCopyAbRes, self)

		self:onUpdateFinish()

		return
	end

	self:checkVersion()
	BootVersionView.instance:show()
end

function ProjBooter:checkVersion()
	if not GameResMgr.IsFromEditorDir then
		VersionValidator.instance:start(self.onCheckVersion, self)
	else
		self:onCheckVersion("0.0.0", false, "", 1)
	end
end

function ProjBooter:onCheckVersion(latestVersion, inReviewing, loginServerUrl, envType)
	UpdateBeat:Add(self._onFrame, self)

	if inReviewing and BootNativeUtil.isIOS() then
		self:loadLogicLua()

		return
	end

	local localVersionStr = SLFramework.GameUpdate.HotUpdateInfoMgr.LocalResVersionStr
	local localVersionSp = string.split(localVersionStr, ".")
	local latestVersionSp = string.split(latestVersion, ".")

	if (HotUpdateVoiceMgr.EnableEditorDebug or localVersionSp[1] == latestVersionSp[1]) and self:isUseBigZip() then
		HotUpdateVoiceMgr.instance:showDownload(self.getOptionalPackageInfo, self)
	else
		self:startUpdate()
	end
end

function ProjBooter:getOptionalPackageInfo()
	logNormal("ProjBooter:getOptionalPackageInfo")
	HotUpdateOptionPackageMgr.instance:showDownload(self.startUpdate, self, HotUpateOptionPackageAdapter.New())
end

function ProjBooter:_onFrame()
	if UnityEngine.Input.GetKeyUp(UnityEngine.KeyCode.Escape) then
		SDKMgr.instance:exitSdk()

		return
	end
end

function ProjBooter:startUpdate()
	logNormal("ProjBooter:startUpdate")

	self._needCopyAb = BootNativeUtil.isAndroid() and GameResMgr:CopyInnerAbToPersistPath(self.onCopyAbRes, self)

	HotUpdateMgr.instance:start(self.onUpdateFinish, self, self.onUpdateDownloadFinish, self)
end

function ProjBooter:onCopyAbRes(progress)
	if progress == -1 then
		HotUpdateMgr.instance:stop()

		local args = {}

		args.title = booterLang("copy_ab")
		args.content = booterLang("copy_ab_error")
		args.leftMsg = booterLang("exit")
		args.leftCb = self.quitGame
		args.leftCbObj = self
		args.rightMsg = nil

		BootMsgBox.instance:show(args)
		BootMsgBox.instance:disable()
	else
		logNormal("ProjBooter:onCopyAbRes progress:" .. tostring(progress))

		if self._hotupdateDownloadFinished or self._hotupdateFinished then
			self._copyProgress = self._copyProgress or 0

			BootLoadingView.instance:showMsg(booterLang("unpacking"))
		else
			self._copyProgress = progress
		end

		if progress >= 1 then
			self._abCopyFinished = true

			if self._hotupdateFinished then
				self:hotUpdateVoice()
			end
		end
	end
end

function ProjBooter:onUpdateDownloadFinish()
	self._hotupdateDownloadFinished = true

	logNormal("ProjBooter:onUpdateDownloadFinish()")
end

function ProjBooter:onUpdateFinish()
	logNormal("ProjBooter:onUpdateFinish")

	self._hotupdateFinished = true

	if self._needCopyAb and not self._abCopyFinished then
		return
	end

	if self:isUseBigZip() then
		self:hotUpdateVoice()
	else
		self:loadLogicLua()
	end
end

function ProjBooter:hotUpdateVoice()
	if self._skipHotUpdate then
		logNormal("ProjBooter:hotUpdateVoice skip")

		if HotUpdateOptionPackageMgr.EnableEditorDebug then
			self:startUpdateOptionalPackage()

			return
		end

		self:loadLogicLua()
	else
		logNormal("ProjBooter:hotUpdateVoice")
		HotUpdateVoiceMgr.instance:startDownload(self.startUpdateOptionalPackage, self)
	end
end

function ProjBooter:startUpdateOptionalPackage()
	logNormal("ProjBooter:startUpdateOptionalPackage")
	HotUpdateOptionPackageMgr.instance:startDownload(self.loadLogicLua, self)
end

function ProjBooter:loadLogicLua()
	BootLoadingView.instance:showFixBtn()
	SLFramework.FileHelper.ClearDir(SLFramework.FrameworkSettings.PersistentResTempDir2)
	logNormal("ProjBooter:loadLogicLua")
	BootLoadingView.instance:show(0.1, booterLang("loading_res"))

	if GameResMgr.IsFromEditorDir or VersionValidator.instance:isInReviewing() and BootNativeUtil.isIOS() then
		self:loadHotupdateAssembly()
	else
		self:resCheck()
	end
end

function ProjBooter:resCheck()
	ResCheckMgr.instance:startCheck(self.onResCheckFinish, self)
end

function ProjBooter:onResCheckFinish(allPass, diffList)
	logNormal("ProjBooter:onResCheckFinish")

	self._resCheckdiffList = diffList

	if allPass then
		self:loadHotupdateAssembly()
	elseif BootVoiceNewView.instance:isNeverOpen() then
		BootVoiceNewView.instance:show(self.loadUnmatchRes, self)
	else
		self:loadUnmatchRes(true)
	end
end

function ProjBooter:loadUnmatchRes(checkNet)
	MassHotUpdateMgr.instance:loadUnmatchRes(self.loadUnmatchResFinish, self, self._resCheckdiffList, checkNet)
end

function ProjBooter:loadUnmatchResFinish()
	logNormal("ProjBooter:loadUnmatchResFinish")
	self:loadHotupdateAssembly()
end

function ProjBooter:loadHotupdateAssembly()
	logNormal("ProjBooter:loadHotupdateAssembly")
	SLFramework.AssemblyMgr.Instance:LoadAssemblyLua(self.loadLogicLuaTrue, self)
end

function ProjBooter:loadLogicLuaTrue()
	if not GameResMgr.NeedLoadLuaBytes then
		LuaInterface.LuaFileUtils.Instance:BindHotupdateCode()
		self:OnLogicLuaLoaded()
		logNormal("ProjBooter:loadLogicLua, src mode, skip loading!")
	else
		LuaInterface.LuaFileUtils.Instance:LoadLogic(nil, self.OnLogicLuaLoaded, self)
		logNormal("ProjBooter:loadLogicLua, bytecode mode, start loading!")
	end
end

function ProjBooter:OnLogicLuaLoaded()
	UpdateBeat:Remove(self._onFrame, self)
	logNormal("ProjBooter:OnLogicLuaLoaded, start game logic!")
	addGlobalModule("modules.ProjModuleStart", "ProjModuleStart")
end

function ProjBooter:quitGame()
	if BootNativeUtil.isAndroid() then
		SDKMgr.instance:destroyGame()
	elseif BootNativeUtil.isIOS() then
		SDKMgr.instance:destroyGame()
	else
		ZProj.AudioManager.Instance:BootDispose()
		UnityEngine.Application.Quit()
	end
end

ProjBooter.instance = ProjBooter.New()

ProjBooter.instance:start()

return ProjBooter
