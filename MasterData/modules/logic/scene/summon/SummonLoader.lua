-- chunkname: @modules/logic/scene/summon/SummonLoader.lua

module("modules.logic.scene.summon.SummonLoader", package.seeall)

local SummonLoader = class("SummonLoader")

function SummonLoader:init(allResPath)
	self._resList = allResPath
	self.loadABCount = 5
	self.callbackPerFrameCount = 2
	self._isLoaded = false
	self._isLoading = false
	self._needSyncLoad = false
	self._assetItemDict = {}
	self._assetItemList = {}
	self._loadFrameBuffer = nil
	self._loadOneCallback = nil
	self._loadOneCallbackObj = nil
	self._loadAllCallback = nil
	self._loadAllCallbackObj = nil
end

function SummonLoader:checkStartLoad(needSync)
	self._needSyncLoad = self._needSyncLoad or needSync

	if not self._isLoaded and not self._isLoading then
		self:startLoad()
	end
end

function SummonLoader:startLoad()
	if not self._resList then
		logError("_resList need be filled!")

		return
	end

	self._isLoading = true
	self._loader = SequenceAbLoader.New()

	self._loader:setPathList(self._resList)
	self._loader:setConcurrentCount(self.loadABCount)
	self._loader:startLoad(self.onLoadCompletedSwitch, self)
end

function SummonLoader:addSceneUrl(url)
	table.insert(self._resList, url)
end

function SummonLoader:isResInList(targetPath)
	for _, path in ipairs(self._resList) do
		if targetPath == path then
			return true
		end
	end

	return false
end

function SummonLoader:onLoadCompletedSwitch()
	logNormal("onLoadCompletedSwitch")

	if not self._isLoading then
		return
	end

	if self._needSyncLoad then
		self:onLoadCompletedSync()
	else
		self:onLoadCompletedAsync()
	end
end

function SummonLoader:onLoadCompletedSync()
	local assetItemDict = self._loader:getAssetItemDict()

	for url, assetItem in pairs(assetItemDict) do
		if self._loadOneCallback then
			assetItem:Retain()
			table.insert(self._assetItemList, assetItem)

			self._assetItemDict[url] = assetItem

			self:doOneItemCallback(url, assetItem)
		end
	end

	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end

	self._isLoading = false
	self._isLoaded = true

	self:doAllItemCallback()
end

function SummonLoader:onLoadCompletedAsync()
	self._loadFrameBuffer = self._loadFrameBuffer or {}

	local assetItemDict = self._loader:getAssetItemDict()

	for url, assetItem in pairs(assetItemDict) do
		assetItem:Retain()
		table.insert(self._assetItemList, assetItem)

		self._assetItemDict[url] = assetItem

		table.insert(self._loadFrameBuffer, url)
	end

	if self._uiLoader then
		self._uiLoader:dispose()

		self._uiLoader = nil
	end

	TaskDispatcher.runRepeat(self.repeatCallbackFrame, self, 0.001)
end

function SummonLoader:repeatCallbackFrame()
	if not self._isLoading or self._isLoaded then
		TaskDispatcher.cancelTask(self.repeatCallbackFrame, self)

		return
	end

	for i = 1, (self._needSyncLoad or nil) and 9999 do
		local count = #self._loadFrameBuffer

		if count > 0 then
			local url = self._loadFrameBuffer[count]

			self._loadFrameBuffer[count] = nil

			local assetItem = self._assetItemDict[url]

			if assetItem then
				self:doOneItemCallback(url, assetItem)
			end
		else
			TaskDispatcher.cancelTask(self.repeatCallbackFrame, self)

			self._isLoading = false
			self._isLoaded = true

			self:doAllItemCallback()

			return
		end
	end
end

function SummonLoader:setLoadOneItemCallback(callback, callbackObj)
	self._loadOneCallback = callback
	self._loadOneCallbackObj = callbackObj
end

function SummonLoader:setLoadFinishCallback(callback, callbackObj)
	self._loadAllCallback = callback
	self._loadAllCallbackObj = callbackObj
end

function SummonLoader:doOneItemCallback(url, assetItem)
	if not self._loadOneCallback then
		return
	end

	if self._loadOneCallbackObj then
		self._loadOneCallback(self._loadOneCallbackObj, url, assetItem)
	else
		self._loadOneCallback(url, assetItem)
	end
end

function SummonLoader:doAllItemCallback()
	if not self._loadAllCallback then
		return
	end

	if self._loadAllCallbackObj then
		self._loadAllCallback(self._loadAllCallbackObj, self)
	else
		self:_loadAllCallback()
	end
end

function SummonLoader:getAssetItem(path)
	local assetItem = self._assetItemDict[path]

	if assetItem then
		return assetItem
	end
end

function SummonLoader:dispose()
	if not self._isDisposed then
		self._isDisposed = true
		self._isLoading = false
		self._isLoaded = false

		TaskDispatcher.cancelTask(self.repeatCallbackFrame, self)

		if self._loader then
			self._loader:dispose()

			self._loader = nil
		end

		for _, assetItem in ipairs(self._assetItemList) do
			assetItem:Release()
		end

		self._assetItemList = nil
		self._assetItemDict = nil
	end
end

return SummonLoader
