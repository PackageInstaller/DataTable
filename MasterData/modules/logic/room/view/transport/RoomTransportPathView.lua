-- chunkname: @modules/logic/room/view/transport/RoomTransportPathView.lua

module("modules.logic.room.view.transport.RoomTransportPathView", package.seeall)

local RoomTransportPathView = class("RoomTransportPathView", BaseView)

function RoomTransportPathView:onInitView()
	self._godragmap = gohelper.findChild(self.viewGO, "#go_dragmap")
	self._gonavigatebuttonscontainer = gohelper.findChild(self.viewGO, "#go_navigatebuttonscontainer")
	self._goleft = gohelper.findChild(self.viewGO, "#go_left")
	self._btnsave = gohelper.findChildButtonWithAudio(self.viewGO, "#go_left/#btn_save")
	self._btnreset = gohelper.findChildButtonWithAudio(self.viewGO, "#go_left/#btn_reset")
	self._btnquick = gohelper.findChildButtonWithAudio(self.viewGO, "#go_left/#btn_quick")
	self._btnremoveBuilding = gohelper.findChildButtonWithAudio(self.viewGO, "go_bottom/#btn_removeBuilding")
	self._goselectRemove = gohelper.findChild(self.viewGO, "go_bottom/#btn_removeBuilding/#go_selectRemove")
	self._btnremoveLand = gohelper.findChildButtonWithAudio(self.viewGO, "go_bottom/#btn_removeLand")
	self._goselectRemoveLand = gohelper.findChild(self.viewGO, "go_bottom/#btn_removeLand/#go_selectRemoveLand")
	self._gotransportgroup = gohelper.findChild(self.viewGO, "#go_transportgroup")
	self._gotypeitem = gohelper.findChild(self.viewGO, "#go_transportgroup/go_pathlinegroup/#go_typeitem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomTransportPathView:addEvents()
	self._btnsave:AddClickListener(self._btnsaveOnClick, self)
	self._btnreset:AddClickListener(self._btnresetOnClick, self)
	self._btnquick:AddClickListener(self._btnquickOnClick, self)
	self._btnremoveBuilding:AddClickListener(self._btnremoveBuildingOnClick, self)
	self._btnremoveLand:AddClickListener(self._btnbtnremoveLandOnClick, self)
end

function RoomTransportPathView:removeEvents()
	self._btnsave:RemoveClickListener()
	self._btnreset:RemoveClickListener()
	self._btnquick:RemoveClickListener()
	self._btnremoveBuilding:RemoveClickListener()
	self._btnremoveLand:RemoveClickListener()
end

function RoomTransportPathView:_btnquickOnClick()
	if not self._lineDataMO then
		return
	end

	local fromType, toType = self._lineDataMO.fromType, self._lineDataMO.toType
	local pathMO = RoomMapTransportPathModel.instance:getTransportPathMOBy2Type(fromType, toType)

	if pathMO and pathMO:isLinkFinish() then
		GameFacade.showToast(ToastEnum.RoomTransportQuickLinkFinish)

		return
	end

	if not self._quickLinkMO then
		self._quickLinkMO = RoomTransportQuickLinkMO.New()

		self._quickLinkMO:init()
	end

	local isRmoveBuilding = false
	local nodeList = self._quickLinkMO:findPath(self._lineDataMO.fromType, self._lineDataMO.toType, isRmoveBuilding)

	if not nodeList or #nodeList < 2 and self._isRemoveBuilding then
		isRmoveBuilding = true
		nodeList = self._quickLinkMO:findPath(self._lineDataMO.fromType, self._lineDataMO.toType, self._isRemoveBuilding, true)
	end

	if not nodeList or #nodeList < 2 then
		GameFacade.showToast(ToastEnum.RoomTransportQuickLinkFail)

		return
	end

	local pathMO = RoomMapTransportPathModel.instance:getTempTransportPathMO() or RoomMapTransportPathModel.instance:addTempTransportPathMO(nodeList[1].hexPoint, fromType, toType)

	if pathMO then
		pathMO:clear()

		pathMO.blockCleanType = self:_getBlockCleanType()

		pathMO:setIsEdit(true)
		pathMO:setIsQuickLink(true)

		pathMO.fromType = fromType
		pathMO.toType = toType

		local hexPointList = pathMO:getHexPointList()

		for _, node in ipairs(nodeList) do
			table.insert(hexPointList, node.hexPoint)
		end

		if isRmoveBuilding then
			for _, node in ipairs(nodeList) do
				self:_unUseBuildingByHexXy(node.hexPoint.x, node.hexPoint.y)
			end
		end

		RoomMapTransportPathModel.instance:placeTempTransportPathMO()
		self:_clearLinkFailPathMO()
		RoomMapTransportPathModel.instance:updateSiteHexPoint()
		RoomTransportController.instance:updateBlockUseState()
		GameFacade.showToast(ToastEnum.RoomTransportQuickLinkSuccess)
	else
		GameFacade.showToast(ToastEnum.RoomTransportQuickLinkFail)
	end
end

function RoomTransportPathView:_btnremoveBuildingOnClick()
	self:_setIsRemoveBuiling(self._isRemoveBuilding ~= true)
end

function RoomTransportPathView:_btnbtnremoveLandOnClick()
	self:_setIsRemoveLand(self._isRemoveLand ~= true)
	self:_updateAllPathBlockState()
end

function RoomTransportPathView:_btnsaveOnClick()
	if RoomMapTransportPathModel.instance:isHasEdit() then
		RoomTransportController.instance:saveEditPath()
	else
		self:closeThis()
	end

	RoomStatController.instance:roomRoadEditClose()
end

function RoomTransportPathView:_btnresetOnClick()
	if RoomMapTransportPathModel.instance:isHasEdit() or RoomMapTransportPathModel.instance:getTempTransportPathMO() then
		GameFacade.showMessageBox(MessageBoxIdDefine.RoomTransportPathResetConfirm, MsgBoxEnum.BoxType.Yes_No, self._clearPath, nil, nil, self, nil, nil)
	end
end

function RoomTransportPathView:_onEscape()
	self:_btnsaveOnClick()
end

function RoomTransportPathView:_editableInitView()
	self._gopathlinegroup = gohelper.findChild(self.viewGO, "#go_transportgroup/go_pathlinegroup")
	self._godragmapTrs = self._godragmap.transform
	self._dragMap = SLFramework.UGUI.UIDragListener.Get(self._godragmap)
	self._isRemoveBuilding = RoomMapTransportPathModel.instance:getIsRemoveBuilding()
	self._screenScaleX = 0
	self._screenScaleY = 0
	self._waitingBlockIdList = {}
	self._unUseBuilingUidList = {}

	self:_setIsRemoveBuiling(self._isRemoveBuilding)
	self:_setIsRemoveLand(true)
end

function RoomTransportPathView:onUpdateParam()
	return
end

function RoomTransportPathView:onOpen()
	self.addEventCb(self, RoomMapController.instance, RoomEvent.TransportPathLineChanged, self._refreshLineLinkUI, self)

	if self.viewContainer then
		self.addEventCb(self, self.viewContainer, RoomEvent.TransportPathDeleteLineItem, self._onDeleteLineItem, self)
		self.addEventCb(self, self.viewContainer, RoomEvent.TransportPathSelectLineItem, self._onSelectLineItem, self)
	end

	if self._dragMap then
		self._dragMap:AddDragListener(self._onDragIng, self)
		self._dragMap:AddDragBeginListener(self._onDragBegin, self)
		self._dragMap:AddDragEndListener(self._onDragEnd, self)
	end

	NavigateMgr.instance:addEscape(self.viewName, self._onEscape, self)
	RoomMapTransportPathModel.instance:setSelectBuildingType(nil)
	self:refreshUI()
	RoomStatController.instance:roomRoadEditView()
	RoomMapController.instance:dispatchEvent(RoomEvent.TransportPathViewShowChanged)

	if self._dataList and #self._dataList > 0 then
		local selectData

		for i = 1, #self._dataList do
			local lineDataMO = self._dataList[i]
			local pathMO = RoomMapTransportPathModel.instance:getTransportPathMOBy2Type(lineDataMO.fromType, lineDataMO.toType)

			if not pathMO then
				selectData = lineDataMO

				break
			end
		end

		self:_onSelectLineItem(selectData or self._dataList[1])
	end
end

function RoomTransportPathView:onClose()
	if self._dragMap then
		self._dragMap:RemoveDragBeginListener()
		self._dragMap:RemoveDragListener()
		self._dragMap:RemoveDragEndListener()
	end

	self:_clearPath()
	RoomMapTransportPathModel.instance:setSelectBuildingType(nil)
	RoomMapController.instance:dispatchEvent(RoomEvent.TransportPathViewShowChanged)
end

function RoomTransportPathView:_setIsRemoveBuiling(isRemove)
	self._isRemoveBuilding = isRemove

	RoomMapTransportPathModel.instance:setIsRemoveBuilding(isRemove)
	gohelper.setActive(self._goselectRemove, self._isRemoveBuilding)
	RoomMapController.instance:dispatchEvent(RoomEvent.TransportPathConfirmChange)
end

function RoomTransportPathView:_setIsRemoveLand(isRemove)
	self._isRemoveLand = isRemove

	gohelper.setActive(self._goselectRemoveLand, self._isRemoveLand)
end

function RoomTransportPathView:_getBlockCleanType()
	if self._isRemoveLand then
		return RoomBlockEnum.CleanType.CleanLand
	end

	return RoomBlockEnum.CleanType.Normal
end

function RoomTransportPathView:onDestroyView()
	return
end

function RoomTransportPathView:_onDragBegin(param, pointerEventData)
	self._isStarDragPath = false
	self._canTouchDrag = true
	self._isChangeSiteHexPoint = false
	self._changeSiteBuildingType = nil
	self._startDragSiteHexPoint = nil
	self._canDelectfinishPathMOList = nil
	self._pathMO = nil
	self._lastMousePosition = pointerEventData.position
	self._screenScaleX = 1920 / UnityEngine.Screen.width
	self._screenScaleY = 1080 / UnityEngine.Screen.height

	if not self._lineDataMO then
		return
	end

	local blockMO = self:_findeBlockMO(self._lastMousePosition)

	if not blockMO then
		return
	end

	if not RoomTransportHelper.canPathByBlockMO(blockMO, self._isRemoveBuilding) then
		return
	end

	local pathMO = RoomMapTransportPathModel.instance:getTempTransportPathMO() or RoomMapTransportPathModel.instance:addTempTransportPathMO(blockMO.hexPoint, self._lineDataMO.fromType, self._lineDataMO.toType)

	if not pathMO then
		return
	end

	if blockMO.hexPoint == pathMO:getLastHexPoint() then
		self._isStarDragPath = true
		self._canTouchDrag = false
	elseif blockMO.hexPoint == pathMO:getFirstHexPoint() then
		pathMO:changeBenEnd()

		self._isStarDragPath = true
		self._canTouchDrag = false
	end

	if not self._isStarDragPath then
		return
	end

	pathMO.blockCleanType = self:_getBlockCleanType()

	if pathMO:isLinkFinish() then
		if not pathMO:checkSameType(self._lineDataMO.fromType, self._lineDataMO.toType) then
			return
		end

		self._isChangeSiteHexPoint = true
		self._changeSiteBuildingType = pathMO.toType

		local finishMOList = RoomMapTransportPathModel.instance:getTransportPathMOListByHexPoint(blockMO.hexPoint, true)

		if finishMOList and #finishMOList > 1 then
			tabletool.removeValue(finishMOList, pathMO)

			self._canDelectfinishPathMOList = finishMOList
			self._startDragSiteHexPoint = blockMO.hexPoint
		end
	end

	self._pathMO = pathMO

	RoomMapTransportPathModel.instance:setOpParam(self._isStarDragPath, self._changeSiteBuildingType)
	pathMO:checkTempTypes(self._lineDataMO.typeList)

	if pathMO:getHexPointCount() == 1 then
		pathMO.fromType = self:_getTempSiteTypeByHexPoint(self._pathMO:getLastHexPoint(), (self._lineDataMO or nil) and self._lineDataMO.typeList)
		pathMO.toType = 0
	end

	if pathMO:checkHexPoint(blockMO.hexPoint) and blockMO:getUseState() ~= RoomBlockEnum.UseState.TransportPath then
		blockMO:setUseState(RoomBlockEnum.UseState.TransportPath)
		blockMO:setCleanType(self._pathMO.blockCleanType)
		self:_addRefreshBlockId(blockMO.blockId)
	end
end

function RoomTransportPathView:_onDragIng(param, pointerEventData)
	if self._isStarDragPath then
		self:_addPathByScreenPos(pointerEventData.position)
	else
		self:_touchDrag(pointerEventData.position)
	end
end

function RoomTransportPathView:_onDragEnd(param, pointerEventData)
	local isDragPath = self._isStarDragPath

	self._canTouchDrag = false
	self._isStarDragPath = false

	RoomMapTransportPathModel.instance:setOpParam(false, nil)

	if isDragPath then
		local pathMO = self._pathMO

		self:_dragPathFinishByPathMO(pathMO)
	end
end

function RoomTransportPathView:_touchDrag(currentPosition)
	if self._canTouchDrag then
		local deltaPosition = currentPosition - self._lastMousePosition

		self._lastMousePosition = currentPosition

		RoomMapController.instance:dispatchEvent(RoomEvent.TouchDrag, Vector2(deltaPosition.x * self._screenScaleX, deltaPosition.y * self._screenScaleY))
	end
end

function RoomTransportPathView:_findeBlockMO(screenPos)
	local worldPos = RoomBendingHelper.screenToWorld(screenPos)

	if worldPos then
		local hexX, hexY = HexMath.posXYToRoundHexYX(worldPos.x, worldPos.y, RoomBlockEnum.BlockSize)
		local blockMO = RoomMapBlockModel.instance:getBlockMO(hexX, hexY)

		if blockMO and blockMO:isInMapBlock() then
			return blockMO
		end
	end
end

function RoomTransportPathView:_addPathByScreenPos(screenPos)
	local blockMO = self:_findeBlockMO(screenPos)

	if not blockMO or not blockMO:isInMapBlock() then
		return
	end

	local hexPoint = blockMO.hexPoint
	local isCheck, index = self._pathMO:checkHexPoint(hexPoint)
	local isCorssTost = false

	if isCheck then
		if index >= 1 and index + 1 == self._pathMO:getHexPointCount() then
			local lastHexPoint = self._pathMO:getLastHexPoint()
			local lastBlockMO = RoomMapBlockModel.instance:getBlockMO(lastHexPoint.x, lastHexPoint.y)

			if lastBlockMO and lastBlockMO:isInMapBlock() then
				self._pathMO:removeLastHexPoint()
				self._pathMO:setIsEdit(true)
				self._pathMO:setIsQuickLink(false)
				self:_changeSiteHexPoint(self._pathMO:getLastHexPoint())
				self._pathMO:checkTempTypes(self._lineDataMO.typeList)

				local siteType = RoomMapTransportPathModel.instance:getSiteTypeByHexPoint(lastHexPoint)

				if not siteType or siteType == 0 then
					lastBlockMO:setUseState(nil)
					lastBlockMO:setCleanType(nil)
				end

				self:_addRefreshBlockId(lastBlockMO.id)
			end
		else
			isCorssTost = true
		end
	elseif HexPoint.Distance(self._pathMO:getLastHexPoint(), hexPoint) == 1 then
		local isAdd, tIsCorss = self:_canPathByBlockMO(blockMO)

		if tIsCorss then
			isCorssTost = true
		end

		if isAdd and self._pathMO:addHexPoint(hexPoint) then
			blockMO:setUseState(RoomBlockEnum.UseState.TransportPath)
			blockMO:setCleanType(self._pathMO.blockCleanType)
			self._pathMO:setIsEdit(true)
			self._pathMO:setIsQuickLink(false)
			self:_changeSiteHexPoint(hexPoint)
			self._pathMO:checkTempTypes(self._lineDataMO.typeList)
			self:_addRefreshBlockId(blockMO.id)
			self:_unUseBuildingByHexXy(hexPoint.x, hexPoint.y)
			AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_luxian)
		end
	end

	if isCorssTost and self._isLastCrossBlockId ~= blockMO.id and self._pathMO:getHexPointCount() > 0 and HexPoint.Distance(self._pathMO:getLastHexPoint(), hexPoint) == 1 then
		self._isLastCrossBlockId = blockMO.id

		GameFacade.showToast(ToastEnum.RoomTransportPathCross)
	end
end

function RoomTransportPathView:_canPathByBlockMO(blockMO)
	local pathMO = self:_findLinkFinishPathMO(blockMO.hexPoint)

	if pathMO and pathMO:getLastHexPoint() ~= blockMO.hexPoint and pathMO:getFirstHexPoint() ~= blockMO.hexPoint then
		return false, true
	end

	if not self._isChangeSiteHexPoint then
		if self._pathMO:getHexPointCount() > 1 then
			local siteType = RoomMapTransportPathModel.instance:getSiteTypeByHexPoint(self._pathMO:getLastHexPoint())

			if siteType and siteType ~= 0 and self._lineDataMO and (self._lineDataMO.fromType == siteType or self._lineDataMO.toType == siteType) then
				return false, true
			end
		end

		local siteType = RoomMapTransportPathModel.instance:getSiteTypeByHexPoint(blockMO.hexPoint)

		if siteType and siteType ~= 0 then
			if self._lineDataMO and (self._lineDataMO.fromType == siteType or self._lineDataMO.toType == siteType) then
				return true
			end

			return false, true
		end

		if self:_findLinkFinishPathMO(blockMO.hexPoint) then
			return false, true
		end
	else
		local siteType = RoomMapTransportPathModel.instance:getSiteTypeByHexPoint(blockMO.hexPoint)

		if siteType and siteType ~= 0 and siteType ~= self._changeSiteBuildingType then
			return false, true
		end
	end

	return RoomTransportHelper.canPathByBlockMO(blockMO, self._isRemoveBuilding)
end

function RoomTransportPathView:_findLinkFinishPathMO(hexPoint)
	local transportPathMOList = RoomMapTransportPathModel.instance:getTransportPathMOList()
	local canDelectMOList = self._canDelectfinishPathMOList

	for i, trPathMO in ipairs(transportPathMOList) do
		if trPathMO:isLinkFinish() and trPathMO:checkHexPoint(hexPoint) and (not canDelectMOList or not tabletool.indexOf(canDelectMOList, trPathMO)) then
			return trPathMO
		end
	end
end

function RoomTransportPathView:_changeSiteHexPoint(hexPoint)
	if self._isChangeSiteHexPoint and self._changeSiteBuildingType then
		local siteHexPoint

		RoomMapTransportPathModel.instance:setSiteHexPointByType(self._changeSiteBuildingType, (RoomTransportHelper.canSiteByHexPoint(hexPoint, self._changeSiteBuildingType) or nil) and hexPoint)
		self:_changeAllPathLineSite()
	elseif self._pathMO then
		self._pathMO.toType = self:_getTempSiteTypeByHexPoint(self._pathMO:getLastHexPoint(), self._lineDataMO and self._lineDataMO.typeList)
	end
end

function RoomTransportPathView:_dragPathFinishByPathMO(pathMO)
	if pathMO:getHexPointCount() == 1 then
		pathMO:clear()
		RoomMapTransportPathModel.instance:updateSiteHexPoint()
		RoomTransportController.instance:waitRefreshPathLineChanged()
		RoomMapTransportPathModel.instance:placeTempTransportPathMO()
	elseif pathMO:isLinkFinish() then
		RoomMapTransportPathModel.instance:placeTempTransportPathMO()
		RoomMapTransportPathModel.instance:setSiteHexPointByType(pathMO.fromType, pathMO:getFirstHexPoint())
		RoomMapTransportPathModel.instance:setSiteHexPointByType(pathMO.toType, pathMO:getLastHexPoint())
	end

	self:_changeAllPathLineSite()
	self:_clearLinkFailPathMO()
end

function RoomTransportPathView:_clearLinkFailPathMO()
	local transportPathMOList = RoomMapTransportPathModel.instance:getTransportPathMOList()
	local tempPathMO = RoomMapTransportPathModel.instance:getTempTransportPathMO()
	local isFlag = false

	for i, trPathMO in ipairs(transportPathMOList) do
		if not trPathMO:isLinkFinish() and trPathMO ~= tempPathMO then
			trPathMO:clear()

			isFlag = true
		end
	end

	if isFlag then
		RoomMapTransportPathModel.instance:updateSiteHexPoint()
		RoomTransportController.instance:updateBlockUseState()
	end
end

function RoomTransportPathView:_changeAllPathLineSite()
	local tRoomMapTransportPathModel = RoomMapTransportPathModel.instance
	local transportPathMOList = tRoomMapTransportPathModel:getTransportPathMOList()

	for i, trPathMO in ipairs(transportPathMOList) do
		trPathMO.toType = tRoomMapTransportPathModel:getSiteTypeByHexPoint(trPathMO:getLastHexPoint())
		trPathMO.fromType = tRoomMapTransportPathModel:getSiteTypeByHexPoint(trPathMO:getFirstHexPoint())
	end

	if self._canDelectfinishPathMOList and self._pathMO then
		for _, trPathMO in ipairs(self._canDelectfinishPathMOList) do
			if trPathMO:isLinkFinish() and self:_isHasIntersection(trPathMO, self._pathMO) then
				trPathMO.toType = 0
				trPathMO.fromType = 0
			end
		end
	end
end

function RoomTransportPathView:_isHasIntersection(aPathMO, bPathMO)
	local aCount = aPathMO:getHexPointCount()
	local bCount = bPathMO:getHexPointCount()

	if aCount < 1 or bCount < 1 then
		return false
	end

	local hexPointList = aPathMO:getHexPointList()

	for i, hexPoint in ipairs(hexPointList) do
		local isIn, idx = bPathMO:checkHexPoint(hexPoint)

		if isIn and (i ~= 1 and idx ~= 1 and idx ~= bCount or i ~= aCount and idx ~= 1 and idx ~= bCount) then
			return true
		end
	end

	return false
end

function RoomTransportPathView:_getTempSiteTypeByHexPoint(hexPoint, typeList)
	if self._pathMO then
		local toType = RoomMapTransportPathModel.instance:getSiteTypeByHexPoint(hexPoint)

		if toType == 0 then
			toType = RoomTransportHelper.getBuildingTypeByHexPoint(hexPoint, typeList)
		end

		return toType
	end

	return 0
end

function RoomTransportPathView:_unUseBuildingByHexXy(hexX, hexY)
	local buildingParam = RoomMapBuildingModel.instance:getBuildingParam(hexX, hexY)
	local buildingUid = buildingParam and buildingParam.buildingUid

	if buildingParam and not tabletool.indexOf(self._unUseBuilingUidList, buildingUid) then
		local buildingMO = RoomMapBuildingModel.instance:getBuildingMOById(buildingUid)
		local buildingCfg = buildingMO and buildingMO.config

		if buildingCfg and RoomBuildingEnum.CanDateleBuildingType[buildingCfg.buildingType] then
			table.insert(self._unUseBuilingUidList, buildingUid)
			RoomMapController.instance:unUseBuildingRequest(buildingUid)
			GameFacade.showToast(ToastEnum.RoomTransportRemoveBuilding, buildingCfg.name)
		end
	end
end

function RoomTransportPathView:_checkCanBlockMO(blockMO)
	if not blockMO or blockMO.packageId == RoomBlockPackageEnum.ID.RoleBirthday then
		return false
	end

	local hexPoint = blockMO.hexPoint
	local buildingMO = RoomMapBuildingModel.instance:getBuildingParam(hexPoint.x, hexPoint.y)

	if buildingMO then
		if buildingMO:isAreaMainBuilding() then
			return false
		end

		if self._isRemoveBuilding ~= true then
			return false
		end
	end
end

function RoomTransportPathView:_onDeleteLineItem(dataMO)
	return
end

function RoomTransportPathView:_onSelectLineItem(lineDataMO)
	if self._canTouchDrag or self._isStarDragPath then
		return
	end

	local oldMO = self._lineDataMO

	self._lineDataMO = lineDataMO

	RoomMapTransportPathModel.instance:setSelectBuildingType(lineDataMO and lineDataMO.fromType)

	if not oldMO or lineDataMO and lineDataMO.fromType ~= oldMO.fromType then
		RoomMapTransportPathModel.instance:placeTempTransportPathMO()
		self:_clearLinkFailPathMO()
	end

	self:_refreshLineLinkUI()
	RoomMapController.instance:dispatchEvent(RoomEvent.TransportPathViewShowChanged)
	self:_initSelectLineRemoveLand()
	self:_updateAllPathBlockState()
end

function RoomTransportPathView:_initSelectLineRemoveLand()
	if self._lineDataMO then
		local selectPathO = RoomMapTransportPathModel.instance:getTransportPathMOBy2Type(self._lineDataMO.fromType, self._lineDataMO.toType)

		if selectPathO then
			self:_setIsRemoveLand(selectPathO.blockCleanType == RoomBlockEnum.CleanType.CleanLand)
		end
	end
end

function RoomTransportPathView:refreshUI()
	self._dataList = self:getLineDataList()
	self._lineItemCompList = {}

	local parent_obj = self._gopathlinegroup
	local model_obj = self._gotypeitem

	gohelper.CreateObjList(self, self._lineItemShow, self._dataList, parent_obj, model_obj, RoomTransportLineItem)
end

function RoomTransportPathView:_refreshLineLinkUI()
	local hasSelect = false

	if self._lineItemCompList then
		for _, lineItem in ipairs(self._lineItemCompList) do
			lineItem:refreshLinkUI()

			local dataMO = lineItem:getDataMO()

			if self._lineDataMO and dataMO and self._lineDataMO.buildingType == dataMO.buildingType then
				hasSelect = true

				lineItem:onSelect(true)
			else
				lineItem:onSelect(false)
			end
		end
	end

	if not hasSelect then
		self._lineDataMO = nil

		RoomMapTransportPathModel.instance:setSelectBuildingType(nil)
	end
end

function RoomTransportPathView:getLineDataList()
	local typesList = RoomTransportHelper.getPathBuildingTypesList()
	local dataList = {}
	local tRoomMapBuildingAreaModel = RoomMapBuildingAreaModel.instance

	for _, types in ipairs(typesList) do
		local fType = types[1]
		local tType = types[2]

		if tRoomMapBuildingAreaModel:getAreaMOByBType(fType) and tRoomMapBuildingAreaModel:getAreaMOByBType(tType) then
			local typeList = {}
			local data = {
				buildingType = fType,
				fromType = fType,
				toType = tType,
				typeList = typeList
			}

			tabletool.addValues(typeList, types)
			table.insert(dataList, data)
		end
	end

	return dataList
end

function RoomTransportPathView:_lineItemShow(cell_component, data, index)
	cell_component:onUpdateMO(data)

	cell_component._view = cell_component._view or self

	table.insert(self._lineItemCompList, cell_component)
end

function RoomTransportPathView:_clearPath()
	RoomMapTransportPathModel.instance:placeTempTransportPathMO()

	if RoomMapTransportPathModel.instance:isHasEdit() then
		RoomMapTransportPathModel.instance:resetByTransportPathMOList(RoomTransportPathModel.instance:getList())
		RoomMapTransportPathModel.instance:updateSiteHexPoint()
		RoomTransportController.instance:updateBlockUseState()
		self:_initSelectLineRemoveLand()
	end
end

function RoomTransportPathView:_updateAllPathBlockState()
	local blockCleanType = self:_getBlockCleanType()
	local isNeedUpdate = false
	local pathMO = RoomMapTransportPathModel.instance:getTempTransportPathMO()

	if pathMO and pathMO:getHexPointCount() > 0 and pathMO.blockCleanType ~= blockCleanType then
		pathMO.blockCleanType = blockCleanType
		isNeedUpdate = true
	end

	if self._lineDataMO then
		local selectPathO = RoomMapTransportPathModel.instance:getTransportPathMOBy2Type(self._lineDataMO.fromType, self._lineDataMO.toType)

		if selectPathO and selectPathO:getHexPointCount() > 0 and selectPathO.blockCleanType ~= blockCleanType then
			selectPathO.blockCleanType = blockCleanType
			isNeedUpdate = true

			selectPathO:setIsEdit(true)
		end
	end

	if isNeedUpdate then
		RoomTransportController.instance:updateBlockUseState()
	end
end

function RoomTransportPathView:_addRefreshBlockId(blockId)
	RoomTransportController.instance:waitRefreshBlockById(blockId)
	RoomTransportController.instance:waitRefreshPathLineChanged()
end

return RoomTransportPathView
