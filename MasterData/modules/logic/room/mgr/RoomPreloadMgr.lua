-- chunkname: @modules/logic/room/mgr/RoomPreloadMgr.lua

module("modules.logic.room.mgr.RoomPreloadMgr", package.seeall)

local RoomPreloadMgr = class("RoomPreloadMgr", BaseController)

function RoomPreloadMgr:onInit()
	return
end

function RoomPreloadMgr:reInit()
	return
end

function RoomPreloadMgr:addConstEvents()
	return
end

function RoomPreloadMgr:startPreload()
	if self._loader then
		self._loader:dispose()
	end

	self._loader = SequenceAbLoader.New()

	self:_addPreloadList(self:_getSceneLevel())
	self:_addPreloadList(self:_getView())
	self:_addPreloadList(self:_getUIUrlList())
	self:_addPreloadList(self:_getGOUrlList())
	self:_addPreloadList(self:_getAnimUrlList())
	self:_addPreloadList(self:_getBuildingUrlList())
	self._loader:setConcurrentCount(#self._loader._pathList / 5)
	RoomHelper.logElapse("++++++++++++ RoomPreloadMgr:startPreload, count = " .. #self._loader._pathList)
	self._loader:setOneFinishCallback(self._onOneFinish)
	self._loader:startLoad(self._onLoadFinish, self)
end

function RoomPreloadMgr:_onOneFinish(loader, assetItem)
	assetItem:GetResource(assetItem.ResPath)
end

function RoomPreloadMgr:_onLoadFinish(loader)
	RoomHelper.logElapse("---------------- RoomPreloadMgr:preloadFinish, count = " .. #self._loader._pathList)
end

function RoomPreloadMgr:_addPreloadList(list)
	for _, path in ipairs(list) do
		self._loader:addPath(path)
	end
end

function RoomPreloadMgr:_getSceneLevel()
	local levelCOs = SceneConfig.instance:getSceneLevelCOs(RoomEnum.RoomSceneId)

	if levelCOs then
		local levelId = levelCOs[1].id

		return {
			ResUrl.getSceneLevelUrl(levelId)
		}
	end

	return {}
end

function RoomPreloadMgr:_getView()
	local list = {}
	local roomViewSetting = ViewMgr.instance:getSetting(ViewName.RoomView)

	table.insert(list, roomViewSetting.mainRes)

	if roomViewSetting.otherRes then
		for _, path in ipairs(roomViewSetting.otherRes) do
			table.insert(list, path)
		end
	end

	if roomViewSetting.tabRes then
		for _, pathList in pairs(roomViewSetting.tabRes) do
			for _, pathList2 in pairs(pathList) do
				for _, path in ipairs(pathList2) do
					table.insert(list, path)
				end
			end
		end
	end

	return list
end

function RoomPreloadMgr:_getMapBlockUrlList()
	local urlList = {}

	table.insert(urlList, ResUrl.getRoomRes("ground/water/water"))
	table.insert(urlList, RoomScenePreloader.DefaultLand)
	table.insert(urlList, RoomScenePreloader.InitLand)
	table.insert(urlList, RoomScenePreloader.ReplaceLand)

	for _, riverBlockType in pairs(RoomRiverEnum.RiverBlockType) do
		table.insert(urlList, RoomResHelper.getMapBlockResPath(RoomResourceEnum.ResourceId.River, riverBlockType))
		table.insert(urlList, RoomResHelper.getMapRiverFloorResPath(riverBlockType))
	end

	for _, lakeBlockType in pairs(RoomRiverEnum.LakeBlockType) do
		table.insert(urlList, RoomResHelper.getMapBlockResPath(RoomResourceEnum.ResourceId.River, lakeBlockType))
	end

	for _, lakeBlockType in pairs(RoomRiverEnum.LakeFloorType) do
		table.insert(urlList, RoomResHelper.getMapRiverFloorResPath(lakeBlockType))
	end

	local buildingMOList = RoomMapBuildingModel.instance:getBuildingMOList()

	for i, buildingMO in ipairs(buildingMOList) do
		table.insert(urlList, RoomResHelper.getBuildingPath(buildingMO.buildingId, buildingMO.level))
	end

	return urlList
end

function RoomPreloadMgr:_getUIUrlList()
	local urlList = {}

	if RoomController.instance:isDebugPackageMode() then
		table.insert(urlList, RoomScenePreloader.ResDebugPackageUI)
	end

	table.insert(urlList, RoomViewConfirm.prefabPath)

	return urlList
end

function RoomPreloadMgr:_getGOUrlList()
	local urlList = {}

	if RoomController.instance:isEditMode() then
		table.insert(urlList, RoomScenePreloader.ResEffectB)
		table.insert(urlList, RoomScenePreloader.ResVXPlacingHere)
		table.insert(urlList, RoomScenePreloader.ResSmoke)
	end

	if RoomController.instance:isObMode() then
		table.insert(urlList, RoomScenePreloader.ResEffectE)
		table.insert(urlList, RoomScenePreloader.ResEffectD01)
		table.insert(urlList, RoomScenePreloader.ResEffectD02)
		table.insert(urlList, RoomScenePreloader.ResEffectD05)
		table.insert(urlList, RoomScenePreloader.ResVXXuXian)
		table.insert(urlList, RoomScenePreloader.ResCharacterClickHelper)
		table.insert(urlList, RoomScenePreloader.ResEffectConfirmCharacter)
		table.insert(urlList, RoomScenePreloader.ResEffectCharacterShadow)
		table.insert(urlList, RoomScenePreloader.ResEffectPressingCharacter)
		table.insert(urlList, RoomScenePreloader.ResEffectPlaceCharacter)
	end

	if RoomController.instance:isVisitMode() then
		table.insert(urlList, RoomScenePreloader.ResEffectCharacterShadow)
	end

	for _, res in ipairs(RoomScenePreloader.ResEffectWaveList) do
		table.insert(urlList, res)
	end

	for _, res in ipairs(RoomScenePreloader.ResEffectWaveWithRiverList) do
		table.insert(urlList, res)
	end

	if RoomController.instance:isDebugPackageMode() then
		for _, res in pairs(RoomScenePreloader.ResDebugPackageColorDict) do
			table.insert(urlList, res)
		end
	end

	for _, res in ipairs(RoomScenePreloader.ResCommonList) do
		table.insert(urlList, res)
	end

	table.insert(urlList, RoomScenePreloader.ResOcean)
	table.insert(urlList, RoomScenePreloader.ResFogParticle)

	if BootNativeUtil.isWindows() then
		table.insert(urlList, RoomScenePreloader.DiffuseGI)
	end

	return urlList
end

function RoomPreloadMgr:_getAnimUrlList()
	local urlList = {}

	for _, res in pairs(RoomScenePreloader.ResAnim) do
		table.insert(urlList, res)
	end

	return urlList
end

function RoomPreloadMgr:_getBuildingUrlList()
	local urlList = {}
	local ownBuildingList = RoomMapBuildingModel.instance:getBuildingMOList()

	for _, buildingMO in ipairs(ownBuildingList) do
		local url = RoomResHelper.getBuildingPath(buildingMO.buildingId, buildingMO.level)

		table.insert(urlList, url)
	end

	table.insert(urlList, RoomScenePreloader.ResInitBuilding)

	return urlList
end

function RoomPreloadMgr:dispose()
	RoomHelper.logElapse("---------------- RoomPreloadMgr:dispose")

	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end
end

RoomPreloadMgr.instance = RoomPreloadMgr.New()

return RoomPreloadMgr
