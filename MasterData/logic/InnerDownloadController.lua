-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/innerdownload/controller/InnerDownloadController.lua

module("logic.extensions.innerdownload.controller.InnerDownloadController", package.seeall)

local InnerDownloadController = class("InnerDownloadController", BaseController)
local VERSION_CODE = 1185
local res_ID = 0
local FUNC_ID = 36

function InnerDownloadController:onInit()
	self._actived = false
	self._isAutoDownload = false
	self._dataInited = false
	self._isLoadingInited = false
	self._dataList = {}

	table.insert(self._dataList, {
		id = 1,
		name = "角色战斗态资源",
		path = "character/"
	})
	table.insert(self._dataList, {
		id = 2,
		name = "技能特效资源",
		path = "effect/"
	})
	table.insert(self._dataList, {
		id = 3,
		name = "语音资源",
		path = "audio/fmod/"
	})
	table.insert(self._dataList, {
		id = 4,
		name = "角色立绘资源",
		path = "lihui_spine/"
	})
	self:onReset()
end

function InnerDownloadController:onReset()
	if self._isLoadingInited then
		self:pauseAllDownload()
	end

	self._isLoadingInited = false

	removetimer(self._onStartLoadNext, self)
end

function InnerDownloadController:getActive()
	return self._actived
end

function InnerDownloadController:getDataList()
	return self._dataList
end

function InnerDownloadController:getLoadInfoIdx(idx)
	if self._allLoaderList then
		return self._allLoaderList[idx]
	end
end

function InnerDownloadController:checkStartDownloadAll()
	if not self._isLoadingInited then
		self:_startDownloadAll()
	end
end

function InnerDownloadController:checkMobileNetworkAndVersion()
	self._actived = false
	self._isAutoDownload = false

	if not FuncOpenModel.instance:getFuncIsOpen(FUNC_ID) then
		return false
	end

	local versionCode = checknumber(BootstrapUtil.getGameVersionCode())

	if versionCode >= VERSION_CODE then
		self._actived = true

		self:_initAllRemoteData()

		local result = NetworkUtil.getCurrentNetworkType()

		if result == NetworkUtil.NETWORK_TYPE_WIFI then
			self._isAutoDownload = true

			self:checkStartDownloadAll()
			GlobalDispatcher:dispatch(GlobalNotify.INNER_DOWNLOAD_INITED)

			return false
		elseif result == NetworkUtil.NETWORK_TYPE_CELLULAR then
			self:checkStartDownloadAll()
			self:pauseAllDownload()
			GlobalDispatcher:dispatch(GlobalNotify.INNER_DOWNLOAD_INITED)

			return self._actived
		else
			return false
		end
	end

	return false
end

function InnerDownloadController:_initAllRemoteData()
	if self._dataInited then
		return
	end

	self._dataInited = true
	self._onlineResUpdateMgr = Framework.OnlineResUpdate.OnlineResUpdateMgr.Instance
	self._versionDataMgr = self._onlineResUpdateMgr.GamePlayLocalCacheVersionDataMgr

	local dict = self._versionDataMgr:GetRemoteData()

	self._all_downloading_map = {}
	self._urlList = {}

	local LAOD_LIST = {}

	for i, v in ipairs(self._dataList) do
		self._urlList[i] = {}
		LAOD_LIST[i] = v.path
	end

	local iter = dict:GetEnumerator()

	while iter:MoveNext() do
		local pair = iter.Current
		local key = pair.Key

		for i, v in ipairs(LAOD_LIST) do
			if string.find(key, v) then
				table.insert(self._urlList[i], key)
			end
		end
	end
end

function InnerDownloadController:_startDownloadAll()
	if BootstrapOnlineResMgr.instance.regCallBackByType then
		local OnlineResUpdateEventType = Framework.OnlineResUpdate.OnlineResUpdateEventType

		BootstrapOnlineResMgr.instance:regCallBackByType(OnlineResUpdateEventType.DownloadFileComplete, self._onDownloadFileComplete, self)
	end

	self._allLoaderList = {}

	local count = 0

	for i, pathList in ipairs(self._urlList) do
		local obj = {}

		obj.isPause = false
		obj.isDone = false
		obj.loader = self:downloadFilesWithSize(pathList, function()
			obj.isDone = true

			GlobalDispatcher:dispatch(GlobalNotify.INNER_DOWNLOAD_UPDATE, i)
		end, function(loader)
			GlobalDispatcher:dispatch(GlobalNotify.INNER_DOWNLOAD_UPDATE, i)
		end)

		if obj.loader.curCount == obj.loader.totalCount then
			obj.isDone = true
			count = count + 1
		end

		self._allLoaderList[i] = obj
	end

	if count == self._urlList then
		self._actived = false
	end

	self._isLoadingInited = true
end

function InnerDownloadController:pauseAllDownload()
	if self._allLoaderList then
		for i, v in ipairs(self._allLoaderList) do
			self:pauseDownloadIndex(i)
		end
	end
end

function InnerDownloadController:resumeAllDownload()
	if self._allLoaderList then
		for i, v in ipairs(self._allLoaderList) do
			self:resumeDownloadIndex(i)
		end
	end
end

function InnerDownloadController:pauseDownloadIndex(idx)
	if self._allLoaderList then
		local obj = self._allLoaderList[idx]

		if obj and obj.loader and obj.isPause == false and obj.isDone == false then
			obj.isPause = true

			local onlineDownloadMgr = Framework.OnlineResUpdate.OnlineResUpdateMgr.Instance.OnlineDownloadMgr

			for fileName, v in pairs(obj.loader.downloadingMap) do
				onlineDownloadMgr:PauseDownloadFile(fileName)
			end

			self:startLoadNext()
		end
	end
end

function InnerDownloadController:resumeDownloadIndex(idx)
	if self._allLoaderList then
		local obj = self._allLoaderList[idx]

		if obj and obj.loader and obj.isPause == true and obj.isDone == false then
			obj.isPause = false

			local firstN
			local onlineDownloadMgr = Framework.OnlineResUpdate.OnlineResUpdateMgr.Instance.OnlineDownloadMgr

			for fileName, v in pairs(obj.loader.downloadingMap) do
				onlineDownloadMgr:ResumeDownloadFile(fileName)
			end

			self:startLoadNext()
		end
	end
end

function InnerDownloadController:startLoadNext()
	removetimer(self._onStartLoadNext, self)
	settimer(0.1, self._onStartLoadNext, self, false)
end

function InnerDownloadController:_onStartLoadNext()
	local onlineDownloadMgr = Framework.OnlineResUpdate.OnlineResUpdateMgr.Instance.OnlineDownloadMgr

	onlineDownloadMgr:OnlineResLoadNext()
end

function InnerDownloadController:downloadFilesWithSize(urlList, completeHandler, progressHandler, handlerObj)
	if urlList and #urlList > 0 then
		local totalSize = 0
		local totalCount = 0
		local curSize = 0
		local curCount = 0
		local downloadingMap = {}
		local checkMap = {}

		for i, path in ipairs(urlList) do
			if checkMap[path] == nil then
				checkMap[path] = true

				local isNew = self._onlineResUpdateMgr:DownloadFileUntilUpdated(path, 1, false)
				local size = self._versionDataMgr:GetRemoteSize(path)

				size = checknumber(tostring(size))
				size = math.max(0, size)
				totalSize = totalSize + size
				totalCount = totalCount + 1

				if isNew then
					curSize = curSize + size
					curCount = curCount + 1
				else
					downloadingMap[path] = size
				end
			end
		end

		res_ID = res_ID + 1

		local loader = {}

		loader.id = res_ID
		loader.totalCount = totalCount
		loader.totalSize = totalSize
		loader.curCount = curCount
		loader.curSize = curSize
		loader.downloadingMap = downloadingMap
		loader.completeHandler = completeHandler
		loader.progressHandler = progressHandler
		loader.handlerObj = handlerObj

		if curCount == totalCount then
			self:_tryCallBackResComplete(loader)
		else
			self._all_downloading_map[loader.id] = loader
		end

		return loader
	else
		return nil
	end
end

function InnerDownloadController:_onDownloadFileComplete(task)
	local path = task.fileName

	for k, loader in pairs(self._all_downloading_map) do
		local size = loader.downloadingMap[path]

		if size ~= nil then
			loader.curSize = loader.curSize + size
			loader.curCount = loader.curCount + 1
			loader.downloadingMap[path] = nil

			if loader.curCount == loader.totalCount then
				self:_tryCallBackResComplete(loader)

				self._all_downloading_map[loader.id] = nil
			else
				self:_tryCallBackResProgress(loader)
			end
		end
	end
end

function InnerDownloadController:_tryCallBackResComplete(loader)
	self:_tryCallBackResProgress(loader)

	if loader.completeHandler then
		if loader.handlerObj then
			loader.completeHandler(loader.handlerObj, loader)
		else
			loader:completeHandler()
		end
	end
end

function InnerDownloadController:_tryCallBackResProgress(loader)
	if loader.progressHandler then
		if loader.handlerObj then
			loader.progressHandler(loader.handlerObj, loader)
		else
			loader:progressHandler()
		end
	end
end

InnerDownloadController.instance = InnerDownloadController.New()

return InnerDownloadController
