-- chunkname: @modules/logic/scene/room/preloadwork/RoomPreloadBuildingWork.lua

module("modules.logic.scene.room.preloadwork.RoomPreloadBuildingWork", package.seeall)

local RoomPreloadBuildingWork = class("RoomPreloadBuildingWork", BaseWork)

function RoomPreloadBuildingWork:onStart(context)
	local uiUrlList = self:_getUIUrlList()

	self._loader = MultiAbLoader.New()

	for _, resPath in ipairs(uiUrlList) do
		self._loader:addPath(resPath)
	end

	self._loader:setLoadFailCallback(self._onPreloadOneFail)
	self._loader:startLoad(self._onPreloadFinish, self)
end

function RoomPreloadBuildingWork:_onPreloadFinish(loader)
	local assetItemDict = loader:getAssetItemDict()

	for url, assetItem in pairs(assetItemDict) do
		self.context.callback(self.context.callbackObj, url, assetItem)
	end

	self:onDone(true)
end

function RoomPreloadBuildingWork:_onPreloadOneFail(loader, assetItem)
	logError("RoomPreloadBuildingWork: 加载失败, url: " .. assetItem.ResPath)
end

function RoomPreloadBuildingWork:clearWork()
	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end
end

function RoomPreloadBuildingWork:_getUIUrlList()
	local urlList = {}
	local ownBuildingList = RoomMapBuildingModel.instance:getBuildingMOList()

	for _, buildingMO in ipairs(ownBuildingList) do
		local url = RoomResHelper.getBuildingPath(buildingMO.buildingId, buildingMO.level)

		table.insert(urlList, url)
	end

	table.insert(urlList, RoomScenePreloader.ResInitBuilding)

	for i, url in ipairs(urlList) do
		self.context.poolGODict[url] = 0
	end

	return urlList
end

return RoomPreloadBuildingWork
