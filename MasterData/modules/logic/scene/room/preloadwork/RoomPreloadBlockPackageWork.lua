-- chunkname: @modules/logic/scene/room/preloadwork/RoomPreloadBlockPackageWork.lua

module("modules.logic.scene.room.preloadwork.RoomPreloadBlockPackageWork", package.seeall)

local RoomPreloadBlockPackageWork = class("RoomPreloadBlockPackageWork", BaseWork)

function RoomPreloadBlockPackageWork:onStart(context)
	local mapBlockUrlList = self:_getMapBlockUrlList()

	self._loader = MultiAbLoader.New()

	for _, resPath in ipairs(mapBlockUrlList) do
		self._loader:addPath(resPath)
	end

	self._loader:setLoadFailCallback(self._onPreloadOneFail)
	self._loader:startLoad(self._onPreloadFinish, self)
end

function RoomPreloadBlockPackageWork:_onPreloadFinish(loader)
	local assetItemDict = loader:getAssetItemDict()

	for url, assetItem in pairs(assetItemDict) do
		self.context.callback(self.context.callbackObj, url, assetItem)
	end

	self:onDone(true)
end

function RoomPreloadBlockPackageWork:_onPreloadOneFail(loader, assetItem)
	logError("RoomPreloadBlockPackageWork: 加载失败, url: " .. assetItem.ResPath)
end

function RoomPreloadBlockPackageWork:clearWork()
	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end
end

function RoomPreloadBlockPackageWork:_getMapBlockUrlList()
	local urlList = {}
	local abList = {}
	local blockResUrlDict = {}
	local blockABUrlDict = {}
	local fullBlockMOList = RoomMapBlockModel.instance:getFullBlockMOList()

	for i, blockMO in ipairs(fullBlockMOList) do
		local defineId = blockMO.defineId
		local res = RoomResHelper.getBlockPath(defineId)
		local ab = RoomResHelper.getBlockABPath(defineId)

		blockResUrlDict[res] = true
		blockABUrlDict[ab] = true
		self.context.resABDict[res] = ab
	end

	for url, _ in pairs(blockResUrlDict) do
		table.insert(urlList, url)
	end

	for url, _ in pairs(blockABUrlDict) do
		table.insert(abList, url)
	end

	for i, url in ipairs(urlList) do
		self.context.poolGODict[url] = 0
	end

	return abList
end

return RoomPreloadBlockPackageWork
