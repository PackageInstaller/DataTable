-- chunkname: @modules/logic/room/view/debug/RoomDebugView.lua

module("modules.logic.room.view.debug.RoomDebugView", package.seeall)

local RoomDebugView = class("RoomDebugView", BaseView)

function RoomDebugView:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomDebugView:addEvents()
	return
end

function RoomDebugView:removeEvents()
	return
end

function RoomDebugView:_editableInitView()
	self._gonormalroot = gohelper.findChild(self.viewGO, "go_normalroot")
	self._txtcamera = gohelper.findChildText(self.viewGO, "go_normalroot/btn_camera/txt_camera")
	self._btnreset = gohelper.findChildButtonWithAudio(self.viewGO, "go_normalroot/btn_debugreset")
	self._btncamera = gohelper.findChildButtonWithAudio(self.viewGO, "go_normalroot/btn_camera")
	self._btndebugplace = gohelper.findChildButtonWithAudio(self.viewGO, "go_normalroot/btn_debugplace")
	self._btndebugbuilding = gohelper.findChildButtonWithAudio(self.viewGO, "go_normalroot/btn_debugbuilding")
	self._btndebugpackage = gohelper.findChildButtonWithAudio(self.viewGO, "go_normalroot/btn_debugpackage")
	self._btnoutput = gohelper.findChildButtonWithAudio(self.viewGO, "go_normalroot/btn_debugoutput")
	self._btnoutputfishing = gohelper.findChildButtonWithAudio(self.viewGO, "go_normalroot/btn_debugoutputfishing")
	self._btnbuildingarea = gohelper.findChildButtonWithAudio(self.viewGO, "go_normalroot/btn_buildingarea")
	self._blockoptab = gohelper.findChild(self.viewGO, "blockop_tab")

	self._btnreset:AddClickListener(self._btnresetOnClick, self)
	self._btncamera:AddClickListener(self._btncameraOnClick, self)
	self._btndebugplace:AddClickListener(self._btndebugplaceOnClick, self)
	self._btndebugbuilding:AddClickListener(self._btndebugbuildingOnClick, self)
	self._btndebugpackage:AddClickListener(self._btndebugpackageOnClick, self)
	self._btnoutput:AddClickListener(self._btnoutputOnClick, self)
	self._btnoutputfishing:AddClickListener(self._btnoutputfishingOnClick, self)
	self._btnbuildingarea:AddClickListener(self._btnbuildingareaOnClick, self)

	self._scene = GameSceneMgr.instance:getCurScene()
	self._rootCanvasGroup = self.viewGO:GetComponent(typeof(UnityEngine.CanvasGroup))
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._canvasGroup = self._gonormalroot:GetComponent(typeof(UnityEngine.CanvasGroup))

	if RoomInventoryBlockModel.instance:openSelectOp() then
		gohelper.setActive(gohelper.findChild(self.viewGO, "go_normalroot/go_inventory"), false)
		gohelper.setActive(gohelper.findChild(self.viewGO, "go_normalroot/go_inventorytask"), false)
	end

	self:_cameraStateUpdate()
	self:_updateNavigateButtonShow()
end

function RoomDebugView:_btnresetOnClick()
	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.RoomForbidBtn) then
		GameFacade.showToast(RoomEnum.GuideForbidEscapeToast)
	else
		GameFacade.showMessageBox(MessageBoxIdDefine.RoomReset, MsgBoxEnum.BoxType.Yes_No, RoomDebugView._resetYesCallback)
	end
end

function RoomDebugView:_btncameraOnClick()
	local cameraState = self._scene.camera:getCameraState()

	if cameraState == RoomEnum.CameraState.Normal then
		self._scene.camera:switchCameraState(RoomEnum.CameraState.Overlook, {})
	elseif cameraState == RoomEnum.CameraState.Overlook then
		self._scene.camera:switchCameraState(RoomEnum.CameraState.Normal, {})
	end
end

function RoomDebugView:_btndebugplaceOnClick()
	RoomDebugController.instance:setDebugPlaceListShow(true)
end

function RoomDebugView:_btndebugbuildingOnClick()
	RoomDebugController.instance:setDebugBuildingListShow(true)
end

function RoomDebugView:_btndebugpackageOnClick()
	RoomDebugController.instance:setDebugPackageListShow(true)
end

function RoomDebugView:_btnbuildingareaOnClick()
	RoomDebugController.instance:openBuildingAreaView()
end

function RoomDebugView:_btnoutputOnClick()
	RoomDebugController.instance:output()
end

function RoomDebugView:_btnoutputfishingOnClick()
	RoomDebugController.instance:outputFishing()
end

function RoomDebugView._resetYesCallback()
	RoomMapController.instance:resetRoom()
end

function RoomDebugView:_listViewShowChanged()
	self:_refreshBtnShow()
end

function RoomDebugView:_updateCharacterInteractionUI()
	self:_refreshBtnShow()
	self:_updateNavigateButtonShow()
end

function RoomDebugView:_updateNavigateButtonShow()
	return
end

function RoomDebugView:_cameraStateUpdate()
	local cameraState = self._scene.camera:getCameraState()

	if cameraState == RoomEnum.CameraState.Overlook then
		self._txtcamera.text = luaLang("roomstandbyview_highview")
	elseif cameraState == RoomEnum.CameraState.Normal then
		self._txtcamera.text = luaLang("roomstandbyview_lowview")
	end
end

function RoomDebugView:_addBtnAudio()
	gohelper.addUIClickAudio(self._btnreset.gameObject, AudioEnum.UI.UI_vertical_first_tabs_click)
end

function RoomDebugView:_refreshBtnShow()
	local isDebugPlaceListShow = RoomDebugController.instance:isDebugPlaceListShow()
	local isDebugPackageListShow = RoomDebugController.instance:isDebugPackageListShow()
	local isDebugBuildingListShow = RoomDebugController.instance:isDebugBuildingListShow()
	local isListShow = isDebugPlaceListShow or isDebugPackageListShow or isDebugBuildingListShow

	gohelper.setActive(self._btnreset.gameObject, RoomController.instance:isDebugMode() and not isListShow and not RoomController.instance:isEditMode())
	gohelper.setActive(self._btndebugplace.gameObject, RoomController.instance:isDebugMode() and not isListShow)
	gohelper.setActive(self._btndebugpackage.gameObject, RoomController.instance:isDebugPackageMode() and not isListShow)
	gohelper.setActive(self._btndebugbuilding.gameObject, RoomController.instance:isDebugPackageMode() and not isListShow)

	local var_19_0 = self._btncamera.gameObject

	gohelper.setActive(var_19_0, (not RoomController.instance:isObMode() or isListShow) and (RoomController.instance:isVisitMode() or RoomController.instance:isDebugMode()) or true)
	gohelper.setActive(self._btnoutput.gameObject, (RoomController.instance:isDebugInitMode() or RoomController.instance:isDebugPackageMode()) and not isListShow)
end

function RoomDebugView:onOpen()
	self:_refreshBtnShow()
	self:_addBtnAudio()
	self.addEventCb(self, RoomDebugController.instance, RoomEvent.DebugPlaceListShowChanged, self._listViewShowChanged, self)
	self.addEventCb(self, RoomDebugController.instance, RoomEvent.DebugPackageListShowChanged, self._listViewShowChanged, self)
	self.addEventCb(self, RoomDebugController.instance, RoomEvent.DebugBuildingListShowChanged, self._listViewShowChanged, self)
	self.addEventCb(self, RoomMapController.instance, RoomEvent.CameraStateUpdate, self._cameraStateUpdate, self)
	self.addEventCb(self, RoomMapController.instance, RoomEvent.BackBlockShowChanged, self._updateNavigateButtonShow, self)
	self.addEventCb(self, RoomBuildingController.instance, RoomEvent.RefreshNavigateButton, self._updateNavigateButtonShow, self)
	self.addEventCb(self, RoomDebugController.instance, RoomEvent.DebugPlaceListShowChanged, self._updateNavigateButtonShow, self)
	self.addEventCb(self, RoomDebugController.instance, RoomEvent.DebugPackageListShowChanged, self._updateNavigateButtonShow, self)
	self.addEventCb(self, RoomDebugController.instance, RoomEvent.DebugBuildingListShowChanged, self._updateNavigateButtonShow, self)
end

function RoomDebugView:onClose()
	return
end

function RoomDebugView:onDestroyView()
	self._btnreset:RemoveClickListener()
	self._btncamera:RemoveClickListener()
	self._btndebugplace:RemoveClickListener()
	self._btndebugbuilding:RemoveClickListener()
	self._btndebugpackage:RemoveClickListener()
	self._btnoutput:RemoveClickListener()
	self._btnoutputfishing:RemoveClickListener()
	self._btnbuildingarea:RemoveClickListener()
end

return RoomDebugView
