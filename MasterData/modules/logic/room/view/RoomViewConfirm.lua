-- chunkname: @modules/logic/room/view/RoomViewConfirm.lua

module("modules.logic.room.view.RoomViewConfirm", package.seeall)

local RoomViewConfirm = class("RoomViewConfirm", BaseView)

function RoomViewConfirm:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomViewConfirm:addEvents()
	return
end

function RoomViewConfirm:removeEvents()
	return
end

function RoomViewConfirm:_editableInitView()
	self._goconfirm = gohelper.findChild(self.viewGO, "go_confirm")
	self._gocontainer = gohelper.findChild(self.viewGO, "go_confirm/go_container")
	self._btnconfirm = gohelper.findChildButtonWithAudio(self.viewGO, "go_confirm/go_container/btn_confirm")
	self._btncancel = gohelper.findChildButtonWithAudio(self.viewGO, "go_confirm/go_container/btn_cancel")

	self._btnconfirm:AddClickListener(self._btnconfirmOnClick, self)
	self._btncancel:AddClickListener(self._btncancelOnClick, self)

	self._btncancelcharacter = gohelper.findChildButtonWithAudio(self.viewGO, "go_confirm/go_container/btn_cancelcharacter")

	self._btncancelcharacter:AddClickListener(self._btncancelOnClick, self)

	self._gocancelpos = gohelper.findChild(self.viewGO, "go_confirm/go_container/go_cancelpos")
	self._goconfirmpos = gohelper.findChild(self.viewGO, "go_confirm/go_container/go_confirmpos")
	self._gocancelposcharacter = gohelper.findChild(self.viewGO, "go_confirm/go_container/go_cancelposcharacter")
	self._goconfirmposcharacter = gohelper.findChild(self.viewGO, "go_confirm/go_container/go_confirmposcharacter")

	local timeMatrix = {}

	for i = 1, 100 do
		table.insert(timeMatrix, 0.5)
	end

	self._gorotate = gohelper.findChild(self.viewGO, "go_confirm/go_container/go_rotate")
	self._rotateClick = SLFramework.UGUI.UIClickListener.Get(self._gorotate)

	self._rotateClick:AddClickListener(self._btnrotateOnClick, self)

	self._rotatePress = SLFramework.UGUI.UILongPressListener.Get(self._gorotate)

	self._rotatePress:SetLongPressTime(timeMatrix)

	self._confirmCanvasGroup = self._gocontainer:GetComponent(typeof(UnityEngine.CanvasGroup))
	self._scene = GameSceneMgr.instance:getCurScene()
	self._isCharacter = false
	self._allFocusItem = self:getUserDataTb_()
	self._allFocusItem[1] = self._btncancel.transform
	self._allFocusItem[2] = self._gorotate.transform
	self._allFocusItem[3] = self._btnconfirm.transform
	self._inputhandle = TaskDispatcher.runRepeat(self._handleMouseInput, self, 0.01)
end

function RoomViewConfirm:_handleMouseInput()
	if not PCInputController.instance:getIsUse() then
		return
	end

	local scrollWheel = UnityEngine.Input.mouseScrollDelta

	if scrollWheel and scrollWheel.y ~= 0 then
		self:_btnrotateOnClick()
	end

	if UnityEngine.Input.GetMouseButtonDown(1) then
		self:_btncancelOnClick()
	end

	if UnityEngine.Input.GetKeyUp("space") then
		self:_btnconfirmOnClick()
	end
end

function RoomViewConfirm:_btnconfirmOnClick()
	if RoomController.instance:isEditMode() then
		if RoomBuildingController.instance:isBuildingListShow() then
			self:_confirmBuilding()
		else
			self:_confirmBlock()
		end
	elseif RoomController.instance:isObMode() then
		if RoomHelper.isFSMState(RoomEnum.FSMObState.PlaceBuildingConfirm) then
			self:_confirmBuilding()
		elseif RoomHelper.isFSMState(RoomEnum.FSMObState.PlaceCharacterConfirm) then
			self:_confirmCharacter()
		end
	end
end

function RoomViewConfirm:_confirmBuilding()
	local tempBuildingMO = RoomMapBuildingModel.instance:getTempBuildingMO()

	if not tempBuildingMO then
		return
	end

	local id = tempBuildingMO.id
	local buildingId = tempBuildingMO.buildingId
	local rotate = tempBuildingMO.rotate
	local hexPoint = tempBuildingMO.hexPoint
	local canConfirmParam, errorCode = RoomBuildingHelper.canConfirmPlace(buildingId, hexPoint, rotate, nil, nil, false, tempBuildingMO.levels, true)

	if canConfirmParam then
		if tonumber(id) < 1 then
			local placeCfg = ManufactureConfig.instance:getManufactureBuildingCfg(buildingId)

			if placeCfg and placeCfg.placeNoCost == 1 then
				RoomBuildingController.instance:sendBuyManufactureBuildingRpc(buildingId)

				return
			end

			ViewMgr.instance:openView(ViewName.RoomManufacturePlaceCostView)

			return
		end

		local removeBuildingMOList = RoomBuildingAreaHelper.findTempOutBuildingMOList()

		if removeBuildingMOList and #removeBuildingMOList then
			local buildingsStr = RoomBuildingAreaHelper.formatBuildingMOListNameStr(removeBuildingMOList)

			GameFacade.showMessageBox(MessageBoxIdDefine.RoomChangeMainBuilding, MsgBoxEnum.BoxType.Yes_No, self._requestUseBuilding, nil, nil, self, nil, nil, buildingsStr)

			return
		end

		local removePathMOList = RoomBuildingAreaHelper.findTempOutTransportMOList()

		if removePathMOList and #removePathMOList then
			GameFacade.showMessageBox(MessageBoxIdDefine.RoomChangeMainBuildingTransportPath, MsgBoxEnum.BoxType.Yes_No, self._requestUseBuilding, nil, nil, self, nil, nil)

			return
		end

		RoomMapController.instance:useBuildingRequest(id, rotate, hexPoint.x, hexPoint.y)
	elseif errorCode == RoomBuildingEnum.ConfirmPlaceBuildingErrorCode.Foundation then
		GameFacade.showToast(ToastEnum.RoomErrorFoundation)
	elseif errorCode == RoomBuildingEnum.ConfirmPlaceBuildingErrorCode.ResourceId then
		GameFacade.showToast(ToastEnum.RoomErrorResourceId)
	elseif errorCode == RoomBuildingEnum.ConfirmPlaceBuildingErrorCode.ResourceArea then
		GameFacade.showToast(ToastEnum.RoomErrorResourceArea)
	elseif errorCode == RoomBuildingEnum.ConfirmPlaceBuildingErrorCode.NoAreaMainBuilding then
		GameFacade.showToast(ToastEnum.NoAreaMainBuilding)
	elseif errorCode == RoomBuildingEnum.ConfirmPlaceBuildingErrorCode.OutSizeAreaBuilding then
		GameFacade.showToast(ToastEnum.OutSizeAreaBuilding)
	elseif errorCode == RoomBuildingEnum.ConfirmPlaceBuildingErrorCode.InTransportPath then
		GameFacade.showToast(ToastEnum.RoomBuildingInTranspath)
	end
end

function RoomViewConfirm:_requestUnUseBuilding()
	local tempBuildingMO = RoomMapBuildingModel.instance:getTempBuildingMO()

	if tempBuildingMO then
		RoomMapController.instance:unUseBuildingRequest(tempBuildingMO.id)
	end
end

function RoomViewConfirm:_requestUseBuilding()
	local tempBuildingMO = RoomMapBuildingModel.instance:getTempBuildingMO()

	if tempBuildingMO then
		local hexPoint = tempBuildingMO.hexPoint

		RoomMapController.instance:useBuildingRequest(tempBuildingMO.id, tempBuildingMO.rotate, hexPoint.x, hexPoint.y)
	end
end

function RoomViewConfirm:_removeOutBuildingMOList(isUnUse)
	local removeBuildingMOList = RoomBuildingAreaHelper.findTempOutBuildingMOList(isUnUse)

	if removeBuildingMOList and #removeBuildingMOList > 0 then
		for _, buildingMO in ipairs(removeBuildingMOList) do
			RoomMapController.instance:unUseBuildingRequest(buildingMO.id)
		end
	end
end

function RoomViewConfirm:_confirmBlock()
	local tempBlockMO = RoomMapBlockModel.instance:getTempBlockMO()
	local inventoryBlockMO = RoomInventoryBlockModel.instance:getSelectInventoryBlockMO()

	if not tempBlockMO or not inventoryBlockMO then
		return
	end

	if RoomInventoryBlockModel.instance:isMaxNum() then
		GameFacade.showToast(RoomEnum.Toast.InventoryBlockMax)

		return
	end

	local id = inventoryBlockMO.id
	local rotate = inventoryBlockMO.rotate
	local hexPoint = tempBlockMO.hexPoint

	RoomMapController.instance:useBlockRequest(id, rotate, hexPoint.x, hexPoint.y)
end

function RoomViewConfirm:_confirmCharacter()
	local tempCharacterMO = RoomCharacterModel.instance:getTempCharacterMO()

	if not tempCharacterMO then
		return
	end

	local currentPosition = tempCharacterMO.currentPosition

	if RoomCharacterHelper.canConfirmPlace(tempCharacterMO.heroId, currentPosition, tempCharacterMO.skinId, true) then
		RoomMapController.instance:useCharacterRequest(tempCharacterMO.id)
	end
end

function RoomViewConfirm:_btnrotateOnClick()
	if RoomController.instance:isEditMode() then
		if RoomBuildingController.instance:isBuildingListShow() then
			self:_rotateBuilding()
		else
			self:_rotateBlock()
		end
	elseif RoomController.instance:isObMode() then
		if RoomHelper.isFSMState(RoomEnum.FSMObState.PlaceBuildingConfirm) then
			self:_rotateBuilding()
		elseif RoomHelper.isFSMState(RoomEnum.FSMObState.PlaceCharacterConfirm) then
			self:_rotateCharacter()
		end
	end
end

function RoomViewConfirm:_rotateBuilding()
	local tempBuildingMO = RoomMapBuildingModel.instance:getTempBuildingMO()

	if not tempBuildingMO then
		return
	end

	for i = 1, 5 do
		local rotate = RoomRotateHelper.rotateRotate(tempBuildingMO.rotate, i)
		local canTry = RoomBuildingHelper.canTryPlace(tempBuildingMO.buildingId, tempBuildingMO.hexPoint, rotate)

		if canTry then
			local param = {}

			param.rotate = rotate

			self._scene.fsm:triggerEvent(RoomSceneEvent.TryPlaceBuilding, param)

			return
		end
	end

	GameFacade.showToast(ToastEnum.RoomRotateBuilding)
end

function RoomViewConfirm:_rotateBlock()
	local tempBlockMO = RoomMapBlockModel.instance:getTempBlockMO()

	if not tempBlockMO then
		return
	end

	local param = {}

	param.rotate = RoomRotateHelper.rotateRotate(tempBlockMO.rotate, 1)

	self._scene.fsm:triggerEvent(RoomSceneEvent.TryPlaceBlock, param)
end

function RoomViewConfirm:_rotateCharacter()
	return
end

function RoomViewConfirm:_btncancelOnClick()
	if RoomController.instance:isEditMode() then
		if RoomBuildingController.instance:isBuildingListShow() then
			self:_cancelBuilding()
		else
			self:_cancelBlock()
		end
	elseif RoomController.instance:isObMode() then
		if RoomHelper.isFSMState(RoomEnum.FSMObState.PlaceBuildingConfirm) then
			self:_cancelBuilding()
		elseif RoomHelper.isFSMState(RoomEnum.FSMObState.PlaceCharacterConfirm) then
			self:_cancelCharacter()
		end
	end
end

function RoomViewConfirm:_cancelBuilding()
	local tempBuildingMO = RoomMapBuildingModel.instance:getTempBuildingMO()

	if not tempBuildingMO then
		return
	end

	if tempBuildingMO.buildingState == RoomBuildingEnum.BuildingState.Temp then
		self._scene.fsm:triggerEvent(RoomSceneEvent.CancelPlaceBuilding)
	elseif tempBuildingMO.buildingState == RoomBuildingEnum.BuildingState.Revert then
		if tempBuildingMO:isBuildingArea() then
			local removeBuildingMOList = RoomBuildingAreaHelper.findTempOutBuildingMOList()

			if removeBuildingMOList and #removeBuildingMOList then
				local buildingsStr = RoomBuildingAreaHelper.formatBuildingMOListNameStr(removeBuildingMOList)

				GameFacade.showMessageBox(MessageBoxIdDefine.RoomUnUseMainBuilding, MsgBoxEnum.BoxType.Yes_No, self._requestUnUseBuilding, nil, nil, self, nil, nil, buildingsStr)

				return
			end
		end

		local hasCritter = self:_checkBuildingHasCriter(tempBuildingMO)

		if hasCritter then
			GameFacade.showMessageBox(MessageBoxIdDefine.RoomUnUseManufactureBuilding, MsgBoxEnum.BoxType.Yes_No, self._requestUnUseBuilding, nil, nil, self, nil, nil)

			return
		end

		local removePathMOList = RoomBuildingAreaHelper.findTempOutTransportMOList()

		if removePathMOList and #removePathMOList then
			GameFacade.showMessageBox(MessageBoxIdDefine.RoomUnUseMainBuildingTransportPath, MsgBoxEnum.BoxType.Yes_No, self._requestUnUseBuilding, nil, nil, self, nil, nil)

			return
		end

		local id = tempBuildingMO.id

		RoomMapController.instance:unUseBuildingRequest(id)
	end
end

function RoomViewConfirm:_checkBuildingHasCriter(buildingMO)
	if buildingMO then
		if buildingMO.config then
			if RoomBuildingEnum.BuildingArea[buildingMO.config] then
				return true
			end
		end
	end

	return false
end

function RoomViewConfirm:_cancelBlock()
	self._scene.fsm:triggerEvent(RoomSceneEvent.CancelPlaceBlock)
end

function RoomViewConfirm:_cancelCharacter()
	local tempCharacterMO = RoomCharacterModel.instance:getTempCharacterMO()

	if not tempCharacterMO then
		return
	end

	if tempCharacterMO.characterState == RoomCharacterEnum.CharacterState.Temp then
		self._scene.fsm:triggerEvent(RoomSceneEvent.CancelPlaceCharacter)
	elseif tempCharacterMO.characterState == RoomCharacterEnum.CharacterState.Revert then
		RoomMapController.instance:unUseCharacterRequest(tempCharacterMO.id, nil, nil, true)
	end
end

function RoomViewConfirm:_refreshUI()
	if RoomController.instance:isEditMode() then
		if RoomBuildingController.instance:isBuildingListShow() then
			self:_refreshBuildingUI()
		else
			self:_refreshBlockUI()
		end

		self._isCharacter = false
	elseif RoomController.instance:isObMode() then
		if RoomHelper.isFSMState(RoomEnum.FSMObState.PlaceBuildingConfirm) then
			self:_refreshBuildingUI()

			self._isCharacter = false
		elseif RoomHelper.isFSMState(RoomEnum.FSMObState.PlaceCharacterConfirm) then
			self:_refreshCharacterUI()

			self._isCharacter = true
		else
			gohelper.setActive(self._gocontainer, false)
		end
	else
		gohelper.setActive(self._gocontainer, false)
	end
end

function RoomViewConfirm:_refreshBuildingUI()
	gohelper.setActive(self._btncancel.gameObject, true)
	gohelper.setActive(self._btncancelcharacter.gameObject, false)

	local isPlaceConfirm = RoomHelper.isFSMState(RoomEnum.FSMObState.PlaceBuildingConfirm) or RoomHelper.isFSMState(RoomEnum.FSMEditState.PlaceBuildingConfirm)

	isPlaceConfirm = isPlaceConfirm and self._dropOP ~= true

	gohelper.setActive(self._gocontainer, isPlaceConfirm)
	gohelper.setActive(self._gorotate, true)

	if isPlaceConfirm then
		local tempBuildingMO = RoomMapBuildingModel.instance:getTempBuildingMO()

		if tempBuildingMO then
			::label_23_0::

			local entity = self._scene.buildingmgr:getBuildingEntity(tempBuildingMO.id, SceneTag.RoomBuilding)

			if entity then
				local bodyGO = entity:getBodyGO() or entity.go
				local worldPos = Vector3(transformhelper.getPos(bodyGO.transform))

				if tempBuildingMO.config then
					self:_setUIPos(worldPos, 0, tempBuildingMO.config and tempBuildingMO.config * 0.001)
				end
			end

			self:_setRotateAudio(AudioEnum.Room.play_ui_home_board_switch)
			self:_setCancelAudio(AudioEnum.Room.play_ui_home_board_recovery)
			self:_setConfirmAudio(0)
		end
	end

	recthelper.setAnchor(self._btncancel.gameObject.transform, recthelper.getAnchor(self._gocancelpos.transform))
	recthelper.setAnchor(self._btnconfirm.gameObject.transform, recthelper.getAnchor(self._goconfirmpos.transform))
end

function RoomViewConfirm:_refreshBlockUI()
	gohelper.setActive(self._btncancel.gameObject, true)
	gohelper.setActive(self._btncancelcharacter.gameObject, false)

	local isPlaceConfirm = RoomHelper.isFSMState(RoomEnum.FSMEditState.PlaceConfirm) or RoomFSMHelper.isCanJompTo(RoomEnum.FSMEditState.PlaceConfirm)

	gohelper.setActive(self._gocontainer, isPlaceConfirm)
	gohelper.setActive(self._gorotate, true)

	if isPlaceConfirm then
		local tempBlockMO = RoomMapBlockModel.instance:getTempBlockMO()

		if tempBlockMO then
			::label_24_0::

			local entity = self._scene.mapmgr:getBlockEntity(tempBlockMO.id, SceneTag.RoomMapBlock)

			if entity then
				local worldPos = Vector3(transformhelper.getPos(entity.go.transform))

				self:_setUIPos(worldPos, 0.12)
			end

			self:_setRotateAudio(AudioEnum.Room.play_ui_home_board_switch)
			self:_setCancelAudio(AudioEnum.Room.play_ui_home_board_remove)
			self:_setConfirmAudio(0)
		end
	end

	recthelper.setAnchor(self._btncancel.gameObject.transform, recthelper.getAnchor(self._gocancelpos.transform))
	recthelper.setAnchor(self._btnconfirm.gameObject.transform, recthelper.getAnchor(self._goconfirmpos.transform))
end

function RoomViewConfirm:_refreshCharacterUI()
	gohelper.setActive(self._gorotate, true)
	gohelper.setActive(self._gocontainer, self._dropOP ~= true)
	gohelper.setActive(self._gorotate, false)

	local tempCharacterMO = RoomCharacterModel.instance:getTempCharacterMO()

	if tempCharacterMO then
		::label_25_0::

		local entity = self._scene.charactermgr:getCharacterEntity(tempCharacterMO.id, SceneTag.RoomCharacter)

		gohelper.setActive(self._btncancel.gameObject, not tempCharacterMO or tempCharacterMO.characterState ~= RoomCharacterEnum.CharacterState.Revert)
		gohelper.setActive(self._btncancelcharacter.gameObject, tempCharacterMO and tempCharacterMO.characterState == RoomCharacterEnum.CharacterState.Revert)

		if entity then
			local currentPosition = tempCharacterMO.currentPosition
			local offsetZ = 0.6 * RoomBlockEnum.BlockSize
			local rotate = self._scene.camera:getCameraRotate()
			local offsetPositionX = currentPosition.x + offsetZ * math.sin(rotate)
			local offsetPositionZ = currentPosition.z + offsetZ * math.cos(rotate)
			local worldPos = Vector3(offsetPositionX, 0, offsetPositionZ)

			self:_setUIPos(worldPos, 0.05, 0.5)
			self:_setRotateAudio(AudioEnum.Room.play_ui_home_role_switch)
			self:_setCancelAudio(AudioEnum.Room.play_ui_home_role_remove)
			self:_setConfirmAudio(AudioEnum.Room.play_ui_home_role_fix)
		end

		recthelper.setAnchor(self._btncancel.gameObject.transform, recthelper.getAnchor(self._gocancelposcharacter.transform))
		recthelper.setAnchor(self._btnconfirm.gameObject.transform, recthelper.getAnchor(self._goconfirmposcharacter.transform))
	end
end

function RoomViewConfirm:_setRotateAudio(audioId)
	if audioId == 0 then
		gohelper.removeUIClickAudio(self._gorotate)
	else
		gohelper.addUIClickAudio(self._gorotate, audioId or AudioEnum.UI.Play_UI_Universal_Click)
	end
end

function RoomViewConfirm:_setCancelAudio(audioId)
	if audioId == 0 then
		gohelper.removeUIClickAudio(self._btncancel.gameObject)
		gohelper.removeUIClickAudio(self._btncancelcharacter.gameObject)
	else
		gohelper.addUIClickAudio(self._btncancel.gameObject, audioId or AudioEnum.UI.Play_UI_Universal_Click)
		gohelper.addUIClickAudio(self._btncancelcharacter.gameObject, audioId or AudioEnum.UI.Play_UI_Universal_Click)
	end
end

function RoomViewConfirm:_setConfirmAudio(audioId)
	if audioId == 0 then
		gohelper.removeUIClickAudio(self._btnconfirm.gameObject)
	else
		gohelper.addUIClickAudio(self._btnconfirm.gameObject, audioId or AudioEnum.UI.Play_UI_Universal_Click)
	end
end

function RoomViewConfirm:_setUIPos(worldPos, offsetY, uiScale)
	local bendingPos = RoomBendingHelper.worldToBendingSimple(worldPos)
	local cameraPos = self._scene.camera:getCameraPosition()
	local focusPos = self._scene.camera:getCameraFocus()
	local distance = Vector3.Distance(cameraPos, bendingPos)
	local scale = Mathf.Clamp(2.912 / distance, 0.4, 1)
	local rotate = self._scene.camera:getCameraRotate()
	local bendingPosXBottom = bendingPos.x - (0.9 - scale * 0.5) * Mathf.Sin(rotate)
	local bendingPosZBottom = bendingPos.z - (0.9 - scale * 0.5) * Mathf.Cos(rotate)

	offsetY = offsetY or 0

	local worldPosBottom = Vector3(bendingPosXBottom, bendingPos.y + offsetY, bendingPosZBottom)
	local localPosBottom = recthelper.worldPosToAnchorPos(worldPosBottom, self._goconfirm.transform)

	recthelper.setAnchor(self._gocontainer.transform, localPosBottom.x, (self._isCharacter or nil) and (localPosBottom.y or localPosBottom.y - 20))
end

function RoomViewConfirm:_onFSMEnterState(stateName)
	self:_refreshUI()
end

function RoomViewConfirm:_onFSMLeaveState(stateName)
	self:_refreshUI()
end

function RoomViewConfirm:_onConfirmRefreshUI()
	self:_refreshUI()
end

function RoomViewConfirm:_pressBuildingUp()
	self._dropOP = true

	self:_refreshUI()
end

function RoomViewConfirm:_dropBuildingDown()
	self._dropOP = false

	self:_refreshUI()
end

function RoomViewConfirm:_pressCharacterUp()
	self._dropOP = true

	self:_refreshUI()
end

function RoomViewConfirm:_dropCharacterDown()
	self._dropOP = false

	self:_refreshUI()
end

function RoomViewConfirm:_isDropOP()
	if self._dropOP then
		return true
	end
end

function RoomViewConfirm:_cameraTransformUpdate()
	self:_refreshUI()
end

function RoomViewConfirm:_addBtnAudio()
	gohelper.addUIClickAudio(self._btnconfirm.gameObject, AudioEnum.UI.Play_UI_Universal_Click)
end

function RoomViewConfirm:_onGamepadKeyUp(key)
	if (key == GamepadEnum.KeyCode.LB or key == GamepadEnum.KeyCode.RB) and self._gocontainer.activeInHierarchy then
		self._focusIndex = self._focusIndex or 2

		local offset = key == GamepadEnum.KeyCode.LB and -1 or 1
		local index = self._focusIndex + offset

		if index == 2 and self._gorotate.activeInHierarchy == false then
			index = index + offset
		end

		index = math.max(1, index)
		index = math.min(3, index)
		self._focusIndex = index

		local trans = self._allFocusItem[index]
		local v = recthelper.rectToRelativeAnchorPos(trans.position, ViewMgr.instance:getUIRoot().transform)

		GamepadController.instance:setPointerAnchor(v.x, v.y)
	end
end

function RoomViewConfirm:onOpen()
	self:_refreshUI()
	self:_addBtnAudio()
	self.addEventCb(self, RoomMapController.instance, RoomEvent.FSMEnterState, self._onFSMEnterState, self)
	self.addEventCb(self, RoomMapController.instance, RoomEvent.FSMLeaveState, self._onFSMLeaveState, self)
	self.addEventCb(self, RoomBuildingController.instance, RoomEvent.PressBuildingUp, self._pressBuildingUp, self)
	self.addEventCb(self, RoomBuildingController.instance, RoomEvent.DropBuildingDown, self._dropBuildingDown, self)
	self.addEventCb(self, RoomCharacterController.instance, RoomEvent.PressCharacterUp, self._pressCharacterUp, self)
	self.addEventCb(self, RoomCharacterController.instance, RoomEvent.DropCharacterDown, self._dropCharacterDown, self)
	self.addEventCb(self, RoomMapController.instance, RoomEvent.CameraTransformUpdate, self._cameraTransformUpdate, self)
	self.addEventCb(self, RoomMapController.instance, RoomEvent.RoomVieiwConfirmRefreshUI, self._onConfirmRefreshUI, self)

	if GamepadController.instance:isOpen() then
		self.addEventCb(self, GamepadController.instance, GamepadEvent.KeyUp, self._onGamepadKeyUp, self)
	end
end

function RoomViewConfirm:onClose()
	return
end

function RoomViewConfirm:onDestroyView()
	self._btnconfirm:RemoveClickListener()
	self._btncancel:RemoveClickListener()
	self._btncancelcharacter:RemoveClickListener()
	self._rotateClick:RemoveClickListener()
	self._rotatePress:RemoveLongPressListener()
	TaskDispatcher.cancelTask(self._handleMouseInput, self)
end

RoomViewConfirm.prefabPath = "ui/viewres/room/roomviewconfirm.prefab"

return RoomViewConfirm
