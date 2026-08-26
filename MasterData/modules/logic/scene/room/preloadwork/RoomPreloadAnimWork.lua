-- chunkname: @modules/logic/scene/room/preloadwork/RoomPreloadAnimWork.lua

module("modules.logic.scene.room.preloadwork.RoomPreloadAnimWork", package.seeall)

local RoomPreloadAnimWork = class("RoomPreloadAnimWork", BaseWork)

function RoomPreloadAnimWork:onStart(context)
	local animUrlList = self:_getAnimUrlList()

	self._loader = MultiAbLoader.New()

	for _, resPath in ipairs(animUrlList) do
		self._loader:addPath(resPath)
	end

	self._loader:setLoadFailCallback(self._onPreloadOneFail)
	self._loader:startLoad(self._onPreloadFinish, self)
end

function RoomPreloadAnimWork:_onPreloadFinish(loader)
	local assetItemDict = loader:getAssetItemDict()

	for url, assetItem in pairs(assetItemDict) do
		self.context.callback(self.context.callbackObj, url, assetItem)
	end

	self:onDone(true)
end

function RoomPreloadAnimWork:_onPreloadOneFail(loader, assetItem)
	logError("RoomPreloadAnimWork: 加载失败, url: " .. assetItem.ResPath)
end

function RoomPreloadAnimWork:clearWork()
	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end
end

function RoomPreloadAnimWork:_getAnimUrlList()
	local urlList = {}

	for _, res in pairs(RoomScenePreloader.ResAnim) do
		table.insert(urlList, res)
	end

	return urlList
end

return RoomPreloadAnimWork
