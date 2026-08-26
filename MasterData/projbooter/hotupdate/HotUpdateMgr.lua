-- chunkname: @projbooter/hotupdate/HotUpdateMgr.lua

module("projbooter.hotupdate.HotUpdateMgr", package.seeall)

local HotUpdateMgr = class("HotUpdateMgr")

HotUpdateMgr.FailAlertCount = 4

function HotUpdateMgr:ctor()
	self._eventMgr = SLFramework.GameUpdate.HotUpdateEvent
	self._eventMgrInst = SLFramework.GameUpdate.HotUpdateEvent.Instance
	self._started = false
	self._useBackupUrl = false
end

function HotUpdateMgr:getUseBackup()
	return self._useBackupUrl
end

function HotUpdateMgr:inverseUseBackup()
	self._useBackupUrl = not self._useBackupUrl
end

function HotUpdateMgr:getFailCount()
	return self._failCount or 0
end

function HotUpdateMgr:resetFailCount()
	self._failCount = 0
	self._failAlertCount = 0
end

function HotUpdateMgr:incFailCount()
	if self._failCount then
		self._failCount = self._failCount + 1 or 1
	end

	if self._failAlertCount then
		self._failAlertCount = self._failAlertCount + 1 or 1
	end
end

function HotUpdateMgr:getFailAlertCount()
	return self._failAlertCount or 0
end

function HotUpdateMgr:resetFailAlertCount()
	self._failAlertCount = 0
end

function HotUpdateMgr:isFailNeedAlert()
	return self._failAlertCount >= HotUpdateMgr.FailAlertCount
end

function HotUpdateMgr:hideConnectTips()
	BootLoadingView.instance:hide()
end

function HotUpdateMgr:showConnectTips()
	if BootVoiceView.instance:isShow() then
		BootVoiceView.instance:updateTips()
		BootLoadingView.instance:hide()
	elseif self:getFailAlertCount() > 0 then
		local progressMsg = string.format(booterLang("network_reconnect"), tostring(self:getFailAlertCount()))

		BootLoadingView.instance:showMsg(progressMsg, "")
	else
		local progressMsg = string.format(booterLang("network_connecting"))

		BootLoadingView.instance:showMsg(progressMsg, "")
	end
end

function HotUpdateMgr:initStatHotUpdatePer()
	self._statHotUpdatePerList = {}
	self._statHotUpdatePerList[1] = {
		0,
		SDKDataTrackMgr.EventName.hotupdate_0_20
	}
	self._statHotUpdatePerList[2] = {
		0.21,
		SDKDataTrackMgr.EventName.hotupdate_21_40
	}
	self._statHotUpdatePerList[3] = {
		0.41,
		SDKDataTrackMgr.EventName.hotupdate_41_60
	}
	self._statHotUpdatePerList[4] = {
		0.61,
		SDKDataTrackMgr.EventName.hotupdate_61_80
	}
	self._statHotUpdatePerList[5] = {
		0.81,
		SDKDataTrackMgr.EventName.hotupdate_81_100
	}
	self._statHotUpdatePerNum = 5
	self._nowStatHotUpdatePerIndex = 1
end

function HotUpdateMgr:start(onFinish, finishObj, onDownloadSucc, downloadSuccObj)
	self:initStatHotUpdatePer()

	self._onFinishCb = onFinish
	self._onFinishObj = finishObj
	self._onDownloadSuccCb = onDownloadSucc
	self._onDownloadSuccObj = downloadSuccObj

	if GameResMgr.IsFromEditorDir then
		-- block empty
	end

	self._started = true

	self:resetFailCount()
	self._eventMgrInst:AddLuaLisenter(self._eventMgr.GetRemoteVersionFail, self._onGetRemoteVersionFail, self)
	self._eventMgrInst:AddLuaLisenter(self._eventMgr.GetRemoteVersionSuccess, self._onGetRemoteVersionSuccess, self)
	self._eventMgrInst:AddLuaLisenter(self._eventMgr.GetUpdateManifestFail, self._onGetUpdateResInfoFail, self)
	self._eventMgrInst:AddLuaLisenter(self._eventMgr.GetUpdateManifestSuccess, self._onGetUpdateResInfoSuccess, self)
	self._eventMgrInst:AddLuaLisenter(self._eventMgr.NeedInstallNewPackage, self._onNeedInstallNewPackage, self)
	self._eventMgrInst:AddLuaLisenter(self._eventMgr.StartHotUpdateNotify, self._onStartHotUpdateNotify, self)
	self._eventMgrInst:AddLuaLisenter(self._eventMgr.HotUpdateDownloadProgress, self._onHotUpdateDownloadProgress, self)
	self._eventMgrInst:AddLuaLisenter(self._eventMgr.HotUpdateDownloadFail, self._onHotUpdateDownloadFail, self)
	self._eventMgrInst:AddLuaLisenter(self._eventMgr.DownloadDiskFull, self._onDownloadDiskFull, self)
	self._eventMgrInst:AddLuaLisenter(self._eventMgr.HotUpdateDownloadSuccess, self._onHotUpdateDownloadSuccess, self)
	self._eventMgrInst:AddLuaLisenter(self._eventMgr.StartUnzipNotify, self._onStartUnzipNotify, self)
	self._eventMgrInst:AddLuaLisenter(self._eventMgr.DiskSpaceNotEnough, self._onDiskSpaceNotEnough, self)
	self._eventMgrInst:AddLuaLisenter(self._eventMgr.UnzipProgress, self._onUnzipProgress, self)
	self._eventMgrInst:AddLuaLisenter(self._eventMgr.UnzipFail, self._onUnzipFail, self)
	self._eventMgrInst:AddLuaLisenter(self._eventMgr.UnzipSuccess, self._onUnzipSuccess, self)
	self._eventMgrInst:AddLuaLisenter(self._eventMgr.HotUpdateComplete, self._onHotUpdateComplete, self)

	local domain = self:getDomainUrl()
	local gameId = SDKMgr.instance:getGameId()
	local osType = SLFramework.FrameworkSettings.CurPlatform

	if SLFramework.FrameworkSettings.IsEditor then
		osType = 2
	end

	local channelId = SDKMgr.instance:getChannelId()
	local resVersion = SLFramework.GameUpdate.HotUpdateInfoMgr.LocalResVersionStr
	local appVersion = tonumber(BootNativeUtil.getAppVersion())
	local packageName = BootNativeUtil.getPackageName()
	local subChannelId = SDKMgr.instance:getSubChannelId()

	self:statStartUpdate()
	SDKDataTrackMgr.instance:track(SDKDataTrackMgr.EventName.hotupdate_check)

	local serverType = GameChannelConfig.getServerType()

	self._eventMgrInst:StartUpdate(domain, gameId, (GameConfig.Instance.IsMuMu or nil) and 5, channelId, serverType, resVersion, appVersion, packageName, subChannelId)

	self._tipsGetter = self._tipsGetter or HotUpdateTipsHttpGetter.New()

	self._tipsGetter:start(self._onHotUpdateTipsHttpResult, self)
end

function HotUpdateMgr:stop()
	self._eventMgrInst:StopUpdate()
end

function HotUpdateMgr:getDomainUrl()
	local formalDomain, backupDomain = GameUrlConfig.getHotUpdateUrl()

	return self:getUseBackup() and backupDomain or formalDomain
end

function HotUpdateMgr:_onFinish()
	if not self._onFinishCb then
		return
	end

	if self._started then
		self._eventMgrInst:ClearLuaListener()
	end

	self._onFinishCb(self._onFinishObj)

	self._started = false

	if self._audioInited then
		BootAudioMgr.instance:dispose()
	end
end

function HotUpdateMgr:_initAudio()
	self._audioInited = true

	BootAudioMgr.instance:init(self._onAudioInited, self)
end

function HotUpdateMgr:_onAudioInited()
	logNormal("启动音效初始化成功！")
end

function HotUpdateMgr:_onGetRemoteVersionFail(errorInfo, responseCode, requestUrl)
	logWarn("HotUpdateMgr:_onGetRemoteVersionFail, 获取版本失败, error = " .. errorInfo)
	self:inverseUseBackup()

	local domain = self:getDomainUrl()

	self._eventMgrInst:ChangeGetInfoDomainUrl(domain)
	self:incFailCount()

	if self:isFailNeedAlert() then
		self:resetFailAlertCount()

		local args = {}

		args.title = booterLang("hotupdate")
		args.content = booterLang("error_request_version") .. errorInfo
		args.leftMsg = booterLang("exit")
		args.leftCb = self._quitGame
		args.leftCbObj = self
		args.rightMsg = booterLang("retry")
		args.rightCb = self._retryGetVersion
		args.rightCbObj = self

		BootMsgBox.instance:show(args)
		self:hideConnectTips()
	else
		logNormal("HotUpdateMgr 静默重试获取版本！")
		self._eventMgrInst:DoRetryAction()
		self:showConnectTips()
	end

	SDKDataTrackMgr.instance:trackGetRemoteVersionEvent(SDKDataTrackMgr.RequestResult.fail, requestUrl, responseCode, errorInfo)
end

function HotUpdateMgr:_quitGame()
	logNormal("HotUpdateMgr:_quitGame, 退出游戏！")
	ProjBooter.instance:quitGame()
end

function HotUpdateMgr:_retryGetVersion()
	logNormal("HotUpdateMgr:_retryGetVersion, 重试获取版本！")
	self._eventMgrInst:DoRetryAction()
	self:showConnectTips()
end

function HotUpdateMgr:_onGetRemoteVersionSuccess(version, inReview, loginUrl, envType, requestUrl)
	self:hideConnectTips()

	local domain = self:getDomainUrl()

	SDKDataTrackMgr.instance:trackDomainFailCount("scene_hotupdate_versioncheck", domain, self:getFailCount())
	self:resetFailCount()
	logNormal("HotUpdateMgr:_onGetRemoteVersionSuccess ！")

	self.shouldHotUpdate = SLFramework.GameUpdate.HotUpdateInfoMgr.ShouldHotUpdate

	SDKDataTrackMgr.instance:trackGetRemoteVersionEvent(SDKDataTrackMgr.RequestResult.success, requestUrl)
end

function HotUpdateMgr:_onGetUpdateResInfoFail(errorInfo, responseCode, requestUrl)
	logWarn("HotUpdateMgr:_onGetUpdateResInfoFail, 获取更新资源信息失败, error = " .. errorInfo)
	self:inverseUseBackup()

	local domain = self:getDomainUrl()

	self._eventMgrInst:ChangeGetInfoDomainUrl(domain)
	self:incFailCount()

	if self:isFailNeedAlert() then
		self:resetFailAlertCount()

		local args = {}

		args.title = booterLang("hotupdate")
		args.content = booterLang("error_request_update") .. errorInfo
		args.leftMsg = booterLang("exit")
		args.leftCb = self._quitGame
		args.leftCbObj = self
		args.rightMsg = booterLang("retry")
		args.rightCb = self._retryGetUpdateManifest
		args.rightCbObj = self

		BootMsgBox.instance:show(args)
		self:hideConnectTips()
	else
		logNormal("HotUpdateMgr 静默重试获取更新资源信息！")
		self._eventMgrInst:DoRetryAction()
		self:showConnectTips()
	end

	SDKDataTrackMgr.instance:trackHotUpdateResourceEvent(SDKDataTrackMgr.RequestResult.fail, requestUrl, responseCode, errorInfo)
end

function HotUpdateMgr:_retryGetUpdateManifest()
	logNormal("HotUpdateMgr:_retryGetUpdateManifest, 重试获取更新信息失败！")
	self._eventMgrInst:DoRetryAction()
	self:showConnectTips()
end

function HotUpdateMgr:_onGetUpdateResInfoSuccess(targetVersion, requestUrl)
	self:hideConnectTips()

	local domain = self:getDomainUrl()

	SDKDataTrackMgr.instance:trackDomainFailCount("scene_hotupdate_srcrequest", domain, self:getFailCount())
	self:resetFailCount()
	logNormal("HotUpdateMgr:_onGetUpdateResInfoSuccess targetVersion = ", targetVersion)
	SDKDataTrackMgr.instance:trackHotUpdateResourceEvent(SDKDataTrackMgr.RequestResult.success, requestUrl)
end

function HotUpdateMgr:_onNeedInstallNewPackage(appUrl)
	logNormal("HotUpdateMgr:_onNeedInstallNewPackage, 需要整包更新！appUrl = " .. appUrl)

	self._appUrl = appUrl

	local args = {}

	args.title = booterLang("hotupdate")
	args.content = booterLang("need_update_package")
	args.leftMsg = booterLang("exit")
	args.leftCb = self._quitGame
	args.leftCbObj = self
	args.rightMsg = booterLang("download")
	args.rightCb = VersionUtil.isVersionLargeEqual("2.7.0") and self._gotoDownloadPackageNew or self._gotoDownloadPackageLegacy

	self:_addRewardFlagParams(args)

	args.rightCbObj = self

	if SDKMgr.instance:getSubChannelId() == "1025" then
		args.rightMsg = nil
	end

	BootMsgBox.instance:show(args)
end

function HotUpdateMgr:_addRewardFlagParams(args)
	args.contentStr = args.content
	args.isShowRewardTips = true

	if not string.nilorempty(self._hotUpdateRewardTips) then
		args.content = args.contentStr .. "\n" .. self._hotUpdateRewardTips
	end
end

function HotUpdateMgr:_onHotUpdateTipsHttpResult(isSuccess, tipsGetter)
	if isSuccess then
		self._hotUpdateRewardTips = tipsGetter:getTipsStr()

		local args = BootMsgBox.instance.args

		if args and args.isShowRewardTips and not string.nilorempty(self._hotUpdateRewardTips) then
			BootMsgBox.instance:setContentText(args.contentStr .. "\n" .. self._hotUpdateRewardTips)
		end
	end
end

function HotUpdateMgr:getRewardTipsStr()
	return self._hotUpdateRewardTips
end

function HotUpdateMgr:_gotoDownloadPackageNew()
	logNormal("HotUpdateMgr:_gotoDownloadPackageNew, 打开下载Url = " .. self._appUrl)

	if BootNativeUtil.isAndroid() then
		SDKNativeUtil.updateGame(self._appUrl)

		local timer = Timer.New(function()
			self:_onNeedInstallNewPackage(self._appUrl)
		end, 0.1)

		timer:Start()

		return
	end

	if BootNativeUtil.isIOS() then
		local jsonObj = {
			deepLink = "",
			url = self._appUrl
		}
		local jsonStr = cjson.encode(jsonObj)

		ZProj.SDKMgr.Instance:CallVoidFuncWithParams("openDeepLink", jsonStr)

		local timer = Timer.New(function()
			self:_onNeedInstallNewPackage(self._appUrl)
		end, 0.1)

		timer:Start()

		return
	end

	if BootNativeUtil.isWindows() and GameChannelConfig.isBilibili() then
		SDKMgr.instance:openLauncher()

		return
	end

	UnityEngine.Application.OpenURL(self._appUrl)

	if not BootNativeUtil.isAndroid() then
		ProjBooter.instance:quitGame()
	end
end

function HotUpdateMgr:_gotoDownloadPackageLegacy()
	logNormal("HotUpdateMgr:_gotoDownloadPackageLegacy, 打开下载Url = " .. self._appUrl)

	if BootNativeUtil.isAndroid() and tostring(SDKMgr.instance:getSubChannelId()) == "1001" then
		SDKNativeUtil.updateGame(self._appUrl)

		local timer = Timer.New(function()
			self:_onNeedInstallNewPackage(self._appUrl)
		end, 0.1)

		timer:Start()

		return
	end

	if BootNativeUtil.isWindows() and GameChannelConfig.isBilibili() then
		SDKMgr.instance:openLauncher()

		return
	end

	UnityEngine.Application.OpenURL(self._appUrl)

	if BootNativeUtil.isAndroid() then
		local timer = Timer.New(function()
			self:_onNeedInstallNewPackage(self._appUrl)
		end, 0.1)

		timer:Start()
	else
		ProjBooter.instance:quitGame()
	end
end

function HotUpdateMgr:_onStartHotUpdateNotify(curSize, allSize)
	self._hasHotUpdate = true
	curSize = tonumber(tostring(curSize))
	allSize = tonumber(tostring(allSize))

	logNormal("HotUpdateMgr:_onStartHotUpdateNotify, 热更新 curSize = " .. curSize .. " allSize = " .. allSize)
	self:_showConfirmUpdateSize(allSize, curSize, self._startDownload)
	self:_initAudio()
end

function HotUpdateMgr:_startDownload()
	logNormal("HotUpdateMgr:_startDownload, 开始下载！")
	SDKDataTrackMgr.instance:track(SDKDataTrackMgr.EventName.hotupdate_download)
	SLFramework.GameUpdate.HotUpdate.Instance:SetUseReserveDomain(self:getUseBackup())
	self._eventMgrInst:DoRetryAction()
end

function HotUpdateMgr:_onHotUpdateDownloadProgress(curSize, allSize)
	curSize = tonumber(tostring(curSize))
	allSize = tonumber(tostring(allSize))

	local progressChanged = not self._prevSize or curSize ~= self._prevSize

	self._prevSize = curSize

	if self:getFailCount() > 0 and progressChanged then
		local domain = self:getDomainUrl()

		SDKDataTrackMgr.instance:trackDomainFailCount("scene_hotupdate_srcdownload", domain, self:getFailCount())
		self:resetFailCount()
	end

	logNormal("HotUpdateMgr:_onHotUpdateDownloadProgress, 下载进度 curSize = " .. curSize .. " allSize = " .. allSize)

	local percent = curSize / allSize
	local statSize = self:_fixSizeMB(allSize)

	if progressChanged then
		HotUpdateProgress.instance:setProgressDownloadHotupdate(curSize)
	end

	self:statHotUpdate(percent, statSize)
end

function HotUpdateMgr:_onHotUpdateDownloadFail(errorCode, errorMsg)
	if errorCode == SLFramework.GameUpdate.FailError.MD5CheckError then
		self:_checkSendFullPonitStat()
	end

	self:inverseUseBackup()
	require("tolua.reflection")
	tolua.loadassembly("SL_AS")

	local type_HotUpdate = typeof(SLFramework.GameUpdate.HotUpdate)
	local field_useReserveDomain = tolua.getfield(type_HotUpdate, "_useReserveDomain", 36)

	field_useReserveDomain:Set(SLFramework.GameUpdate.HotUpdate.Instance, self:getUseBackup())
	self:incFailCount()

	if self:isFailNeedAlert() then
		self:resetFailAlertCount()

		local args = {}

		args.title = booterLang("hotupdate")
		args.content = self:_getDownloadFailedTip(errorCode, errorMsg)
		args.leftMsg = booterLang("exit")
		args.leftCb = self._quitGame
		args.leftCbObj = self
		args.rightMsg = booterLang("retry")
		args.rightCb = self._retryDownload
		args.rightCbObj = self

		BootMsgBox.instance:show(args)
	else
		logNormal("HotUpdateMgr 静默重试下载！")
		self._eventMgrInst:DoRetryAction()
		self:showConnectTips()
	end
end

function HotUpdateMgr:_onDownloadDiskFull()
	local args = {}

	args.title = booterLang("hotupdate")
	args.content = booterLang("download_fail_no_enough_disk")
	args.leftMsg = booterLang("exit")
	args.leftCb = self._quitGame
	args.leftCbObj = self
	args.rightMsg = booterLang("retry")
	args.rightCb = self._retryDownload
	args.rightCbObj = self

	BootMsgBox.instance:show(args)
end

function HotUpdateMgr:_retryDownload()
	logNormal("HotUpdateMgr:_retryDownload, 重试下载！")
	self._eventMgrInst:DoRetryAction()
	self:showConnectTips()
end

function HotUpdateMgr:_getDownloadFailedTip(errorCode, errorMsg)
	local ErrorDefine = SLFramework.GameUpdate.FailError

	if errorCode == ErrorDefine.DownloadErrer then
		return booterLang("download_fail_download_error")
	elseif errorCode == ErrorDefine.NotFound then
		return booterLang("download_fail_not_found")
	elseif errorCode == ErrorDefine.ServerPause then
		return booterLang("download_fail_server_pause")
	elseif errorCode == ErrorDefine.TimeOut then
		return booterLang("download_fail_time_out")
	elseif errorCode == ErrorDefine.NoEnoughDisk then
		return booterLang("download_fail_no_enough_disk")
	elseif errorCode == ErrorDefine.MD5CheckError then
		SDKDataTrackMgr.instance:trackHotupdateFilesCheckEvent(SDKDataTrackMgr.Result.fail, errorMsg)

		return booterLang("download_fail_md5_check_error")
	else
		return booterLang("download_fail_other") .. tostring(errorMsg)
	end
end

function HotUpdateMgr:_onHotUpdateDownloadSuccess()
	logNormal("下载热更新资源包完成，开始解压所有资源包！")
	self:_checkSendFullPonitStat()
	SDKDataTrackMgr.instance:trackHotupdateFilesCheckEvent(SDKDataTrackMgr.Result.success)

	if self._onDownloadSuccCb then
		self._onDownloadSuccCb(self._onDownloadSuccObj)
	end
end

function HotUpdateMgr:_onStartUnzipNotify()
	SDKDataTrackMgr.instance:track(SDKDataTrackMgr.EventName.unzip_start)
end

function HotUpdateMgr:_onDiskSpaceNotEnough()
	logNormal("解压所有资源包遇到错误，设备磁盘空间不足！")

	local args = {}

	args.title = booterLang("hotupdate")
	args.content = booterLang("unpack_error")
	args.leftMsg = booterLang("exit")
	args.leftCb = self._quitGame
	args.leftCbObj = self
	args.rightMsg = nil

	BootMsgBox.instance:show(args)
end

function HotUpdateMgr:_onUnzipProgress(progress, totalProgress)
	logNormal("正在解压资源包，请稍后... progress = " .. progress .. " totalProgress = " .. totalProgress)

	if tostring(progress) == "nan" then
		return
	end

	HotUpdateProgress.instance:setProgressUnzipHotupdate(totalProgress)
end

function HotUpdateMgr:_onUnzipFail(unzipState)
	logNormal("解压所有资源包遇到错误，解压失败！")

	local args = {}

	args.title = booterLang("hotupdate")
	args.content = self:_getUnzipFailedTip(unzipState)
	args.leftMsg = booterLang("exit")
	args.leftCb = self._quitGame
	args.leftCbObj = self
	args.rightMsg = booterLang("retry")
	args.rightCb = self._retryUnzipFile
	args.rightCbObj = self

	BootMsgBox.instance:show(args)
	SDKDataTrackMgr.instance:trackUnzipFinishEvent(SDKDataTrackMgr.Result.fail, args.content)
end

function HotUpdateMgr:_retryUnzipFile()
	logNormal("HotUpdateMgr:_retryUnzipFile, 重试解压资源包！")
	self._eventMgrInst:DoRetryAction()
end

function HotUpdateMgr:_getUnzipFailedTip(unzipState)
	local StateDefine = SLFramework.GameUpdate.UnzipStatus

	if unzipState == StateDefine.Running then
		return booterLang("unpack_error_running")
	elseif unzipState == StateDefine.Done then
		return booterLang("unpack_error_done")
	elseif unzipState == StateDefine.FileNotFound then
		return booterLang("unpack_error_file_not_found")
	elseif unzipState == StateDefine.NotEnoughSpace then
		return booterLang("unpack_error_not_enough_space")
	elseif unzipState == StateDefine.ThreadAbort then
		return booterLang("unpack_error_thread_abort")
	elseif unzipState == StateDefine.Exception then
		return booterLang("unpack_error_exception")
	else
		return booterLang("unpack_error_unknown")
	end
end

function HotUpdateMgr:_onUnzipSuccess()
	SDKDataTrackMgr.instance:trackUnzipFinishEvent(SDKDataTrackMgr.Result.success)
end

function HotUpdateMgr:hasHotUpdate()
	return self._hasHotUpdate
end

function HotUpdateMgr:_onHotUpdateComplete()
	if self._hasHotUpdate then
		self:_onFinish()
	else
		self:_showConfirmUpdateSize(0, 0, self._onFinish)
	end
end

function HotUpdateMgr:_showConfirmUpdateSize(hotupdateAllSize, hotupdateCurSize, callback)
	local voiceTotalSize = HotUpdateVoiceMgr.instance:getTotalSize()

	HotUpdateProgress.instance:initDownloadSize(hotupdateAllSize, hotupdateCurSize)

	local voiceNeedDownloadSize = HotUpdateVoiceMgr.instance:getNeedDownloadSize()
	local optionPackageNeedDownloadSize = HotUpdateOptionPackageMgr.instance:getNeedDownloadSize()
	local hotupdateNeedDownloadSize = hotupdateAllSize - hotupdateCurSize
	local totalNeedDownloadSize = voiceNeedDownloadSize + hotupdateNeedDownloadSize + optionPackageNeedDownloadSize

	if not BootVoiceView.instance:isFirstDownloadDone() and not VersionValidator.instance:isInReviewing() and ProjBooter.instance:isUseBigZip() then
		local choices = BootVoiceView.instance:getDownloadChoices()

		if totalNeedDownloadSize > 0 or #choices > 0 and voiceTotalSize == 0 then
			BootVoiceView.instance:showDownloadSize(hotupdateNeedDownloadSize, callback, self)
		else
			BootVoiceView.instance:hide()
			callback(self)
		end
	elseif totalNeedDownloadSize > 0 then
		if UnityEngine.Application.internetReachability == UnityEngine.NetworkReachability.ReachableViaLocalAreaNetwork then
			BootVoiceView.instance:hide()
			callback(self)
		else
			local downloadSize = self:_fixSizeStr(totalNeedDownloadSize)
			local args = {}

			args.title = booterLang("hotupdate")

			local msg = hotupdateCurSize == 0 and booterLang("hotupdate_info") or booterLang("hotupdate_continue_info")

			args.content = string.format(msg, downloadSize)
			args.leftMsg = booterLang("exit")
			args.leftCb = self._quitGame
			args.leftCbObj = self
			args.rightMsg = hotupdateCurSize == 0 and booterLang("download") or booterLang("continue_download")
			args.rightCb = callback
			args.rightCbObj = self

			self:_addRewardFlagParams(args)
			BootMsgBox.instance:show(args)
		end
	else
		BootVoiceView.instance:hide()
		callback(self)
	end
end

function HotUpdateMgr:statStartUpdate()
	self._statNextPoint = 0
	self._statAllSize = 0
end

function HotUpdateMgr:statHotUpdate(percent, allSize)
	for i = self._nowStatHotUpdatePerIndex, self._statHotUpdatePerNum do
		local v = self._statHotUpdatePerList[i]
		local startPoint = v[1]

		if startPoint <= percent then
			SDKDataTrackMgr.instance:track(v[2])

			self._nowStatHotUpdatePerIndex = i + 1
		else
			break
		end
	end

	if not self._statNextPoint then
		return
	end

	self._statAllSize = allSize

	if percent >= self._statNextPoint then
		SDKDataTrackMgr.instance:track(SDKDataTrackMgr.EventName.HotUpdate, {
			[SDKDataTrackMgr.EventProperties.UpdateAmount] = allSize,
			[SDKDataTrackMgr.EventProperties.UpdatePercentage] = tostring(self._statNextPoint)
		})

		self._statNextPoint = self._statNextPoint + 0.5
	end
end

function HotUpdateMgr:_checkSendFullPonitStat()
	if self._statNextPoint and self._statNextPoint < 1.5 and self._statAllSize and self._statAllSize ~= 0 then
		self._statNextPoint = 1

		self:statHotUpdate(1, self._statAllSize)
	end
end

function HotUpdateMgr:_fixSizeStr(size)
	return HotUpdateMgr.fixSizeStr(size)
end

function HotUpdateMgr:_fixSizeMB(size)
	return HotUpdateMgr.fixSizeMB(size)
end

HotUpdateMgr.MB_SIZE = 1048576
HotUpdateMgr.KB_SIZE = 1024

function HotUpdateMgr.fixSizeStr(size)
	local ret = size / HotUpdateMgr.MB_SIZE
	local units = "MB"

	if ret < 1 then
		ret = size / HotUpdateMgr.KB_SIZE
		units = "KB"

		if size / HotUpdateMgr.KB_SIZE < 0.01 then
			ret = 0.01
		end
	end

	ret = ret - ret % 0.01

	return string.format("%.2f %s", ret, units)
end

function HotUpdateMgr.fixSizeMB(size)
	local ret = size / HotUpdateMgr.MB_SIZE

	if ret < 0.001 then
		return 0.001
	end

	ret = ret - ret % 0.001

	return ret
end

HotUpdateMgr.instance = HotUpdateMgr.New()

return HotUpdateMgr
