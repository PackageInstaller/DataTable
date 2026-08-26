-- chunkname: @modules/logic/scene/room/preloadwork/RoomPreloadMapBlockWork.lua

module("modules.logic.scene.room.preloadwork.RoomPreloadMapBlockWork", package.seeall)

local RoomPreloadMapBlockWork = class("RoomPreloadMapBlockWork", BaseWork)

function RoomPreloadMapBlockWork:onStart(context)
	local mapBlockUrlList = self:_getMapBlockUrlList()

	self._loader = MultiAbLoader.New()

	if GameResMgr.IsFromEditorDir then
		for _, resPath in ipairs(mapBlockUrlList) do
			self._loader:addPath(resPath)
		end
	else
		for resPath, _ in pairs(mapBlockUrlList) do
			self._loader:addPath(resPath)
		end
	end

	local len = tabletool.len(mapBlockUrlList)

	self._timestamp = Time.GetTimestamp()

	self._loader:setLoadFailCallback(self._onPreloadOneFail)
	self._loader:startLoad(self._onPreloadFinish, self)
end

function RoomPreloadMapBlockWork:_onPreloadFinish(loader)
	local assetItemDict = loader:getAssetItemDict()

	for url, assetItem in pairs(assetItemDict) do
		self.context.callback(self.context.callbackObj, url, assetItem)
	end

	self:onDone(true)
end

function RoomPreloadMapBlockWork:_onPreloadOneFail(loader, assetItem)
	logError("RoomPreloadMapBlockWork: 加载失败, url: " .. assetItem.ResPath)
end

function RoomPreloadMapBlockWork:clearWork()
	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end
end

function RoomPreloadMapBlockWork:_getMapBlockUrlList()
	local urlList = {}
	local urlList2 = {}

	table.insert(urlList, ResUrl.getRoomRes("ground/water/water"))
	table.insert(urlList, RoomScenePreloader.InitLand)

	local defineBlockTypes, defineWaterTypes = self:_findDefineBlockAndWaterTypes()

	for i = 1, #defineBlockTypes do
		local defineBlockType = defineBlockTypes[i]

		self:_addRiverFloorUrlByBlockType(urlList, RoomRiverEnum.LakeFloorType, defineBlockType)
		self:_addRiverFloorUrlByBlockType(urlList, RoomRiverEnum.LakeFloorBType, defineBlockType)
		self:_addRiverFloorUrlByBlockType(urlList, RoomRiverEnum.RiverBlockType, defineBlockType)
		table.insert(urlList, RoomResHelper.getBlockLandPath(defineBlockType, false)[1])
		table.insert(urlList, RoomResHelper.getBlockLandPath(defineBlockType, true)[1])
	end

	for i = 1, #defineWaterTypes do
		local defineWaterType = defineWaterTypes[i]

		self:_addWaterBlockUrlByWaterType(urlList, RoomRiverEnum.RiverBlockType, defineWaterType)
		self:_addWaterBlockUrlByWaterType(urlList, RoomRiverEnum.LakeBlockType, defineWaterType)
	end

	local buildingMOList = RoomMapBuildingModel.instance:getBuildingMOList()

	for i, buildingMO in ipairs(buildingMOList) do
		table.insert(urlList, RoomResHelper.getBuildingPath(buildingMO.buildingId, buildingMO.level))
	end

	for i, url in ipairs(urlList) do
		self.context.poolGODict[url] = 1
		urlList2[url] = 1
	end

	if GameResMgr.IsFromEditorDir then
		return urlList
	else
		return urlList2
	end
end

function RoomPreloadMapBlockWork:_addRiverFloorUrlByBlockType(urlList, dict, defineBlockType)
	for _, blockFloorType in pairs(dict) do
		local resPath, abPath = RoomResHelper.getMapRiverFloorResPath(blockFloorType, defineBlockType)

		table.insert(urlList, abPath)
	end
end

function RoomPreloadMapBlockWork:_addWaterBlockUrlByWaterType(urlList, dict, defineWaterType)
	for _, lakeBlockType in pairs(dict) do
		local resPath, abPath = RoomResHelper.getMapBlockResPath(RoomResourceEnum.ResourceId.River, lakeBlockType, defineWaterType)

		table.insert(urlList, abPath)
	end
end

function RoomPreloadMapBlockWork:_findDefineBlockAndWaterTypes()
	local fullBlockMOList = RoomMapBlockModel.instance:getFullBlockMOList()
	local blockTypes = {}
	local waterTypes = {}

	for i = 1, #fullBlockMOList do
		local blockMO = fullBlockMOList[i]
		local blockType = blockMO:getDefineBlockType()
		local waterType = blockMO:getDefineWaterType()

		if not tabletool.indexOf(blockTypes, blockType) then
			table.insert(blockTypes, blockType)
		end

		if not tabletool.indexOf(waterTypes, waterType) then
			table.insert(waterTypes, waterType)
		end
	end

	return blockTypes, waterTypes
end

return RoomPreloadMapBlockWork
