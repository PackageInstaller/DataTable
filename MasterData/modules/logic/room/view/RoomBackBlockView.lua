-- chunkname: @modules/logic/room/view/RoomBackBlockView.lua

module("modules.logic.room.view.RoomBackBlockView", package.seeall)

local RoomBackBlockView = class("RoomBackBlockView", BaseView)

function RoomBackBlockView:onInitView()
	self._goviewcontent = gohelper.findChild(self.viewGO, "#go_viewContent")
	self._gobackOne = gohelper.findChild(self.viewGO, "#go_viewContent/#go_backOne")
	self._btnback = gohelper.findChildButtonWithAudio(self.viewGO, "#go_viewContent/#go_backOne/#btn_back")
	self._gobackState = gohelper.findChild(self.viewGO, "#go_viewContent/#go_backOne/#btn_back/#go_backState")
	self._gonotbackState = gohelper.findChild(self.viewGO, "#go_viewContent/#go_backOne/#btn_back/#go_notbackState")
	self._gobackMore = gohelper.findChild(self.viewGO, "#go_viewContent/#go_backMore")
	self._btnmoreConfirm = gohelper.findChildButtonWithAudio(self.viewGO, "#go_viewContent/#go_backMore/#btn_moreConfirm")
	self._btnmoreCancel = gohelper.findChildButtonWithAudio(self.viewGO, "#go_viewContent/#go_backMore/#btn_moreCancel")
	self._gonoSelect = gohelper.findChild(self.viewGO, "#go_viewContent/#go_backMore/#go_noSelect")
	self._gonumber = gohelper.findChild(self.viewGO, "#go_viewContent/#go_number")
	self._gonumberItem = gohelper.findChild(self.viewGO, "#go_viewContent/#go_number/#go_numberItem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomBackBlockView:addEvents()
	self._btnback:AddClickListener(self._btnbackOnClick, self)
	self._btnmoreConfirm:AddClickListener(self._btnmoreConfirmOnClick, self)
	self._btnmoreCancel:AddClickListener(self._btnmoreCancelOnClick, self)
end

function RoomBackBlockView:removeEvents()
	self._btnback:RemoveClickListener()
	self._btnmoreConfirm:RemoveClickListener()
	self._btnmoreCancel:RemoveClickListener()
end

function RoomBackBlockView:_btnmoreConfirmOnClick()
	local backBlockModel = RoomMapBlockModel.instance:getBackBlockModel()
	local count = backBlockModel:getCount()

	if count < 1 then
		GameFacade.showToast(RoomEnum.Toast.InventoryConfirmNoBackBlock)

		return
	end

	if not RoomMapBlockModel.instance:isCanBackBlock() then
		GameFacade.showToast(RoomEnum.Toast.InventoryBlockMoreUnBack)

		return
	end

	local hasBuilding, boxId = self:_isHasBuilding()

	boxId = boxId or MessageBoxIdDefine.RoomInventoryBlockMoreBack

	GameFacade.showMessageBox(boxId, MsgBoxEnum.BoxType.Yes_No, function()
		self:_sendRequest()
	end)
end

function RoomBackBlockView:_isHasBuilding()
	local backBlockModel = RoomMapBlockModel.instance:getBackBlockModel()
	local list = backBlockModel:getList()
	local tRoomMapBuildingModel = RoomMapBuildingModel.instance
	local hasBuilding = false
	local hasTransportPath = false

	for i = 1, #list do
		local hexPoint = list[i].hexPoint
		local param = hexPoint and tRoomMapBuildingModel:getBuildingParam(hexPoint.x, hexPoint.y)

		if param then
			hasBuilding = true

			if tRoomMapBuildingModel:isHasCritterByBuid(param.buildingUid) then
				return true, MessageBoxIdDefine.RoomBackBlockCritterBuilding
			end
		end

		if not hasTransportPath and RoomTransportHelper.checkInLoadHexXY(hexPoint.x, hexPoint.y) then
			hasTransportPath = true
		end
	end

	if hasTransportPath then
		return true, MessageBoxIdDefine.RoomBackBlockHasTransportPath
	end

	if hasBuilding then
		return true, MessageBoxIdDefine.RoomInventoryBlockBuildingBack
	end

	return false
end

function RoomBackBlockView:_btnmoreCancelOnClick()
	self:cancelBack()
end

function RoomBackBlockView:cancelBack()
	RoomMapController.instance:switchBackBlock(false)
end

function RoomBackBlockView:_btnbackOnClick()
	local backBlockModel = RoomMapBlockModel.instance:getBackBlockModel()

	if backBlockModel:getCount() < 1 then
		return
	end

	if not RoomMapBlockModel.instance:isCanBackBlock() then
		GameFacade.showToast((RoomBackBlockHelper.isHasInitBlock(backBlockModel:getList()) or nil) and (RoomEnum.Toast.InventoryCannotBackInitBlock or RoomEnum.Toast.InventoryBlockUnBack))

		return
	end

	local hasBuilding, boxId = self:_isHasBuilding()

	if hasBuilding then
		GameFacade.showMessageBox(boxId, MsgBoxEnum.BoxType.Yes_No, function()
			self:_sendRequest()
		end)
	else
		self:_sendRequest()
	end
end

function RoomBackBlockView:_editableInitView()
	self._animator = ZProj.ProjAnimatorPlayer.Get(self.viewGO)
	self._gonumberTrs = self._gonumber.transform
	self._gobackOneTrs = self._gobackOne.transform
	self._btnbackTrs = self._btnback.transform
	self._gobackOneTrs = self._gobackOne.transform
	self._btnmoreConfirmGO = self._btnmoreConfirm.gameObject
	self._scene = GameSceneMgr.instance:getCurScene()
	self._isOneCanBack = true
	self._blockNumberItemList = {}
	self._confirmCanvasGroup = self._gobackOne:GetComponent(typeof(UnityEngine.CanvasGroup))

	table.insert(self._blockNumberItemList, MonoHelper.addNoUpdateLuaComOnceToGo(self._gonumberItem, RoomBackBlockNumberItem, self))
	gohelper.setActive(self._gonumberItem, false)
end

function RoomBackBlockView:_sendRequest()
	local backBlockModel = RoomMapBlockModel.instance:getBackBlockModel()

	if backBlockModel:getCount() < 1 then
		return
	end

	local blockList = backBlockModel:getList()
	local blockIdList = {}

	for i = 1, #blockList do
		table.insert(blockIdList, blockList[i].id)
	end

	RoomMapController.instance:unUseBlockListRequest(blockIdList)
end

function RoomBackBlockView:_sceneEvent(eventName, param)
	self._scene.fsm:triggerEvent(eventName, param or {})
end

function RoomBackBlockView:onUpdateParam()
	return
end

function RoomBackBlockView:onOpen()
	self.addEventCb(self, RoomMapController.instance, RoomEvent.CameraTransformUpdate, self._cameraTransformUpdate, self)
	self.addEventCb(self, RoomMapController.instance, RoomEvent.ClientTryBackBlock, self._onTryBackBlock, self)
	self.addEventCb(self, RoomMapController.instance, RoomEvent.ClientCancelBackBlock, self._onBackBlockEventHandler, self)
	self.addEventCb(self, RoomMapController.instance, RoomEvent.ConfirmBackBlock, self._onBackBlockEventHandler, self)
	self.addEventCb(self, RoomBuildingController.instance, RoomEvent.BuildingListShowChanged, self._onBuildViewShowChanged, self)
	self.addEventCb(self, RoomMapController.instance, RoomEvent.BackBlockShowChanged, self._backBlockShowChanged, self)
	self:_refreshUI()
end

function RoomBackBlockView:onClose()
	return
end

function RoomBackBlockView:_backBlockShowChanged()
	if not RoomMapBlockModel.instance:isBackMore() then
		self._isOneCanBack = RoomMapBlockModel.instance:isCanBackBlock()
	end

	local isMore = RoomMapBlockModel.instance:isBackMore()

	if isMore or self._isLastPlayAnimClose then
		self._isLastPlayAnimClose = false

		self._animator:Play(UIAnimationName.Open)
		self:_refreshUI()
		TaskDispatcher.cancelTask(self._refreshUI, self)
	elseif not isMore and not self._isLastPlayAnimClose then
		self._isLastPlayAnimClose = true

		self._animator:Play(UIAnimationName.Close)
		TaskDispatcher.runDelay(self._refreshUI, self, 0.3)
	end
end

function RoomBackBlockView:_onTryBackBlock()
	if not RoomMapBlockModel.instance:isBackMore() then
		self._isOneCanBack = RoomMapBlockModel.instance:isCanBackBlock()
	end

	self:_refreshUI()
end

function RoomBackBlockView:_onBuildViewShowChanged(isShow)
	gohelper.setActive(self._goviewcontent, not isShow)
end

function RoomBackBlockView:_onBackBlockEventHandler()
	self:_refreshUI()
end

function RoomBackBlockView:_cameraTransformUpdate()
	self:_refreshUI()
end

function RoomBackBlockView:_getBackBlockModel()
	return RoomMapBlockModel.instance:getBackBlockModel()
end

function RoomBackBlockView:_refreshUI()
	local backBlockModel = self:_getBackBlockModel()
	local backblockCount = backBlockModel:getCount()
	local isMore = RoomMapBlockModel.instance:isBackMore()

	gohelper.setActive(self._gobackMore, isMore == true)
	gohelper.setActive(self._btnmoreConfirmGO, backblockCount > 0)
	gohelper.setActive(self._gonoSelect, backblockCount <= 0)

	if backblockCount < 1 then
		gohelper.setActive(self._gobackOne, false)
		gohelper.setActive(self._gonumber, false)

		return
	end

	gohelper.setActive(self._gobackOne, isMore == false)
	gohelper.setActive(self._gonumber, isMore == true)

	if isMore == false then
		local tempBlockMO = backBlockModel:getByIndex(1)

		if tempBlockMO then
			::label_23_0::

			local entity = self._scene.mapmgr:getBlockEntity(tempBlockMO.id, SceneTag.RoomMapBlock)

			if entity then
				local worldPos = Vector3(transformhelper.getPos(entity.goTrs))

				self:_setUIPos(worldPos, self._btnbackTrs, self._gobackOneTrs, nil, true)
				gohelper.setActive(self._gobackState, self._isOneCanBack == true)
				gohelper.setActive(self._gonotbackState, self._isOneCanBack == false)
			end
		end
	end

	self:_refreshItemUI()
	self:_refreshItemUIPos()
end

function RoomBackBlockView:_refreshItemUI()
	local backBlockModel = RoomMapBlockModel.instance:getBackBlockModel()
	local blockBlockList = backBlockModel:getList()

	for i = 1, #blockBlockList do
		local numberItem = self._blockNumberItemList[i]

		if not numberItem then
			local cloneGo = gohelper.clone(self._gonumberItem, self._gonumber, "numberitem" .. i)

			numberItem = MonoHelper.addNoUpdateLuaComOnceToGo(cloneGo, RoomBackBlockNumberItem, self)

			table.insert(self._blockNumberItemList, numberItem)
		end

		numberItem:setNumber(i)
		numberItem:setBlockMO(blockBlockList[i])
	end

	for i = #blockBlockList + 1, #self._blockNumberItemList do
		local numberItem = self._blockNumberItemList[i]

		numberItem:setBlockMO(nil)
	end
end

function RoomBackBlockView:_refreshItemUIPos()
	for i = 1, #self._blockNumberItemList do
		local numberItem = self._blockNumberItemList[i]
		local blockMO = numberItem:getBlockMO()

		if blockMO then
			::label_25_0::

			local entity = self._scene.mapmgr:getBlockEntity(blockMO.id, SceneTag.RoomMapBlock)

			if entity then
				local worldPos = Vector3(transformhelper.getPos(entity.goTrs))

				self:_setUIPos(worldPos, numberItem:getGOTrs(), self._gonumberTrs)
			end
		end
	end
end

function RoomBackBlockView:_setUIPos(worldPos, targetUIGOTrs, parentUIGOTrs, offsetY, isUpdateAlpha, isBottom)
	local bendingPos = RoomBendingHelper.worldToBendingSimple(worldPos)
	local focusPos = self._scene.camera:getCameraFocus()
	local focusDistance = Vector2.Distance(focusPos, Vector2(worldPos.x, worldPos.z))

	if isUpdateAlpha then
		local curAlpha = 1

		curAlpha = focusDistance <= 2.5 and 1 or focusDistance >= 3.5 and 0 or 3.5 - focusDistance

		if self._lastAlpha == nil or math.abs(self._lastAlpha - curAlpha) >= 0.02 then
			self._lastAlpha = curAlpha
			self._confirmCanvasGroup.alpha = curAlpha
			self._confirmCanvasGroup.blocksRaycasts = curAlpha > 0.25
		end
	end

	local scale = 1

	transformhelper.setLocalScale(targetUIGOTrs, scale, scale, scale)

	local rotate = self._scene.camera:getCameraRotate()
	local bendingPosX = bendingPos.x
	local bendingPosZ = bendingPos.z

	offsetY = offsetY or 0.12

	if isBottom then
		bendingPosX = bendingPos.x - (0.9 - scale * 0.5) * Mathf.Sin(rotate)
		bendingPosZ = bendingPos.z - (0.9 - scale * 0.5) * Mathf.Cos(rotate)
	end

	local worldPos = Vector3(bendingPosX, bendingPos.y + offsetY, bendingPosZ)
	local localPos = recthelper.worldPosToAnchorPos(worldPos, parentUIGOTrs)

	recthelper.setAnchor(targetUIGOTrs, localPos.x, localPos.y)
end

function RoomBackBlockView:onDestroyView()
	TaskDispatcher.cancelTask(self._refreshUI, self)
end

return RoomBackBlockView
