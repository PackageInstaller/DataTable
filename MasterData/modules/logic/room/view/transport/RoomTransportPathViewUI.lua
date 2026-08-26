-- chunkname: @modules/logic/room/view/transport/RoomTransportPathViewUI.lua

module("modules.logic.room.view.transport.RoomTransportPathViewUI", package.seeall)

local RoomTransportPathViewUI = class("RoomTransportPathViewUI", BaseView)

function RoomTransportPathViewUI:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomTransportPathViewUI:addEvents()
	return
end

function RoomTransportPathViewUI:removeEvents()
	return
end

function RoomTransportPathViewUI:_editableInitView()
	self._gomapui = gohelper.findChild(self.viewGO, "go_mapui")
	self._gomapuiitem = gohelper.findChild(self.viewGO, "go_mapui/go_mapuiitem")
	self._gomapuiTrs = self._gomapui.transform
	self._buildingTypeIconColor = {
		[RoomBuildingEnum.BuildingType.Collect] = "#91D7F1",
		[RoomBuildingEnum.BuildingType.Process] = "#E2D487",
		[RoomBuildingEnum.BuildingType.Manufacture] = "#99EAC8"
	}
	self._uiitemTBList = {
		self:_createTB(self._gomapuiitem)
	}

	gohelper.setActive(self._gomapuiitem, false)
end

function RoomTransportPathViewUI:onUpdateParam()
	return
end

function RoomTransportPathViewUI:onOpen()
	self.addEventCb(self, RoomMapController.instance, RoomEvent.CameraTransformUpdate, self._cameraTransformUpdate, self)

	if self.viewContainer then
		self.addEventCb(self, self.viewContainer, RoomEvent.TransportPathSelectLineItem, self.startWaitRunDelayTask, self)
	end

	self:startWaitRunDelayTask()
end

function RoomTransportPathViewUI:onClose()
	self.__hasWaitRunDelayTask_ = false

	TaskDispatcher.cancelTask(self.__onWaitRunDelayTask_, self)
end

function RoomTransportPathViewUI:onDestroyView()
	return
end

function RoomTransportPathViewUI:_cameraTransformUpdate()
	self:_refreshItemUIPos()
end

function RoomTransportPathViewUI:startWaitRunDelayTask()
	if not self.__hasWaitRunDelayTask_ then
		self.__hasWaitRunDelayTask_ = true

		TaskDispatcher.runDelay(self.__onWaitRunDelayTask_, self, 0.001)
	end
end

function RoomTransportPathViewUI:__onWaitRunDelayTask_()
	self.__hasWaitRunDelayTask_ = false

	self:_refreshItemList()
	self:_refreshItemUIPos()
end

function RoomTransportPathViewUI:_createTB(go)
	local tb = self:getUserDataTb_()

	tb.go = go
	tb.goTrs = go.transform
	tb._imageicon = gohelper.findChildImage(go, "image_icon")

	return tb
end

function RoomTransportPathViewUI:_refreshTB(tb, buildingId, hexPoint)
	if tb.buildingId ~= buildingId then
		local buildingCfg = RoomConfig.instance:getBuildingConfig(buildingId)
		local iconName = ManufactureConfig.instance:getManufactureBuildingIcon(buildingId)

		UISpriteSetMgr.instance:setRoomSprite(tb._imageicon, iconName)

		if buildingCfg then
			if not self._buildingTypeIconColor[buildingCfg.buildingType] then
				local colorStr = "#FFFFFF"

				SLFramework.UGUI.GuiHelper.SetColor(tb._imageicon, colorStr)
			end
		end
	end

	if tb.hexPoint == nil or tb.hexPoint ~= hexPoint then
		tb.hexPoint = hexPoint

		local px, pz = HexMath.hexXYToPosXY(hexPoint.x, hexPoint.y, RoomBlockEnum.BlockSize)

		tb.worldPos = Vector3(px, 0, pz)
	end
end

function RoomTransportPathViewUI:_getBuildingMOList()
	local buildingType = RoomMapTransportPathModel.instance:getSelectBuildingType()

	if not buildingType then
		return nil
	end

	local fromType, toType = RoomTransportHelper.getSiteFromToByType(buildingType)

	if fromType == nil and toType == nil then
		return nil
	end

	local moList = {}
	local buildingMOList = RoomMapBuildingModel.instance:getBuildingMOList()

	for _, buildingMO in ipairs(buildingMOList) do
		if buildingMO:checkSameType(fromType) or buildingMO:checkSameType(toType) then
			table.insert(moList, buildingMO)
		end
	end

	return moList
end

function RoomTransportPathViewUI:_refreshItemList()
	local buildingMOList = self:_getBuildingMOList()
	local count = 0

	if buildingMOList and #buildingMOList > 0 then
		local tRoomMapHexPointModel = RoomMapHexPointModel.instance
		local tRoomMapModel = RoomMapModel.instance

		for _, buildingMO in ipairs(buildingMOList) do
			local hexPoint = buildingMO.hexPoint
			local pointList = tRoomMapModel:getBuildingPointList(buildingMO.buildingId, buildingMO.rotate)

			for __, point in ipairs(pointList) do
				count = count + 1

				local itemTb = self._uiitemTBList[count]

				if not itemTb then
					itemTb = self:_createTB(gohelper.cloneInPlace(self._gomapuiitem))
					self._uiitemTBList[count] = itemTb
				end

				local hexPoint = tRoomMapHexPointModel:getHexPoint(point.x + hexPoint.x, point.y + hexPoint.y)

				self:_refreshTB(itemTb, buildingMO.buildingId, hexPoint)
			end
		end
	end

	for i = 1, #self._uiitemTBList do
		local itemTb = self._uiitemTBList[i]
		local isActive = i <= count

		if itemTb.isActive ~= isActive then
			itemTb.isActive = isActive

			gohelper.setActive(itemTb.go, isActive)
		end
	end
end

function RoomTransportPathViewUI:_refreshItemUIPos()
	for i = 1, #self._uiitemTBList do
		local itemTb = self._uiitemTBList[i]

		if itemTb.isActive then
			self:_setUIPos(itemTb.worldPos, itemTb.goTrs, self._gomapuiTrs, 0.12)
		end
	end
end

function RoomTransportPathViewUI:_setUIPos(worldPos, targetUIGOTrs, parentUIGOTrs, offsetY)
	local bendingPos = RoomBendingHelper.worldToBendingSimple(worldPos)
	local bendingPosX = bendingPos.x
	local bendingPosZ = bendingPos.z

	offsetY = offsetY or 0.12

	local worldPos = Vector3(bendingPosX, bendingPos.y + offsetY, bendingPosZ)
	local localPos = recthelper.worldPosToAnchorPos(worldPos, parentUIGOTrs)

	recthelper.setAnchor(targetUIGOTrs, localPos.x, localPos.y)
end

return RoomTransportPathViewUI
