-- chunkname: @modules/logic/room/view/RoomViewUI.lua

module("modules.logic.room.view.RoomViewUI", package.seeall)

local RoomViewUI = class("RoomViewUI", BaseView)

function RoomViewUI:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomViewUI:addEvents()
	return
end

function RoomViewUI:removeEvents()
	return
end

function RoomViewUI:_editableInitView()
	self._cameraStateShowUIMap = {
		[RoomEnum.CameraState.Overlook] = true,
		[RoomEnum.CameraState.OverlookAll] = true
	}
	self._showBuildingItemTypeMap = {
		[RoomBuildingEnum.BuildingType.Interact] = true
	}
	self._gopart = gohelper.findChild(self.viewGO, "go_normalroot/go_ui/go_part")
	self._canvasGroup = gohelper.onceAddComponent(self._gopart, typeof(UnityEngine.CanvasGroup))
	self._scene = GameSceneMgr.instance:getCurScene()
	self._manufactureItemDict = {}
end

function RoomViewUI:onClickBellTower()
	local item = self._partItemDict[1]

	if not RoomController.instance:isObMode() or not item or not item._isShow then
		return
	end

	item:_onClick()
end

function RoomViewUI:onClickMarket()
	local item = self._partItemDict[2]

	if not RoomController.instance:isObMode() or not item or not item._isShow then
		return
	end

	item:_onClick()
end

function RoomViewUI:_onUseBuildingReply()
	TaskDispatcher.cancelTask(self._onDelayInit, self)
	TaskDispatcher.runDelay(self._onDelayInit, self, 0.1)
end

function RoomViewUI:_cameraStateUpdate()
	local cameraState = self._scene.camera:getCameraState()

	self._canvasGroup.alpha = self._cameraStateShowUIMap[cameraState] and 1 or 0
end

function RoomViewUI:onOpen()
	self.addEventCb(self, PCInputController.instance, PCInputEvent.NotifyRoomBellTower, self.onClickBellTower, self)
	self.addEventCb(self, PCInputController.instance, PCInputEvent.NotifyRoomMarket, self.onClickMarket, self)
	self.addEventCb(self, RoomMapController.instance, RoomEvent.UseBuildingReply, self._onUseBuildingReply, self)
	self.addEventCb(self, RoomMapController.instance, RoomEvent.CameraStateUpdate, self._cameraStateUpdate, self)
	self.addEventCb(self, RoomCharacterController.instance, RoomEvent.CharacterEntityChanged, self._refreshCharacterItem, self)
	self.addEventCb(self, RoomCharacterController.instance, RoomEvent.CharacterEntityChanged, self._refreshCharacterInteractionItem, self)
	self.addEventCb(self, RoomMapController.instance, RoomEvent.SceneTrainChangeSpine, self._refreshCritterItem, self)
	self.addEventCb(self, CritterController.instance, CritterEvent.TrainSelectEventOptionReply, self._refreshCritterItem, self)
	self.addEventCb(self, ManufactureController.instance, ManufactureEvent.ManufactureInfoUpdate, self._refreshCritterItem, self)
	self.addEventCb(self, ManufactureController.instance, ManufactureEvent.ManufactureBuildingInfoChange, self._refreshCritterItem, self)
	self.addEventCb(self, CritterController.instance, CritterEvent.CritterInfoPushUpdate, self._refreshCritterItem, self)
	TaskDispatcher.runDelay(self._onDelayInit, self, 0.1)
	TaskDispatcher.runRepeat(self._sort, self, 1)
end

function RoomViewUI:_onDelayInit()
	self._isRunDalayInit = true

	self:_initPartItem()
	self:_initInitItem()
	self:_initCharacterItem()
	self:_initCharacterInteractionItem()
	self:_initFishingItem()
	self:refresh()
end

function RoomViewUI:_initPartItem()
	local resPath = self.viewContainer._viewSetting.otherRes[10]

	self._partItemDict = {}

	if not RoomController.instance:isObMode() then
		return
	end

	for i, partConfig in ipairs(lua_production_part.configList) do
		local partId = partConfig.id
		local partItem = self._partItemDict[partId]

		if not partItem then
			local go = self:getResInst(resPath, self._gopart, "partId" .. partId)

			partItem = MonoHelper.addNoUpdateLuaComOnceToGo(go, RoomViewUIPartItem, partId)
			self._partItemDict[partId] = partItem
		end
	end
end

function RoomViewUI:_initInitItem()
	local resPath = self.viewContainer._viewSetting.otherRes[10]

	self._initItem = nil

	if not RoomController.instance:isObMode() then
		return
	end

	if not self._initItem then
		local go = self:getResInst(resPath, self._gopart, "init")

		self._initItem = MonoHelper.addNoUpdateLuaComOnceToGo(go, RoomViewUIInitItem)
	end
end

function RoomViewUI:_initCharacterItem()
	self._gocharacterui = gohelper.findChild(self.viewGO, "go_normalroot/go_ui/go_part/go_characterui")

	gohelper.setActive(self._gocharacterui, false)

	self._characterItemDict = {}
end

function RoomViewUI:_initCharacterInteractionItem()
	self._gocharacterinteractionui = gohelper.findChild(self.viewGO, "go_normalroot/go_ui/go_part/go_characterinteractionui")

	gohelper.setActive(self._gocharacterinteractionui, false)

	self._characterInteractionItemDict = {}
end

function RoomViewUI:_initFishingItem()
	local isInFishing = FishingModel.instance:isInFishing()

	if not isInFishing then
		if self._fishingItem then
			self._fishingItem:removeEventListeners()
			gohelper.destroy(self._fishingItem.go)
		end

		return
	end

	if self._fishingItem then
		self._fishingItem:refreshUI()
	else
		local resPath = RoomViewUIFishingItem.prefabPath
		local go = self:getResInst(resPath, self._gopart, "fishing")

		self._fishingItem = MonoHelper.addNoUpdateLuaComOnceToGo(go, RoomViewUIFishingItem)
	end
end

function RoomViewUI:refresh()
	self:_refreshCharacterItem()
	self:_refreshCharacterInteractionItem()
	self:_refreshManufactureItem()
	self:_refreshTransportSiteItem()
	self:_refreshCritterBuildingItem()
	self:_refreshTradeBuildingItem()
	self:_refreshCritterItem()
	self:_refreshBuildingItem()
	self:_refreshFishingFriendItem()
	self:_refreshFishingStoreItem()
	self:_sort()
end

function RoomViewUI:_refreshCharacterItem()
	if not self._isRunDalayInit then
		return
	end

	if not RoomController.instance:isObMode() and not RoomController.instance:isVisitMode() then
		return
	end

	local resPath = self.viewContainer._viewSetting.otherRes[9]
	local characterEntityDict = self._scene.charactermgr:getRoomCharacterEntityDict()

	for heroId, characterEntity in pairs(characterEntityDict) do
		local characterItem = self._characterItemDict[heroId]

		if not characterItem then
			local go = self:getResInst(resPath, self._gopart, "heroId" .. heroId)

			characterItem = MonoHelper.addNoUpdateLuaComOnceToGo(go, RoomViewUICharacterItem, heroId)
			self._characterItemDict[heroId] = characterItem
		end
	end

	for heroId, characterItem in pairs(self._characterItemDict) do
		if not characterEntityDict[heroId] then
			characterItem:removeEventListeners()
			gohelper.destroy(characterItem.go)

			self._characterItemDict[heroId] = nil
		end
	end
end

function RoomViewUI:_refreshCharacterInteractionItem()
	if not self._isRunDalayInit then
		return
	end

	if not RoomController.instance:isObMode() or not RoomEnum.IsShowUICharacterInteraction then
		return
	end

	local resPath = self.viewContainer._viewSetting.otherRes[8]
	local characterEntityDict = self._scene.charactermgr:getRoomCharacterEntityDict()

	for heroId, characterEntity in pairs(characterEntityDict) do
		local characterInteractionItem = self._characterInteractionItemDict[heroId]

		if not characterInteractionItem then
			local go = self:getResInst(resPath, self._gopart, "interaction" .. heroId)

			characterInteractionItem = MonoHelper.addNoUpdateLuaComOnceToGo(go, RoomViewUICharacterInteractionItem, heroId)
			self._characterInteractionItemDict[heroId] = characterInteractionItem
		end
	end

	for heroId, characterInteractionItem in pairs(self._characterInteractionItemDict) do
		if not characterEntityDict[heroId] then
			characterInteractionItem:removeEventListeners()
			gohelper.destroy(characterInteractionItem.go)

			self._characterInteractionItemDict[heroId] = nil
		end
	end
end

function RoomViewUI:_refreshManufactureItem()
	if not RoomController.instance:isObMode() or not self._isRunDalayInit then
		return
	end

	local buildingAreaDict = RoomMapBuildingAreaModel.instance:getBuildingType2AreaMODict()
	local resPath = self.viewContainer._viewSetting.otherRes[11]

	for manufactureType, _ in pairs(buildingAreaDict) do
		local manufactureItem = self._manufactureItemDict[manufactureType]

		if not manufactureItem then
			local go = self:getResInst(resPath, self._gopart, "manufacture" .. manufactureType)

			manufactureItem = MonoHelper.addNoUpdateLuaComOnceToGo(go, RoomViewUIManufactureItem, manufactureType)
			self._manufactureItemDict[manufactureType] = manufactureItem
		end
	end

	for manufactureType, manufactureItem in pairs(self._manufactureItemDict) do
		if not buildingAreaDict[manufactureType] then
			manufactureItem:removeEventListeners()
			gohelper.destroy(manufactureItem.go)

			self._manufactureItemDict[manufactureType] = nil
		end
	end
end

function RoomViewUI:_refreshTransportSiteItem()
	if not RoomController.instance:isObMode() or not self._isRunDalayInit then
		return
	end

	self._transportSiteItemDict = self._transportSiteItemDict or {}

	local resPath = RoomViewUITransportSiteItem.prefabPath
	local buildingTypeList = RoomTransportHelper.getSiteBuildingTypeList()

	for i = 1, #buildingTypeList do
		local siteType = buildingTypeList[i]
		local hexPoint = RoomMapTransportPathModel.instance:getSiteHexPointByType(siteType)
		local siteItem = self._transportSiteItemDict[siteType]

		if hexPoint then
			if not siteItem then
				local go = self:getResInst(resPath, self._gopart, "site_" .. siteType)

				siteItem = MonoHelper.addNoUpdateLuaComOnceToGo(go, RoomViewUITransportSiteItem, siteType)
				self._transportSiteItemDict[siteType] = siteItem
			end
		elseif siteItem then
			siteItem:removeEventListeners()
			gohelper.destroy(siteItem.go)

			self._transportSiteItemDict[siteType] = nil
		end
	end
end

function RoomViewUI:_refreshCritterBuildingItem()
	if not RoomController.instance:isObMode() or not self._isRunDalayInit then
		return
	end

	local buildingUid
	local buildingList = ManufactureModel.instance:getCritterBuildingListInOrder()
	local buildingEntity = self._scene.buildingmgr:getBuildingEntity((buildingList or nil) and buildingList[1].buildingUid, SceneTag.RoomBuilding)

	if buildingEntity then
		if not self._critterBuildingItem then
			local resPath = self.viewContainer._viewSetting.otherRes[12]
			local go = self:getResInst(resPath, self._gopart, "critterBuilding")

			self._critterBuildingItem = MonoHelper.addNoUpdateLuaComOnceToGo(go, RoomViewUICritterBuildingItem)
		end
	elseif self._critterBuildingItem then
		self._critterBuildingItem:removeEventListeners()
		gohelper.destroy(self._critterBuildingItem.go)

		self._critterBuildingItem = nil
	end
end

function RoomViewUI:_refreshTradeBuildingItem()
	if not RoomController.instance:isObMode() or not self._isRunDalayInit then
		return
	end

	local buildingUid
	local buildingList = ManufactureModel.instance:getTradeBuildingListInOrder()
	local buildingEntity = self._scene.buildingmgr:getBuildingEntity((buildingList or nil) and buildingList[1].buildingUid, SceneTag.RoomBuilding)

	if buildingEntity then
		if not self._tradeBuildingItem then
			local resPath = self.viewContainer._viewSetting.otherRes[12]
			local go = self:getResInst(resPath, self._gopart, "tradeBuilding")

			self._tradeBuildingItem = MonoHelper.addNoUpdateLuaComOnceToGo(go, RoomViewUITradeBuildingItem)
		end
	elseif self._tradeBuildingItem then
		self._tradeBuildingItem:removeEventListeners()
		gohelper.destroy(self._tradeBuildingItem.go)

		self._tradeBuildingItem = nil
	end
end

function RoomViewUI:_refreshCritterItem(updateTrain, updateWork)
	if not RoomController.instance:isObMode() or not self._isRunDalayInit then
		return
	end

	self._critterItemDict = self._critterItemDict or {}

	local critterMOList = CritterModel.instance:getAllCritters()

	for i = 1, #critterMOList do
		local critterMO = critterMOList[i]
		local critterUid = critterMO.id
		local isShowCritterItem = self:_isShowCritterItem(critterMO)

		if isShowCritterItem and not self._critterItemDict[critterUid] then
			local go = self:getResInst(RoomViewUICritterEventItem.prefabPath, self._gopart, "critter_" .. critterUid)

			self._critterItemDict[critterMO.id] = MonoHelper.addNoUpdateLuaComOnceToGo(go, RoomViewUICritterEventItem, critterUid)
		end
	end

	for critterUid, item in pairs(self._critterItemDict) do
		local critterMO = CritterModel.instance:getCritterMOByUid(critterUid)
		local isShowCritterItem = self:_isShowCritterItem(critterMO)

		if not isShowCritterItem then
			if item then
				item:removeEventListeners()
				gohelper.destroy(item.go)
			end

			self._critterItemDict[critterUid] = nil
		end
	end
end

function RoomViewUI:_isShowCritterItem(critterMO)
	local critterEntity
	local hasTrainEvent = false
	local critterUid = critterMO:getId()
	local isCultivating = critterMO:isCultivating()

	if isCultivating then
		hasTrainEvent = critterMO.trainInfo:isHasEventTrigger()
		critterEntity = self._scene.crittermgr:getCritterEntity(critterUid, SceneTag.RoomCharacter)
	end

	local noMoodWorking = false

	if not hasTrainEvent then
		noMoodWorking = critterMO:isNoMoodWorking()
		critterEntity = self._scene.buildingcrittermgr:getCritterEntity(critterUid, SceneTag.RoomCharacter)
	end

	return critterMO and critterEntity and (hasTrainEvent or noMoodWorking)
end

function RoomViewUI:_refreshBuildingItem()
	if not RoomController.instance:isObMode() or not self._isRunDalayInit then
		return
	end

	self._buildingItemDict = self._buildingItemDict or {}

	local buildingMOList = RoomMapBuildingModel.instance:getBuildingMOList()

	for i = 1, #buildingMOList do
		local buildingMO = buildingMOList[i]
		local buildingUid = buildingMO.id

		if buildingMO.config then
			if buildingMO.config and self._showBuildingItemTypeMap[buildingMO.config] and not self._buildingItemDict[buildingUid] then
				local resPath = self.viewContainer._viewSetting.otherRes[12]
				local go = self:getResInst(resPath, self._gopart, "building_" .. buildingUid)

				self._buildingItemDict[buildingUid] = MonoHelper.addNoUpdateLuaComOnceToGo(go, RoomViewUIBuildingItem, buildingUid)
			end
		end
	end

	for buildingUid, item in pairs(self._buildingItemDict) do
		local buildingMO = RoomMapBuildingModel.instance:getBuildingMOById(buildingUid)

		if not buildingMO then
			if item then
				item:removeEventListeners()
				gohelper.destroy(item.go)
			end

			self._buildingItemDict[buildingUid] = nil
		end
	end
end

function RoomViewUI:_refreshFishingFriendItem()
	if not FishingModel.instance:isInFishing() or not self._isRunDalayInit then
		return
	end

	local userShowBuildingDict = {}

	self._fishingFriendItemDict = self._fishingFriendItemDict or {}

	local buildingList = RoomMapBuildingModel.instance:getBuildingListByType(RoomBuildingEnum.BuildingType.Fishing)
	local myUserId = PlayerModel.instance:getMyUserId()

	if buildingList then
		for _, buildingMO in ipairs(buildingList) do
			local buildingEntity = self._scene.buildingmgr:getBuildingEntity(buildingMO.buildingUid, SceneTag.RoomBuilding)
			local belongUserId = buildingMO:getBelongUserId()

			if buildingEntity and belongUserId and belongUserId ~= myUserId then
				local go = self:getResInst(RoomViewUIFishingFriendItem.prefabPath, self._gopart, "fishingFriend_" .. belongUserId)

				self._fishingFriendItemDict[belongUserId] = MonoHelper.addNoUpdateLuaComOnceToGo(go, RoomViewUIFishingFriendItem, belongUserId)
				userShowBuildingDict[belongUserId] = true
			end
		end
	end

	for userId, item in pairs(self._fishingFriendItemDict) do
		if not userShowBuildingDict[userId] then
			if item then
				item:removeEventListeners()
				gohelper.destroy(item.go)
			end

			self._fishingFriendItemDict[userId] = nil
		end
	end
end

function RoomViewUI:_refreshFishingStoreItem()
	if not RoomController.instance:isFishingMode() or not self._isRunDalayInit then
		return
	end

	local buildingList = RoomMapBuildingModel.instance:getBuildingListByType(RoomBuildingEnum.BuildingType.FishingStore)
	local buildingUid = buildingList and buildingList[1].buildingUid
	local buildingEntity = self._scene.buildingmgr:getBuildingEntity(buildingUid, SceneTag.RoomBuilding)

	if buildingEntity then
		if not self._fishingStoreItem then
			local resPath = self.viewContainer._viewSetting.otherRes[12]
			local go = self:getResInst(resPath, self._gopart, "fishingStore")

			self._fishingStoreItem = MonoHelper.addNoUpdateLuaComOnceToGo(go, RoomViewUIFishingStoreItem)
		end
	elseif self._fishingStoreItem then
		self._fishingStoreItem:removeEventListeners()
		gohelper.destroy(self._fishingStoreItem.go)

		self._fishingStoreItem = nil
	end
end

function RoomViewUI:_sort()
	if not self._isRunDalayInit then
		return
	end

	self._uiItemList = {}

	LuaUtil.insertDict(self._uiItemList, self._partItemDict)
	table.insert(self._uiItemList, self._initItem)
	LuaUtil.insertDict(self._uiItemList, self._characterItemDict)
	LuaUtil.insertDict(self._uiItemList, self._characterInteractionItemDict)
	LuaUtil.insertDict(self._uiItemList, self._manufactureItemDict)
	LuaUtil.insertDict(self._uiItemList, self._transportSiteItemDict)
	table.insert(self._uiItemList, self._critterBuildingItem)
	table.insert(self._uiItemList, self._tradeBuildingItem)
	LuaUtil.insertDict(self._uiItemList, self._critterItemDict)
	LuaUtil.insertDict(self._uiItemList, self._buildingItemDict)
	table.insert(self._uiItemList, self._fishingItem)
	LuaUtil.insertDict(self._uiItemList, self._fishingFriendItemDict)
	table.insert(self._uiItemList, self._fishingStoreItem)

	local cameraPosition = self._scene.camera:getCameraPosition()

	for i, uiItem in ipairs(self._uiItemList) do
		local worldPos = uiItem:getUI3DPos()

		uiItem.__distance = Vector3.Distance(cameraPosition, worldPos)
	end

	table.sort(self._uiItemList, function(a, b)
		return a.__distance > b.__distance
	end)

	for i, uiItem in ipairs(self._uiItemList) do
		gohelper.setAsLastSibling(uiItem.go)
	end
end

function RoomViewUI:onClose()
	TaskDispatcher.cancelTask(self._sort, self)
	TaskDispatcher.cancelTask(self._onDelayInit, self)
	self.removeEventCb(self, PCInputController.instance, PCInputEvent.NotifyRoomBellTower, self.onClickBellTower, self)
	self.removeEventCb(self, PCInputController.instance, PCInputEvent.NotifyRoomMarket, self.onClickMarket, self)
	self.removeEventCb(self, RoomMapController.instance, RoomEvent.UseBuildingReply, self._onUseBuildingReply, self)
end

function RoomViewUI:onDestroyView()
	return
end

return RoomViewUI
