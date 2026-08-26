-- chunkname: @projbooter/reschecker/MassHotUpdateMgr.lua

module("modules.reschecker.MassHotUpdateMgr", package.seeall)

local MassHotUpdateMgr = class("MassHotUpdateMgr")
local Manual_FixRes = "Manual_FixRes"

function MassHotUpdateMgr:ctor()
	self._maxRetryCount = 3
	self._downloadFailAlertNum = 0
	self._isDownloading = false
end

function MassHotUpdateMgr:_needShowChangeZipDownload()
	return self._downloadFailAlertNum > 3
end

function MassHotUpdateMgr:isDownloading()
	return self._isDownloading
end

function MassHotUpdateMgr:loadUnmatchRes(cb, cbObj, diffList, checkNet)
	self._time = Time.time
	self._downloadFailAlertNum = 0
	self._lastProgressSize = 0
	self._checkNet = checkNet
	self.cb = cb
	self.cbObj = cbObj
	self._retryCount = 0
	self._useBackupUrl = false

	if BootNativeUtil.isIOS() then
		SLFramework.GameUpdate.MassHotUpdate.Instance.useBackground = false
	else
		SLFramework.GameUpdate.MassHotUpdate.Instance.useBackground = false
	end

	local url, backupUrl = GameUrlConfig.getMassHotUpdateUrl()
	local gameId = SDKMgr.instance:getGameId()

	url = url .. "/" .. gameId
	backupUrl = backupUrl .. "/" .. gameId

	local allSize = SLFramework.GameUpdate.MassHotUpdate.Instance:SetUrlAndBackupUrl(url, backupUrl)

	self.eventDispatcher = SLFramework.GameLuaEventDispatcher.Instance

	self.eventDispatcher:AddListener(self.eventDispatcher.MassHotUpdate_DownloadFinish, self.onDownloadFinish, self)
	self.eventDispatcher:AddListener(self.eventDispatcher.MassHotUpdate_Progress, self.onDownloadProgress, self)
	self.eventDispatcher:AddListener(self.eventDispatcher.MassHotUpdate_NotEnoughDiskSpace, self._onDiskSpaceNotEnough, self)
	self.eventDispatcher:AddListener(204, self.onDownloadNumProgress, self)

	local isManualFixRes = UnityEngine.PlayerPrefs.GetFloat(Manual_FixRes)

	self._fixResEntrance = isManualFixRes == 1 and "主动修复" or "自动修复"

	local resourceFixupData = {
		count = 0,
		status = "start",
		entrance = self._fixResEntrance
	}

	SDKDataTrackMgr.instance:trackResourceFixup(resourceFixupData)

	local progressMsg = booterLang("res_fixing") .. "\n" .. booterLang("fixed_content_tips")

	BootLoadingView.instance:showMsg(progressMsg)

	local timer = Timer.New(function()
		self:_setUnmatchRes(diffList)
	end, 0.1)

	timer:Start()
end

function MassHotUpdateMgr:_setUnmatchRes(diffList)
	self._fakerPerSize = 1
	self._fakerRecvSize = 0
	self._fakerInterval = 0.1
	self._fakerSpeed = 1048576 * self._fakerInterval
	self._backgroundSuccNum = 0
	self._backgroundAllNum = 0
	self._backgroundTarSize = 0
	self._timer = Timer.New(function()
		self:updateFakerSize()
	end, self._fakerInterval)
	self._lastRecvSize = 0
	self._allSize = 0

	if diffList then
		SLFramework.GameUpdate.MassHotUpdate.Instance:SetLoadFilesLua(diffList)
	else
		local allBigTypeList = ResCheckMgr.instance:getAllLocalResBigType()

		SLFramework.ResChecker.Instance:LoadUnmatchRes(allBigTypeList)
	end

	local allSize = SLFramework.GameUpdate.MassHotUpdate.Instance:GetAllSize()

	self._allSize = tonumber(tostring(allSize))
	self._lastFailedFileCount = 0
	self._nextStatProgressPer = 0

	if self._allSize > 0 then
		if not self._checkNet or UnityEngine.Application.internetReachability == UnityEngine.NetworkReachability.ReachableViaLocalAreaNetwork then
			self:_startLoadUnmatchRes()
		else
			local downloadSize = HotUpdateMgr.instance:_fixSizeStr(self._allSize)
			local args = {}

			args.title = booterLang("hotupdate")

			local msg = booterLang("hotupdate_info")

			args.content = string.format(msg, downloadSize)
			args.leftMsg = booterLang("exit")
			args.leftCb = self._quitGame
			args.leftCbObj = self
			args.rightMsg = booterLang("download")
			args.rightCb = self._startLoadUnmatchRes
			args.rightCbObj = self

			BootMsgBox.instance:show(args)
		end
	else
		self:doCallBack()
	end
end

function MassHotUpdateMgr:_startLoadUnmatchRes()
	SLFramework.GameUpdate.MassHotUpdate.Instance:StartLoad()

	self._isDownloading = true
end

function MassHotUpdateMgr:_quitGame()
	logNormal("MassHotUpdateMgr:_quitGame, 退出游戏！")
	ProjBooter.instance:quitGame()
end

function MassHotUpdateMgr:startFakerSize()
	if not self._fakerSizeRun then
		self._fakerSizeRun = true

		self._timer:Start()
	end
end

function MassHotUpdateMgr:stopFakerSize()
	if self._fakerSizeRun then
		self._fakerSizeRun = false

		self._timer:Stop()
	end
end

function MassHotUpdateMgr:updateFakerSize()
	self._timer.loop = 5

	if self._backgroundTarSize > self._fakerRecvSize then
		self._fakerRecvSize = self._fakerRecvSize + (self._backgroundTarSize - self._fakerRecvSize) / 10
	end

	local allSize = HotUpdateMgr.instance:_fixSizeStr(self._allSize)
	local curSize = HotUpdateMgr.instance:_fixSizeStr(self._fakerRecvSize)
	local percent = self._fakerRecvSize / self._allSize
	local progressMsg = string.format(booterLang("mass_download_Progress"), curSize, allSize)

	BootLoadingView.instance:show(percent, progressMsg)
	self:trackUpdatePer(percent)
end

MassHotUpdateMgr.FakerAdvanceNumDic = {
	{
		10000,
		50
	},
	{
		1000,
		10
	},
	{
		500,
		5
	},
	{
		100,
		2
	}
}

function MassHotUpdateMgr:onDownloadNumProgress(curNum, allNum)
	curNum = tonumber(tostring(curNum))
	self._fakerPerSize = self._allSize / allNum
	self._backgroundAllNum = allNum
	self._backgroundSuccNum = curNum

	self:startFakerSize(curNum, allNum)

	local leftNum = allNum - curNum
	local offNum = 1

	for i, v in ipairs(MassHotUpdateMgr.FakerAdvanceNumDic) do
		if leftNum > v[1] then
			offNum = v[2]

			break
		end
	end

	self._backgroundTarSize = math.max(self._backgroundTarSize, math.min(curNum + offNum, allNum) * self._fakerPerSize)
end

function MassHotUpdateMgr:onDownloadProgress(curSize, allSize)
	if self._allSize == 0 then
		local progressMsg = booterLang("mass_download")

		BootLoadingView.instance:show(0, progressMsg)

		return
	end

	self:stopFakerSize()

	local curSizeNum = tonumber(tostring(curSize))

	curSize = self._lastRecvSize + curSizeNum
	allSize = tonumber(tostring(allSize))

	local percent = (self._lastRecvSize + curSizeNum) / self._allSize

	curSize = HotUpdateMgr.instance:_fixSizeStr(curSize)

	local allSize = HotUpdateMgr.instance:_fixSizeStr(self._allSize)
	local progressMsg = string.format(booterLang("mass_download_Progress"), curSize, allSize)

	HotUpdateProgress.instance:setProgressDownloadRes(percent, progressMsg)
	self:trackUpdatePer(percent)
end

function MassHotUpdateMgr:onDownloadFinish(failedFileCount, failSize, errorCodeList, errorMsgList)
	local needAutoRetry = not self._fakerSizeRun

	self:stopFakerSize()

	failSize = tonumber(tostring(failSize))

	local recvSize = self._allSize - failSize

	logNormal("MassHotUpdateMgr:onDownloadFinish cost time: " .. Time.time - self._time .. " s      recvSize = " .. recvSize .. "    failSize = " .. failSize)

	self._lastRecvSize = recvSize

	if failedFileCount == 0 then
		self:trackUpdatePer(1)
		self:doCallBack()
	else
		if self._lastFailedFileCount ~= failedFileCount then
			self._downloadFailAlertNum = 0
		end

		self._retryCount = self._retryCount + 1

		if needAutoRetry and (self._lastFailedFileCount == 0 or failedFileCount / self._lastFailedFileCount < 0.5) then
			self._lastFailedFileCount = failedFileCount

			self:retryFailedFiles()

			return
		end

		local ErrorDefine = SLFramework.GameUpdate.FailError
		local failedTip, count

		if errorCodeList.Count > 0 then
			failedTip = self:_getDownloadFailedTip(errorCodeList[0], errorMsgList[0])
			count = errorCodeList.Count
		else
			failedTip = booterLang("download_fail_time_out")
			count = 1
		end

		for i = 1, count - 1 do
			local code = errorCodeList[i]

			if code == ErrorDefine.NoEnoughDisk then
				failedTip = self:_getDownloadFailedTip(errorCodeList[i], errorMsgList[i])

				break
			end
		end

		self._useBackupCount = not self._useBackupCount and 1 or self._useBackupCount + 1

		local useBackupUrl = self._useBackupUrl

		if self._useBackupCount == 2 then
			self._useBackupUrl = not self._useBackupUrl

			SLFramework.GameUpdate.MassHotUpdate.Instance:SetUseBackupDownloadUrl(self._useBackupUrl)

			self._useBackupCount = 0
		end

		if BootNativeUtil.getPackageName() ~= "com.shenlan.m.reverse1999.nearme.gamecenter" and SDKMgr.instance:isIgnoreFileMissing() then
			if SLFramework.GameUpdate.MassHotUpdate.Instance.useBackground then
				SLFramework.GameUpdate.MassHotUpdate.Instance.useBackground = false

				self:retryFailedFiles()
			elseif useBackupUrl == true then
				self._lastFailedFileCount = failedFileCount

				self:_skip()
			else
				self:retryFailedFiles()
			end

			return
		end

		if UnityEngine.Application.internetReachability ~= UnityEngine.NetworkReachability.NotReachable then
			self._downloadFailAlertNum = self._downloadFailAlertNum + 1
		end

		self._lastFailedFileCount = failedFileCount

		local args = {}

		args.title = booterLang("hotupdate")
		args.content = string.format(booterLang("mass_download_fail_other"), failedTip, failedFileCount)

		if ProjBooter.instance:isUseBigZip() then
			args.leftMsg = booterLang("skip")
			args.leftMsgEn = "skip"
			args.leftCb = self._skip
		elseif self:_needShowChangeZipDownload() then
			args.content = string.format(booterLang("mass_download_fail_other_switch"), failedTip, failedFileCount)
			args.leftMsg = booterLang("switch_zip")
			args.leftMsgEn = "switch"
			args.leftCb = self._switchZipDownloadTip

			local resourceFixupData = {
				status = "fail_switchZipDownloadTip",
				count = self._lastFailedFileCount,
				entrance = self._fixResEntrance,
				fail_count = self._downloadFailAlertNum
			}

			SDKDataTrackMgr.instance:trackResourceFixup(resourceFixupData)
		else
			args.leftMsg = booterLang("exit")
			args.leftMsgEn = "exit"
			args.leftCb = self._quitGame
		end

		args.leftCbObj = self
		args.rightMsg = booterLang("retry")
		args.rightCb = self.retryFailedFiles
		args.rightCbObj = self

		BootMsgBox.instance:show(args)
	end
end

function MassHotUpdateMgr:retryFailedFiles()
	logNormal("MassHotUpdateMgr:retryFailedFiles ,   retryCount:" .. self._retryCount)

	if SLFramework.GameUpdate.MassHotUpdate.Instance.useBackground == true then
		self:startFakerSize()
	end

	SLFramework.GameUpdate.MassHotUpdate.Instance:RetryFailedFiles()
end

function MassHotUpdateMgr:_onDiskSpaceNotEnough()
	logNormal("修复错误，设备磁盘空间不足！")

	local args = {}

	args.title = booterLang("hotupdate")
	args.content = booterLang("unpack_error")
	args.leftMsg = booterLang("exit")
	args.leftCb = self._quitGame
	args.leftCbObj = self
	args.rightMsg = nil

	BootMsgBox.instance:show(args)
end

function MassHotUpdateMgr:_getDownloadFailedTip(errorCode, errorMsg)
	local ErrorDefine = SLFramework.GameUpdate.FailError

	errorCode = ErrorDefine.IntToEnum(errorCode)
	self._errorCode = errorCode
	errorMsg = errorMsg or ""

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
		return booterLang("download_fail_md5_check_error")
	else
		return booterLang("download_fail_other") .. tostring(errorMsg)
	end
end

function MassHotUpdateMgr:_skip()
	self:doCallBack(true)
end

function MassHotUpdateMgr:_switchZipDownloadTip()
	local args = {}

	args.title = booterLang("hotupdate")
	args.content = booterLang("switch_zip_tips")
	args.leftMsg = booterLang("cancel")
	args.leftMsgEn = "cancel"
	args.leftCb = self._quitGame
	args.leftCbObj = self
	args.rightMsg = booterLang("sure")
	args.rightCb = self._switchZipDownload
	args.rightCbObj = self

	BootMsgBox.instance:show(args)
end

function MassHotUpdateMgr:_switchZipDownload()
	local resourceFixupData = {
		status = "fail_switchZipConfirm",
		count = self._lastFailedFileCount,
		entrance = self._fixResEntrance,
		fail_count = self._downloadFailAlertNum
	}

	SDKDataTrackMgr.instance:trackResourceFixup(resourceFixupData)

	if self.cb then
		self.cb(self.cbObj)
	end

	UnityEngine.PlayerPrefs.DeleteAll()
	SLFramework.GameUpdate.HotUpdateInfoMgr.RemoveLocalVersionFile()
	SLFramework.GameUpdate.OptionalUpdate.Instance:RemoveLocalVersionFile()
	ResCheckMgr.instance:DeleteLocalhashFile()
	ResCheckMgr.instance:DeleteOutVersion()
	ProjBooter.instance:UseBigZipDownload()
	UnityEngine.PlayerPrefs.Save()

	local timer = Timer.New(function()
		if BootNativeUtil.isAndroid() then
			if SDKMgr.restartGame ~= nil then
				SDKMgr.instance:restartGame()
			else
				ProjBooter.instance:quitGame()
			end
		else
			ProjBooter.instance:quitGame()
		end
	end, 0.5)

	timer:Start()
end

function MassHotUpdateMgr:doCallBack(isSkip)
	self._isDownloading = false

	if self.eventDispatcher then
		self.eventDispatcher:RemoveListener(self.eventDispatcher.MassHotUpdate_DownloadFinish)
		self.eventDispatcher:RemoveListener(self.eventDispatcher.MassHotUpdate_Progress)
		self.eventDispatcher:RemoveListener(self.eventDispatcher.MassHotUpdate_NotEnoughDiskSpace)
		self.eventDispatcher:RemoveListener(204)
	end

	if isSkip ~= true then
		ResCheckMgr.instance:markLastCheckAppVersion()
		UnityEngine.PlayerPrefs.DeleteKey(Manual_FixRes)
	end

	local resourceFixupData = {
		status = isSkip and "fail" or "success",
		count = self._lastFailedFileCount,
		entrance = self._fixResEntrance,
		fail_count = self._downloadFailAlertNum
	}

	SDKDataTrackMgr.instance:trackResourceFixup(resourceFixupData)

	if self.cb then
		self.cb(self.cbObj)
	end
end

function MassHotUpdateMgr:trackUpdatePer(percentage)
	if percentage < self._nextStatProgressPer then
		return
	end

	self._nextStatProgressPer = self._nextStatProgressPer + 0.2

	local data = {
		update_amount = self._allSize,
		update_percentage = tostring(math.ceil(percentage * 100))
	}

	SDKDataTrackMgr.instance:trackMassHotUpdatePer(data)
end

function MassHotUpdateMgr:_quitGame()
	logNormal("MassHotUpdateMgr:_quitGame, 退出游戏！")
	ProjBooter.instance:quitGame()
end

MassHotUpdateMgr.instance = MassHotUpdateMgr.New()

return MassHotUpdateMgr
