-- chunkname: @modules/logic/room/view/RoomViewCameraState.lua

module("modules.logic.room.view.RoomViewCameraState", package.seeall)

local RoomViewCameraState = class("RoomViewCameraState", BaseView)

function RoomViewCameraState:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomViewCameraState:addEvents()
	self._btncamera:AddClickListener(self._btncameraOnClick, self)
	self._btncameramask:AddClickListener(self._btncameramaskOnClick, self)
end

function RoomViewCameraState:removeEvents()
	self._btncamera:RemoveClickListener()
	self._btncameramask:RemoveClickListener()
end

function RoomViewCameraState:_editableInitView()
	self._btncamera = gohelper.findChildButtonWithAudio(self.viewGO, "go_normalroot/btn_camera")
	self._btncameramask = gohelper.findChildButtonWithAudio(self.viewGO, "go_normalroot/btn_cameramask")
	self._gocameraexpand = gohelper.findChild(self.viewGO, "go_normalroot/#go_cameraexpand")
	self._gocameritem = gohelper.findChild(self.viewGO, "go_normalroot/#go_cameraexpand/go_cameritem")
	self._txtcamera = gohelper.findChildText(self.viewGO, "go_normalroot/btn_camera/txt_camera")
	self._imageicon = gohelper.findChildImage(self.viewGO, "go_normalroot/btn_camera/image_icon")
	self._scene = GameSceneMgr.instance:getCurScene()
	self._cameraStateDataList = {
		{
			landKey = "roomstandbyview_highview_all",
			icon = "zuoce_ziyuan_quanlanshijiao",
			cameraState = RoomEnum.CameraState.OverlookAll
		},
		{
			landKey = "roomstandbyview_highview",
			icon = "zuoce_ziyuan_gaoshijiao",
			cameraState = RoomEnum.CameraState.Overlook
		},
		{
			landKey = "roomstandbyview_lowview",
			icon = "zuoce_ziyuan_pingshijiao",
			cameraState = RoomEnum.CameraState.Normal
		}
	}
	self._cameraTbList = {}

	for i, stateData in ipairs(self._cameraStateDataList) do
		local cloneGo = gohelper.cloneInPlace(self._gocameritem)
		local cameraTb = self:_createCameraTb(cloneGo, stateData)

		table.insert(self._cameraTbList, cameraTb)
	end

	gohelper.setActive(self._gocameritem, false)
	gohelper.setActive(self._gocameraexpand, false)
end

function RoomViewCameraState:_createCameraTb(go, stateData)
	local tb = self:getUserDataTb_()

	tb.go = go
	tb.stateData = stateData
	tb.goselect = gohelper.findChild(go, "go_select")
	tb.btn = gohelper.findButtonWithAudio(go)
	tb.txtcamera = gohelper.findChildText(go, "txt_camera")
	tb.imageicon = gohelper.findChildImage(go, "image_icon")

	function tb.dispose(tbself)
		tbself.btn:RemoveClickListener()
	end

	tb.btn:AddClickListener(self._onCameraTbOnClick, self, tb)
	UISpriteSetMgr.instance:setRoomSprite(tb.imageicon, stateData.icon)

	tb.txtcamera.text = luaLang(stateData.landKey)

	return tb
end

function RoomViewCameraState:_btncameraOnClick()
	self:_showExpand(self._isShowExpand ~= true)
end

function RoomViewCameraState:_btncameramaskOnClick()
	self:_showExpand(false)
end

function RoomViewCameraState:_onCameraTbOnClick(camerTb)
	local cameraState = self._scene.camera:getCameraState()

	if cameraState ~= camerTb.stateData.cameraState then
		self._scene.camera:switchCameraState(camerTb.stateData.cameraState, {}, nil, self._finishSwitchCameraState, self)
	end

	self:_showExpand(false)
end

function RoomViewCameraState:_finishSwitchCameraState()
	if self._scene and self._scene.audio then
		self._scene.audio:changeRTPCValue()
	end
end

function RoomViewCameraState:_refreshSelect()
	local cameraState = self._scene.camera:getCameraState()

	for i, cameraTb in ipairs(self._cameraTbList) do
		gohelper.setActive(cameraTb.goselect, cameraState == cameraTb.stateData.cameraState)
	end
end

function RoomViewCameraState:_showExpand(isShow)
	self._isShowExpand = isShow

	gohelper.setActive(self._gocameraexpand, isShow)
	gohelper.setActive(self._btncameramask, isShow)
end

function RoomViewCameraState:_btntrackingOnClick()
	local cameraFocus = self._scene.camera:getCameraFocus()

	if self._scene.camera:getCameraState() == RoomEnum.CameraState.Overlook and math.abs(cameraFocus.x) < 0.1 and math.abs(cameraFocus.y) < 0.1 then
		GameFacade.showToast(ToastEnum.ClickRoomTracking)

		return
	end

	self._scene.camera:switchCameraState(RoomEnum.CameraState.Overlook, {
		focusX = 0,
		focusY = 0
	})
end

function RoomViewCameraState:_cameraStateUpdate()
	local cameraState = self._scene.camera:getCameraState()
	local stateData = self:_getStateData(cameraState)

	if stateData then
		self._txtcamera.text = luaLang(stateData.landKey)

		UISpriteSetMgr.instance:setRoomSprite(self._imageicon, stateData.icon)
		self:_refreshSelect()
	else
		self:_showExpand(false)
	end
end

function RoomViewCameraState:_getStateData(cameraState)
	for i, stateData in ipairs(self._cameraStateDataList) do
		if stateData.cameraState == cameraState then
			return stateData
		end
	end
end

function RoomViewCameraState:onOpen()
	self.addEventCb(self, RoomMapController.instance, RoomEvent.CameraStateUpdate, self._cameraStateUpdate, self)
	self:_cameraStateUpdate()
end

function RoomViewCameraState:onClose()
	return
end

function RoomViewCameraState:onDestroyView()
	if self._cameraTbList then
		for i, cameraTb in ipairs(self._cameraTbList) do
			cameraTb:dispose()
		end

		self._cameraTbList = nil
	end
end

return RoomViewCameraState
