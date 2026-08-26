-- chunkname: @modules/logic/room/view/RoomViewUICharacterInteractionItem.lua

module("modules.logic.room.view.RoomViewUICharacterInteractionItem", package.seeall)

local RoomViewUICharacterInteractionItem = class("RoomViewUICharacterInteractionItem", RoomViewUIBaseItem)

function RoomViewUICharacterInteractionItem:ctor(heroId)
	RoomViewUICharacterInteractionItem.super.ctor(self)

	self._heroId = heroId
end

function RoomViewUICharacterInteractionItem:_customOnInit()
	self._gochaticon = gohelper.findChild(self._gocontainer, "go_chaticon")
	self._btnchat = gohelper.findChildButton(self._gocontainer, "go_chaticon/btn_chat")
	self._godialog = gohelper.findChild(self._gocontainer, "go_dialog")
	self._txtdialog = gohelper.findChildText(self._gocontainer, "go_dialog/bg/txt_dialog")
	self._animator = self._godialog:GetComponent(typeof(UnityEngine.Animator))
	self._gogetfaith = gohelper.findChild(self._gocontainer, "go_getfaith")
	self._btngetfaith = gohelper.findChildButton(self._gocontainer, "go_getfaith/btn_getfaith")
	self._imageprocess = gohelper.findChildImage(self._gocontainer, "go_getfaith/process")
	self._gofullfaith = gohelper.findChild(self._gocontainer, "go_fullfaith")
	self._btnfull = gohelper.findChildButton(self._gocontainer, "go_fullfaith/btn_full")
	self._gomaxfaith = gohelper.findChild(self._gocontainer, "go_maxfaith")
	self._btnmax = gohelper.findChildButton(self._gocontainer, "go_maxfaith/btn_max")
end

function RoomViewUICharacterInteractionItem:_customAddEventListeners()
	RoomCharacterController.instance:registerCallback(RoomEvent.CharacterPositionChanged, self._characterPositionChanged, self)
	RoomCharacterController.instance:registerCallback(RoomEvent.UpdateCharacterInteractionUI, self._refreshBtnShow, self)
	RoomCharacterController.instance:registerCallback(RoomEvent.RefreshFaithShow, self._refreshBtnShow, self)
	CharacterController.instance:registerCallback(CharacterEvent.HeroUpdatePush, self._refreshBtnShow, self)
	self:refreshUI(true)
end

function RoomViewUICharacterInteractionItem:_customRemoveEventListeners()
	RoomCharacterController.instance:unregisterCallback(RoomEvent.CharacterPositionChanged, self._characterPositionChanged, self)
	RoomCharacterController.instance:unregisterCallback(RoomEvent.UpdateCharacterInteractionUI, self._refreshBtnShow, self)
	RoomCharacterController.instance:unregisterCallback(RoomEvent.RefreshFaithShow, self._refreshBtnShow, self)
	CharacterController.instance:unregisterCallback(CharacterEvent.HeroUpdatePush, self._refreshBtnShow, self)
end

function RoomViewUICharacterInteractionItem:refreshUI(isInit)
	self:_refreshBtnShow()
	self:_refreshShow(isInit)
	self:_refreshPosition()
end

function RoomViewUICharacterInteractionItem:_characterPositionChanged(heroId)
	if self._heroId ~= heroId then
		return
	end

	self:_refreshPosition()
end

function RoomViewUICharacterInteractionItem:_refreshBtnShow()
	gohelper.setActive(self._godialog, false)

	local roomCharacterMO = RoomCharacterModel.instance:getCharacterMOById(self._heroId)

	if not roomCharacterMO then
		return
	end

	local currentInteractionId = roomCharacterMO:getCurrentInteractionId()

	if not currentInteractionId then
		gohelper.setActive(self._gochaticon, false)

		local isFaithFull = RoomCharacterController.instance:isCharacterFaithFull(roomCharacterMO.heroId)
		local var_7_0

		if isFaithFull then
			::label_7_0::

			var_7_0 = RoomController.instance:isObMode()
			var_7_0 = var_7_0 and RoomCharacterModel.instance:isShowFaithFull(roomCharacterMO.heroId)
		end

		gohelper.setActive(self._gofullfaith, var_7_0)

		if isFaithFull then
			gohelper.setActive(self._gogetfaith, false)
			gohelper.setActive(self._gomaxfaith, false)

			return
		end

		local faithFill = RoomCharacterHelper.getCharacterFaithFill(roomCharacterMO)

		gohelper.setActive(self._gogetfaith, faithFill > 0 and faithFill < 1)
		gohelper.setActive(self._gomaxfaith, faithFill >= 1)

		if faithFill > 0 and faithFill < 1 then
			self._imageprocess.fillAmount = faithFill * 0.55 + 0.2
		end

		return
	end

	gohelper.setActive(self._gofullfaith, false)
	gohelper.setActive(self._gogetfaith, false)
	gohelper.setActive(self._gomaxfaith, false)

	local playingInteractionParam = RoomCharacterController.instance:getPlayingInteractionParam()

	gohelper.setActive(self._gochaticon, not playingInteractionParam)
end

function RoomViewUICharacterInteractionItem:_refreshShow(isInit)
	local roomCharacterMO = RoomCharacterModel.instance:getCharacterMOById(self._heroId)

	if not roomCharacterMO then
		self:_setShow(false, true)

		return
	end

	if RoomBuildingController.instance:isBuildingListShow() or RoomCharacterController.instance:isCharacterListShow() then
		self:_setShow(false, isInit)

		return
	end

	local cameraState = self._scene.camera:getCameraState()

	if cameraState ~= RoomEnum.CameraState.Normal then
		self:_setShow(false, isInit)

		return
	end

	if RoomMapController.instance:isInRoomInitBuildingViewCamera() then
		self:_setShow(false, isInit)

		return
	end

	self:_setShow(true, isInit)
end

function RoomViewUICharacterInteractionItem:getUI3DPos()
	local roomCharacterMO = RoomCharacterModel.instance:getCharacterMOById(self._heroId)

	if not roomCharacterMO then
		return Vector3.zero
	end

	local movingPosition = roomCharacterMO.currentPosition
	local height = movingPosition.y + 0.18
	local entity = self._scene.charactermgr:getCharacterEntity(roomCharacterMO.id, SceneTag.RoomCharacter)

	if entity then
		local headGOTrs = entity.characterspine:getMountheadGOTrs()

		if headGOTrs then
			local px, py, pz = transformhelper.getPos(headGOTrs)

			height = py - 0.02
		end
	end

	return (Vector3(movingPosition.x, height, movingPosition.z))
end

function RoomViewUICharacterInteractionItem:_refreshPosition()
	local worldPos = self:getUI3DPos()
	local bendingPos = RoomBendingHelper.worldToBendingSimple(worldPos)
	local anchorPos = RoomBendingHelper.worldPosToAnchorPos(bendingPos, self.go.transform.parent)

	if anchorPos then
		anchorPos.x = anchorPos.x * 0.98

		recthelper.setAnchor(self.go.transform, anchorPos.x, anchorPos.y)
	end

	local scale = 0

	if anchorPos then
		local cameraGO = CameraMgr.instance:getMainCameraGO()
		local cameraPosition = cameraGO.transform.position
		local forward = cameraGO.transform.forward
		local target = bendingPos - cameraPosition
		local distance = Vector3.Dot(forward, target)

		scale = distance == 0 and 0 or 1 / distance
	end

	transformhelper.setLocalScale(self._gocontainer.transform, scale, scale, scale)
	self:_refreshCanvasGroup()
end

function RoomViewUICharacterInteractionItem:_onClick(go, param)
	if not RoomController.instance:isObMode() then
		return
	end

	local roomCharacterMO = RoomCharacterModel.instance:getCharacterMOById(self._heroId)

	if not roomCharacterMO then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Rolesback)

	if go.transform:IsChildOf(self._btngetfaith.transform) or go.transform:IsChildOf(self._btnmax.transform) then
		RoomCharacterController.instance:gainCharacterFaith({
			roomCharacterMO.heroId
		})
		AudioMgr.instance:trigger(AudioEnum.Room.ui_home_board_upgrade)
	elseif go.transform:IsChildOf(self._btnfull.transform) then
		RoomCharacterController.instance:setCharacterFullFaithChecked(roomCharacterMO.heroId)
		GameFacade.showToast(RoomEnum.Toast.GainFaithFull)
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Rolesback)
	elseif go.transform:IsChildOf(self._btnchat.transform) then
		RoomCharacterController.instance:startInteraction(roomCharacterMO:getCurrentInteractionId(), true)
	end
end

function RoomViewUICharacterInteractionItem:_customOnDestory()
	return
end

return RoomViewUICharacterInteractionItem
