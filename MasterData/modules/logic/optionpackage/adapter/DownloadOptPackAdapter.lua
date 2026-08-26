-- chunkname: @modules/logic/optionpackage/adapter/DownloadOptPackAdapter.lua

module("modules.logic.optionpackage.adapter.DownloadOptPackAdapter", package.seeall)

local DownloadOptPackAdapter = class("DownloadOptPackAdapter", OptionPackageBaseAdapter)

function DownloadOptPackAdapter:ctor(lands)
	self._langList = {}

	tabletool.addValues(self._langList, lands)
end

function DownloadOptPackAdapter:getHttpGetterList()
	return {}
end

function DownloadOptPackAdapter:getDownloadList()
	if self._httpWorker then
		return self._httpWorker:getHttpResult()
	end
end

function DownloadOptPackAdapter:onDownloadProgressRefresh(packName, curSize, allSize)
	logNormal("DownloadOptPackAdapter:onDownloadProgressRefresh, packName = " .. packName .. " curSize = " .. curSize .. " allSize = " .. allSize)

	local size = self._downloader:getDownloadSize() or 0
	local totalSize = self._downloader:getTotalSize()

	OptionPackageModel.instance:setDownloadProgress(packName, curSize, allSize)
	OptionPackageController.instance:dispatchEvent(OptionPackageEvent.DownloadProgressRefresh, packName, size, totalSize)
end

function DownloadOptPackAdapter:onDownloadPackSuccess(packName)
	logNormal("包体下载成功, packName = " .. packName)
	OptionPackageModel.instance:onDownloadSucc(packName)
end

function DownloadOptPackAdapter:onDownloadPackFail(packName, resUrl, failError, errorMsg)
	if failError == 5 then
		self:onNotEnoughDiskSpace(packName)
	else
		local failTips = OptionPackageDownloader.getDownloadFailedTip(failError, errorMsg)

		logNormal("下载失败, packName = " .. packName .. " " .. failTips)
		self:_showErrorMsgBox(string.format("%s(%s)", failTips, packName))
	end
end

function DownloadOptPackAdapter:onNotEnoughDiskSpace(packName)
	logNormal("sdk空间不足下载失败, packName = " .. packName)

	local failTips = booterLang("download_fail_no_enough_disk")

	self:_showErrorMsgBox(string.format("%s(%s)", failTips, packName))
end

function DownloadOptPackAdapter:onUnzipProgress(progress)
	if tostring(progress) == "nan" then
		return
	end

	OptionPackageController.instance:dispatchEvent(OptionPackageEvent.UnZipProgressRefresh, progress)
end

function DownloadOptPackAdapter:onPackUnZipFail(packName, failReason)
	if packName then
		local failTips = OptionPackageDownloader.getUnzipFailedTip(failReason)

		logNormal(failTips)
		self:_showErrorMsgBox(failTips)
	end
end

function DownloadOptPackAdapter:_retryDownload()
	if self._downloader then
		self._downloader:retry()
	end
end

function DownloadOptPackAdapter:_exitDownload()
	if self._downloader then
		self._downloader:cancelDownload()
	end

	OptionPackageController.instance:stopDownload()
end

function DownloadOptPackAdapter:_showErrorMsgBox(tipsStr)
	local messageBoxId = MessageBoxIdDefine.OptPackDownloadError
	local msgBoxType = MsgBoxEnum.BoxType.Yes_No
	local yesStr = booterLang("retry")
	local yesStrEn = "RETRY"
	local noStr = booterLang("exit")
	local noStrEn = "CANCEL"
	local yesCallback = self._retryDownload
	local noCallback = self._exitDownload
	local msgInfo = {
		msg = MessageBoxConfig.instance:getMessage(messageBoxId),
		msgBoxType = msgBoxType,
		yesCallback = yesCallback,
		noCallback = noCallback,
		yesCallbackObj = self,
		noCallbackObj = self,
		yesStr = yesStr,
		noStr = noStr,
		yesStrEn = yesStrEn,
		noStrEn = noStrEn,
		extra = tipsStr
	}

	OptionPackageController.instance:dispatchEvent(OptionPackageEvent.DownladErrorMsg, msgInfo)
end

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

return DownloadOptPackAdapter
