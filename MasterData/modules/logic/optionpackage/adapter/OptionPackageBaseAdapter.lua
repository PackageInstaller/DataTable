-- chunkname: @modules/logic/optionpackage/adapter/OptionPackageBaseAdapter.lua

module("modules.logic.optionpackage.adapter.OptionPackageBaseAdapter", package.seeall)

local OptionPackageBaseAdapter = class("OptionPackageBaseAdapter")

function OptionPackageBaseAdapter:ctor()
	return
end

function OptionPackageBaseAdapter:setDownloder(downloader, httpWorker)
	self._downloader = downloader
	self._httpWorker = httpWorker
end

function OptionPackageBaseAdapter:getHttpGetterList()
	logError("[OptionPackageBaseAdapter:getHttpGetterList()]子类及派生类重新该接口")
end

function OptionPackageBaseAdapter:getDownloadList()
	logError("[OptionPackageBaseAdapter:getHttpGetterList()]子类及派生类重新该接口")
end

function OptionPackageBaseAdapter:getDownloadUrl(packeName)
	if self._httpWorker then
		return self._httpWorker:getDownloadUrl(packeName)
	end
end

function OptionPackageBaseAdapter:onDownloadStart(packName, curSize, allSize)
	return
end

function OptionPackageBaseAdapter:onDownloadProgressRefresh(packName, curSize, allSize)
	return
end

function OptionPackageBaseAdapter:onDownloadPackSuccess(packName)
	return
end

function OptionPackageBaseAdapter:onDownloadPackFail(packName, resUrl, failError, errorMsg)
	return
end

function OptionPackageBaseAdapter:onNotEnoughDiskSpace(packName)
	return
end

function OptionPackageBaseAdapter:onUnzipProgress(progress)
	return
end

function OptionPackageBaseAdapter:onPackUnZipFail(packName, failReason)
	return
end

function OptionPackageBaseAdapter:onPackItemStateChange(packName)
	return
end

return OptionPackageBaseAdapter
