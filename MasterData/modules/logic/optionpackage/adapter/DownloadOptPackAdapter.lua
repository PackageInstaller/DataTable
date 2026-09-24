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

return DownloadOptPackAdapter
