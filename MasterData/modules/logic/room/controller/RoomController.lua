-- chunkname: @modules/logic/room/controller/RoomController.lua

module("modules.logic.room.controller.RoomController", package.seeall)

local RoomController = class("RoomController", BaseController)

function RoomController:onInit()
	self:_clear()

	self._showChangeNotOpenToastDic = {
		[MaterialEnum.MaterialType.Building] = RoomEnum.Toast.RoomLockMaterialChangeTip,
		[MaterialEnum.MaterialType.BlockPackage] = RoomEnum.Toast.RoomLockMaterialChangeTip,
		[MaterialEnum.MaterialType.SpecialBlock] = RoomEnum.Toast.RoomLockMaterialChangeTip
	}
end

function RoomController:reInit()
	self:_clear()
end

function RoomController:_clear()
	self.rotateSpeed = 1
	self.moveSpeed = 1
	self.scaleSpeed = 1
	self.touchMoveSpeed = 1

	TaskDispatcher.cancelTask(self._delaySwitchScene, self)

	self._isEditorMode = false
	self._isReset = false
end

function RoomController:addConstEvents()
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onOnCloseViewFinish, self)
	self.addEventCb(self, self, RoomEvent.OnSwitchModeDone, self._onOnSwitchModeDone, self)
end

function RoomController:_onOnCloseViewFinish(viewName, viewParam)
	if viewName == ViewName.CommonPropView then
		self:checkThemeCollerctFullReward()
	end
end

function RoomController:checkThemeCollerctFullReward()
	local themeId = RoomModel.instance:findHasGetThemeRewardThemeId()

	if themeId and not ViewMgr.instance:isOpen(ViewName.RoomThemeTipView) then
		ViewMgr.instance:openView(ViewName.RoomThemeTipView, {
			type = MaterialEnum.MaterialType.RoomTheme,
			id = themeId
		})
	end
end

function RoomController:_onOnSwitchModeDone()
	GameSceneMgr.instance:dispatchEvent(SceneEventName.CloseLoading)
end

function RoomController:sendInitRoomObInfo()
	RoomRpc.instance:sendGetRoomObInfoRequest(true, self._onInitObInfoReply, self)
end

function RoomController:_onInitObInfoReply(cmd, resultCode, msg)
	if resultCode == 0 and msg.needBlockData == true then
		RoomLayoutController.instance:sendGetRoomPlanInfoRpc()
		RoomModel.instance:setObInfo(msg)
	end
end

function RoomController:setEditorMode(isEditorMode)
	self._isEditorMode = isEditorMode
end

function RoomController:isRoomScene()
	local sceneType = GameSceneMgr.instance:getCurSceneType()

	return sceneType == SceneType.Room
end

function RoomController:isEditorMode()
	return self._isEditorMode
end

function RoomController:isEditMode()
	return RoomModel.instance:getGameMode() == RoomEnum.GameMode.Edit
end

function RoomController:isObMode()
	return RoomModel.instance:getGameMode() == RoomEnum.GameMode.Ob
end

function RoomController:isVisitMode()
	local gameMode = RoomModel.instance:getGameMode()

	return gameMode == RoomEnum.GameMode.Visit or gameMode == RoomEnum.GameMode.VisitShare
end

function RoomController:isVisitShareMode()
	return RoomModel.instance:getGameMode() == RoomEnum.GameMode.VisitShare
end

function RoomController:isFishingMode()
	return RoomModel.instance:getGameMode() == RoomEnum.GameMode.Fishing
end

function RoomController:isFishingVisitMode()
	return RoomModel.instance:getGameMode() == RoomEnum.GameMode.FishingVisit
end

function RoomController:isDebugMode()
	local gameMode = RoomModel.instance:getGameMode()

	return gameMode == RoomEnum.GameMode.DebugNormal or gameMode == RoomEnum.GameMode.DebugInit or gameMode == RoomEnum.GameMode.DebugPackage
end

function RoomController:isDebugNormalMode()
	return RoomModel.instance:getGameMode() == RoomEnum.GameMode.DebugNormal
end

function RoomController:isDebugInitMode()
	return RoomModel.instance:getGameMode() == RoomEnum.GameMode.DebugInit
end

function RoomController:isDebugPackageMode()
	return RoomModel.instance:getGameMode() == RoomEnum.GameMode.DebugPackage
end

function RoomController:getDebugParam()
	return RoomModel.instance:getDebugParam()
end

function RoomController:getOpenViews()
	return self._openViews
end

function RoomController:enterRoom(gameMode, editInfo, obInfo, param, openViews, forceStart, isReset)
	RoomHelper.logStart("开始进入小屋")
	self:_startEnterRoomBlock()

	self._forceStart = forceStart
	self._isReset = isReset
	self._openViews = {}

	tabletool.addValues(self._openViews, openViews)

	if GameSceneMgr.instance:getCurSceneType() == SceneType.Room and RoomController.instance:isObMode() then
		-- block empty
	end

	RoomModel.instance:setGameMode(gameMode)

	if not self:isDebugMode() and (RoomLayoutModel.instance:isNeedRpcGet() or self:isObMode()) then
		RoomLayoutController.instance:sendGetRoomPlanInfoRpc()
	end

	local enterFunc = self:_getEnterRoonFuncByGameMode(gameMode)

	if enterFunc then
		enterFunc(self, editInfo, obInfo, param)
	else
		logError(string.format("can not find enter room function by gameModel:%s", gameMode))
	end
end

RoomController.ENTER_ROOM_BLOCK_KEY = "RoomController_ENTER_ROOM_BLOCK_KEY"

function RoomController:_startEnterRoomBlock()
	UIBlockMgr.instance:startBlock(RoomController.ENTER_ROOM_BLOCK_KEY)
	TaskDispatcher.cancelTask(self._endEnterRoomBlock, self)
	TaskDispatcher.runDelay(self._endEnterRoomBlock, self, 10)
end

function RoomController:_endEnterRoomBlock()
	TaskDispatcher.cancelTask(self._endEnterRoomBlock, self)
	UIBlockMgr.instance:endBlock(RoomController.ENTER_ROOM_BLOCK_KEY)
end

function RoomController:_getEnterRoonFuncByGameMode(gameMode)
	self._enterRoomFuncMap = self._enterRoomFuncMap or {
		[RoomEnum.GameMode.Ob] = self._enterRoomObOrEdit,
		[RoomEnum.GameMode.Edit] = self._enterRoomObOrEdit,
		[RoomEnum.GameMode.Visit] = self._enterRoomVisit,
		[RoomEnum.GameMode.VisitShare] = self._enterRoomVisitShare,
		[RoomEnum.GameMode.DebugNormal] = self._enterRoomDebugNormal,
		[RoomEnum.GameMode.DebugInit] = self._enterRoomDebugInit,
		[RoomEnum.GameMode.DebugPackage] = self._enterRoomDebugPackage,
		[RoomEnum.GameMode.Fishing] = self._enterRoomFishing,
		[RoomEnum.GameMode.FishingVisit] = self._enterRoomFishingVisit
	}

	return self._enterRoomFuncMap[gameMode]
end

function RoomController:_enterRoomObOrEdit(editInfo, obInfo, param)
	local curScene = GameSceneMgr.instance:getCurScene()

	if curScene and curScene.fsm then
		local backBlockModel = RoomMapBlockModel.instance:getBackBlockModel()

		if backBlockModel and backBlockModel:getCount() > 0 then
			curScene.fsm:triggerEvent(RoomSceneEvent.CancelBackBlock)
		end

		if RoomMapBlockModel.instance:getTempBlockMO() then
			curScene.fsm:triggerEvent(RoomSceneEvent.CancelPlaceBlock)
		end

		if RoomMapBuildingModel.instance:getTempBuildingMO() then
			curScene.fsm:triggerEvent(RoomSceneEvent.CancelPlaceBuilding)
		end
	end

	RoomModel.instance:setEnterParam(param)

	self._editInfoReady = false
	self._obInfoReady = false

	local gameMode = RoomModel.instance:getGameMode()

	if editInfo or gameMode == RoomEnum.GameMode.Ob then
		self._editInfoReady = true

		if editInfo then
			RoomModel.instance:setEditInfo(editInfo)
		end
	end

	if obInfo then
		self._obInfoReady = true

		RoomModel.instance:setObInfo(obInfo)
		RoomLayoutController.instance:updateObInfo()
	end

	if not self._editInfoReady then
		RoomRpc.instance:sendGetRoomInfoRequest(self.getRoomInfoReply, self)
	end

	if not self._obInfoReady then
		RoomRpc.instance:sendGetRoomObInfoRequest(true, self.getRoomObInfoReply, self)
	end

	RoomGiftController.instance:getAct159Info()
	ManufactureController.instance:getManufactureServerInfo()
	self:_checkInfo()
end

function RoomController:getRoomInfoReply(cmd, resultCode, msg)
	if resultCode == 0 then
		RoomHelper.logElapse("获取小屋协议完成")
		RoomModel.instance:setEditInfo(msg)

		self._editInfoReady = true

		self:_checkInfo()
	else
		self:_endEnterRoomBlock()
	end
end

function RoomController:getRoomObInfoReply(cmd, resultCode, msg)
	self:_roomXObInfoReply(cmd, resultCode, msg, RoomEnum.GameMode.Ob)
end

function RoomController:_enterRoomVisit(editInfo, obInfo, param)
	RoomModel.instance:setVisitParam(param)

	self._obInfoReady = false
	self._editInfoReady = true

	local userId = param.userId

	RoomRpc.instance:sendGetOtherRoomObInfoRequest(userId, self.getOtherRoomObInfoReply, self)
end

function RoomController:getOtherRoomObInfoReply(cmd, resultCode, msg)
	if resultCode == 0 and not string.nilorempty(msg.shareCode) then
		RoomModel.instance:setInfoByMode(msg, RoomEnum.GameMode.Visit)
		RoomRpc.instance:sendGetRoomShareRequest(msg.shareCode, self._onGetOtherToShareCodeReply, self)
	else
		self:_roomXObInfoReply(cmd, resultCode, msg, RoomEnum.GameMode.Visit)
	end
end

function RoomController:_onGetOtherToShareCodeReply(cmd, resultCode, msg)
	if resultCode == 0 then
		RoomModel.instance:setGameMode(RoomEnum.GameMode.VisitShare)
		self:getGetRoomShareReply(cmd, resultCode, msg)
	else
		self:_roomXObInfoReply(cmd, 0, RoomModel.instance:getInfoByMode(RoomEnum.GameMode.Visit), RoomEnum.GameMode.Visit)
	end
end

function RoomController:_enterRoomVisitShare(editInfo, obInfo, param)
	self._obInfoReady = false
	self._editInfoReady = true
	self._isVisitCompareInfo = RoomLayoutHelper.checkVisitParamCoppare(param)

	if obInfo and obInfo.shareCode == param.shareCode and obInfo.shareUserId == param.userId then
		self:getGetRoomShareReply(nil, 0, obInfo)
	else
		local shareCode = param.shareCode

		RoomRpc.instance:sendGetRoomShareRequest(shareCode, self.getGetRoomShareReply, self)
	end
end

function RoomController:getGetRoomShareReply(cmd, resultCode, msg)
	if resultCode == 0 then
		local newParam = {
			userId = msg.shareUserId,
			shareCode = msg.shareCode,
			nickName = msg.nickName,
			portrait = msg.portrait,
			useCount = msg.useCount,
			roomPlanName = msg.roomPlanName
		}

		if self._isVisitCompareInfo then
			newParam.isCompareInfo = true
		end

		RoomModel.instance:setVisitParam(newParam)
	end

	self:_roomXObInfoReply(cmd, resultCode, msg, RoomEnum.GameMode.VisitShare)
end

function RoomController:_enterRoomDebugNormal(editInfo, obInfo, param)
	local map = RoomDebugController.instance:getDebugMapInfo()

	RoomModel.instance:setEditInfo(map)
	RoomModel.instance:setObInfo(nil)
	self:_enterScene()
end

function RoomController:_enterRoomDebugInit(editInfo, obInfo, param)
	RoomModel.instance:setDebugParam(param)
	RoomDebugController.instance:getDebugInitMapInfo(param, self._onEnterRoomDebugParam, self)
end

function RoomController:_enterRoomDebugPackage(editInfo, obInfo, param)
	RoomModel.instance:setDebugParam(param)
	RoomDebugController.instance:getDebugPackageMapInfo(param, self._onEnterRoomDebugParam, self)
end

function RoomController:_onEnterRoomDebugParam(map)
	RoomModel.instance:setEditInfo(map)
	RoomModel.instance:setObInfo(nil)
	self:_enterScene()
end

function RoomController:_enterRoomFishing(editInfo, obInfo, param)
	FishingController.instance:getFishingInfo(nil, self._afterGetMyFishingInfo, self)
end

function RoomController:_afterGetMyFishingInfo(cmd, resultCode, msg)
	if resultCode ~= 0 then
		self:_endEnterRoomBlock()

		return
	end

	self:_setFinishingMapInfo()
	self:_enterScene()
end

function RoomController:_enterRoomFishingVisit(editInfo, obInfo, param)
	local userId = param and param.userId

	if not userId then
		return
	end

	if param.hasFishingVisitInfo then
		self:_afterGetOtherFishingInfo(nil, 0, nil)
	else
		FishingController.instance:getFishingInfo(userId, self._afterGetOtherFishingInfo, self)
	end
end

function RoomController:_afterGetOtherFishingInfo(cmd, resultCode, msg)
	if resultCode ~= 0 then
		self:_endEnterRoomBlock()

		return
	end

	self:_setFinishingMapInfo(true)
	self:_enterScene()
end

function RoomController:_setFinishingMapInfo(isVisit)
	if isVisit then
		if not RoomEnum.GameMode.FishingVisit then
			local mode = RoomEnum.GameMode.Fishing
			local mapInfo = FishingConfig.instance:getFishingMapInfo()
			local mapId = mapInfo.mapId
			local myPointData = FishingConfig.instance:getFishingConst(FishingEnum.ConstId.MyPoint, true, "#")
			local maxUid = FishingConfig.instance:getMaxBuildingUid(mapId) + 1
			local var_45_1 = {
				use = true,
				resAreaDirection = 0,
				rotate = 0,
				mapId = mapId,
				uid = maxUid,
				defineId = FishingEnum.Const.FishingBuilding
			}

			var_45_1.x = myPointData[1] or 0
			var_45_1.y = myPointData[2] or 0
			var_45_1.belongUserId = FishingModel.instance:getCurShowingUserId()
			mapInfo.buildingInfos[#mapInfo.buildingInfos + 1] = var_45_1

			local friendBoastInfoList = FishingModel.instance:getFriendBoatInfoList()

			if friendBoastInfoList then
				local friendPointIndex = 1
				local strangerPointIndex = 1
				local friendPointData = FishingConfig.instance:getFishingConst(FishingEnum.ConstId.FriendPoint, false, "|")
				local strangerPointData = FishingConfig.instance:getFishingConst(FishingEnum.ConstId.StrangerPoint, false, "|")

				for _, boatInfo in ipairs(friendBoastInfoList) do
					local strPointData
					local uid = maxUid + 1
					local userId = boatInfo.userId

					if boatInfo.isFriend then
						strPointData = friendPointData[friendPointIndex]
						friendPointIndex = friendPointIndex + 1
					else
						strPointData = strangerPointData[strangerPointIndex]
						strangerPointIndex = strangerPointIndex + 1
					end

					if not string.nilorempty(strPointData) then
						local pointData = string.splitToNumber(strPointData, "#")
						local var_45_2 = {
							use = true,
							resAreaDirection = 0,
							rotate = 0,
							mapId = mapId,
							uid = uid,
							defineId = FishingEnum.Const.FishingBuilding
						}

						var_45_2.x = pointData[1] or 0
						var_45_2.y = pointData[2] or 0
						var_45_2.belongUserId = userId
						mapInfo.buildingInfos[#mapInfo.buildingInfos + 1] = var_45_2
						maxUid = uid
					end
				end
			end

			RoomModel.instance:setInfoByMode(mapInfo, mode)
		end
	end
end

function RoomController:_roomXObInfoReply(cmd, resultCode, msg, gameMode)
	if resultCode == 0 then
		RoomHelper.logElapse("获取小屋 ob协议完成")
		RoomModel.instance:setInfoByMode(msg, gameMode)

		self._obInfoReady = true

		self:_checkInfo()
	else
		self:_endEnterRoomBlock()
	end
end

function RoomController:_checkInfo()
	if self._editInfoReady and self._obInfoReady then
		RoomHelper.logElapse("开始加载小屋场景")
		self:_enterScene()
	end
end

function RoomController:_enterScene()
	local curSceneType = GameSceneMgr.instance:getCurSceneType()

	if curSceneType == SceneType.Room then
		self:_switchScene()
		self:_endEnterRoomBlock()
	else
		GameSceneMgr.instance:startSceneDefaultLevel(SceneType.Room, RoomEnum.RoomSceneId, self._forceStart)
		TaskDispatcher.runDelay(self._nextFrameStartPreload, self, 0.01)
	end
end

function RoomController:_nextFrameStartPreload()
	RoomPreloadMgr.instance:startPreload()
	self:_endEnterRoomBlock()
end

function RoomController:_switchScene()
	GameSceneMgr.instance:dispatchEvent(SceneEventName.SetLoadingTypeOnce, GameLoadingState.LoadingRoomView)
	GameSceneMgr.instance:showLoading(SceneType.Room)
	TaskDispatcher.runDelay(self._delaySwitchScene, self, 2)
	self:dispatchEvent(RoomEvent.SwitchScene)

	local scene = GameSceneMgr.instance:getCurScene()

	if RoomController.instance:isObMode() then
		scene.camera:playCameraAnim("in_show")
	elseif RoomController.instance:isEditMode() then
		scene.camera:playCameraAnim("in_edit")
	end
end

function RoomController:_delaySwitchScene()
	local roomScene = GameSceneMgr.instance:getScene(SceneType.Room)

	roomScene.director:switchMode()
end

function RoomController:leaveRoom()
	RoomMapController.instance:statRoomEnd()
	MainController.instance:enterMainScene()
end

function RoomController:blockPackageGainPush(msg)
	RoomModel.instance:blockPackageGainPush(msg)

	if self:isEditMode() then
		RoomInventoryBlockModel.instance:addBlockPackageList(msg.blockPackages)
	end
end

function RoomController:gainSpecialBlockPush(msg)
	RoomModel.instance:addSpecialBlockIds(msg.specialBlocks)

	if self:isEditMode() then
		RoomInventoryBlockModel.instance:addSpecialBlockIds(msg.specialBlocks)
	end
end

function RoomController:getBlockPackageInfoReply(msg)
	RoomModel.instance:setBlockPackageIds(msg.blockPackageIds)
	RoomModel.instance:setSpecialBlockInfoList(msg.specialBlocks)
end

function RoomController:getBuildingInfoReply(msg)
	RoomModel.instance:setBuildingInfos(msg.buildingInfos)
end

function RoomController:getRoomThemeCollectionBonusReply(msg)
	RoomModel.instance:addGetThemeRewardId(msg.id)
	self:dispatchEvent(RoomEvent.UpdateRoomThemeReward, msg.id)
end

function RoomController:MaterialChangeByRoomProductLine(list)
	local buildDegree = RoomMapModel.instance:getAllBuildDegree()
	local totalBuildBonus = RoomConfig.instance:getBuildBonusByBuildDegree(buildDegree) / 10
	local toastId = RoomEnum.Toast.MaterialChangeByRoomProductLine_Base

	if totalBuildBonus > 0 then
		toastId = RoomEnum.Toast.MaterialChangeByRoomProductLine
	else
		totalBuildBonus = nil
	end

	for i, v in ipairs(list) do
		local icon = ResUrl.getPropItemIcon(v.materilId)
		local config = ItemModel.instance:getItemConfig(v.materilType, v.materilId)

		ToastController.instance:showToastWithIcon(toastId, icon, string.format("%s+%d", config.name, v.quantity), totalBuildBonus)
	end
end

function RoomController:exitRoom(isHomeClick)
	local isInFishing = FishingModel.instance:isInFishing()
	local isFishingVisit = self:isFishingVisitMode()

	if self:isEditorMode() then
		GameSceneMgr.instance:closeScene()
		ViewMgr.instance:openView(ViewName.RoomDebugEntranceView)
	elseif self:isEditMode() then
		local param = {
			isFromEditMode = true
		}

		if RoomMapController.instance:isHasConfirmOp() then
			param.isConfirm = true
		end

		if RoomMapController.instance:isNeedConfirmRoom() then
			param.isConfirm = true
			param.isHomeClick = isHomeClick

			RoomMapController.instance:confirmRoom(self._confirmRoomCallback, self, param)
		else
			RoomShowBuildingListModel.instance:clearFilterData()
			RoomThemeFilterListModel.instance:clearFilterData()

			if isHomeClick then
				self:leaveRoom()
			else
				self:enterRoom(RoomEnum.GameMode.Ob, nil, nil, param)
			end
		end
	elseif isHomeClick then
		if isInFishing then
			if isFishingVisit then
				if not StatEnum.RoomFishingResult.ExitFriend then
					local result = StatEnum.RoomFishingResult.Exit
					local curPoolUserId = FishingModel.instance:getCurShowingUserId()

					FishingController.instance:sendExitFishingTrack(result, curPoolUserId)
				end
			end
		end

		self:leaveRoom()
	elseif self:isVisitShareMode() or self:isFishingMode() then
		local myUserId = PlayerModel.instance:getMyUserId()

		FishingController.instance:sendExitFishingTrack(StatEnum.RoomFishingResult.Exit, myUserId)
		self:enterRoom(RoomEnum.GameMode.Ob, nil, nil, nil, nil, nil, true)
	elseif isFishingVisit then
		FishingController.instance:enterFishingMode(true)
	else
		self:leaveRoom()

		if self:isVisitMode() then
			JumpController.instance:jump(JumpEnum.JumpView.SocialView)
		end
	end
end

function RoomController:_confirmRoomCallback(param)
	RoomShowBuildingListModel.instance:clearFilterData()

	if param.isHomeClick then
		self:leaveRoom()
	else
		self:enterRoom(RoomEnum.GameMode.Ob, nil, nil, param)
	end
end

function RoomController:isReset()
	return self._isReset
end

function RoomController:openStoreGoodsTipView(_storeGoodsMO)
	ViewMgr.instance:openView(ViewName.RoomStoreGoodsTipView, {
		storeGoodsMO = _storeGoodsMO
	})
end

function RoomController:openThemeFilterView(isBottom, posX)
	ViewMgr.instance:openView(ViewName.RoomThemeFilterView, {
		isBottom = isBottom,
		posX = posX
	})
end

function RoomController:popUpRoomBlockPackageView(materialDataMOList)
	if not materialDataMOList then
		return
	end

	self:_showPopupViewChange(materialDataMOList)
	self:_showTipsMaterialChange(materialDataMOList)
end

function RoomController:_showPopupViewChange(materialDataMOList)
	local orderMO = RoomStoreOrderModel.instance:getMOByList(materialDataMOList)
	local list = {}
	local tempMOList = materialDataMOList
	local tRoomConfig = RoomConfig.instance

	if orderMO then
		RoomStoreOrderModel.instance:remove(orderMO)

		if orderMO.themeId then
			table.insert(list, {
				itemType = MaterialEnum.MaterialType.RoomTheme,
				itemId = orderMO.themeId
			})

			tempMOList = {}

			for i, materialDataMO in ipairs(materialDataMOList) do
				local tempThemeId = tRoomConfig:getThemeIdByItem(materialDataMO.materilId, materialDataMO.materilType)

				if orderMO.themeId ~= tempThemeId then
					table.insert(tempMOList, materialDataMO)
				end
			end
		end
	end

	for i, materialDataMO in ipairs(tempMOList) do
		if materialDataMO.materilType == MaterialEnum.MaterialType.BlockPackage then
			local config = tRoomConfig:getBlockPackageConfig(materialDataMO.materilId)

			if config and not string.nilorempty(config.rewardIcon) and self:_containRare(CommonConfig.instance:getConstStr(ConstEnum.RoomBlockPackageGetRare), config.rare) then
				table.insert(list, {
					itemType = MaterialEnum.MaterialType.BlockPackage,
					itemId = materialDataMO.materilId
				})
			end
		end
	end

	for i, materialDataMO in ipairs(tempMOList) do
		if materialDataMO.materilType == MaterialEnum.MaterialType.Building then
			local config = tRoomConfig:getBuildingConfig(materialDataMO.materilId)

			if config and not string.nilorempty(config.rewardIcon) and self:_containRare(CommonConfig.instance:getConstStr(ConstEnum.RoomBuildingGetRare), config.rare) then
				table.insert(list, {
					itemType = MaterialEnum.MaterialType.Building,
					itemId = materialDataMO.materilId,
					roomBuildingLevel = materialDataMO.roomBuildingLevel
				})
			end
		end
	end

	if #list > 0 then
		PopupController.instance:addPopupView(PopupEnum.PriorityType.RoomBlockPackageGetView, ViewName.RoomBlockPackageGetView, {
			itemList = list
		})
	end
end

function RoomController:_showTipsMaterialChange(materialDataMOList)
	local isOpen = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Room)

	for i = 1, #materialDataMOList do
		local materialDataMO = materialDataMOList[i]

		if isOpen then
			if materialDataMO.materilType == MaterialEnum.MaterialType.SpecialBlock then
				local blockCfg = RoomConfig.instance:getBlock(materialDataMO.materilId)

				if blockCfg then
					local specialCfg = RoomConfig.instance:getSpecialBlockConfig(materialDataMO.materilId)
					local packageCfg = RoomConfig.instance:getBlockPackageConfig(blockCfg.packageId)
					local var_66_0

					if specialCfg then
						var_66_0 = specialCfg.name or materialDataMO.materilId

						local var_66_1

						if packageCfg then
							var_66_1 = packageCfg.name or blockCfg.packageId
						end
					end

					ToastController.instance:showToast(RoomEnum.Toast.SpecialBlockGain, var_66_0, var_66_1)
				end
			end
		elseif self._showChangeNotOpenToastDic and self._showChangeNotOpenToastDic[materialDataMO.materilType] then
			local cfg = ItemModel.instance:getItemConfig(materialDataMO.materilType, materialDataMO.materilId)

			ToastController.instance:showToast(self._showChangeNotOpenToastDic[materialDataMO.materilType], (cfg or nil) and (cfg.name or materialDataMO.materilId))
		end
	end
end

function RoomController:showInteractionRewardToast(materialDataMOList)
	if not materialDataMOList then
		return
	end

	for i, materialDataMO in ipairs(materialDataMOList) do
		local config, icon = ItemModel.instance:getItemConfigAndIcon(materialDataMO.materilType, materialDataMO.materilId)

		if config then
			GameFacade.showToastWithIcon(ToastEnum.RoomRewardToast, icon, config.name, materialDataMO.quantity)
		end
	end
end

function RoomController:homeClick()
	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.RoomForbidBtn) then
		GameFacade.showToast(RoomEnum.GuideForbidEscapeToast)

		return
	end

	RoomController.instance:exitRoom(true)
end

function RoomController:_containRare(rareStr, rare)
	if string.nilorempty(rareStr) then
		return false
	end

	local rareList = string.splitToNumber(rareStr, "#")

	return tabletool.indexOf(rareList, rare)
end

function RoomController:popUpSourceView(openedViewNameList)
	local hasRoomFormulaView = false
	local hasRoomInitBuildingView = false
	local hasProductLineLevelUpView = false

	for _, openView in ipairs(openedViewNameList) do
		if openView.viewName == ViewName.RoomInitBuildingView then
			hasRoomInitBuildingView = true
		elseif openView.viewName == ViewName.RoomFormulaView then
			hasRoomFormulaView = true
		elseif openView.viewName == ViewName.RoomProductLineLevelUpView then
			hasProductLineLevelUpView = true
		end
	end

	for _, openView in ipairs(openedViewNameList) do
		if openView.viewName == ViewName.RoomInitBuildingView then
			openView.viewParam = openView.viewParam or {}
			openView.viewParam.showFormulaView = hasRoomFormulaView and hasProductLineLevelUpView == false

			local isRoomScene = RoomController.instance:isRoomScene()

			if isRoomScene then
				RoomMapController.instance:openRoomInitBuildingView(0, openView.viewParam)
			else
				RoomMapController.instance:openFormulaItemBuildingViewOutSide()
			end
		elseif openView.viewName == ViewName.RoomFormulaView and (not hasRoomInitBuildingView or hasProductLineLevelUpView) then
			ViewMgr.instance:openView(openView.viewName, openView.viewParam)
		end
	end
end

RoomController.instance = RoomController.New()

return RoomController
