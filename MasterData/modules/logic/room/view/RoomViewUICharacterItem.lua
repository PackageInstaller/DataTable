-- chunkname: @modules/logic/room/view/RoomViewUICharacterItem.lua

module("modules.logic.room.view.RoomViewUICharacterItem", package.seeall)

local RoomViewUICharacterItem = class("RoomViewUICharacterItem", RoomViewUIBaseItem)

function RoomViewUICharacterItem:ctor(heroId)
	RoomViewUICharacterItem.super.ctor(self)

	self._heroId = heroId
end

function RoomViewUICharacterItem:_customOnInit()
	self._simageheroicon = gohelper.findChildImage(self._gocontainer, "mask/simage_heroicon")
	self._gochat = gohelper.findChild(self._gocontainer, "go_chat")
	self._btnchat = gohelper.findChildButton(self._gocontainer, "go_chat/btn_chat")
	self._gofullfaith = gohelper.findChild(self._gocontainer, "go_fullfaith")
	self._gogetfaith = gohelper.findChild(self._gocontainer, "go_getfaith")
	self._btngetfaith = gohelper.findChildButton(self._gocontainer, "go_getfaith/btn_getfaith")
	self._btnfull = gohelper.findChildButton(self._gocontainer, "go_fullfaith/btn_full")
	self._gomaxfaith = gohelper.findChild(self._gocontainer, "go_maxfaith")
	self._btnmax = gohelper.findChildButton(self._gocontainer, "go_maxfaith/btn_max")
	self._imageprocess = gohelper.findChildImage(self._gocontainer, "go_getfaith/process")
	self._goonbirthdayicon = gohelper.findChild(self._gocontainer, "#image_onbirthday")
end

function RoomViewUICharacterItem:_customAddEventListeners()
	RoomCharacterController.instance:registerCallback(RoomEvent.CharacterPositionChanged, self._characterPositionChanged, self)
	RoomCharacterController.instance:registerCallback(RoomEvent.RefreshFaithShow, self._refreshBtnShow, self)
	CharacterController.instance:registerCallback(CharacterEvent.HeroUpdatePush, self._refreshBtnShow, self)
	RoomCharacterController.instance:registerCallback(RoomEvent.UpdateCharacterInteractionUI, self._refreshBtnShow, self)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, self._onDailyRefresh, self)
	self:refreshUI(true)
end

function RoomViewUICharacterItem:_customRemoveEventListeners()
	RoomCharacterController.instance:unregisterCallback(RoomEvent.CharacterPositionChanged, self._characterPositionChanged, self)
	RoomCharacterController.instance:unregisterCallback(RoomEvent.RefreshFaithShow, self._refreshBtnShow, self)
	CharacterController.instance:unregisterCallback(CharacterEvent.HeroUpdatePush, self._refreshBtnShow, self)
	RoomCharacterController.instance:unregisterCallback(RoomEvent.UpdateCharacterInteractionUI, self._refreshBtnShow, self)
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, self._onDailyRefresh, self)
end

function RoomViewUICharacterItem:refreshUI(isInit)
	self:_refreshCharacter()
	self:_refreshBtnShow()
	self:_refreshShow(isInit)
	self:_refreshPosition()
	self:_refreshBirthday()
end

function RoomViewUICharacterItem:_characterPositionChanged(heroId)
	if self._heroId ~= heroId then
		return
	end

	self:_refreshPosition()
end

function RoomViewUICharacterItem:_refreshCharacter()
	local roomCharacterMO = RoomCharacterModel.instance:getCharacterMOById(self._heroId)

	if not roomCharacterMO then
		return
	end

	local skinId = roomCharacterMO.skinId
	local skinConfig = SkinConfig.instance:getSkinCo(skinId)

	gohelper.getSingleImage(self._simageheroicon.gameObject):LoadImage(ResUrl.roomHeadIcon(skinConfig.headIcon))
end

function RoomViewUICharacterItem:_refreshBtnShow()
	local roomCharacterMO = RoomCharacterModel.instance:getCharacterMOById(self._heroId)

	if not roomCharacterMO or roomCharacterMO:isTrainSourceState() then
		return
	end

	if self._isPlayingGainAnim then
		return
	end

	TaskDispatcher.cancelTask(self._gainCharacterFaithAnimEnd, self)

	local currentInteractionId = roomCharacterMO:getCurrentInteractionId()

	if currentInteractionId and RoomController.instance:isObMode() then
		gohelper.setActive(self._gochat, true)
		gohelper.setActive(self._gofullfaith, false)
		gohelper.setActive(self._gogetfaith, false)
		gohelper.setActive(self._gomaxfaith, false)

		return
	end

	gohelper.setActive(self._gochat, false)

	local isFaithFull = RoomCharacterController.instance:isCharacterFaithFull(roomCharacterMO.heroId)
	local var_8_0

	if isFaithFull then
		::label_8_0::

		var_8_0 = RoomController.instance:isObMode()
		var_8_0 = var_8_0 and RoomCharacterModel.instance:isShowFaithFull(roomCharacterMO.heroId)
	end

	gohelper.setActive(self._gofullfaith, var_8_0)

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
end

function RoomViewUICharacterItem:_onDailyRefresh()
	self:_refreshBirthday()
end

function RoomViewUICharacterItem:_refreshShow(isInit)
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

	if RoomEnum.CameraShowSpineMap[cameraState] then
		self:_setShow(false, isInit)

		return
	end

	if RoomMapController.instance:isInRoomInitBuildingViewCamera() then
		self:_setShow(false, isInit)

		return
	end

	self:_setShow(true, isInit)
end

function RoomViewUICharacterItem:_refreshBirthday()
	local isOnBirthday = RoomCharacterModel.instance:isOnBirthday(self._heroId)

	gohelper.setActive(self._goonbirthdayicon, isOnBirthday)
end

function RoomViewUICharacterItem:getUI3DPos()
	local roomCharacterMO = RoomCharacterModel.instance:getCharacterMOById(self._heroId)

	if not roomCharacterMO then
		return Vector3.zero
	end

	local movingPosition = roomCharacterMO.currentPosition

	return (Vector3(movingPosition.x, movingPosition.y, movingPosition.z))
end

function RoomViewUICharacterItem:_gainCharacterFaith(cmd, resultCode, msg)
	if resultCode ~= 0 then
		self._isPlayingGainAnim = false

		return
	end

	self._baseAnimator:Play("room_task_lingqu", 0, 0)
	TaskDispatcher.runDelay(self._gainCharacterFaithAnimEnd, self, 1.5)
end

function RoomViewUICharacterItem:_gainCharacterFaithAnimEnd()
	self._isPlayingGainAnim = false

	self:_refreshBtnShow()
end

function RoomViewUICharacterItem:_onClick(go, param)
	if not RoomController.instance:isObMode() then
		return
	end

	local roomCharacterMO = RoomCharacterModel.instance:getCharacterMOById(self._heroId)

	if not roomCharacterMO then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Rolesback)

	if go.transform:IsChildOf(self._btngetfaith.gameObject.transform) or go.transform:IsChildOf(self._btnmax.gameObject.transform) then
		self._switchCamera(self, self.gainCharacterFaith, self)
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Rolesback)
	elseif go.transform:IsChildOf(self._btnfull.gameObject.transform) then
		RoomCharacterController.instance:setCharacterFullFaithChecked(roomCharacterMO.heroId)
		self:_switchCamera()
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Rolesback)
	elseif go.transform:IsChildOf(self._btnchat.gameObject.transform) then
		self._switchCamera(self, self.startInteraction, self)
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Rolesback)
	else
		self:_switchCamera()

		local needShowBirthDayToast = RoomCharacterModel.instance:isNeedShowBirthdayToastTip(self._heroId)

		if needShowBirthDayToast then
			GameFacade.showToast(ToastEnum.CharacterOnBirthday)
			RoomCharacterModel.instance:setHasShowBirthdayToastTip(self._heroId)
		end

		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Rolesback)
	end
end

function RoomViewUICharacterItem:_switchCamera(callback, callbackObj)
	local roomCharacterMO = RoomCharacterModel.instance:getCharacterMOById(self._heroId)
	local pos = roomCharacterMO.currentPosition

	self._scene.camera:switchCameraState(RoomEnum.CameraState.Normal, {
		focusX = pos.x,
		focusY = pos.z
	}, nil, callback, callbackObj)
end

function RoomViewUICharacterItem:startInteraction()
	local roomCharacterMO = RoomCharacterModel.instance:getCharacterMOById(self._heroId)

	if not roomCharacterMO then
		return
	end

	RoomCharacterController.instance:startInteraction(roomCharacterMO:getCurrentInteractionId(), true)
end

function RoomViewUICharacterItem:gainCharacterFaith()
	if not RoomController.instance:isObMode() then
		return
	end

	local roomCharacterMO = RoomCharacterModel.instance:getCharacterMOById(self._heroId)

	if not roomCharacterMO then
		return
	end

	RoomCharacterController.instance:gainCharacterFaith({
		roomCharacterMO.heroId
	})
	AudioMgr.instance:trigger(AudioEnum.Room.ui_home_board_upgrade)
end

function RoomViewUICharacterItem:_customOnDestory()
	TaskDispatcher.cancelTask(self._gainCharacterFaithAnimEnd, self)
end

return RoomViewUICharacterItem
