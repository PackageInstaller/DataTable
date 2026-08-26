-- chunkname: @projbooter/hotupdate/VoiceDownloader.lua

module("projbooter.hotupdate.VoiceDownloader", package.seeall)

local VoiceDownloader = class("VoiceDownloader")

function VoiceDownloader:start(onFinish, finishObj)
	self._lang2DownloadList = HotUpdateVoiceMgr.instance:getAllLangDownloadList()
	self._totalSize = 0
	self._download_voice_pack_list = BootVoiceView.instance:getDownloadChoices()

	for _, list in pairs(self._lang2DownloadList) do
		for _, one in ipairs(list) do
			self._totalSize = self._totalSize + one.length
		end
	end

	self._statHotUpdatePerList = {}
	self._statHotUpdatePerList[1] = {
		0,
		"start"
	}
	self._statHotUpdatePerList[2] = {
		0.2,
		"20%"
	}
	self._statHotUpdatePerList[3] = {
		0.4,
		"40%"
	}
	self._statHotUpdatePerList[4] = {
		0.6,
		"60%"
	}
	self._statHotUpdatePerList[5] = {
		0.8,
		"80%"
	}
	self._statHotUpdatePerList[6] = {
		1,
		"100%"
	}
	self._statHotUpdatePerNum = 6
	self._nowStatHotUpdatePerIndex = 1
	self._downLoadStartTime = math.floor(Time.realtimeSinceStartup * 1000)
	self._downloadSize = 0

	if self._totalSize > 0 then
		self._optionalUpdate = SLFramework.GameUpdate.OptionalUpdate
		self._optionalUpdateInst = self._optionalUpdate.Instance

		self._optionalUpdateInst:SetUseReserveUrl(HotUpdateMgr.instance:getUseBackup())
		self._optionalUpdateInst:Register(self._optionalUpdate.NotEnoughDiskSpace, self._onNotEnoughDiskSpace, self)
		self._optionalUpdateInst:Register(self._optionalUpdate.DownloadStart, self._onDownloadStart, self)
		self._optionalUpdateInst:Register(self._optionalUpdate.DownloadProgressRefresh, self._onDownloadProgressRefresh, self)
		self._optionalUpdateInst:Register(self._optionalUpdate.DownloadPackFail, self._onDownloadPackFail, self)
		self._optionalUpdateInst:Register(self._optionalUpdate.DownloadPackSuccess, self._onDownloadPackSuccess, self)
		self._optionalUpdateInst:Register(self._optionalUpdate.PackUnZipFail, self._onPackUnZipFail, self)
		self._optionalUpdateInst:Register(self._optionalUpdate.PackItemStateChange, self._onPackItemStateChange, self)

		self._onDownloadFinish = onFinish
		self._onDownloadFinishObj = finishObj
		self._downloadSuccSize = 0

		self:_startOneLangDownload()
	else
		self:_setDoneFirstDownload()
		onFinish(finishObj)
	end
end

function VoiceDownloader:_startOneLangDownload()
	local lang, list = next(self._lang2DownloadList)

	if lang and list then
		self._downloadingList = list
		self._downloadUrl, self._downloadUrlBak = HotUpdateVoiceMgr.instance:getDownloadUrl(lang)

		self._optionalUpdateInst:SetRemoteAssetUrl(self._downloadUrl, self._downloadUrlBak)

		local names = {}
		local hashs = {}
		local orders = {}
		local lengths = {}
		local latest_ver

		for _, one in ipairs(list) do
			table.insert(names, one.name)
			table.insert(hashs, one.hash)
			table.insert(orders, one.order)
			table.insert(lengths, one.length)

			if not latest_ver then
				local temp = string.splitToNumber(one.latest_ver, ".")

				latest_ver = temp[2] or 0
			end
		end

		self._optionalUpdateInst:StartDownload(lang, names, hashs, orders, lengths, latest_ver)

		self._eventMgrInst = SLFramework.GameUpdate.HotUpdateEvent.Instance

		self._eventMgrInst:AddLuaLisenter(SLFramework.GameUpdate.HotUpdateEvent.UnzipProgress, self._onUnzipProgress, self)
	else
		self._optionalUpdateInst:UnRegister(self._optionalUpdate.NotEnoughDiskSpace)
		self._optionalUpdateInst:UnRegister(self._optionalUpdate.DownloadStart)
		self._optionalUpdateInst:UnRegister(self._optionalUpdate.DownloadProgressRefresh)
		self._optionalUpdateInst:UnRegister(self._optionalUpdate.DownloadPackFail)
		self._optionalUpdateInst:UnRegister(self._optionalUpdate.DownloadPackSuccess)
		self._optionalUpdateInst:UnRegister(self._optionalUpdate.PackUnZipFail)
		self._optionalUpdateInst:UnRegister(self._optionalUpdate.PackItemStateChange)

		self._optionalUpdateInst = nil
		self._optionalUpdate = nil
		self._lang2DownloadList = nil
		self._downloadDict = nil

		self:_setDoneFirstDownload()

		if self._eventMgrInst then
			self._eventMgrInst:ClearLuaListener()

			self._eventMgrInst = nil
		end

		self._onDownloadFinish(self._onDownloadFinishObj)
	end
end

function VoiceDownloader:_setDoneFirstDownload()
	BootVoiceView.instance:setFirstDownloadDone()
end

function VoiceDownloader:_onDownloadStart(packName, curSize, allSize)
	self._downLoadStartTime = math.floor(Time.realtimeSinceStartup * 1000)

	logNormal("VoiceDownloader:_onDownloadStart, packName = " .. packName .. " curSize = " .. curSize .. " allSize = " .. allSize)

	curSize = tonumber(tostring(curSize))
	allSize = tonumber(tostring(allSize))
	self._nowPackSize = allSize
	self._downloadSize = curSize + self._downloadSuccSize

	self:statHotUpdate(0, self._downloadSize)
end

function VoiceDownloader:_onDownloadProgressRefresh(packName, curSize, allSize)
	curSize = tonumber(tostring(curSize))
	allSize = tonumber(tostring(allSize))

	local progressChanged = not self._prevSize or curSize ~= self._prevSize

	self._prevSize = curSize

	if HotUpdateMgr.instance:getFailCount() > 0 and progressChanged then
		if HotUpdateMgr.instance:getUseBackup() then
			if not self._downloadUrlBak then
				local url = self._downloadUrl
				local domain = string.match(url, "(https?://[^/]+)")

				SDKDataTrackMgr.instance:trackDomainFailCount("scene_voice_srcdownload", domain, HotUpdateMgr.instance:getFailCount())
				HotUpdateMgr.instance:resetFailCount()
			end
		end
	end

	logNormal("VoiceDownloader:_onDownloadProgressRefresh, packName = " .. packName .. " curSize = " .. curSize .. " allSize = " .. allSize)

	local size = curSize + self._downloadSuccSize

	self._downloadSize = size

	local percent = size / self._totalSize
	local s1 = self:_fixSizeStr(size)
	local s2 = self:_fixSizeStr(self._totalSize)
	local progressMsg

	self._downProgressS1 = s1
	self._downProgressS2 = s2

	if progressChanged then
		HotUpdateProgress.instance:setProgressDownloadVoice(curSize, self._downloadSuccSize, UnityEngine.Application.internetReachability == UnityEngine.NetworkReachability.ReachableViaLocalAreaNetwork and string.format(booterLang("download_info_wifi"), s1, s2) or string.format(booterLang("download_info"), s1, s2))
	end

	self:statHotUpdate(percent, size)
end

function VoiceDownloader:statHotUpdate(percent, size)
	for i = self._nowStatHotUpdatePerIndex, self._statHotUpdatePerNum do
		local v = self._statHotUpdatePerList[i]
		local startPoint = v[1]

		if startPoint <= percent or startPoint == 1 and self._totalSize - size < 1024 then
			local data = {}

			data.step = v[2]
			data.spend_time = math.floor(Time.realtimeSinceStartup * 1000) - self._downLoadStartTime
			data.update_amount = self:_fixSizeMB(self._totalSize - size)
			data.download_voice_pack_list = self._download_voice_pack_list

			SDKDataTrackMgr.instance:trackVoicePackDownloading(data)

			self._nowStatHotUpdatePerIndex = i + 1
		else
			break
		end
	end
end

function VoiceDownloader:_onPackItemStateChange(packName)
	logNormal("VoiceDownloader:_onPackItemStateChange, packName = " .. packName)
end

function VoiceDownloader:_onDownloadPackSuccess(packName)
	logNormal("VoiceDownloader:_onDownloadPackSuccess, packName = " .. packName)

	if self._downloadingList then
		for _, item in ipairs(self._downloadingList) do
			self._downloadSuccSize = self._downloadSuccSize + item.length
		end
	end

	self._downloadSize = self._downloadSuccSize
	self._lang2DownloadList[packName] = nil
	self._downloadingList = nil

	self:_startOneLangDownload()
end

function VoiceDownloader:_onDownloadPackFail(packName, resUrl, failError, errorMsg)
	logNormal("VoiceDownloader:_onDownloadPackFail, packName = " .. packName .. " resUrl = " .. resUrl .. " failError = " .. failError)

	if failError == 5 then
		self:_onNotEnoughDiskSpace(packName)
	else
		HotUpdateMgr.instance:inverseUseBackup()
		require("tolua.reflection")
		tolua.loadassembly("SL_AS")

		local type_OptionalUpdate = typeof(SLFramework.GameUpdate.OptionalUpdate)
		local field_useReserveUrl = tolua.getfield(type_OptionalUpdate, "_useReserveUrl", 36)

		field_useReserveUrl:Set(SLFramework.GameUpdate.OptionalUpdate.Instance, HotUpdateMgr.instance:getUseBackup())
		HotUpdateMgr.instance:incFailCount()

		if HotUpdateMgr.instance:isFailNeedAlert() then
			HotUpdateMgr.instance:resetFailAlertCount()

			local args = {}

			args.title = booterLang("hotupdate")
			args.content = self:_getDownloadFailedTip(failError, errorMsg)
			args.leftMsg = booterLang("exit")
			args.leftCb = self._quitGame
			args.leftCbObj = self
			args.rightMsg = booterLang("retry")
			args.rightCb = self._retry
			args.rightCbObj = self

			BootMsgBox.instance:show(args)
		else
			logNormal("VoiceDownloader 静默重试下载！")
			self:_retry()
			HotUpdateMgr.instance:showConnectTips()
		end
	end

	local data = {}

	data.step = "fail"
	data.spend_time = math.floor(Time.realtimeSinceStartup * 1000) - self._downLoadStartTime
	data.result_msg = self:_getDownloadFailedTip(failError, errorMsg)
	data.download_voice_pack_list = self._download_voice_pack_list
	data.update_amount = self:_fixSizeMB(self._totalSize - self._downloadSize)

	SDKDataTrackMgr.instance:trackVoicePackDownloading(data)
end

function VoiceDownloader:_onNotEnoughDiskSpace(packName)
	logNormal("VoiceDownloader:_onNotEnoughDiskSpace, packName = " .. packName)

	local args = {}

	args.title = booterLang("hotupdate")
	args.content = booterLang("download_fail_no_enough_disk")
	args.rightMsg = booterLang("exit")
	args.rightCb = self._quitGame
	args.rightCbObj = self

	BootMsgBox.instance:show(args)
end

function VoiceDownloader:_onPackUnZipFail(packName, failReason)
	if packName then
		logNormal("VoiceDownloader:_onPackUnZipFail, packName = " .. packName .. " failReason = " .. failReason)

		local args = {}

		args.title = booterLang("hotupdate")
		args.content = self:_getUnzipFailedTip(failReason)
		args.leftMsg = booterLang("exit")
		args.leftCb = self._quitGame
		args.leftCbObj = self
		args.rightMsg = booterLang("retry")
		args.rightCb = self._retry
		args.rightCbObj = self

		BootMsgBox.instance:show(args)
	end
end

function VoiceDownloader:_quitGame()
	ProjBooter.instance:quitGame()
end

function VoiceDownloader:_retry()
	self._optionalUpdateInst:RunNextStepAction()
end

function VoiceDownloader:_onUnzipProgress(progress)
	logNormal("正在解压语音包，请稍后... progress = " .. progress)

	if tostring(progress) == "nan" then
		return
	end

	if not self._downProgressS1 then
		local s1 = ""

		if not self._downProgressS2 then
			local s2 = ""
			local progressInt = math.floor(100 * progress + 0.5)
			local progressMsg

			HotUpdateProgress.instance:setProgressUnzipVoice(progress, self._nowPackSize, self._downloadSuccSize, UnityEngine.Application.internetReachability == UnityEngine.NetworkReachability.ReachableViaLocalAreaNetwork and string.format(booterLang("unziping_progress_wifi"), tostring(progressInt), s1, s2) or string.format(booterLang("unziping_progress"), tostring(progressInt), s1, s2))
		end
	end
end

function VoiceDownloader:cancelDownload()
	if self._optionalUpdateInst then
		self._optionalUpdateInst:StopDownload()

		self._errorCode = nil
	end
end

function VoiceDownloader:_getDownloadFailedTip(errorCode, errorMsg)
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

function VoiceDownloader:_getUnzipFailedTip(unzipState)
	local StateDefine = SLFramework.GameUpdate.UnzipStatus

	unzipState = StateDefine.IntToEnum(unzipState)

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

function VoiceDownloader:_fixSizeStr(size)
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

function VoiceDownloader:_fixSizeMB(size)
	local ret = size / HotUpdateMgr.MB_SIZE

	if ret < 0.001 then
		return 0.001
	end

	ret = ret - ret % 0.001

	return ret
end

return VoiceDownloader
