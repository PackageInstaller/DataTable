-- chunkname: @modules/logic/room/controller/RoomMapController.lua

module("modules.logic.room.controller.RoomMapController", package.seeall)

local RoomMapController = class("RoomMapController", BaseController)

function RoomMapController:onInit()
	self:clear()
end

function RoomMapController:reInit()
	self:clear()
end

function RoomMapController:clear()
	self._isResetEdit = nil
	self._isNeedConfirmRoom = not not self._isResetRoomReply
	self._isHasConfirmOp = false
	self._isResetRoomReply = false
	self._isUIHide = false

	TaskDispatcher.cancelTask(self._realOpenRoomInitBuildingView, self)

	self._openRoomInitBuildingViewCameraState = nil
	self._openRoomInitBuildingViewZoom = nil
end

function RoomMapController:addConstEvents()
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self.addEventCb(self, TimeDispatcher.instance, TimeDispatcher.OnHour, self._onHourReporting, self)
end

function RoomMapController:_onOpenView(viewName)
	if viewName == ViewName.RoomInitBuildingView then
		TaskDispatcher.cancelTask(self._realOpenRoomInitBuildingView, self)
	end
end

function RoomMapController:_onHourReporting()
	local dTable = os.date("*t", ServerTime.nowInLocal())
	local hour = dTable.hour

	self:dispatchEvent(RoomEvent.OnHourReporting, hour)
end

function RoomMapController:updateBlockReplaceDefineId(fullBlockMOList)
	if not fullBlockMOList then
		::label_7_0::

		local fullBlockMOList = RoomMapBlockModel.instance:getFullBlockMOList()
		local tempRoomMapBuildingModel = RoomMapBuildingModel.instance

		for _, mo in ipairs(fullBlockMOList) do
			mo.replaceDefineId = nil
			mo.replaceRotate = nil

			if mo.hexPoint then
				local param = tempRoomMapBuildingModel:getBuildingParam(mo.hexPoint.x, mo.hexPoint.y)

				if not param and not RoomBuildingController.instance:isPressBuilding() then
					param = tempRoomMapBuildingModel:getTempBuildingParam(mo.hexPoint.x, mo.hexPoint.y)
				end

				mo.replaceDefineId = param and param.blockDefineId
				mo.replaceRotate = param and param.blockRotate
			end
		end
	end
end

function RoomMapController:initMap()
	local editInfo = RoomModel.instance:getEditInfo()

	self._isResetEdit = RoomController.instance:isEditMode() and editInfo and editInfo.isReset

	RoomMapModel.instance:init()

	self._isHasConfirmOp = false

	local gameMode = RoomModel.instance:getGameMode()
	local initFunc = self:_getInitMapFuncByGameMode(gameMode)
	local obInfo = RoomModel.instance:getInfoByMode(gameMode)

	if initFunc then
		initFunc(self, editInfo, obInfo)
	else
		logError(string.format("can not find initMap function by gameModel:%s", gameMode))
	end

	RoomMapHexPointModel.instance:init()
	RoomResourceModel.instance:init()
	self:dispatchEvent(RoomEvent.UpdateInventoryCount)
end

function RoomMapController:_getInitMapFuncByGameMode(gameMode)
	self._initMapFuncMap = self._initMapFuncMap or {
		[RoomEnum.GameMode.Ob] = self._initMapOb,
		[RoomEnum.GameMode.Edit] = self._initMapEdit,
		[RoomEnum.GameMode.Visit] = self._initMapVisit,
		[RoomEnum.GameMode.VisitShare] = self._initMapVisit,
		[RoomEnum.GameMode.DebugNormal] = self._initMapDebug,
		[RoomEnum.GameMode.DebugInit] = self._initMapDebug,
		[RoomEnum.GameMode.DebugPackage] = self._initMapDebug,
		[RoomEnum.GameMode.Fishing] = self._initMapFishing,
		[RoomEnum.GameMode.FishingVisit] = self._initMapFishing
	}

	return self._initMapFuncMap[gameMode]
end

function RoomMapController:_initMapOb(editInfo, obInfo)
	local enterParam = RoomModel.instance:getEnterParam()

	RoomModel.instance:resetBuildingInfos()
	RoomModel.instance:updateBuildingInfos(obInfo.buildingInfos or {})
	RoomMapModel.instance:updateRoomLevel(obInfo.roomLevel)
	RoomProductionModel.instance:updateLineMaxLevel()
	RoomMapBlockModel.instance:initMap(obInfo.infos)
	RoomMapBuildingModel.instance:initMap(obInfo.buildingInfos)
	RoomCharacterModel.instance:initCharacter(obInfo.roomHeroDatas)
	RoomCritterModel.instance:initCititer(obInfo.roomCititerDatas)
	RoomFormulaModel.instance:initFormula(obInfo.formulaInfos)
	RoomMapBuildingAreaModel.instance:init()
	RoomTransportController.instance:initPathData(obInfo.roadInfos)
	RoomInventoryBuildingModel.instance:initInventory(RoomModel.instance:getBuildingInfoList())
	RoomShowBuildingListModel.instance:initShowBuilding()
	RoomDebugPlaceListModel.instance:initDebugPlace()
	RoomCharacterPlaceListModel.instance:initCharacterPlace()

	if not enterParam or not enterParam.isFromEditMode then
		RoomShowBuildingListModel.instance:initFilter()
		RoomCharacterPlaceListModel.instance:initFilter()
		RoomCharacterPlaceListModel.instance:initOrder()
	end

	RoomTransportController.instance:updateBlockUseState()
	self:updateBlockReplaceDefineId()
	RoomCharacterController.instance:refreshCharacterFaithTimer()
	RoomCharacterController.instance:init()
	RoomVehicleController.instance:init()
	RoomInteractionController.instance:init()
	RoomCritterController.instance:initMapTrainCritter()
	RoomCritterController.instance:init()
	RoomInteractBuildingModel.instance:init()
end

function RoomMapController:_initMapEdit(editInfo)
	RoomThemeFilterListModel.instance:init()

	local obInfo = RoomModel.instance:getInfoByMode(RoomEnum.GameMode.Ob)

	RoomMapModel.instance:updateRoomLevel(obInfo.roomLevel)
	RoomProductionModel.instance:updateLineMaxLevel()
	RoomMapBlockModel.instance:initMap(editInfo.infos)

	local blockPackageIds = RoomModel.instance:getBlockPackageIds()
	local specialBlockIds = RoomModel.instance:getSpecialBlockIds()

	RoomInventoryBlockModel.instance:initInventory(blockPackageIds, editInfo.blockPackages, editInfo.infos, specialBlockIds)
	RoomMapBuildingModel.instance:initMap(editInfo.buildingInfos)
	RoomModel.instance:resetBuildingInfos()
	RoomModel.instance:updateBuildingInfos(editInfo.buildingInfos or {})
	RoomInventoryBuildingModel.instance:initInventory(RoomModel.instance:getBuildingInfoList())
	RoomCharacterModel.instance:initCharacter(obInfo.roomHeroDatas)
	RoomCritterModel.instance:initCititer(obInfo.roomCititerDatas)
	RoomMapBuildingAreaModel.instance:init()
	RoomTransportController.instance:initPathData(editInfo.roadInfos)
	RoomTransportController.instance:updateBlockUseState()
	self:updateBlockReplaceDefineId()
	RoomInteractBuildingModel.instance:init()
end

function RoomMapController:_initMapVisit(editInfo, obInfo)
	if not obInfo.infos then
		local infos = {}

		if not obInfo.buildingInfos then
			local buildingInfos = {}
			local visitParam = RoomModel.instance:getVisitParam()

			if RoomLayoutHelper.checkVisitParamCoppare(visitParam) then
				infos, buildingInfos = RoomLayoutHelper.findHasBlockBuildingInfos(obInfo.infos, buildingInfos)
			end

			RoomMapModel.instance:setOtherLineLevelDict(obInfo.productionLines)
			RoomSkinModel.instance:setOtherPlayerRoomSkinDict(obInfo.skins)
			RoomMapModel.instance:updateRoomLevel(obInfo.roomLevel)
			RoomMapBlockModel.instance:initMap(obInfo.infos)
			RoomMapBuildingModel.instance:initMap(buildingInfos)
			RoomCharacterModel.instance:initCharacter(obInfo.roomHeroDatas)
			RoomCritterModel.instance:initCititer(obInfo.roomCititerDatas)
			RoomMapBuildingAreaModel.instance:init()
			RoomTransportController.instance:initPathData(obInfo.roadInfos)
			RoomTransportController.instance:updateBlockUseState()
			RoomVehicleController.instance:init()
			RoomInteractBuildingModel.instance:init()
		end
	end
end

function RoomMapController:_initMapDebug(editInfo, obInfo)
	local debugParam = RoomModel.instance:getDebugParam()

	RoomMapBlockModel.instance:initMap(editInfo.infos)
	RoomMapBuildingModel.instance:initMap(editInfo.buildingInfos)

	if RoomController.instance:isDebugMode() then
		logNormal("直接点击放置地块")
		logNormal("点击已放置的地块更改资源样式")
		logNormal("Shift + 点击: 选中地块信息")
		logNormal("Shift + S: 所有地块信息")
		logNormal("Z: 更改地块中心资源样式")
		logNormal("X: 旋转地块")
		logNormal("C: 删除地块")
	end

	if RoomController.instance:isDebugNormalMode() then
		logNormal("V: 放置建筑")
		logNormal("B: 旋转建筑")
		logNormal("N: 删除建筑")
	end

	if RoomController.instance:isDebugPackageMode() then
		logNormal("按住C点击下面地块包UI中的地块: 从地块包中移除地块")
		logNormal("按住Shift点击下面地块包UI中的地块: 指定地块在地块包中的分类")
		logNormal("按住Ctrl点击下面地块包UI中的地块: 指定地块在地块包中的顺序")
	end
end

function RoomMapController:_initMapFishing(editInfo, obInfo)
	RoomMapBlockModel.instance:initMap(obInfo.infos)
	RoomMapBuildingModel.instance:initMap(obInfo.buildingInfos)
end

function RoomMapController:clearMap()
	RoomModel.instance:updateCharacterPoint()
	RoomMapBlockModel.instance:clear()
	RoomInventoryBlockModel.instance:clear()
	RoomMapModel.instance:clear()
	RoomResourceModel.instance:clear()
	RoomMapBuildingModel.instance:clear()
	RoomFormulaListModel.instance:clear()
	RoomFormulaModel.instance:clear()
	RoomShowBuildingListModel.instance:clearMapData()
	RoomDebugPlaceListModel.instance:clear()
	RoomCharacterPlaceListModel.instance:clearMapData()
	RoomCharacterModel.instance:clear()
	RoomMapBuildingAreaModel.instance:clear()
	RoomTransportController.instance:clear()
	self:clear()
	RoomDebugController.instance:clear()
	RoomBuildingController.instance:clear()
	RoomBuildingFormulaController.instance:clear()
	RoomCharacterController.instance:clear()
	RoomVehicleController.instance:clear()
	RoomInteractionController.instance:clear()
	RoomCritterController.instance:clear()
	RoomInteractBuildingModel.instance:clear()
end

function RoomMapController:resetRoom()
	if RoomController.instance:isDebugNormalMode() then
		PlayerPrefsHelper.setString(PlayerPrefsKey.RoomDebugMapParam, "")
		RoomController.instance:enterRoom(RoomEnum.GameMode.DebugNormal)
	elseif RoomController.instance:isDebugInitMode() then
		local debugParam = RoomModel.instance:getDebugParam()

		RoomDebugController.instance:resetInitJson()
		RoomController.instance:enterRoom(RoomEnum.GameMode.DebugInit, nil, nil, debugParam)
	elseif RoomController.instance:isDebugPackageMode() then
		local debugParam = RoomModel.instance:getDebugParam()

		RoomDebugController.instance:resetPackageJson(debugParam.packageMapId)
		RoomController.instance:enterRoom(RoomEnum.GameMode.DebugPackage, nil, nil, debugParam)
	elseif RoomController.instance:isEditMode() then
		RoomRpc.instance:sendResetRoomRequest(self._resetRoomReply, self)
	end
end

function RoomMapController:_resetRoomReply(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	self._isNeedConfirmRoom = true
	self._isResetRoomReply = true

	RoomController.instance:enterRoom(RoomEnum.GameMode.Edit, msg, RoomModel.instance:getObInfo(), nil, nil, nil, true)
end

function RoomMapController:useBlockRequest(blockId, rotate, x, y, cb, cbObj)
	local blockCfg = RoomConfig.instance:getBlock(blockId)

	if blockCfg then
		RoomRpc.instance:sendUseBlockRequest(blockId, blockCfg.packageId, rotate, x, y, cb, cbObj)
	end
end

function RoomMapController:unUseBlockListRequest(blockIdList)
	local buildDegree = 0

	for i, blockId in ipairs(blockIdList) do
		local packageConfig = RoomConfig.instance:getPackageConfigByBlockId(blockId)

		buildDegree = buildDegree + ((packageConfig or nil) and (packageConfig.blockBuildDegree or 0))
	end

	RoomRpc.instance:sendUnUseBlockRequest(blockIdList)
end

function RoomMapController:unUseBlockRequest(blockId)
	RoomRpc.instance:sendUnUseBlockRequest({
		blockId
	})
end

function RoomMapController:unUseBlockReply(backInfo)
	self._isNeedConfirmRoom = true

	local scene = GameSceneMgr.instance:getCurScene()
	local tRoomMapBlockModel = RoomMapBlockModel.instance
	local blockMList = {}
	local blockIds = backInfo.blockIds
	local buildingInfos = backInfo.buildingInfos
	local buildingIds = {}
	local roadInfos = backInfo.roadInfos

	for i = 1, #blockIds do
		local blockMO = tRoomMapBlockModel:backBlockById(blockIds[i])

		if blockMO then
			table.insert(blockMList, blockMO)
		end
	end

	if #buildingInfos > 0 then
		for i = 1, #buildingInfos do
			table.insert(buildingIds, buildingInfos[i].defineId)
		end
	end

	RoomInventoryBlockModel.instance:blackBlocksByIds(blockIds)

	local tempBlockMO = tRoomMapBlockModel:getTempBlockMO()

	if tempBlockMO then
		table.insert(blockMList, tempBlockMO)
		tRoomMapBlockModel:removeTempBlockMO()
	end

	RoomResourceModel.instance:unUseBlockList(blockMList)
	RoomSceneTaskController.instance:dispatchEvent(RoomEvent.TaskUpdate)
	RoomMapController.instance:dispatchEvent(RoomEvent.SelectBlock)
	scene.fsm:triggerEvent(RoomSceneEvent.ConfirmBackBlock, {
		blockMOList = blockMList
	})
	self:_unUseBuildings(buildingInfos)

	local count = RoomShowBlockListModel.instance:getCount()

	self:setRoomShowBlockList()
	RoomModel.instance:setEditFlag()

	if count <= 0 and RoomShowBlockListModel.instance:getCount() > 0 then
		RoomMapController.instance:dispatchEvent(RoomEvent.SelectBlock)
	end

	local minBlockIndex

	for _, blockId in ipairs(blockIds) do
		local mo = RoomShowBlockListModel.instance:getById(blockId)

		if mo then
			::label_21_0::

			local index = RoomShowBlockListModel.instance:getIndex(mo)

			if index and (not minBlockIndex or index < minBlockIndex) then
				minBlockIndex = index
			end
		end
	end

	self:_deleteRoadInfos(roadInfos)

	local isHasCurPackage = count < RoomShowBlockListModel.instance:getCount()

	RoomMapController.instance:dispatchEvent(RoomEvent.BackBlockListDataChanged, blockIds, isHasCurPackage, buildingIds, minBlockIndex)
end

function RoomMapController:_deleteRoadInfos(roadInfos)
	if roadInfos and #roadInfos then
		local roadIds = {}

		for _, roadInfo in ipairs(roadInfos) do
			table.insert(roadIds, roadInfo.id)
		end

		RoomTransportController.instance:deleteRoadByIds(roadIds)
	end
end

function RoomMapController:useBlockReply(blockInfo)
	self._isNeedConfirmRoom = true

	local scene = GameSceneMgr.instance:getCurScene()
	local tempBlockMO = RoomMapBlockModel.instance:getTempBlockMO()

	if tempBlockMO and tempBlockMO.id == blockInfo.blockId then
		RoomMapBlockModel.instance:placeTempBlockMO(blockInfo)
		RoomResourceModel.instance:useBlock(tempBlockMO)
	end

	RoomInventoryBlockModel.instance:placeBlock(blockInfo.blockId)
	self:setRoomShowBlockList()
	RoomResourceModel.instance:clearResourceAreaList()
	RoomResourceModel.instance:clearLightResourcePoint()
	RoomSceneTaskController.instance:dispatchEvent(RoomEvent.TaskUpdate)
	RoomModel.instance:setEditFlag()
	RoomMapController.instance:dispatchEvent(RoomEvent.SelectBlock)
	scene.fsm:triggerEvent(RoomSceneEvent.ConfirmPlaceBlock, {
		tempBlockMO = tempBlockMO
	})
end

function RoomMapController:useBuildingRequest(buildingUid, rotate, x, y)
	RoomRpc.instance:sendUseBuildingRequest(buildingUid, rotate, x, y)
end

function RoomMapController:useBuildingReply(msg)
	self._isNeedConfirmRoom = true

	local scene = GameSceneMgr.instance:getCurScene()
	local buildingInfo = msg.buildingInfo
	local tempBuildingMO = RoomMapBuildingModel.instance:getTempBuildingMO()

	RoomMapBuildingModel.instance:placeTempBuildingMO(buildingInfo)
	RoomInventoryBuildingModel.instance:placeBuilding(buildingInfo)
	RoomShowBuildingListModel.instance:setShowBuildingList()
	RoomResourceModel.instance:clearResourceAreaList()
	RoomModel.instance:setEditFlag()

	if RoomBuildingAreaHelper.isBuildingArea(buildingInfo.defineId) then
		RoomMapBuildingAreaModel.instance:refreshBuildingAreaMOList()
	end

	scene.fsm:triggerEvent(RoomSceneEvent.ConfirmPlaceBuilding, {
		buildingInfo = buildingInfo,
		tempBuildingMO = tempBuildingMO
	})
	self:_unUseBuildings(msg.deleteBuildingInfos)
	self:_deleteRoadInfos(msg.deleteRoadInfos)
end

function RoomMapController:unUseBuildingRequest(buildingUid)
	RoomRpc.instance:sendUnUseBuildingRequest(buildingUid)
end

function RoomMapController:unUseBuildingReply(msg)
	RoomModel.instance:setEditFlag()

	self._isNeedConfirmRoom = true

	self:_unUseBuildings(msg.buildingInfos)
	self:_deleteRoadInfos(msg.roadInfos)
end

function RoomMapController:_unUseBuildings(buildingInfos)
	local scene = GameSceneMgr.instance:getCurScene()
	local hasArea = false

	for i = 1, #buildingInfos do
		RoomInventoryBuildingModel.instance:unUseBuilding(buildingInfos[i])

		if not hasArea and RoomBuildingAreaHelper.isBuildingArea(buildingInfos[i].defineId) then
			hasArea = true
		end
	end

	RoomResourceModel.instance:clearResourceAreaList()
	scene.fsm:triggerEvent(RoomSceneEvent.UnUseBuilding, {
		buildingInfos = buildingInfos
	})
	RoomShowBuildingListModel.instance:setShowBuildingList()

	if RoomMapBlockModel.instance:isBackMore() then
		RoomBlockController.instance:refreshBackBuildingEffect()
	end

	if hasArea then
		RoomMapBuildingAreaModel.instance:refreshBuildingAreaMOList()
	end
end

function RoomMapController:buildingLevelUpByInfos(buildingInfos, needEvent)
	local flag = false
	local levelUpBuildingDict = {}

	if buildingInfos and (RoomController.instance:isObMode() or RoomController.instance:isEditMode()) then
		local tRoomMapBuildingModel = RoomMapBuildingModel.instance

		for i, buildingInfo in ipairs(buildingInfos) do
			local buildingUid = buildingInfo.uid
			local buildingMO = tRoomMapBuildingModel:getBuildingMOById(buildingUid)

			if buildingInfo.level and buildingMO and buildingMO.config and buildingMO.config.canLevelUp then
				buildingMO.level = buildingInfo.level

				buildingMO:refreshCfg()

				levelUpBuildingDict[buildingUid] = true
				flag = true
			end
		end
	end

	if flag or needEvent then
		self:dispatchEvent(RoomEvent.BuildingLevelUpPush, levelUpBuildingDict)
	end
end

function RoomMapController:useCharacterRequest(heroId)
	local roomHeroIds = {}
	local roomCharacterMOList = RoomCharacterModel.instance:getList()

	for _, roomCharacterMO in ipairs(roomCharacterMOList) do
		if roomCharacterMO:isPlaceSourceState() then
			table.insert(roomHeroIds, roomCharacterMO.heroId)
		end
	end

	if not tabletool.indexOf(roomHeroIds, heroId) then
		table.insert(roomHeroIds, heroId)
	end

	RoomRpc.instance:sendUpdateRoomHeroDataRequest(roomHeroIds, self.useCharacterReply, self)
end

function RoomMapController:useCharacterReply(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local scene = GameSceneMgr.instance:getCurScene()
	local tempCharacterMO = RoomCharacterModel.instance:getTempCharacterMO()

	if tempCharacterMO and not tempCharacterMO:isPlaceSourceState() and RoomModel.instance:getCharacterById(tempCharacterMO.id) then
		tempCharacterMO.sourceState = RoomCharacterEnum.SourceState.Place
	end

	RoomCharacterModel.instance:placeTempCharacterMO()
	RoomCharacterController.instance:correctCharacterHeight(tempCharacterMO)
	RoomCharacterPlaceListModel.instance:setCharacterPlaceList()
	RoomCharacterController.instance:updateCharacterFaith(msg.roomHeroDatas)
	scene.fsm:triggerEvent(RoomSceneEvent.ConfirmPlaceCharacter, {
		tempCharacterMO = tempCharacterMO
	})
	RoomInteractBuildingModel.instance:checkAllHero()
end

function RoomMapController:unUseCharacterRequest(heroId, callback, callbackObj, unUseAnim)
	self._unUseCharacterCallback = callback
	self._unUseCharacterCallbackObj = callbackObj
	self._unUseAnim = unUseAnim

	local roomHeroIds = {}
	local roomCharacterMOList = RoomCharacterModel.instance:getList()

	for _, roomCharacterMO in ipairs(roomCharacterMOList) do
		if roomCharacterMO:isPlaceSourceState() and roomCharacterMO.heroId ~= heroId then
			table.insert(roomHeroIds, roomCharacterMO.heroId)
		end
	end

	if RoomCharacterController.instance:isCharacterFaithFull(heroId) then
		RoomCharacterController.instance:setCharacterFullFaithChecked(heroId)
	end

	RoomRpc.instance:sendUpdateRoomHeroDataRequest(roomHeroIds, self.unUseCharacterReply, self)
end

function RoomMapController:unUseCharacterReply(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local scene = GameSceneMgr.instance:getCurScene()
	local tempCharacterMO = RoomCharacterModel.instance:getTempCharacterMO()

	scene.fsm:triggerEvent(RoomSceneEvent.UnUseCharacter, {
		heroId = tempCharacterMO.heroId,
		tempCharacterMO = tempCharacterMO,
		anim = self._unUseAnim
	})

	if tempCharacterMO:isTrainSourceState() or tempCharacterMO:isTraining() then
		RoomCharacterModel.instance:setHideFaithFull(tempCharacterMO.heroId, false)
	else
		RoomCharacterModel.instance:deleteCharacterMO(tempCharacterMO.heroId)
	end

	RoomCharacterController.instance:updateCharacterFaith(msg.roomHeroDatas)
	RoomInteractBuildingModel.instance:checkAllHero()

	if self._unUseCharacterCallback then
		self._unUseCharacterCallback(self._unUseCharacterCallbackObj)
	end

	self._unUseCharacterCallback = nil
	self._unUseCharacterCallbackObj = nil
end

function RoomMapController:confirmRoom(callback, callbackObj, param)
	local isReset = RoomController.instance:isReset()

	if isReset then
		RoomRpc.instance:sendUpdateRoomHeroDataRequest({})
	end

	local needRemoveCount = RoomCharacterHelper.getNeedRemoveCount()

	if not isReset and needRemoveCount > 0 then
		GameFacade.showMessageBox(MessageBoxIdDefine.RoomRemoveCharacter, MsgBoxEnum.BoxType.Yes_No, function()
			ViewMgr.instance:openView(ViewName.RoomCharacterPlaceInfoView, {
				needRemoveCount = needRemoveCount,
				sureCallback = self._confirmYesCallback,
				callbackObj = self,
				callbackParam = {
					callback = callback,
					callbackObj = callbackObj,
					param = param
				}
			})
		end, nil, nil, nil, nil, nil, needRemoveCount)
	else
		self:_confirmYesCallback({
			callback = callback,
			callbackObj = callbackObj,
			param = param
		})
	end
end

function RoomMapController:_confirmYesCallback(param)
	RoomRpc.instance:sendRoomConfirmRequest(self._confirmRoomReply, self)

	if param.callback then
		if param.callbackObj then
			param.callback(param.callbackObj, param.param)
		else
			param.callback(param.param)
		end
	end
end

function RoomMapController:_confirmRoomReply(cmd, resultCode, msg)
	if resultCode == 0 then
		RoomModel.instance:setObInfo(msg)

		self._isNeedConfirmRoom = false
		self._isHasConfirmOp = true

		GameFacade.showToast(RoomEnum.Toast.RoomConfirmRoomSuccess)
		RoomLayoutController.instance:sendGetRoomPlanInfoRpc()
		RoomLayoutController.instance:updateObInfo()
	end
end

function RoomMapController:revertRoom()
	RoomRpc.instance:sendRoomRevertRequest(self._revertRoomReply, self)
end

function RoomMapController:_revertRoomReply(cmd, resultCode, msg)
	if resultCode == 0 then
		self._isNeedConfirmRoom = false
	end
end

function RoomMapController:isResetEdit()
	return self._isResetEdit
end

function RoomMapController:isNeedConfirmRoom()
	return self._isNeedConfirmRoom
end

function RoomMapController:isHasConfirmOp()
	return self._isHasConfirmOp
end

function RoomMapController:openFormulaItemBuildingViewOutSide()
	RoomFormulaModel.instance:initFormula()
	ViewMgr.instance:openView(ViewName.RoomInitBuildingView, {
		openInOutside = true,
		partId = 3,
		showFormulaView = true
	})
end

function RoomMapController:openRoomInitBuildingView(delay, param)
	local scene = GameSceneMgr.instance:getCurScene()

	self._openRoomInitBuildingViewCameraState = scene.camera:getCameraState()
	self._openRoomInitBuildingViewZoom = scene.camera:getCameraZoom()

	RoomBuildingController.instance:tweenCameraFocusPart(param and param.partId, RoomEnum.CameraState.Normal, 0)

	self._openRoomInitBuildingViewParam = nil

	RoomMapController.instance:dispatchEvent(RoomEvent.WillOpenRoomInitBuildingView)
	RoomCharacterController.instance:dispatchEvent(RoomEvent.RefreshSpineShow)
	RoomBuildingController.instance:dispatchEvent(RoomEvent.RefreshNavigateButton)

	if not delay or delay <= 0 then
		self:_realOpenRoomInitBuildingView(param)
		self:dispatchEvent(RoomEvent.RefreshUIShow)

		return
	else
		self._openRoomInitBuildingViewParam = param

		TaskDispatcher.cancelTask(self._realOpenRoomInitBuildingView, self)
		TaskDispatcher.runDelay(self._realOpenRoomInitBuildingView, self, delay)
		self:dispatchEvent(RoomEvent.RefreshUIShow)
	end
end

function RoomMapController:_realOpenRoomInitBuildingView(param)
	param = param or self._openRoomInitBuildingViewParam
	self._openRoomInitBuildingViewParam = nil

	ViewMgr.instance:openView(ViewName.RoomInitBuildingView, param)
	RoomSkinController.instance:clearInitBuildingEntranceReddot(param and param.partId)
end

function RoomMapController:onCloseRoomInitBuildingView()
	if self._openRoomInitBuildingViewCameraState and self._openRoomInitBuildingViewZoom then
		local scene = GameSceneMgr.instance:getCurScene()

		scene.camera:switchCameraState(self._openRoomInitBuildingViewCameraState, {
			zoom = self._openRoomInitBuildingViewZoom
		})

		self._openRoomInitBuildingViewCameraState = nil
		self._openRoomInitBuildingViewZoom = nil

		self:dispatchEvent(RoomEvent.RefreshUIShow)
		RoomCharacterController.instance:dispatchEvent(RoomEvent.RefreshSpineShow)
		RoomBuildingController.instance:dispatchEvent(RoomEvent.RefreshNavigateButton)
	end
end

function RoomMapController:isInRoomInitBuildingViewCamera()
	return self._openRoomInitBuildingViewCameraState and self._openRoomInitBuildingViewZoom
end

function RoomMapController:openRoomLevelUpView()
	ViewMgr.instance:openView(ViewName.RoomLevelUpView)
end

function RoomMapController:switchBackBlock(isBackMore)
	local lastBackMore = RoomMapBlockModel.instance:isBackMore()

	RoomMapBlockModel.instance:setBackMore(isBackMore)

	local scene = GameSceneMgr.instance:getCurScene()

	if not isBackMore then
		scene.fsm:triggerEvent(RoomSceneEvent.CancelBackBlock)
	else
		local tBackBlockModel = RoomMapBlockModel.instance:getBackBlockModel()

		if tBackBlockModel:getCount() > 0 and RoomMapBlockModel.instance:isCanBackBlock() == false then
			scene.fsm:triggerEvent(RoomSceneEvent.CancelBackBlock)
		end

		scene.fsm:triggerEvent(RoomSceneEvent.CancelPlaceBlock)
	end

	RoomMapController.instance:dispatchEvent(RoomEvent.BackBlockShowChanged)
	RoomMapController.instance:dispatchEvent(RoomEvent.SelectBlock)
	RoomBackBlockHelper.resfreshInitBlockEntityEffect()

	if lastBackMore == true and RoomMapBlockModel.instance:isBackMore() == false then
		TaskDispatcher.cancelTask(self._playBackBlockUIAnim, self)
		TaskDispatcher.runDelay(self._playBackBlockUIAnim, self, 0.3333333333333333)
	end

	if lastBackMore ~= RoomMapBlockModel.instance:isBackMore() then
		RoomBlockController.instance:refreshBackBuildingEffect()
	end
end

function RoomMapController:_playBackBlockUIAnim()
	if RoomMapBlockModel.instance:isBackMore() == false then
		self:dispatchEvent(RoomEvent.BackBlockPlayUIAnim)
	end
end

function RoomMapController:switchWaterReform(isWaterReform)
	local scene = GameSceneMgr.instance:getCurScene()

	scene.fsm:triggerEvent(RoomSceneEvent.CancelBackBlock)
	scene.fsm:triggerEvent(RoomSceneEvent.CancelPlaceBlock)

	if isWaterReform then
		scene.fsm:triggerEvent(RoomSceneEvent.EnterWaterReform)
	else
		scene.fsm:triggerEvent(RoomSceneEvent.CloseWaterReform)
	end

	RoomWaterReformController.instance:dispatchEvent(RoomEvent.WaterReformShowChanged)
end

function RoomMapController:statRoomStart()
	self._statTime = ServerTime.now()
end

function RoomMapController:statRoomEnd()
	if not self._statTime then
		return
	end

	local statInfo
	local useTime = ServerTime.now() - self._statTime

	if RoomController.instance:isObMode() then
		local blockCount = RoomMapBlockModel.instance:getConfirmBlockCount()
		local characterArray = {}
		local characterMOList = RoomCharacterModel.instance:getList()

		for i, characterMO in ipairs(characterMOList) do
			table.insert(characterArray, {
				heroname = characterMO.heroConfig.name
			})
		end

		local buildingDict = {}
		local buildingMOList = RoomMapBuildingModel.instance:getBuildingMOList()

		for _, buildingMO in ipairs(buildingMOList) do
			local build = buildingDict[buildingMO.config.id]

			if not build then
				build = {
					build_num = 1,
					buildname = buildingMO.config.name
				}
				buildingDict[buildingMO.config.id] = build
			else
				build.build_num = build.build_num + 1
			end
		end

		local buildingArray = {}

		for _, build in pairs(buildingDict) do
			table.insert(buildingArray, build)
		end

		local buildDegree = RoomMapModel.instance:getAllBuildDegree()
		local roomLevel = RoomMapModel.instance:getRoomLevel()

		statInfo = {
			[StatEnum.EventProperties.PlacePlotnum] = blockCount,
			[StatEnum.EventProperties.PlaceHero] = characterArray,
			[StatEnum.EventProperties.PlaceBuild] = buildingArray,
			[StatEnum.EventProperties.UseTime] = useTime,
			[StatEnum.EventProperties.VitalityValue] = buildDegree,
			[StatEnum.EventProperties.PivotLevel] = roomLevel,
			[StatEnum.EventProperties.OwnPlans] = RoomLayoutModel.instance:getLayoutCount(),
			[StatEnum.EventProperties.PlanName] = RoomLayoutModel.instance:getCurrentUsePlanName(),
			[StatEnum.EventProperties.PlotBag] = RoomLayoutModel.instance:getCurrentPlotBagData()
		}
	elseif RoomController.instance:isEditMode() then
		local obInfo = RoomModel.instance:getObInfo()
		local buildDegree = 0
		local blockCount = 0

		for i, info in ipairs(obInfo.infos) do
			if info.blockId > 0 then
				blockCount = blockCount + 1
			end

			local packageConfig = RoomConfig.instance:getPackageConfigByBlockId(info.blockId)

			buildDegree = buildDegree + ((packageConfig or nil) and (packageConfig.blockBuildDegree or 0))
		end

		local characterArray = {}

		for i, info in ipairs(obInfo.roomHeroDatas) do
			local heroConfig = HeroConfig.instance:getHeroCO(info.heroId)

			table.insert(characterArray, {
				heroname = heroConfig.name
			})
		end

		local buildingArray = {}
		local buildingDict = {}

		for _, info in ipairs(obInfo.buildingInfos) do
			local build = buildingDict[info.defineId]

			if not build then
				local buildingConfig = RoomConfig.instance:getBuildingConfig(info.defineId)

				build = {
					build_num = 1,
					buildname = buildingConfig.name,
					buildDegree = buildingConfig.buildDegree
				}
				buildingDict[info.defineId] = build
				buildDegree = buildDegree + buildingConfig.buildDegree
			else
				build.build_num = build.build_num + 1
				buildDegree = buildDegree + build.buildDegree
			end
		end

		for _, build in pairs(buildingDict) do
			build.buildDegree = nil

			table.insert(buildingArray, build)
		end

		local roomLevel = obInfo.roomLevel

		statInfo = {
			[StatEnum.EventProperties.PlacePlotnum] = blockCount,
			[StatEnum.EventProperties.PlaceHero] = characterArray,
			[StatEnum.EventProperties.PlaceBuild] = buildingArray,
			[StatEnum.EventProperties.UseTime] = useTime,
			[StatEnum.EventProperties.VitalityValue] = buildDegree,
			[StatEnum.EventProperties.PivotLevel] = roomLevel,
			[StatEnum.EventProperties.OwnPlans] = RoomLayoutModel.instance:getLayoutCount(),
			[StatEnum.EventProperties.PlanName] = RoomLayoutModel.instance:getCurrentUsePlanName(),
			[StatEnum.EventProperties.PlotBag] = RoomLayoutModel.instance:getCurrentPlotBagData()
		}
	end

	if statInfo then
		self._statTime = nil
		statInfo[StatEnum.EventProperties.SharePlanNum] = RoomLayoutModel.instance:getSharePlanCount()
		statInfo[StatEnum.EventProperties.Attention] = RoomLayoutModel.instance:getUseCount()

		StatController.instance:track(StatEnum.EventName.ExitCabin, statInfo)
	end
end

function RoomMapController:isUIHide()
	return self._isUIHide
end

function RoomMapController:setUIHide(isHide, viewName)
	local flag = self._isUIHide ~= isHide

	self._isUIHide = isHide

	if flag then
		if isHide then
			if not RoomEvent.HideUI then
				local eventid = RoomEvent.ShowUI

				self:dispatchEvent(eventid, viewName)
			end
		end
	end
end

function RoomMapController:setRoomShowBlockList()
	RoomShowBlockListModel.instance:setShowBlockList()
	self:getNextBlockReformPermanentInfo()
end

function RoomMapController:clearRoomShowBlockList()
	local scene = GameSceneMgr.instance:getCurScene()

	if not scene or not scene.inventorymgr then
		return
	end

	local showBlockList = RoomShowBlockListModel.instance:getList()

	for _, blockMO in ipairs(showBlockList) do
		scene.inventorymgr:removeBlockEntity(blockMO.id)
	end
end

function RoomMapController:getNextBlockReformPermanentInfo(startIndex)
	local previewBlockIdList = RoomShowBlockListModel.instance:getPreviewBlockIdList(startIndex)

	if previewBlockIdList and #previewBlockIdList > 0 then
		RoomWaterReformController.instance:getBlockReformPermanentInfo(previewBlockIdList)
	end
end

RoomMapController.instance = RoomMapController.New()

return RoomMapController
