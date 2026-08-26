-- chunkname: @modules/logic/scene/room/preloadwork/RoomPreloadUIWork.lua

module("modules.logic.scene.room.preloadwork.RoomPreloadUIWork", package.seeall)

local RoomPreloadUIWork = class("RoomPreloadUIWork", BaseWork)

function RoomPreloadUIWork:onStart(context)
	local uiUrlList = self:_getUIUrlList()

	self._loader = MultiAbLoader.New()

	for _, resPath in ipairs(uiUrlList) do
		self._loader:addPath(resPath)
	end

	self._loader:setLoadFailCallback(self._onPreloadOneFail)
	self._loader:startLoad(self._onPreloadFinish, self)
end

function RoomPreloadUIWork:_onPreloadFinish(loader)
	local assetItemDict = loader:getAssetItemDict()

	for url, assetItem in pairs(assetItemDict) do
		self.context.callback(self.context.callbackObj, url, assetItem)
	end

	self:onDone(true)
end

function RoomPreloadUIWork:_onPreloadOneFail(loader, assetItem)
	logError("RoomPreloadUIWork: 加载失败, url: " .. assetItem.ResPath)
end

function RoomPreloadUIWork:clearWork()
	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end
end

function RoomPreloadUIWork:_getUIUrlList()
	local urlList = {}

	if RoomController.instance:isDebugPackageMode() then
		table.insert(urlList, RoomScenePreloader.ResDebugPackageUI)
	end

	table.insert(urlList, RoomViewConfirm.prefabPath)

	for i, url in ipairs(urlList) do
		self.context.poolUIDict[url] = true
	end

	return urlList
end

return RoomPreloadUIWork
