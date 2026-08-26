-- chunkname: @projbooter/hotupdate/optionpackage/HotUpateOptionPackageAdapter.lua

module("projbooter.hotupdate.optionpackage.HotUpateOptionPackageAdapter", package.seeall)

local HotUpateOptionPackageAdapter = class("HotUpateOptionPackageAdapter")

function HotUpateOptionPackageAdapter:ctor()
	self._downloadSuccSize = 0
end

function HotUpateOptionPackageAdapter:getHttpGetterList()
	local langPackList = HotUpdateOptionPackageMgr.instance:getHotUpdateLangPacks()
	local httpGeterList = {}

	if langPackList and #langPackList > 0 then
		table.insert(httpGeterList, OptionPackageHttpGetter.New(3, langPackList))
	end

	return httpGeterList
end

function HotUpateOptionPackageAdapter:setDownloder(downloader, packageMgr)
	self._downloader = downloader
	self._packageMgr = packageMgr or HotUpdateOptionPackageMgr.instance
end

function HotUpateOptionPackageAdapter:_downloadRetry()
	self._downloader:retry()
end

function HotUpateOptionPackageAdapter:_quitGame()
	ProjBooter.instance:quitGame()
end

function HotUpateOptionPackageAdapter:_fixSizeStr(size)
	return HotUpdateMgr.fixSizeStr(size)
end

function HotUpateOptionPackageAdapter:_fixSizeMB(size)
	return HotUpdateMgr.fixSizeMB(size)
end

function HotUpateOptionPackageAdapter:onDownloadStart(packName, curSize, allSize)
	self._nowPackSize = allSize
end

function HotUpateOptionPackageAdapter:onDownloadProgressRefresh(packName, curSize, allSize)
	logNormal("HotUpateOptionPackageAdapter:onDownloadProgressRefresh, packName = " .. packName .. " curSize = " .. curSize .. " allSize = " .. allSize)

	curSize = tonumber(tostring(curSize))
	allSize = tonumber(tostring(allSize))

	local size = self._downloader:getDownloadSize()
	local totalSize = self._downloader:getTotalSize()
	local s1 = self:_fixSizeStr(size)
	local s2 = self:_fixSizeStr(totalSize)

	self._downProgressS1 = s1
	self._downProgressS2 = s2

	local progressMsg

	HotUpdateProgress.instance:setProgressDownloadOptionPackage(curSize, self._downloader:getDownloadSuccSize(), UnityEngine.Application.internetReachability == UnityEngine.NetworkReachability.ReachableViaLocalAreaNetwork and string.format(booterLang("download_info_wifi"), s1, s2) or string.format(booterLang("download_info"), s1, s2))
end

function HotUpateOptionPackageAdapter:onDownloadPackSuccess(packName)
	return
end

function HotUpateOptionPackageAdapter:onDownloadPackFail(packName, resUrl, failError, errorMsg)
	if failError == 5 then
		self:onNotEnoughDiskSpace(packName)
	else
		local args = {}

		args.title = booterLang("hotupdate")
		args.content = OptionPackageDownloader.getDownloadFailedTip(failError, errorMsg)
		args.leftMsg = booterLang("exit")
		args.leftCb = self._quitGame
		args.leftCbObj = self
		args.rightMsg = booterLang("retry")
		args.rightCb = self._downloadRetry
		args.rightCbObj = self

		BootMsgBox.instance:show(args)
	end
end

function HotUpateOptionPackageAdapter:onNotEnoughDiskSpace(packName)
	logNormal("HotUpateOptionPackageAdapter:_onNotEnoughDiskSpace, packName = " .. packName)

	local args = {}

	args.title = booterLang("hotupdate")
	args.content = booterLang("download_fail_no_enough_disk")
	args.rightMsg = booterLang("exit")
	args.rightCb = self._quitGame
	args.rightCbObj = self

	BootMsgBox.instance:show(args)
end

function HotUpateOptionPackageAdapter:onUnzipProgress(progress)
	if tostring(progress) == "nan" then
		return
	end

	if not self._downProgressS1 then
		local s1 = ""

		if not self._downProgressS2 then
			local s2 = ""
			local progressInt = math.floor(100 * progress + 0.5)
			local progressMsg

			HotUpdateProgress.instance:setProgressUnzipOptionPackage(progress, self._nowPackSize, self._downloader:getDownloadSuccSize(), UnityEngine.Application.internetReachability == UnityEngine.NetworkReachability.ReachableViaLocalAreaNetwork and string.format(booterLang("unziping_progress_wifi"), tostring(progressInt), s1, s2) or string.format(booterLang("unziping_progress"), tostring(progressInt), s1, s2))
		end
	end
end

function HotUpateOptionPackageAdapter:onPackUnZipFail(packName, failReason)
	if packName then
		local args = {}

		args.title = booterLang("hotupdate")
		args.content = OptionPackageDownloader._getUnzipFailedTip(failReason)
		args.leftMsg = booterLang("exit")
		args.leftCb = self._quitGame
		args.leftCbObj = self
		args.rightMsg = booterLang("retry")
		args.rightCb = self._downloadRetry
		args.rightCbObj = self

		BootMsgBox.instance:show(args)
	end
end

function HotUpateOptionPackageAdapter:onPackItemStateChange(packName)
	return
end

return HotUpateOptionPackageAdapter
