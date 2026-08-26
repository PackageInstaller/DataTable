-- chunkname: @modules/logic/room/view/RoomView.lua

module("modules.logic.room.view.RoomView", package.seeall)

local RoomView = class("RoomView", BaseView)

function RoomView:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomView:addEvents()
	self._btnRecord:AddClickListener(self._btnRecordOnClick, self)
	self._btnCritter:AddClickListener(self._btnCritterOnClick, self)
	self._btnOverview:AddClickListener(self._btnOverviewOnClick, self)
	self._btnTrade:AddClickListener(self._btnTradeOnClick, self)
	self._btnWarehouse:AddClickListener(self._btnWarehouseOnClick, self)
	self._btnfishing:AddClickListener(self._btnfishingOnClick, self)
end

function RoomView:removeEvents()
	self._btnRecord:RemoveClickListener()
	self._btnCritter:RemoveClickListener()
	self._btnOverview:RemoveClickListener()
	self._btnTrade:RemoveClickListener()
	self._btnWarehouse:RemoveClickListener()
	self._btnfishing:RemoveClickListener()
end

function RoomView:_editableInitView()
	self._goreturnroot = gohelper.findChild(self.viewGO, "navigatebuttonscontainer")
	self._gonormalroot = gohelper.findChild(self.viewGO, "go_normalroot")
	self._simagemaskbg = gohelper.findChildSingleImage(self.viewGO, "go_normalroot/#simage_maskbg")
	self._simagemaskbg.spriteMeshType = UnityEngine.SpriteMeshType.Tight
	self._btnedit = gohelper.findChildButtonWithAudio(self.viewGO, "go_normalroot/btn_edit")
	self._gobtncamera = gohelper.findChild(self.viewGO, "go_normalroot/btn_camera")
	self._btncharacter = gohelper.findChildButtonWithAudio(self.viewGO, "go_normalroot/btn_character")
	self._btntracking = gohelper.findChildButtonWithAudio(self.viewGO, "go_normalroot/btn_tracking")
	self._imagetracking = gohelper.findChildImage(self.viewGO, "go_normalroot/btn_tracking")
	self._txttracking = gohelper.findChildText(self.viewGO, "go_normalroot/btn_tracking/txt")
	self._btndialog = gohelper.findChildButtonWithAudio(self.viewGO, "go_normalroot/btn_dialog")
	self._btnhide = gohelper.findChildButtonWithAudio(self.viewGO, "go_normalroot/btn_hide")
	self._btnstore = gohelper.findChildButtonWithAudio(self.viewGO, "go_normalroot/btn_store")
	self._gobtnfishingResources = gohelper.findChild(self.viewGO, "go_normalroot/btn_fishingResource")
	self._btnlayoutplan = gohelper.findChildButtonWithAudio(self.viewGO, "go_normalroot/btn_layoutplan")
	self._btnlayoutcopy = gohelper.findChildButtonWithAudio(self.viewGO, "go_normalroot/btn_copy")
	self._gobtnexpandManufacture = gohelper.findChild(self.viewGO, "go_normalroot/layout/btn_expandManufacture")
	self._btnexpandManufacture = gohelper.findChildButtonWithAudio(self.viewGO, "go_normalroot/layout/btn_expandManufacture/btn")
	self._manufactureAnimator = gohelper.findChildComponent(self.viewGO, "go_normalroot/layout/btn_expandManufacture", RoomEnum.ComponentType.Animator)
	self._goManufactureEntranceReddot = gohelper.findChild(self.viewGO, "go_normalroot/layout/btn_expandManufacture/#go_reddot")
	self._btnRecord = gohelper.findChildButtonWithAudio(self.viewGO, "go_normalroot/layout/btn_expandManufacture/go_manuExpand/layout/btn_record")
	self._goRecordReddot = gohelper.findChild(self.viewGO, "go_normalroot/layout/btn_expandManufacture/go_manuExpand/layout/btn_record/#go_reddot")
	self._btnCritter = gohelper.findChildButtonWithAudio(self.viewGO, "go_normalroot/layout/btn_expandManufacture/go_manuExpand/layout/btn_critter")
	self._goCritterReddot = gohelper.findChild(self.viewGO, "go_normalroot/layout/btn_expandManufacture/go_manuExpand/layout/btn_critter/#go_reddot")
	self._btnOverview = gohelper.findChildButtonWithAudio(self.viewGO, "go_normalroot/layout/btn_expandManufacture/go_manuExpand/layout/btn_overview")
	self._goOverviewReddot = gohelper.findChild(self.viewGO, "go_normalroot/layout/btn_expandManufacture/go_manuExpand/layout/btn_overview/#go_reddot")
	self._btnTrade = gohelper.findChildButtonWithAudio(self.viewGO, "go_normalroot/layout/btn_expandManufacture/go_manuExpand/layout/btn_trade")
	self._goTradeReddot = gohelper.findChild(self.viewGO, "go_normalroot/layout/btn_expandManufacture/go_manuExpand/layout/btn_trade/#go_reddot")
	self._btnWarehouse = gohelper.findChildButtonWithAudio(self.viewGO, "go_normalroot/layout/btn_expandManufacture/go_manuExpand/layout/btn_warehouse")
	self._goWarehouseReddot = gohelper.findChild(self.viewGO, "go_normalroot/layout/btn_expandManufacture/go_manuExpand/layout/btn_warehouse/#go_reddot")
	self._warehouseAnimator = self._btnWarehouse:GetComponent(typeof(UnityEngine.Animator))
	self._btnfishing = gohelper.findChildButtonWithAudio(self.viewGO, "go_normalroot/layout/btn_fishing")
	self._gobuildingreddot = gohelper.findChild(self.viewGO, "go_normalroot/btn_building/go_buildingreddot")
	self._goeditreddot = gohelper.findChild(self.viewGO, "go_normalroot/btn_edit/go_editreddot")
	self._blockoptab = gohelper.findChild(self.viewGO, "blockop_tab")
	self._golayoutplanUnlock = gohelper.findChild(self.viewGO, "go_normalroot/btn_layoutplan/icon")
	self._golayoutplanLock = gohelper.findChild(self.viewGO, "go_normalroot/btn_layoutplan/go_lock")
	self._golayoutcopyUnlock = gohelper.findChild(self.viewGO, "go_normalroot/btn_copy/icon")
	self._golayoutcopyLock = gohelper.findChild(self.viewGO, "go_normalroot/btn_copy/go_lock")
	self._gologtip = gohelper.findChild(self.viewGO, "go_normalroot/go_logtips")
	self._simagesticker = gohelper.findChildSingleImage(self.viewGO, "go_normalroot/go_logtips/#simage_stickers")
	self._txtlogdesc = gohelper.findChildText(self.viewGO, "go_normalroot/go_logtips/#scroll_des/viewport/content/#txt_Desc")
	self._btngoto = gohelper.findChildButton(self.viewGO, "go_normalroot/go_logtips/#btn_goto")

	self._btnedit:AddClickListener(self._btneditOnClick, self)
	self._btncharacter:AddClickListener(self._btncharacterOnClick, self)
	self._btntracking:AddClickListener(self._btntrackingOnClick, self)
	self._btndialog:AddClickListener(self._btndialogOnClick, self)
	self._btnhide:AddClickListener(self._btnhideOnClick, self)
	self._btnstore:AddClickListener(self._btnstoreOnClick, self)
	self._btnlayoutplan:AddClickListener(self._btnlayoutplanOnClick, self)
	self._btnlayoutcopy:AddClickListener(self._btnlayoutcopyOnClick, self)
	self._btnexpandManufacture:AddClickListener(self._btnexpandManufactureOnClick, self)
	self._btngoto:AddClickListener(self._openLogView, self)

	self._scene = GameSceneMgr.instance:getCurScene()
	self._rootCanvasGroup = self.viewGO:GetComponent(typeof(UnityEngine.CanvasGroup))
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._canvasGroup = self._gonormalroot:GetComponent(typeof(UnityEngine.CanvasGroup))
	self._layoutplanAnimator = gohelper.findChildComponent(self.viewGO, "go_normalroot/btn_layoutplan", typeof(UnityEngine.Animator))

	if RoomInventoryBlockModel.instance:openSelectOp() then
		gohelper.setActive(gohelper.findChild(self.viewGO, "go_normalroot/go_inventory"), false)
		gohelper.setActive(gohelper.findChild(self.viewGO, "go_normalroot/go_inventorytask"), false)
	end

	self._showHideViewNameDict = {
		[ViewName.RoomCharacterPlaceView] = true,
		[ViewName.RoomInitBuildingView] = true,
		[ViewName.RoomManufactureBuildingView] = true,
		[ViewName.RoomCritterBuildingView] = true,
		[ViewName.RoomTransportSiteView] = true,
		[ViewName.RoomInteractBuildingView] = true
	}
	self._showHideViewNameList = {}

	for checkViewName, _ in pairs(self._showHideViewNameDict) do
		table.insert(self._showHideViewNameList, checkViewName)
	end

	self:_updateNavigateButtonShow()
	gohelper.removeUIClickAudio(self._btncharacter.gameObject)
	gohelper.addUIClickAudio(self._btnlayoutplan.gameObject, AudioEnum.Room.play_ui_home_yield_open)

	self._PcBtnLocation = gohelper.findChild(self.viewGO, "go_normalroot/btn_tracking/#go_pcbtn")
	self._PcBuy = gohelper.findChild(self.viewGO, "go_normalroot/btn_store/#go_pcbtn")
	self._PcBtnLayout = gohelper.findChild(self.viewGO, "go_normalroot/btn_layoutplan/#go_pcbtn")
	self._PcBtnPlace = gohelper.findChild(self.viewGO, "go_normalroot/btn_character/#go_pcbtn")
	self._PcBtnEdit = gohelper.findChild(self.viewGO, "go_normalroot/btn_edit/#go_pcbtn")
	self._PcBtnHide = gohelper.findChild(self.viewGO, "go_normalroot/btn_hide/#go_pcbtn")

	self:_refreshLayoutPlan()
	self:showKeyTips()
end

function RoomView:showKeyTips()
	PCInputController.instance:showkeyTips(self._PcBtnLocation, PCInputModel.Activity.room, PCInputModel.RoomActivityFun.guting)
	PCInputController.instance:showkeyTips(self._PcBuy, PCInputModel.Activity.room, PCInputModel.RoomActivityFun.buy)
	PCInputController.instance:showkeyTips(self._PcBtnLayout, PCInputModel.Activity.room, PCInputModel.RoomActivityFun.layout)
	PCInputController.instance:showkeyTips(self._PcBtnPlace, PCInputModel.Activity.room, PCInputModel.RoomActivityFun.place)
	PCInputController.instance:showkeyTips(self._PcBtnEdit, PCInputModel.Activity.room, PCInputModel.RoomActivityFun.edit)
	PCInputController.instance:showkeyTips(self._PcBtnHide, PCInputModel.Activity.room, PCInputModel.RoomActivityFun.hide)
end

function RoomView:_btneditOnClick()
	local layoutMO = RoomLayoutModel.instance:getById(RoomEnum.LayoutUsedPlanId)

	if layoutMO and layoutMO:isSharing() then
		GameFacade.showMessageBox(MessageBoxIdDefine.RoomEditShareLayoutPlan, MsgBoxEnum.BoxType.Yes_No, self._onEnterRoomEdit, nil, nil, self, nil, nil)

		return
	end

	self:_onEnterRoomEdit()
end

function RoomView:_onEnterRoomEdit()
	RoomController.instance:enterRoom(RoomEnum.GameMode.Edit)
end

function RoomView:_btncharacterOnClick()
	if RoomEnum.UseAStarPath and ZProj.AStarPathBridge.IsAStarInProgress() then
		self.MaxCheckAStarCount = 5
		self._checkAStarCount = 0

		TaskDispatcher.runRepeat(self._checkAStarFinish, self, 0.5, self.MaxCheckAStarCount)
		UIBlockMgr.instance:startBlock(UIBlockKey.RoomAStarScan)
		logNormal("astar扫描中，完成后再打开角色界面")
	else
		RoomCharacterController.instance:setCharacterListShow(true)
	end
end

function RoomView:_checkAStarFinish()
	self._checkAStarCount = self._checkAStarCount + 1

	if self._checkAStarCount >= self.MaxCheckAStarCount or not ZProj.AStarPathBridge.IsAStarInProgress() then
		logNormal("astar扫描完成，打开角色界面")
		TaskDispatcher.cancelTask(self._checkAStarFinish, self)
		UIBlockMgr.instance:endBlock(UIBlockKey.RoomAStarScan)
		RoomCharacterController.instance:setCharacterListShow(true)
	end
end

function RoomView:_btntrackingOnClick()
	local targetState = RoomEnum.CameraState.Overlook
	local targetX, targetY = 0, 0
	local isInFishing = FishingModel.instance:isInFishing()

	if isInFishing then
		local buildingList = RoomMapBuildingModel.instance:getBuildingListByType(RoomBuildingEnum.BuildingType.Fishing)

		if buildingList then
			for _, buildingMO in ipairs(buildingList) do
				local belongUserId = buildingMO:getBelongUserId()
				local myUserId = PlayerModel.instance:getMyUserId()

				if belongUserId and belongUserId == myUserId then
					local pos = HexMath.hexToPosition(buildingMO.hexPoint, RoomBlockEnum.BlockSize)

					targetX = pos.x
					targetY = pos.y

					break
				end
			end
		end

		targetState = RoomEnum.CameraState.OverlookAll
	end

	local cameraFocus = self._scene.camera:getCameraFocus()

	if self._scene.camera:getCameraState() == targetState and math.abs(cameraFocus.x - targetX) < 0.1 and math.abs(cameraFocus.y - targetY) < 0.1 then
		GameFacade.showToast((isInFishing or nil) and ToastEnum.ClickRoomFishingTracking)

		return
	end

	self._scene.camera:switchCameraState(targetState, {
		focusX = targetX,
		focusY = targetY
	})
end

function RoomView:_btndialogOnClick()
	RoomCharacterController.instance:trynextDialogInteraction()
end

function RoomView:_btnhideOnClick()
	if RoomMapController.instance:isUIHide() then
		RoomMapController.instance:setUIHide(false)
	else
		RoomMapController.instance:setUIHide(true)
	end
end

function RoomView:_btnstoreOnClick()
	local isCanOpen = StoreController.instance:checkAndOpenStoreView(StoreEnum.StoreId.RoomStore)

	if isCanOpen then
		RoomMapController.instance:dispatchEvent(RoomEvent.BlockAtmosphereEffect)
	end
end

function RoomView:_btnlayoutplanOnClick()
	local isCanOpen = RoomLayoutController.instance:openView()

	if isCanOpen then
		RoomMapController.instance:dispatchEvent(RoomEvent.BlockAtmosphereEffect)
	end
end

function RoomView:_btnlayoutcopyOnClick()
	if RoomLayoutController.instance:isOpen(true) then
		RoomLayoutController.instance:openCopyView()
	end
end

function RoomView:_btnexpandManufactureOnClick()
	local oldManuExpand = ManufactureModel.instance:getExpandManufactureBtn()

	ManufactureModel.instance:setExpandManufactureBtn(not oldManuExpand)
	self:_refreshManufactureExpand(true)
end

function RoomView:_btnRecordOnClick()
	ManufactureController.instance:openRoomRecordView()
end

function RoomView:_btnCritterOnClick()
	ManufactureController.instance:openCritterBuildingView()
end

function RoomView:_btnOverviewOnClick()
	ManufactureController.instance:openOverView()
end

function RoomView:_btnTradeOnClick()
	ManufactureController.instance:openRoomTradeView()
end

function RoomView:_btnWarehouseOnClick()
	ManufactureController.instance:openRoomBackpackView()
end

function RoomView:_btnfishingOnClick()
	FishingController.instance:enterFishingMode()
end

function RoomView:_show(viewName)
	if self:_isHasNeedHideView() then
		return
	end

	if self:_isCheckHideView(viewName) then
		self:_hideView()
	else
		self._animator:Play("show")
	end
end

function RoomView:_hide(viewName)
	if self:_isHasNeedHideView() then
		return
	end

	self._animator:Play("hide")
end

function RoomView._resetYesCallback()
	RoomMapController.instance:resetRoom()
end

function RoomView._confirmYesCallback()
	RoomMapController.instance:confirmRoom()
end

function RoomView:_revertYesCallback()
	RoomMapController.instance:revertRoom()
end

function RoomView:_listViewShowChanged()
	self:_refreshBtnShow()
end

function RoomView:_updateCharacterInteractionUI()
	self:_refreshBtnShow()
	self:_updateNavigateButtonShow()
end

function RoomView:_updateNavigateButtonShow(param)
	local isBuildingListShow = RoomBuildingController.instance:isBuildingListShow()
	local isDebugPlaceListShow = RoomDebugController.instance:isDebugPlaceListShow()
	local isDebugPackageListShow = RoomDebugController.instance:isDebugPackageListShow()
	local isDebugBuildingListShow = RoomDebugController.instance:isDebugBuildingListShow()
	local isBackBlockShow = RoomMapBlockModel.instance:isBackMore()
	local isWaterReform = RoomWaterReformModel.instance:isWaterReform()
	local isInDialogInteraction = RoomCharacterHelper.isInDialogInteraction()
	local isRoomInitBuildingViewShow = RoomMapController.instance:isInRoomInitBuildingViewCamera()
	local isTransportPath = RoomTransportController.instance:isTransportPathShow() or RoomTransportController.instance:isTransportSitShow()
	local isInteractBuildingShow = ViewMgr.instance:isOpen(ViewName.RoomInteractBuildingView)
	local isCritterBuildingShow, isManufactureBuildingShow

	if param and type(param) == "table" then
		isCritterBuildingShow = param.inCritterBuildingView or ViewMgr.instance:isOpen(ViewName.RoomCritterBuildingView)
		isManufactureBuildingShow = param.inManufactureBuildingView or ViewMgr.instance:isOpen(ViewName.RoomManufactureBuildingView)
	else
		isCritterBuildingShow = ViewMgr.instance:isOpen(ViewName.RoomCritterBuildingView)
		isManufactureBuildingShow = ViewMgr.instance:isOpen(ViewName.RoomManufactureBuildingView)
	end

	self.viewContainer:setNavigateButtonShow(not isDebugPlaceListShow and not isDebugPackageListShow and not isDebugBuildingListShow and not isBackBlockShow and not isInDialogInteraction and not isRoomInitBuildingViewShow and not isWaterReform and not isTransportPath and not isInteractBuildingShow and not isCritterBuildingShow and not isManufactureBuildingShow)
end

function RoomView:_addBtnAudio()
	gohelper.addUIClickAudio(self._btnedit.gameObject, AudioEnum.UI.UI_vertical_first_tabs_click)
end

function RoomView:_refreshBtnShow()
	local isBuildingListShow = RoomBuildingController.instance:isBuildingListShow()
	local isDebugPlaceListShow = RoomDebugController.instance:isDebugPlaceListShow()
	local isDebugPackageListShow = RoomDebugController.instance:isDebugPackageListShow()
	local isDebugBuildingListShow = RoomDebugController.instance:isDebugBuildingListShow()
	local isCharacterListShow = RoomCharacterController.instance:isCharacterListShow()
	local isListShow = isBuildingListShow or isDebugPlaceListShow or isDebugPackageListShow or isDebugBuildingListShow or isCharacterListShow
	local isInDialogInteraction = RoomCharacterHelper.isInDialogInteraction()
	local isObMode = RoomController.instance:isObMode()
	local isFishingMode = RoomController.instance:isFishingMode()

	gohelper.setActive(self._simagemaskbg, not RoomController.instance:isEditMode())
	gohelper.setActive(self._btnedit.gameObject, isObMode and not isInDialogInteraction and (not isListShow or isCharacterListShow))

	if self._btnedit.gameObject.activeSelf then
		RedDotController.instance:addRedDot(self._goeditreddot, RedDotEnum.DotNode.RoomEditBtn)
	end

	gohelper.setActive(self._btnhide.gameObject, isObMode and not isCharacterListShow and not isInDialogInteraction)
	gohelper.setActive(self._btncharacter.gameObject, isObMode and not isInDialogInteraction and (not isListShow or isCharacterListShow))

	local var_32_0 = self._gobtncamera
	local var_32_1

	if (isObMode or isFishingMode) and not isInDialogInteraction then
		if isListShow then
			if not isCharacterListShow then
				::label_32_0::

				var_32_1 = RoomController.instance:isVisitMode() or RoomController.instance:isDebugMode()

				goto label_32_1
			end
		end
	end

	::label_32_1::

	gohelper.setActive(var_32_0, true)
	gohelper.setActive(self._btntracking.gameObject, (isObMode or isFishingMode) and not isInDialogInteraction and (not isListShow or isCharacterListShow))

	local trackLangId = "p_roomview_tracking"
	local trackIcon = "xw_dingweishuniu_icon1"

	if isFishingMode then
		trackLangId = "p_roomview_fishing_tracking"
		trackIcon = "roomfish_locatebn"
	end

	self._txttracking.text = luaLang(trackLangId)

	UISpriteSetMgr.instance:setRoomSprite(self._imagetracking, trackIcon, true)
	gohelper.setActive(self._btndialog.gameObject, isObMode and isInDialogInteraction and not isListShow)
	gohelper.setActive(self._btnstore.gameObject, isObMode and not isInDialogInteraction and (not isListShow or isCharacterListShow))
	gohelper.setActive(self._gobtnfishingResources, isFishingMode and not isInDialogInteraction and (not isListShow or isCharacterListShow))

	local showLayoutplan = not isInDialogInteraction and isObMode

	self._isShowLayoutplan = showLayoutplan and not isListShow

	gohelper.setActive(self._btnlayoutplan, showLayoutplan and (not isListShow or isCharacterListShow))

	local isInteractBuildingShow = ViewMgr.instance:isOpen(ViewName.RoomInteractBuildingView)
	local notReview = not VersionValidator.instance:isInReviewing()

	self._isShowManufactureBtn = notReview and isObMode and not isListShow and not isInDialogInteraction and not isInteractBuildingShow

	self:_checkManufactureUnlock()

	self._isShowRoomFishingBtn = isObMode and not isListShow and not isInDialogInteraction and not isInteractBuildingShow

	self:_checkRoomFishingShow()

	local visitParam = RoomModel.instance:getVisitParam()
	local var_32_2 = self._btnlayoutcopy
	local var_32_3

	if not RoomEnum.IsCloseLayouCopy then
		var_32_3 = RoomController.instance:isVisitMode()

		if var_32_3 and visitParam then
			::label_32_2::

			var_32_3 = visitParam.userId and SocialModel.instance:isMyFriendByUserId(visitParam.userId)

			goto label_32_3
		end
	end

	var_32_3 = true

	::label_32_3::

	gohelper.setActive(var_32_2, var_32_3)

	if RoomController.instance:isDebugMode() then
		ViewMgr.instance:openView(ViewName.RoomDebugView)
	end

	if self._isShowLayoutplan then
		self:_layoutPlanUnLockAnim()
	end

	if VersionValidator.instance:isInReviewing() then
		gohelper.setActive(self._btnstore, false)
	end

	self:_refreshTradeBtn()
end

function RoomView:_switchScene()
	self._animator:Play("xiaoshi", 0, 0)
end

function RoomView:_onSelectBlockOpTab(tabIndex)
	if not tabIndex then
		return
	end

	local isValid = false

	for _, modeIndex in pairs(RoomEnum.RoomViewBlockOpMode) do
		if modeIndex == tabIndex then
			isValid = true

			break
		end
	end

	if isValid then
		self.viewContainer:selectBlockOpTab(tabIndex)
	end
end

function RoomView:onOpen()
	self:_refreshBtnShow()
	self:_addBtnAudio()
	self.addEventCb(self, RoomBuildingController.instance, RoomEvent.BuildingListShowChanged, self._listViewShowChanged, self)
	self.addEventCb(self, RoomDebugController.instance, RoomEvent.DebugPlaceListShowChanged, self._listViewShowChanged, self)
	self.addEventCb(self, RoomDebugController.instance, RoomEvent.DebugPackageListShowChanged, self._listViewShowChanged, self)
	self.addEventCb(self, RoomDebugController.instance, RoomEvent.DebugBuildingListShowChanged, self._listViewShowChanged, self)
	self.addEventCb(self, RoomCharacterController.instance, RoomEvent.CharacterListShowChanged, self._listViewShowChanged, self)
	self.addEventCb(self, RoomMapController.instance, RoomEvent.BackBlockShowChanged, self._listViewShowChanged, self)
	self.addEventCb(self, RoomWaterReformController.instance, RoomEvent.WaterReformShowChanged, self._listViewShowChanged, self)
	self.addEventCb(self, RoomMapController.instance, RoomEvent.InteractBuildingShowChanged, self._listViewShowChanged, self)
	self.addEventCb(self, RoomMapController.instance, RoomEvent.BackBlockShowChanged, self._updateNavigateButtonShow, self)
	self.addEventCb(self, RoomWaterReformController.instance, RoomEvent.WaterReformShowChanged, self._updateNavigateButtonShow, self)
	self.addEventCb(self, RoomBuildingController.instance, RoomEvent.RefreshNavigateButton, self._updateNavigateButtonShow, self)
	self.addEventCb(self, RoomBuildingController.instance, RoomEvent.BuildingListShowChanged, self._updateNavigateButtonShow, self)
	self.addEventCb(self, RoomDebugController.instance, RoomEvent.DebugPlaceListShowChanged, self._updateNavigateButtonShow, self)
	self.addEventCb(self, RoomDebugController.instance, RoomEvent.DebugPackageListShowChanged, self._updateNavigateButtonShow, self)
	self.addEventCb(self, RoomDebugController.instance, RoomEvent.DebugBuildingListShowChanged, self._updateNavigateButtonShow, self)
	self.addEventCb(self, RoomCharacterController.instance, RoomEvent.CharacterListShowChanged, self._updateNavigateButtonShow, self)
	self.addEventCb(self, RoomMapController.instance, RoomEvent.TransportPathViewShowChanged, self._updateNavigateButtonShow, self)
	self.addEventCb(self, RoomMapController.instance, RoomEvent.TransportSiteViewShowChanged, self._updateNavigateButtonShow, self)
	self.addEventCb(self, RoomMapController.instance, RoomEvent.InteractBuildingShowChanged, self._updateNavigateButtonShow, self)
	self.addEventCb(self, ManufactureController.instance, ManufactureEvent.ManufactureBuildingViewChange, self._updateNavigateButtonShow, self)
	self.addEventCb(self, CritterController.instance, CritterEvent.CritterBuildingViewChange, self._updateNavigateButtonShow, self)
	self.addEventCb(self, RoomController.instance, RoomEvent.SwitchScene, self._switchScene, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self.addEventCb(self, RoomMapController.instance, RoomEvent.WillOpenRoomInitBuildingView, self._willOpenRoomInitBuildingView, self)
	self.addEventCb(self, RoomCharacterController.instance, RoomEvent.UpdateCharacterInteractionUI, self._updateCharacterInteractionUI, self)
	self.addEventCb(self, RoomMapController.instance, RoomEvent.ShowUI, self._show, self)
	self.addEventCb(self, RoomMapController.instance, RoomEvent.HideUI, self._hide, self)
	self.addEventCb(self, RoomMapController.instance, RoomEvent.UpdateRoomLevel, self._updateRoomLevel, self)
	self.addEventCb(self, RoomMapController.instance, RoomEvent.SelectRoomViewBlockOpTab, self._onSelectBlockOpTab, self)
	self.addEventCb(self, PCInputController.instance, PCInputEvent.NotifyHide, self._btnhideOnClick, self)
	self.addEventCb(self, PCInputController.instance, PCInputEvent.NotifyEdit, self._btneditOnClick, self)
	self.addEventCb(self, PCInputController.instance, PCInputEvent.NotifyPlace, self._btncharacterOnClick, self)
	self.addEventCb(self, PCInputController.instance, PCInputEvent.Notifylocate, self._btntrackingOnClick, self)
	self.addEventCb(self, PCInputController.instance, PCInputEvent.NotifyBuy, self._btnstoreOnClick, self)
	self.addEventCb(self, PCInputController.instance, PCInputEvent.NotifyLayout, self._btnlayoutplanOnClick, self)
	self.addEventCb(self, CritterController.instance, CritterEvent.onEnterCritterBuildingView, self._hideView, self)
	self.addEventCb(self, ManufactureController.instance, ManufactureEvent.OnEnterManufactureBuildingView, self._hideView, self)
	self.addEventCb(self, RoomController.instance, RoomEvent.NewLog, self._showLogTips, self)
	OpenController.instance:registerCallback(OpenEvent.NewFuncUnlock, self._onNewFuncUnlock, self)
	self.addEventCb(self, RoomTradeController.instance, RoomTradeEvent.OnTradeLevelUpReply, self._refreshTradeBtn, self)
	self.addEventCb(self, RoomController.instance, RoomEvent.ManufactureExpand, self._onManufactureExpand, self)

	if RoomController.instance:isObMode() then
		RoomRpc.instance:sendGetRoomLogRequest()
	end

	if ViewMgr.instance:isOpen(ViewName.RoomInitBuildingView) then
		self:_hideView()
	end

	self:_refreshManufactureExpand()
	self:_addReddot()
	Activity186Model.instance:checkReadTasks({
		Activity186Enum.ReadTaskId.Task1,
		Activity186Enum.ReadTaskId.Task2,
		Activity186Enum.ReadTaskId.Task3
	})
end

function RoomView:onOpenFinish()
	self:_refreshTradeBtn()
end

function RoomView:_addReddot()
	RedDotController.instance:addRedDot(self._goManufactureEntranceReddot, RedDotEnum.DotNode.ManufactureEntrance)
	RedDotController.instance:addRedDot(self._goRecordReddot, RedDotEnum.DotNode.RecordEntrance)
	RedDotController.instance:addRedDot(self._goCritterReddot, RedDotEnum.DotNode.CritterEntrance)
	RedDotController.instance:addRedDot(self._goOverviewReddot, RedDotEnum.DotNode.OverviewEntrance)
	RedDotController.instance:addRedDot(self._goTradeReddot, RedDotEnum.DotNode.TradeEntrance)
	RedDotController.instance:addRedDot(self._goWarehouseReddot, RedDotEnum.DotNode.RoomBackpackEntrance)
end

function RoomView:_onOpenView(viewName)
	if self:_isCheckHideView(viewName) then
		self:_hideView()
	end
end

function RoomView:_onCloseView(viewName)
	if self:_isCheckHideView(viewName) and not self:_isHasNeedHideView() then
		self:_showView()
		self:_layoutPlanUnLockAnim()
		self:_checkManufactureUnlock()
	end

	if viewName == ViewName.RoomManufactureGetView then
		local isOpenOverView = ViewMgr.instance:isOpen(ViewName.RoomOverView)
		local isOpenManufactureView = ViewMgr.instance:isOpen(ViewName.RoomManufactureBuildingView)
		local isExpand = ManufactureModel.instance:getExpandManufactureBtn()

		if self._isShowManufactureBtn and not isOpenOverView and not isOpenManufactureView and isExpand then
			self._warehouseAnimator:Play("charge", 0, 0)
			AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_shouji2)
		end
	end
end

function RoomView:_isCheckHideView(viewName)
	if self._showHideViewNameDict[viewName] then
		return true
	end

	return false
end

function RoomView:_isHasNeedHideView()
	for i = 1, #self._showHideViewNameList do
		if ViewMgr.instance:isOpen(self._showHideViewNameList[i]) then
			return true
		end
	end

	return false
end

function RoomView:_willOpenRoomInitBuildingView()
	self:_hideView()
end

function RoomView:_updateRoomLevel()
	self:_refreshLayoutPlan()
end

function RoomView:_refreshLayoutPlan()
	local isOpen = RoomLayoutController.instance:isOpen()

	gohelper.setActive(self._golayoutplanUnlock, isOpen)
	gohelper.setActive(self._golayoutplanLock, not isOpen)
	gohelper.setActive(self._golayoutcopyUnlock, isOpen)
	gohelper.setActive(self._golayoutcopyLock, not isOpen)
	self:_layoutPlanUnLockAnim()
end

function RoomView:_layoutPlanUnLockAnim()
	if self._isShowLayoutplan and RoomLayoutController.instance:isOpen() and not RoomLayoutModel.instance:getPlayUnLock() and not ViewMgr.instance:isOpen(ViewName.RoomInitBuildingView) then
		self._layoutplanAnimator:Play("unlock", 0, 0)
		RoomLayoutModel.instance:setPlayUnLock(true)
	end
end

function RoomView:_refreshManufactureExpand(playAnim)
	self._warehouseAnimator:Play("idle", 0, 0)

	local isExpand = ManufactureModel.instance:getExpandManufactureBtn()

	if isExpand then
		if not UIAnimationName.Open then
			local animName = UIAnimationName.Close

			if playAnim then
				self._manufactureAnimator:Play(animName, 0, 0)
			else
				self._manufactureAnimator:Play(animName, 0, 1)
			end
		end
	end
end

function RoomView:_hideView()
	self._animator:Play(UIAnimationName.Close)
end

function RoomView:_showView()
	self._animator:Play(UIAnimationName.Open)
end

function RoomView:_refreshTradeBtn()
	local isManufactureUnlock = ManufactureModel.instance:isManufactureUnlock()
	local openLevel = RoomTradeTaskModel.instance:getOpenOrderLevel()
	local isShow = openLevel <= ((isManufactureUnlock or nil) and ManufactureModel.instance:getTradeLevel())

	gohelper.setActive(self._btnTrade.gameObject, isShow)

	if isShow and RoomTradeModel.instance:isCanPlayTradeEnterBtnUnlockAnim() then
		self._tradeBtnAnimator = self._tradeBtnAnimator or SLFramework.AnimatorPlayer.Get(self._btnTrade.gameObject)

		self._tradeBtnAnimator:Play(RoomTradeEnum.TradeAnim.Unlock, nil, self)
		RoomTradeModel.instance:setPlayTradeEnterBtnUnlockAnim()
	end
end

function RoomView:_showLogTips(logInfo)
	self._haveLog = true

	gohelper.setActive(self._gologtip, true)

	local temp = string.split(logInfo.config.extraBonus, "#")
	local stickerpath = temp[2]

	if stickerpath then
		self._simagesticker:LoadImage(ResUrl.getPropItemIcon(stickerpath))
	end

	self._txtlogdesc.text = logInfo.logConfigList[1].content

	TaskDispatcher.runDelay(self._closeLogTips, self, 6)
end

function RoomView:_closeLogTips()
	self._haveLog = false

	gohelper.setActive(self._gologtip, false)
	RoomRpc.instance:sendReadRoomLogNewRequest()
end

function RoomView:_openLogView()
	ViewMgr.instance:openView(ViewName.RoomRecordView, RoomRecordEnum.View.Log)
	self:_closeLogTips()
end

function RoomView:_onManufactureExpand(param)
	local mode = tonumber(param)

	if mode == 1 then
		ManufactureModel.instance:setExpandManufactureBtn(false)
		self:_refreshManufactureExpand()
	elseif mode == 2 then
		ManufactureModel.instance:setExpandManufactureBtn(true)
		self:_refreshManufactureExpand()
	elseif mode == 3 then
		-- block empty
	end
end

function RoomView:_onNewFuncUnlock()
	self:_checkManufactureUnlock()
	self:_checkRoomFishingShow()
end

function RoomView:_checkManufactureUnlock()
	ManufactureController.instance:getManufactureServerInfo()

	local isUnlock = ManufactureModel.instance:isManufactureUnlock()

	gohelper.setActive(self._gobtnexpandManufacture, isUnlock and self._isShowManufactureBtn)
	self:_refreshManufactureExpand()

	local isPlay = ManufactureModel.instance:getPlayManufactureUnlock()
	local isOpenInitBuildingView = ViewMgr.instance:isOpen(ViewName.RoomInitBuildingView)

	if self._isShowManufactureBtn and isUnlock and not isPlay and not isOpenInitBuildingView then
		self._manufactureAnimator:Play("unlock", 0, 0)
		ManufactureModel.instance:setPlayManufactureUnlock(true)
	end
end

function RoomView:_checkRoomFishingShow()
	local isUnlock = FishingModel.instance:isUnlockRoomFishing()

	gohelper.setActive(self._btnfishing, isUnlock and self._isShowRoomFishingBtn)
end

function RoomView:onClose()
	TaskDispatcher.cancelTask(self._checkAStarFinish, self)
	TaskDispatcher.cancelTask(self._closeLogTips, self)
	UIBlockMgr.instance:endBlock(UIBlockKey.RoomAStarScan)
	ViewMgr.instance:closeView(ViewName.RoomDebugView)
	self.removeEventCb(self, PCInputController.instance, PCInputEvent.NotifyHide, self._btnhideOnClick, self)
	self.removeEventCb(self, PCInputController.instance, PCInputEvent.NotifyEdit, self._btneditOnClick, self)
	self.removeEventCb(self, PCInputController.instance, PCInputEvent.NotifyPlace, self._btncharacterOnClick, self)
	self.removeEventCb(self, PCInputController.instance, PCInputEvent.Notifylocate, self._btntrackingOnClick, self)
	self.removeEventCb(self, PCInputController.instance, PCInputEvent.NotifyBuy, self._btnstoreOnClick, self)
	self.removeEventCb(self, PCInputController.instance, PCInputEvent.NotifyLayout, self._btnlayoutplanOnClick, self)
	self.removeEventCb(self, CritterController.instance, CritterEvent.onEnterCritterBuildingView, self._hideView, self)
	self.removeEventCb(self, RoomController.instance, RoomEvent.NewLog, self._showLogTips, self)
	OpenController.instance:unregisterCallback(OpenEvent.NewFuncUnlock, self._onNewFuncUnlock, self)
	self.removeEventCb(self, RoomTradeController.instance, RoomTradeEvent.OnTradeLevelUpReply, self._refreshTradeBtn, self)
	self.removeEventCb(self, RoomController.instance, RoomEvent.ManufactureExpand, self._onManufactureExpand, self)
end

function RoomView:onDestroyView()
	self._simagemaskbg:UnLoadImage()
	self._btnedit:RemoveClickListener()
	self._btncharacter:RemoveClickListener()
	self._btntracking:RemoveClickListener()
	self._btndialog:RemoveClickListener()
	self._btnhide:RemoveClickListener()
	self._btnstore:RemoveClickListener()
	self._btnlayoutplan:RemoveClickListener()
	self._btnlayoutcopy:RemoveClickListener()
	self._btnexpandManufacture:RemoveClickListener()
	self._btngoto:RemoveClickListener()
end

return RoomView
