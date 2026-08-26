-- chunkname: @modules/logic/room/controller/RoomJumpController.lua

module("modules.logic.room.controller.RoomJumpController", package.seeall)

local RoomJumpController = class("RoomJumpController", BaseController)

function RoomJumpController:jumpFormTaskView(jumpId)
	if string.nilorempty(jumpId) then
		return
	end

	local isSuccessJump = false
	local jumpParam = string.splitToNumber(jumpId, "#")

	if jumpParam[1] == JumpEnum.JumpView.RoomView then
		if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Room then
			return
		end

		local func = self["jumpTo" .. jumpParam[2]]

		if func then
			isSuccessJump = func(self, jumpParam)
		end
	end

	if isSuccessJump and ViewMgr.instance:isOpen(ViewName.RoomRecordView) then
		ViewMgr.instance:closeView(ViewName.RoomRecordView, false)
	end
end

function RoomJumpController:jumpTo1(jumpParam)
	if not jumpParam[3] then
		if jumpParam[3] == 1 then
			return
		end

		if ViewMgr.instance:isOpen(ViewName.RoomRecordView) then
			if jumpParam[3] == 2 then
				if not RoomRecordEnum.AnimName.Task2Log then
					local animName = RoomRecordEnum.AnimName.Task2HandBook

					RoomController.instance:dispatchEvent(RoomEvent.SwitchRecordView, {
						animName = animName,
						view = jumpParam[3]
					})
				end
			end
		else
			ManufactureController.instance:openRoomRecordView(jumpParam[3])
		end
	end
end

function RoomJumpController:jumpTo2(jumpParam)
	if not jumpParam[3] then
		local buildingList = ManufactureModel.instance:getCritterBuildingListInOrder()

		if not buildingList or #buildingList <= 0 then
			self:showRoomNotBuildingMessageBox()

			return
		end

		if jumpParam[3] == 3 then
			if not GuideModel.instance:isGuideFinish(RoomTradeEnum.GuideUnlock.Summon) then
				GameFacade.showToast(RoomEnum.Toast.RoomTradeLowLevel)

				return
			end
		elseif jumpParam[3] == 4 and ManufactureModel.instance:getTradeLevel() < RoomTradeTaskModel.instance:getOpenCritterIncubateLevel() then
			GameFacade.showToast(RoomEnum.Toast.RoomTradeLowLevel)

			return
		end

		return ManufactureController.instance:openCritterBuildingView(nil, jumpParam[3])
	end
end

function RoomJumpController:jumpTo3(jumpParam)
	return ManufactureController.instance:openOverView()
end

function RoomJumpController:jumpTo4(jumpParam)
	if not jumpParam[3] then
		return ManufactureController.instance:openRoomTradeView(nil, jumpParam[3])
	end
end

function RoomJumpController:jumpTo5(jumpParam)
	return ManufactureController.instance:openRoomBackpackView()
end

function RoomJumpController:jumpTo6(jumpParam)
	return self:jumpToPlaceBuilding()
end

function RoomJumpController:jumpTo7(jumpParam)
	local buildingType = jumpParam[3]

	return self:jumpToManufactureBuilding(buildingType)
end

function RoomJumpController:jumpTo8(jumpParam)
	local buildingType = jumpParam[3]

	return self:jumpToManufactureBuildingLevelUp(buildingType)
end

function RoomJumpController:jumpTo9(jumpParam)
	JumpController.instance:jump(JumpEnum.JumpId.RoomStoreTabFluff)
end

function RoomJumpController:jumpTo10(jumpParam)
	local isOpen = ManufactureModel.instance:getTradeLevel() >= ManufactureConfig.instance:getUnlockSystemTradeLevel(RoomTradeEnum.LevelUnlock.TransportSystemOpen)

	if not isOpen then
		GameFacade.showToast(RoomEnum.Toast.RoomTradeLowLevel)

		return
	end

	local siteType = jumpParam[3]
	local isHas = RoomTransportController.instance:_findLinkPathSiteType(siteType)

	if not isHas then
		self:showRoomNotTransportRoadMessageBox()

		return false
	end

	RoomTransportController.instance:openTransportSiteView(siteType)

	return true
end

function RoomJumpController:jumpTo11(jumpParam)
	local buildingId = jumpParam[3]

	return self:jumpToManufactureBuilding(nil, buildingId)
end

function RoomJumpController:jumpTo12(jumpParam)
	local buildingId = jumpParam[3]

	return self:jumpToManufactureBuildingLevelUp(nil, buildingId)
end

function RoomJumpController:jumpTo13(jumpParam)
	local isOpen = ManufactureModel.instance:getTradeLevel() >= ManufactureConfig.instance:getUnlockSystemTradeLevel(RoomTradeEnum.LevelUnlock.TransportSystemOpen)

	if not isOpen then
		GameFacade.showToast(RoomEnum.Toast.RoomTradeLowLevel)

		return
	end

	return self:jumpToTransportSiteView()
end

function RoomJumpController:jumpToPlaceBuilding()
	ManufactureController.instance:jump2PlaceManufactureBuildingView()

	return true
end

function RoomJumpController:jumpToTransportSiteView()
	local isEditMode = RoomController.instance:isEditMode()

	if isEditMode then
		GameFacade.showToast(RoomEnum.Toast.TaskAlreadyInEditMode)
	else
		if RoomMapBuildingAreaModel.instance:getCount() < 2 then
			GameFacade.showToast(ToastEnum.RoomTranspathUnableEdite)

			return false
		end

		local isOpenTradeView = ViewMgr.instance:isOpen(ViewName.RoomTradeView)

		if isOpenTradeView then
			RoomTradeController.instance:dispatchEvent(RoomTradeEvent.PlayCloseTVAnim)
		end

		local isOpenRoomBackpackView = ViewMgr.instance:isOpen(ViewName.RoomBackpackView)
		local isOpenOverView = ViewMgr.instance:isOpen(ViewName.RoomOverView)

		if isOpenRoomBackpackView or isOpenOverView then
			AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_state_normal)
		end

		ViewMgr.instance:closeView(ViewName.RoomManufactureMaterialTipView)
		RoomTransportPathModel.instance:setIsJumpTransportSite(true)
		RoomController.instance:enterRoom(RoomEnum.GameMode.Edit)
	end

	return true
end

function RoomJumpController:jumpToManufactureBuilding(buildingType, buildingId)
	if buildingId then
		local buildingMo = RoomMapBuildingModel.instance:getBuildingMoByBuildingId(buildingId)

		if buildingMo then
			ManufactureController.instance:openManufactureBuildingViewByBuilding(buildingMo)
		else
			self:showRoomNotBuildingMessageBox()

			return false
		end
	else
		local isHas, _type = self:isHasBuilding(buildingType)

		if not isHas then
			self:showRoomNotBuildingMessageBox()

			return false
		end

		ManufactureController.instance:openManufactureBuildingViewByType(_type)
	end

	return true
end

function RoomJumpController:jumpToManufactureBuildingLevelUp(buildingType, buildingId)
	if buildingId then
		local buildingMo = RoomMapBuildingModel.instance:getBuildingMoByBuildingId(buildingId)

		if buildingMo then
			ManufactureController.instance:jumpToManufactureBuildingLevelUpView(buildingMo.buildingUid)
		else
			self:showRoomNotBuildingMessageBox()

			return false
		end
	else
		local isHas, _type = self:isHasBuilding(buildingType)

		if not isHas then
			self:showRoomNotBuildingMessageBox()

			return false
		end

		local buildingList = RoomMapBuildingModel.instance:getBuildingListByType(_type)

		if buildingList and #buildingList > 0 then
			local buildingUid = buildingList[1].buildingUid

			ManufactureController.instance:jumpToManufactureBuildingLevelUpView(buildingUid)
		end
	end

	return true
end

function RoomJumpController:isHasBuilding(buildingType)
	if buildingType and buildingType > 0 then
		local buildingList = RoomMapBuildingModel.instance:getBuildingListByType(buildingType)

		return buildingList and #buildingList > 0, buildingType
	end

	for _, _type in pairs(RoomJumpEnum.ManufactureBuildingType) do
		local buildingList = RoomMapBuildingModel.instance:getBuildingListByType(_type)

		if buildingList and #buildingList > 0 then
			return true, _type
		end
	end
end

function RoomJumpController:showRoomNotBuildingMessageBox()
	GameFacade.showMessageBox(MessageBoxIdDefine.RoomNotBuilding, MsgBoxEnum.BoxType.Yes_No, self.jumpToPlaceBuilding)
end

function RoomJumpController:showRoomNotTransportRoadMessageBox()
	GameFacade.showMessageBox(MessageBoxIdDefine.RoomNotTransportRoad, MsgBoxEnum.BoxType.Yes_No, self.jumpToTransportSiteView)
end

RoomJumpController.instance = RoomJumpController.New()

return RoomJumpController
