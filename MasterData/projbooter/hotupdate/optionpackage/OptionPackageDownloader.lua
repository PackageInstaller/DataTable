-- chunkname: @projbooter/hotupdate/optionpackage/OptionPackageDownloader.lua

module("projbooter.hotupdate.optionpackage.OptionPackageDownloader", package.seeall)

local OptionPackageDownloader = class("OptionPackageDownloader")
local AdapterFuncNameMap = {
	DownloadStart = "onDownloadStart",
	DownloadProgressRefresh = "onDownloadProgressRefresh",
	DownloadPackFail = "onDownloadPackFail",
	PackUnZipFail = "onPackUnZipFail",
	PackItemStateChange = "onPackItemStateChange",
	DownloadPackSuccess = "onDownloadPackSuccess",
	UnzipProgress = "onUnzipProgress",
	NotEnoughDiskSpace = "onNotEnoughDiskSpace"
}

function OptionPackageDownloader:start(downloadListTb, onFinish, finishObj, adapter)
	self._adppter = adapter

	local tempDownloadListTb = downloadListTb or {}

	self._lang2DownloadList = {}
	self._download_pack_list = {}
	self._totalSize = 0

	for lang, langTb in pairs(tempDownloadListTb) do
		if langTb and langTb.res and #langTb.res > 0 then
			self._lang2DownloadList[lang] = langTb

			table.insert(self._download_pack_list, lang)

			for _, oneRes in ipairs(langTb.res) do
				self._totalSize = self._totalSize + oneRes.length
			end
		end
	end

	self._statHotUpdatePerList = {}
	self._statHotUpdatePerList[1] = {
		0,
		"start"
	}
	self._statHotUpdatePerList[2] = {
		0.5,
		"50%"
	}
	self._statHotUpdatePerList[3] = {
		1,
		"100%"
	}
	self._statHotUpdatePerNum = #self._statHotUpdatePerList
	self._nowStatHotUpdatePerIndex = 1
	self._downLoadStartTime = math.floor(Time.realtimeSinceStartup * 1000)
	self._downloadSize = 0

	if self._totalSize > 0 then
		self._optionalUpdate = SLFramework.GameUpdate.OptionalUpdate
		self._optionalUpdateInst = self._optionalUpdate.Instance

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
		self:_checkAdppterFuncNames()
	else
		onFinish(finishObj)
	end
end

function OptionPackageDownloader:_startOneLangDownload()
	local packName, infoTb = next(self._lang2DownloadList)

	if packName and infoTb and infoTb.res then
		logNormal("OptionPackageDownloader:_startOneLangDownload, start download packName = " .. packName)

		self._downloadingList = {}

		tabletool.addValues(self._downloadingList, infoTb.res)
		self._optionalUpdateInst:SetRemoteAssetUrl(infoTb.download_url, infoTb.download_url_bak)

		local names = {}
		local hashs = {}
		local orders = {}
		local lengths = {}

		for _, one in ipairs(infoTb.res) do
			table.insert(names, one.name)
			table.insert(hashs, one.hash)
			table.insert(orders, one.order)
			table.insert(lengths, one.length)
		end

		local temp = string.splitToNumber(infoTb.latest_ver, ".")

		if not temp[2] then
			self._optionalUpdateInst:StartDownload(packName, names, hashs, orders, lengths, temp[2])

			self._eventMgrInst = SLFramework.GameUpdate.HotUpdateEvent.Instance

			self._eventMgrInst:AddLuaLisenter(SLFramework.GameUpdate.HotUpdateEvent.UnzipProgress, self._onUnzipProgress, self)
		end
	else
		logNormal("OptionPackageDownloader:_startOneLangDownload, download finish all")
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

		self._onDownloadFinish(self._onDownloadFinishObj)

		if self._eventMgrInst then
			self._eventMgrInst:ClearLuaListener()

			self._eventMgrInst = nil
		end
	end
end

function OptionPackageDownloader:_onDownloadStart(packName, curSize, allSize)
	self._downLoadStartTime = math.floor(Time.realtimeSinceStartup * 1000)

	logNormal("OptionPackageDownloader:_onDownloadStart, packName = " .. packName .. " curSize = " .. curSize .. " allSize = " .. allSize)

	curSize = tonumber(tostring(curSize))
	allSize = tonumber(tostring(allSize))
	self._downloadSize = curSize + self._downloadSuccSize

	self:_callAdppterFunc(AdapterFuncNameMap.DownloadStart, packName, curSize, allSize)
	self:statHotUpdate(0, self._downloadSize)
end

function OptionPackageDownloader:_onDownloadProgressRefresh(packName, curSize, allSize)
	curSize = tonumber(tostring(curSize))
	allSize = tonumber(tostring(allSize))

	logNormal("OptionPackageDownloader:_onDownloadProgressRefresh, packName = " .. packName .. " curSize = " .. curSize .. " allSize = " .. allSize)

	local size = curSize + self._downloadSuccSize

	self._downloadSize = size

	local percent = size / self._totalSize

	self:_callAdppterFunc(AdapterFuncNameMap.DownloadProgressRefresh, packName, curSize, allSize)
	self:statHotUpdate(percent, size)
end

function OptionPackageDownloader:statHotUpdate(percent, size)
	for i = self._nowStatHotUpdatePerIndex, self._statHotUpdatePerNum do
		local v = self._statHotUpdatePerList[i]
		local startPoint = v[1]

		if startPoint <= percent or startPoint == 1 and self._totalSize - size < 1024 then
			local data = {}

			data.step = v[2]
			data.spend_time = math.floor(Time.realtimeSinceStartup * 1000) - self._downLoadStartTime
			data.update_amount = self:_fixSizeMB(self._totalSize - size)
			data.resource_type = self._download_pack_list

			SDKDataTrackMgr.instance:trackOptionPackDownloading(data)

			self._nowStatHotUpdatePerIndex = i + 1
		else
			break
		end
	end
end

function OptionPackageDownloader:_onPackItemStateChange(packName)
	logNormal("OptionPackageDownloader:_onPackItemStateChange, packName = " .. packName)
	self:_callAdppterFunc(AdapterFuncNameMap.PackItemStateChange, packName)
end

function OptionPackageDownloader:_onDownloadPackSuccess(packName)
	logNormal("OptionPackageDownloader:_onDownloadPackSuccess, packName = " .. packName)

	if self._downloadingList then
		for _, item in ipairs(self._downloadingList) do
			self._downloadSuccSize = self._downloadSuccSize + item.length
		end
	end

	self._downloadSize = self._downloadSuccSize
	self._lang2DownloadList[packName] = nil
	self._downloadingList = nil

	self:_callAdppterFunc(AdapterFuncNameMap.DownloadPackSuccess, packName)

	local timer = Timer.New(function()
		self:_startOneLangDownload()
	end, 0.2)

	timer:Start()
end

function OptionPackageDownloader:_onDownloadPackFail(packName, resUrl, failError, errorMsg)
	logNormal("OptionPackageDownloader:_onDownloadPackFail, packName = " .. packName .. " resUrl = " .. resUrl .. " failError = " .. failError)
	self:_callAdppterFunc(AdapterFuncNameMap.DownloadPackFail, packName, resUrl, failError, errorMsg)

	local data = {}

	data.step = "fail"
	data.spend_time = math.floor(Time.realtimeSinceStartup * 1000) - self._downLoadStartTime
	data.result_msg = self:_getDownloadFailedTip(failError, errorMsg)
	data.update_amount = self:_fixSizeMB(self._totalSize - self._downloadSize)
	data.resource_type = self._download_pack_list

	SDKDataTrackMgr.instance:trackOptionPackDownloading(data)
end

function OptionPackageDownloader:_onNotEnoughDiskSpace(packName)
	self:_callAdppterFunc(AdapterFuncNameMap.NotEnoughDiskSpace, packName)
end

function OptionPackageDownloader:getDownloadSize()
	return self._downloadSize
end

function OptionPackageDownloader:getTotalSize()
	return self._totalSize
end

function OptionPackageDownloader:getDownloadSuccSize()
	return self._downloadSuccSize
end

function OptionPackageDownloader:_callAdppterFunc(funcName, p1, p2, p3, p4)
	if self._adppter and self._adppter[funcName] then
		self._adppter[funcName](self._adppter, p1, p2, p3, p4)
	end
end

function OptionPackageDownloader:_checkAdppterFuncNames()
	if self._adppter then
		for _, funcName in pairs(AdapterFuncNameMap) do
			if not self._adppter[funcName] then
				logWarn(string.format("class : [%s], can not find function : [%s]", self._adppter.__cname or "nil", funcName))
			end
		end
	end
end

function OptionPackageDownloader:_onPackUnZipFail(packName, failReason)
	self:_callAdppterFunc(AdapterFuncNameMap.PackUnZipFail, packName, failReason)
end

function OptionPackageDownloader:_quitGame()
	ProjBooter.instance:quitGame()
end

function OptionPackageDownloader:retry()
	self._optionalUpdateInst:RunNextStepAction()
end

function OptionPackageDownloader:_onUnzipProgress(progress)
	logNormal("正在解压独立资源包，请稍后... progress = " .. progress)

	if tostring(progress) == "nan" then
		return
	end

	self:_callAdppterFunc(AdapterFuncNameMap.UnzipProgress, progress)
end

function OptionPackageDownloader:cancelDownload()
	if self._optionalUpdateInst then
		self._optionalUpdateInst:StopDownload()

		self._errorCode = nil
	end
end

function OptionPackageDownloader:_getDownloadFailedTip(errorCode, errorMsg)
	self._errorCode = errorCode

	return OptionPackageDownloader.getDownloadFailedTip(errorCode, errorMsg)
end

function OptionPackageDownloader:_getUnzipFailedTip(unzipState)
	return OptionPackageDownloader.getUnzipFailedTip(unzipState)
end

function OptionPackageDownloader:_fixSizeStr(size)
	return HotUpdateMgr.fixSizeStr(size)
end

function OptionPackageDownloader:_fixSizeMB(size)
	return HotUpdateMgr.fixSizeMB(size)
end

function OptionPackageDownloader.getDownloadFailedTip(errorCode, errorMsg)
	local ErrorDefine = SLFramework.GameUpdate.FailError

	errorCode = ErrorDefine.IntToEnum(errorCode)
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

function OptionPackageDownloader.getUnzipFailedTip(unzipState)
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

return OptionPackageDownloader
