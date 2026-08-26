-- chunkname: @modules/logic/room/view/RoomMiniMapView.lua

module("modules.logic.room.view.RoomMiniMapView", package.seeall)

local RoomMiniMapView = class("RoomMiniMapView", BaseView)

function RoomMiniMapView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._simagelefticon = gohelper.findChildSingleImage(self.viewGO, "#simage_lefticon")
	self._simagerighticon = gohelper.findChildSingleImage(self.viewGO, "#simage_righticon")
	self._simagerighticon2 = gohelper.findChildSingleImage(self.viewGO, "#simage_righticon2")
	self._simagemask = gohelper.findChildSingleImage(self.viewGO, "#simage_mask")
	self._simageline = gohelper.findChildSingleImage(self.viewGO, "#simage_line")
	self._simageline2 = gohelper.findChildSingleImage(self.viewGO, "#simage_line2")
	self._simagecontour = gohelper.findChildSingleImage(self.viewGO, "#simage_mapbg/#simage_contour")
	self._gocontainer = gohelper.findChild(self.viewGO, "#go_container")
	self._goblockcontainer = gohelper.findChild(self.viewGO, "#go_container/#go_blockcontainer")
	self._gounititem = gohelper.findChild(self.viewGO, "#go_container/#go_blockcontainer/unitcontainer/#go_unititem")
	self._gobuildingitem = gohelper.findChild(self.viewGO, "#go_container/#go_blockcontainer/buildingcontainer/#go_buildingitem")
	self._goredpointitem = gohelper.findChild(self.viewGO, "#go_container/#go_blockcontainer/redpointcontainer/#go_redpointitem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomMiniMapView:addEvents()
	return
end

function RoomMiniMapView:removeEvents()
	return
end

function RoomMiniMapView:_editableInitView()
	self._scene = GameSceneMgr.instance:getCurScene()

	self._simagebg:LoadImage(ResUrl.getCommonIcon("full/bg_fmand2"))
	self._simagelefticon:LoadImage(ResUrl.getCommonIcon("bg_leftdown"))
	self._simagerighticon:LoadImage(ResUrl.getCommonIcon("bg_rightdown"))
	self._simagerighticon2:LoadImage(ResUrl.getCommonIcon("bg_rightup"))
	self._simagemask:LoadImage(ResUrl.getCommonIcon("full/bg_noise2"))
	self._simageline:LoadImage(ResUrl.getRoomImage("quanlanditu_line_002"))
	self._simageline2:LoadImage(ResUrl.getRoomTexture("bgline.jpg"))
	self._simagecontour:LoadImage(ResUrl.getRoomImage("quanlanditukuai_012"))

	self._unitItemList = {}
	self._buildingItemList = {}
	self._redpointItemDict = {}
	self._countItemList = {}

	gohelper.setActive(self._gounititem, false)
	gohelper.setActive(self._gobuildingitem, false)
	gohelper.setActive(self._goredpointitem, false)

	self._left = 0
	self._right = 0
	self._bottom = 0
	self._top = 0
	self._width = recthelper.getWidth(self._gocontainer.transform)
	self._height = recthelper.getHeight(self._gocontainer.transform)
	self._touchMgr = TouchEventMgrHepler.getTouchEventMgr(self._gocontainer)

	self._touchMgr:SetIgnoreUI(true)
	self._touchMgr:SetOnlyTouch(true)
	self._touchMgr:SetOnDragBeginCb(self._onDragBegin, self)
	self._touchMgr:SetOnDragCb(self._onDrag, self)
	self._touchMgr:SetOnDragEndCb(self._onDragEnd, self)

	self._lastPos = nil

	self:_setScale(0.5)
end

function RoomMiniMapView:_onDragBegin(screenPos)
	self._isDraging = true
	self._lastPos = recthelper.screenPosToAnchorPos(screenPos, self._gocontainer.transform)

	if math.abs(self._lastPos.x) > self._width / 2 or math.abs(self._lastPos.y) > self._height / 2 then
		self._lastPos = nil
	end
end

function RoomMiniMapView:_onDrag(screenPos)
	self._isDraging = true

	if not self._lastPos then
		return
	end

	local anchorPos = recthelper.screenPosToAnchorPos(screenPos, self._gocontainer.transform)

	self:_moveMap(anchorPos - self._lastPos)

	self._lastPos = anchorPos
end

function RoomMiniMapView:_onDragEnd(screenPos)
	self._isDraging = false
	self._lastPos = nil
end

function RoomMiniMapView:_moveMap(deltaPos)
	local currentPosX, currentPosY = transformhelper.getLocalPos(self._goblockcontainer.transform)
	local targetPosX, targetPosY = currentPosX + deltaPos.x, currentPosY + deltaPos.y

	self:_setMapPos(Vector2(targetPosX, targetPosY))
end

function RoomMiniMapView:_setMapPos(mapPos)
	local targetPosX, targetPosY = mapPos.x, mapPos.y

	targetPosX = Mathf.Clamp(targetPosX, -self._right * self._scale, -self._left * self._scale)
	targetPosY = Mathf.Clamp(targetPosY, -self._top * self._scale, -self._bottom * self._scale)

	transformhelper.setLocalPos(self._goblockcontainer.transform, targetPosX, targetPosY, 0)
end

function RoomMiniMapView:onOpen()
	self:_refreshFixed()
	self:_refreshDynamic()
	self:_resetScale()

	local cameraFocus = self._scene.camera:getCameraFocus()
	local focusHexPoint = HexMath.positionToHex(cameraFocus, RoomBlockEnum.BlockSize)

	self._focusMapPos = -self:_getMapPos(focusHexPoint)

	self:_setMapPos(self._focusMapPos)
end

function RoomMiniMapView:_resetScale()
	self:_setScale(0.5)
end

function RoomMiniMapView:_setScale(scale)
	self._scale = scale

	transformhelper.setLocalScale(self._goblockcontainer.transform, scale, scale, 1)
end

function RoomMiniMapView:onClose()
	return
end

function RoomMiniMapView:_refreshFixed()
	self:_refreshUnitItems()
	self:_refreshBuildingItems()
	self:_refreshInitBuildingItems()
end

function RoomMiniMapView:_refreshDynamic()
	if RoomController.instance:isObMode() then
		self:_refreshRedpointItems()
	end
end

function RoomMiniMapView:_refreshUnitItems()
	local mapBlockMOList = RoomMapBlockModel.instance:getBlockMOList()

	for _, blockMO in ipairs(mapBlockMOList) do
		if blockMO.blockState == RoomBlockEnum.BlockState.Map then
			local hexPoint = blockMO.hexPoint
			local unitItem = self:getUserDataTb_()

			unitItem.go = gohelper.cloneInPlace(self._gounititem, string.format("%s_%s", hexPoint.x, hexPoint.y))
			unitItem.imageunit = gohelper.findChildImage(unitItem.go, "image_unit")

			table.insert(self._unitItemList, unitItem)

			local mapResourceId = RoomBlockHelper.getMapResourceId(blockMO)

			UISpriteSetMgr.instance:setRoomSprite(unitItem.imageunit, "mapunit" .. mapResourceId)
			self:_setCommonPosition(unitItem.go.transform, hexPoint)
			gohelper.setActive(unitItem.go, true)
		end
	end
end

function RoomMiniMapView:_refreshBuildingItems()
	local mapBlockMOList = RoomMapBlockModel.instance:getBlockMOList()

	for _, blockMO in ipairs(mapBlockMOList) do
		if blockMO.blockState == RoomBlockEnum.BlockState.Map then
			local hexPoint = blockMO.hexPoint
			local buildingParam = RoomBuildingHelper.getOccupyBuildingParam(hexPoint)
			local buildingUid = buildingParam and buildingParam.buildingUid

			if buildingUid then
				::label_17_0::

				local buildingMO = RoomMapBuildingModel.instance:getBuildingMOById(buildingUid)
				local buildingType = buildingMO and buildingMO.config.buildingType
				local buildingShowType = buildingMO and buildingMO.config.buildingShowType

				if buildingType and buildingType ~= RoomBuildingEnum.BuildingType.Decoration then
					local buildingItem = self:getUserDataTb_()

					buildingItem.id = buildingMO.id
					buildingItem.go = gohelper.cloneInPlace(self._gobuildingitem, string.format("%s_%s", hexPoint.x, hexPoint.y))
					buildingItem.imagebuilding = gohelper.findChildImage(buildingItem.go, "image_building")

					table.insert(self._buildingItemList, buildingItem)
					UISpriteSetMgr.instance:setRoomSprite(buildingItem.imagebuilding, "buildingtype" .. buildingShowType)
					self:_setCommonPosition(buildingItem.go.transform, hexPoint)
					gohelper.setActive(buildingItem.go, true)
				end
			end
		end
	end
end

function RoomMiniMapView:_refreshInitBuildingItems()
	local occupyDict = RoomConfig.instance:getInitBuildingOccupyDict()

	for x, dict in pairs(occupyDict) do
		for y, _ in pairs(dict) do
			local hexPoint = HexPoint(x, y)
			local buildingItem = self:getUserDataTb_()

			buildingItem.id = 0
			buildingItem.go = gohelper.cloneInPlace(self._gobuildingitem, string.format("%s_%s", hexPoint.x, hexPoint.y))
			buildingItem.imagebuilding = gohelper.findChildImage(buildingItem.go, "image_building")
			buildingItem.btnbuilding = gohelper.findChildButtonWithAudio(buildingItem.go, "btn_building")

			table.insert(self._buildingItemList, buildingItem)
			gohelper.setActive(buildingItem.btnbuilding.gameObject, false)
			SLFramework.UGUI.GuiHelper.SetColor(buildingItem.imagebuilding, "#A29E88")
			UISpriteSetMgr.instance:setRoomSprite(buildingItem.imagebuilding, "buildingtype0")
			recthelper.setWidth(buildingItem.imagebuilding.gameObject.transform, 38)
			recthelper.setHeight(buildingItem.imagebuilding.gameObject.transform, 31)
			self:_setCommonPosition(buildingItem.go.transform, hexPoint)
			gohelper.setActive(buildingItem.go, true)
		end
	end
end

function RoomMiniMapView:_refreshRedpointItems()
	local mapBuildingMOList = RoomMapBuildingModel.instance:getBuildingMOList()

	for buildingUid, redpointItem in pairs(self._redpointItemDict) do
		gohelper.setActive(redpointItem.go, false)
	end

	for i, buildingMO in ipairs(mapBuildingMOList) do
		local topRightHexPoint = RoomBuildingHelper.getTopRightHexPoint(buildingMO.buildingId, buildingMO.hexPoint, buildingMO.rotate)
		local buildingType = buildingMO.config.buildingType

		if buildingType ~= RoomBuildingEnum.BuildingType.Decoration and topRightHexPoint and buildingMO.buildingState == RoomBuildingEnum.BuildingState.Map then
			local redpointItem = self._redpointItemDict[buildingMO.id]

			if not redpointItem then
				redpointItem = self:getUserDataTb_()
				redpointItem.go = gohelper.cloneInPlace(self._goredpointitem, string.format("%s_%s", topRightHexPoint.x, topRightHexPoint.y))
				redpointItem.goreddot = gohelper.findChild(redpointItem.go, "go_buildingreddot")

				if RoomController.instance:isObMode() then
					RedDotController.instance:addMultiRedDot(redpointItem.goreddot, {
						{
							id = RedDotEnum.DotNode.RoomBuildingFull,
							uid = tonumber(buildingMO.id)
						},
						{
							id = RedDotEnum.DotNode.RoomBuildingGet,
							uid = tonumber(buildingMO.id)
						}
					})
				end

				self._redpointItemDict[buildingMO.id] = redpointItem

				self:_setCommonPosition(redpointItem.go.transform, topRightHexPoint)
			end

			gohelper.setActive(redpointItem.go, true)
		end
	end
end

function RoomMiniMapView:_setCommonPosition(transform, hexPoint)
	local position = HexMath.hexToPosition(hexPoint, 43.78481 / math.sqrt(3) * 2)
	local theta = 30 * Mathf.Deg2Rad
	local rotatedPosition = Vector2(position.x * Mathf.Cos(theta) - position.y * Mathf.Sin(theta), position.x * Mathf.Sin(theta) + position.y * Mathf.Cos(theta))

	self._left = math.min(rotatedPosition.x, self._left)
	self._right = math.max(rotatedPosition.x, self._right)
	self._bottom = math.min(rotatedPosition.y, self._bottom)
	self._top = math.max(rotatedPosition.y, self._top)

	recthelper.setAnchor(transform, position.x, position.y)
end

function RoomMiniMapView:_getMapPos(hexPoint)
	local position = HexMath.hexToPosition(hexPoint, 43.78481 / math.sqrt(3) * 2)
	local theta = 30 * Mathf.Deg2Rad
	local rotatedPosition = Vector2(position.x * Mathf.Cos(theta) - position.y * Mathf.Sin(theta), position.x * Mathf.Sin(theta) + position.y * Mathf.Cos(theta))

	return Vector2(rotatedPosition.x * self._scale, rotatedPosition.y * self._scale)
end

function RoomMiniMapView:onDestroyView()
	if self._touchMgr then
		TouchEventMgrHepler.remove(self._touchMgr)

		self._touchMgr = nil
	end

	self._simagebg:UnLoadImage()
	self._simagelefticon:UnLoadImage()
	self._simagerighticon:UnLoadImage()
	self._simagerighticon2:UnLoadImage()
	self._simagemask:UnLoadImage()
	self._simageline:UnLoadImage()
	self._simageline2:UnLoadImage()
	self._simagecontour:UnLoadImage()
end

return RoomMiniMapView
