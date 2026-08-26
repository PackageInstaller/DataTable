-- chunkname: @modules/logic/room/view/RoomInventorySelectView.lua

module("modules.logic.room.view.RoomInventorySelectView", package.seeall)

local RoomInventorySelectView = class("RoomInventorySelectView", BaseView)

function RoomInventorySelectView:onInitView()
	self._gonoblurmask = gohelper.findChild(self.viewGO, "#go_noblurmask")
	self._goblurmask = gohelper.findChild(self.viewGO, "#go_blurmask")
	self._goitem = gohelper.findChild(self.viewGO, "go_content/#go_item")
	self._gofinished = gohelper.findChild(self.viewGO, "go_content/#go_finished")
	self._imagerare = gohelper.findChildImage(self.viewGO, "go_content/go_count/#image_rare")
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "go_content/go_count/#simage_icon")
	self._txtname = gohelper.findChildText(self.viewGO, "go_content/go_count/#txt_name")
	self._btnpackage = gohelper.findChildButtonWithAudio(self.viewGO, "go_content/go_count/#btn_package")
	self._goreddot = gohelper.findChild(self.viewGO, "go_content/go_count/#btn_package/#go_reddot")
	self._txtnum = gohelper.findChildText(self.viewGO, "go_content/go_count/#txt_num")
	self._txtdegree = gohelper.findChildText(self.viewGO, "go_content/go_count/#txt_degree")
	self._goreclaimtips = gohelper.findChild(self.viewGO, "go_content/#go_reclaimtips")
	self._gototalitem = gohelper.findChild(self.viewGO, "go_content/filterswitch/rescontent/#go_totalitem")
	self._btntheme = gohelper.findChildButtonWithAudio(self.viewGO, "go_content/#btn_theme")
	self._gounfold = gohelper.findChild(self.viewGO, "#go_unfold")
	self._btnback = gohelper.findChildButtonWithAudio(self.viewGO, "#go_unfold/#btn_back")
	self._btnreset = gohelper.findChildButtonWithAudio(self.viewGO, "#go_unfold/#btn_reset")
	self._btnstore = gohelper.findChildButtonWithAudio(self.viewGO, "#go_unfold/#btn_store")
	self._btnreform = gohelper.findChildButtonWithAudio(self.viewGO, "#go_unfold/#btn_reform")
	self._btntransportPath = gohelper.findChildButtonWithAudio(self.viewGO, "#go_unfold/#btn_transportPath")
	self._goswitch = gohelper.findChild(self.viewGO, "#go_switch")
	self._btnbuilding = gohelper.findChildButtonWithAudio(self.viewGO, "#go_switch/#btn_building")
	self._gobuildingreddot = gohelper.findChild(self.viewGO, "#go_switch/#btn_building/#go_buildingreddot")
	self._btnblock = gohelper.findChildButtonWithAudio(self.viewGO, "#go_switch/#btn_block")
	self._goblockreddot = gohelper.findChild(self.viewGO, "#go_switch/#btn_block/#go_blockreddot")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomInventorySelectView:addEvents()
	self._btnpackage:AddClickListener(self._btnpackageOnClick, self)
	self._btntheme:AddClickListener(self._btnthemeOnClick, self)
	self._btnback:AddClickListener(self._btnbackOnClick, self)
	self._btnreset:AddClickListener(self._btnresetOnClick, self)
	self._btnstore:AddClickListener(self._btnstoreOnClick, self)
	self._btnreform:AddClickListener(self._btnreformOnClick, self)
	self._btntransportPath:AddClickListener(self._btntransportPathOnClick, self)
	self._btnbuilding:AddClickListener(self._btnbuildingOnClick, self)
	self._btnblock:AddClickListener(self._btnblockOnClick, self)
end

function RoomInventorySelectView:removeEvents()
	self._btnpackage:RemoveClickListener()
	self._btntheme:RemoveClickListener()
	self._btnback:RemoveClickListener()
	self._btnreset:RemoveClickListener()
	self._btnstore:RemoveClickListener()
	self._btnreform:RemoveClickListener()
	self._btntransportPath:RemoveClickListener()
	self._btnbuilding:RemoveClickListener()
	self._btnblock:RemoveClickListener()
end

function RoomInventorySelectView:_btntransportPathOnClick()
	self:_openTransportPathView()
end

function RoomInventorySelectView:_btnthemeOnClick()
	RoomController.instance:openThemeFilterView(true)
end

function RoomInventorySelectView:_btnbuildingOnClick(notPlayAudio)
	local isShowBuildingList = RoomBuildingController.instance:isBuildingListShow()

	if not isShowBuildingList and not notPlayAudio then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_feedback_close)
	end

	RoomBuildingController.instance:setBuildingListShow(true)
	self:_setSwithBtnSelectId(2)

	if self._firstObtainBuilding == RoomEnum.ObtainReadState.FristObtain then
		self:_setFristStateByKey(PlayerPrefsKey.RoomFirstObtainBuildingShow, RoomEnum.ObtainReadState.ClickToView)
		self:_refreshFristEffect()
	end

	RoomController.instance:dispatchEvent(RoomEvent.GuideRoomInventoryBuilding)
end

function RoomInventorySelectView:_btnblockOnClick()
	if RoomBuildingController.instance:isBuildingListShow() then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_feedback_close)
	end

	RoomBuildingController.instance:setBuildingListShow(false)
	self:_setSwithBtnSelectId(1)
end

function RoomInventorySelectView:_guideSwitchBlockTab()
	RoomBuildingController.instance:setBuildingListShow(false)
	self:_setSwithBtnSelectId(1)
end

function RoomInventorySelectView:_btnresetOnClick()
	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.RoomForbidBtn) then
		GameFacade.showToast(RoomEnum.GuideForbidEscapeToast)
	else
		GameFacade.showMessageBox(MessageBoxIdDefine.RoomReset, MsgBoxEnum.BoxType.Yes_No, RoomInventorySelectView._resetYesCallback)
	end
end

function RoomInventorySelectView:_btnmoreOnClick()
	self._isShowMoreBtn = self._isShowMoreBtn == false

	gohelper.setActive(self._gounfold, self._isShowMoreBtn)
end

function RoomInventorySelectView:_btnconfirmOnClick()
	RoomInventorySelectView.confirmYesCallback()
end

function RoomInventorySelectView:_btnpackageOnClick()
	ViewMgr.instance:openView(ViewName.RoomBlockPackageView)

	if self._firstObtainPackage == RoomEnum.ObtainReadState.FristObtain then
		self:_setFristStateByKey(PlayerPrefsKey.RoomFirstObtainBlockPackageShow, RoomEnum.ObtainReadState.ClickToView)
		self:_refreshFristEffect()
	end
end

function RoomInventorySelectView:_btnbackOnClick()
	if RoomBuildingController.instance:isBuildingListShow() then
		RoomBuildingController.instance:setBuildingListShow(false, true)
		self:_setSwithBtnSelectId(1)
	end

	RoomMapController.instance:switchBackBlock(true)
end

function RoomInventorySelectView:_btnstoreOnClick()
	RoomInventorySelectView.tryConfirmAndToStore()
end

function RoomInventorySelectView.tryConfirmAndToStore()
	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.RoomForbidBtn) then
		GameFacade.showToast(RoomEnum.GuideForbidEscapeToast)
	elseif RoomMapController.instance:isResetEdit() then
		GameFacade.showMessageBox(MessageBoxIdDefine.RoomConfirm, MsgBoxEnum.BoxType.Yes_No, RoomInventorySelectView._confirmYesCallback)
	else
		RoomInventorySelectView._confirmYesCallback()
	end
end

function RoomInventorySelectView._confirmYesCallback()
	if RoomMapController.instance:isNeedConfirmRoom() then
		RoomMapController.instance:confirmRoom(RoomInventorySelectView._confirmCallback)
	else
		RoomInventorySelectView._confirmCallback()
	end
end

function RoomInventorySelectView._confirmCallback()
	StoreController.instance:checkAndOpenStoreView(StoreEnum.StoreId.RoomStore)
end

function RoomInventorySelectView:_btnreformOnClick()
	if RoomBuildingController.instance:isBuildingListShow() then
		RoomBuildingController.instance:setBuildingListShow(false, true)
		self:_setSwithBtnSelectId(1)
	end

	RoomMapController.instance:switchWaterReform(true)
end

function RoomInventorySelectView:_editableInitView()
	self.showAnimName = nil
	self._gocontent = gohelper.findChild(self.viewGO, "go_content")
	self._gobtns = gohelper.findChild(self.viewGO, "btns")
	self._itemParentGO = gohelper.findChild(self.viewGO, "go_content/#hand_inventory")
	self._scrollblock = gohelper.findChildScrollRect(self.viewGO, "go_content/scroll_block")
	self._simagedegree = gohelper.findChildImage(self.viewGO, "go_content/go_count/#txt_degree/coin")
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._scrollblockTrs = self._scrollblock.transform
	self._gocontentTrs = self._gocontent.transform
	self._gocount = gohelper.findChild(self.viewGO, "go_content/go_count")
	self._govxchickdown = gohelper.findChild(self.viewGO, "go_content/go_count/vx_click_down")
	self._govxchilckup = gohelper.findChild(self.viewGO, "go_content/go_count/vx_click_up")

	local tgonormal = gohelper.findChild(self.viewGO, "#go_switch/#btn_building/go_normal")

	self._animbuilding = tgonormal:GetComponent(typeof(UnityEngine.Animator))

	if self._btntheme then
		local themeGO = self._btntheme.gameObject

		self._gothemeSelect = gohelper.findChild(themeGO, "go_select")
		self._gothemeUnSelect = gohelper.findChild(themeGO, "go_unselect")
	end

	self._scrollLeft = 191
	self._scrollRight = 41
	self._scrollRight2 = 335
	self._blockBuildDegree = 0

	if RoomController.instance:isEditMode() then
		self._initRT = true

		OrthCameraRTMgr.instance:initRT()
	end

	self:_createSwithBtnUserDataTb_(self._btnblock.gameObject, 1)
	self:_createSwithBtnUserDataTb_(self._btnbuilding.gameObject, 2)
	gohelper.setActive(self._goitem, false)
	UISpriteSetMgr.instance:setRoomSprite(self._simagedegree, "jianshezhi")
	RedDotController.instance:addRedDot(self._goreddot, RedDotEnum.DotNode.RoomBlockPackageBtn)
	gohelper.setActive(self._btnstore.gameObject, OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Bank))
	self:_setSwithBtnSelectId(1)
	gohelper.removeUIClickAudio(self._btnblock.gameObject)
	gohelper.removeUIClickAudio(self._btnbuilding.gameObject)
	self:_initResList()
end

function RoomInventorySelectView:_createSwithBtnUserDataTb_(goItem, id)
	local tb = self:getUserDataTb_()

	tb._go = goItem
	tb._id = id
	tb._goselect = gohelper.findChild(goItem, "go_select")
	tb._gonormal = gohelper.findChild(goItem, "go_normal")
	self._switchBtnUserDataTbs = self._switchBtnUserDataTbs or {}

	table.insert(self._switchBtnUserDataTbs, tb)

	return tb
end

function RoomInventorySelectView:_setSwithBtnSelectId(id)
	for i = 1, #self._switchBtnUserDataTbs do
		local tb = self._switchBtnUserDataTbs[i]

		gohelper.setActive(tb._goselect, id == tb._id)
		gohelper.setActive(tb._gonormal, id ~= tb._id)
	end
end

function RoomInventorySelectView:_initResList()
	if not self._resDataList then
		local landExcludes = {
			RoomResourceEnum.ResourceId.River
		}

		tabletool.addValues(landExcludes, RoomResourceEnum.ResourceRoadList)

		self._resDataList = {
			{
				isPackage = true,
				nameLanguage = "room_block_type_name_package_txt"
			},
			{
				nameLanguage = "room_block_type_name_land_txt",
				excludes = landExcludes
			},
			{
				nameLanguage = "room_block_type_name_river_txt",
				includes = {
					RoomResourceEnum.ResourceId.River
				}
			},
			{
				nameLanguage = "room_block_type_name_road_txt",
				includes = RoomResourceEnum.ResourceRoadList
			}
		}
	end

	self._resItemList = self._resItemList or {}

	for i = #self._resItemList + 1, #self._resDataList do
		local goItem = self._gototalitem
		local cloneGo = gohelper.cloneInPlace(goItem, "btn_resItem" .. i)

		gohelper.setActive(cloneGo, true)
		gohelper.addUIClickAudio(cloneGo, AudioEnum.UI.play_ui_role_open)

		local resItem = MonoHelper.addNoUpdateLuaComOnceToGo(cloneGo, RoomViewBuildingResItem, self)

		resItem:setCallback(self._onResItemOnClick, self)
		table.insert(self._resItemList, resItem)
	end

	for i = 1, #self._resDataList do
		local resItem = self._resItemList[i]

		gohelper.setActive(resItem:getGO(), true)
		resItem:setData(self._resDataList[i])
		resItem:setSelect(self._curSelectResData == self._resDataList[i])
		resItem:setLineActive(i > 1)
	end

	for i = #self._resDataList + 1, #self._resItemList do
		gohelper.setActive(self._resItemList[i]:getGO(), false)
	end

	gohelper.setActive(self._gototalitem, false)
	self:_setSelectResData(self._resDataList[1])
end

function RoomInventorySelectView:_onResItemOnClick(resData)
	if self._curSelectResData == resData then
		return
	end

	self:_setSelectResData(resData)
end

function RoomInventorySelectView:_setSelectResData(resData)
	if self._curSelectResData ~= resData then
		local scene = GameSceneMgr.instance:getCurScene()

		scene.fsm:triggerEvent(RoomSceneEvent.CancelPlaceBlock)
	end

	self._curSelectResData = resData

	for i = 1, #self._resItemList do
		local resItem = self._resItemList[i]

		resItem:setSelect(resData == resItem:getData())
	end

	if resData then
		RoomShowBlockListModel.instance:setFilterResType(resData.includes, resData.excludes)
		RoomShowBlockListModel.instance:setIsPackage(resData.isPackage)
	else
		RoomShowBlockListModel.instance:setFilterResType(nil, nil)
		RoomShowBlockListModel.instance:setIsPackage(true)
	end

	local isPackage = RoomShowBlockListModel.instance:getIsPackage()

	gohelper.setActive(self._gocount, isPackage)
	gohelper.setActive(self._btntheme, not isPackage)

	local with = recthelper.getWidth(self._gocontentTrs)

	if isPackage then
		if not self._scrollRight2 then
			local right = self._scrollRight
			local scwidth = with - self._scrollLeft - right

			recthelper.setWidth(self._scrollblockTrs, scwidth)
			recthelper.setAnchorX(self._scrollblockTrs, (scwidth - with) * 0.5 + self._scrollLeft)
			RoomMapController.instance:setRoomShowBlockList()
			self:_refresFinishUI()
		end
	end
end

function RoomInventorySelectView:_themeFilterChanged()
	RoomMapController.instance:setRoomShowBlockList()
	self:_refreshFilterState()
	self:_refresFinishUI()
end

function RoomInventorySelectView:_refreshFilterState()
	local isOpen = RoomThemeFilterListModel.instance:getSelectCount() > 0

	if self._isLastThemeOpen ~= isOpen then
		self._isLastThemeOpen = isOpen

		gohelper.setActive(self._gothemeUnSelect, not isOpen)
		gohelper.setActive(self._gothemeSelect, isOpen)
	end
end

function RoomInventorySelectView:onUpdateParam()
	return
end

function RoomInventorySelectView:onOpen()
	self.addEventCb(self, RoomMapController.instance, RoomEvent.UpdateInventoryCount, self._refreshCountHandler, self)
	self.addEventCb(self, RoomMapController.instance, RoomEvent.ConfirmSelectBlockPackage, self._refreshBlockPackageHandler, self)
	self.addEventCb(self, RoomMapController.instance, RoomEvent.ClientTryBackBlock, self._onBackBlockEventHandler, self)
	self.addEventCb(self, RoomMapController.instance, RoomEvent.ClientCancelBackBlock, self._onBackBlockEventHandler, self)
	self.addEventCb(self, RoomMapController.instance, RoomEvent.ConfirmBackBlock, self._onBackBlockEventHandler, self)
	self.addEventCb(self, RoomMapController.instance, RoomEvent.BackBlockShowChanged, self._onBackBlockShowChanged, self)
	self.addEventCb(self, RoomBuildingController.instance, RoomEvent.BuildingListShowChanged, self._onCheckShowView, self)
	self.addEventCb(self, RoomWaterReformController.instance, RoomEvent.WaterReformShowChanged, self._onWaterReformShowChanged, self)
	self.addEventCb(self, RoomController.instance, RoomEvent.GuideRoomInventoryBlock, self._guideSwitchBlockTab, self)
	self.addEventCb(self, RoomMapController.instance, RoomEvent.NewBuildingPush, self._onNewBuildingPush, self)
	self.addEventCb(self, RoomMapController.instance, RoomEvent.NewBlockPackagePush, self._onNewBlockPackagePush, self)
	self.addEventCb(self, RoomMapController.instance, RoomEvent.UIRoomThemeFilterChanged, self._themeFilterChanged, self)
	self.addEventCb(self, RoomMapController.instance, RoomEvent.TransportPathViewShowChanged, self._onTransportPathShowChanged, self)
	self.addEventCb(self, RoomTradeController.instance, RoomTradeEvent.OnTradeLevelUpReply, self._tradeLevelUp, self)
	NavigateMgr.instance:addEscape(ViewName.RoomInventorySelectView, self._onEscBtnClick, self)
	RoomShowBlockListModel.instance:initShowBlock()
	self:_refreshUI()
	self:_onCheckShowView()
	self:_refreshFristEffect()
	self:_refreshFilterState()

	local isOpen, isOpenAnim = self:_isOpenTransporPath()

	if not isOpen or isOpenAnim then
		gohelper.setActive(self._btntransportPath, false)
	end

	if isOpenAnim then
		TaskDispatcher.runDelay(self._tradeLevelUp, self, 2)
	end

	if self.viewParam and self.viewParam.isJumpTransportSite then
		self:_openTransportPathView()
	end
end

function RoomInventorySelectView:onClose()
	TaskDispatcher.cancelTask(self._tradeLevelUp, self)
	TaskDispatcher.cancelTask(self._delayOpenOrClose, self)
end

function RoomInventorySelectView:_onBackBlockEventHandler()
	return
end

function RoomInventorySelectView:_onNewBuildingPush()
	if self._firstObtainBuilding == RoomEnum.ObtainReadState.None then
		self:_refreshFristEffect()
	end
end

function RoomInventorySelectView:_onNewBlockPackagePush()
	if self._firstObtainPackage == RoomEnum.ObtainReadState.None then
		self:_refreshFristEffect()
	end
end

function RoomInventorySelectView:_onBackBlockShowChanged()
	local isBackMore = RoomMapBlockModel.instance:isBackMore()

	self:_onRemodeOpenAnimShowChanged(not isBackMore)
end

function RoomInventorySelectView:_onWaterReformShowChanged()
	local isWaterReform = RoomWaterReformModel.instance:isWaterReform()

	self:_onRemodeOpenAnimShowChanged(not isWaterReform)
end

function RoomInventorySelectView:_onTransportPathShowChanged()
	local isTransportPath = RoomTransportController.instance:isTransportPathShow()

	self:_onRemodeOpenAnimShowChanged(not isTransportPath)
end

function RoomInventorySelectView:_tradeLevelUp()
	local isOpen, isAnim = self:_isOpenTransporPath()

	gohelper.setActive(self._btntransportPath, isOpen)

	if isOpen and isAnim then
		RoomHelper.setNumberByKey(PlayerPrefsKey.RoomTradeLevelUnlockTransportPath, 1)

		local animator = self._btntransportPath.gameObject:GetComponent(RoomEnum.ComponentType.Animator)

		if animator then
			animator:Play(RoomTradeEnum.TradeAnim.Unlock, 0, 0)
		end
	end
end

function RoomInventorySelectView:_isOpenTransporPath()
	local isOpen = ManufactureModel.instance:getTradeLevel() >= ManufactureConfig.instance:getUnlockSystemTradeLevel(RoomTradeEnum.LevelUnlock.TransportSystemOpen)

	return isOpen, (isOpen and RoomHelper.getNumberByKey(PlayerPrefsKey.RoomTradeLevelUnlockTransportPath) ~= 1 or nil) and true
end

function RoomInventorySelectView:_onRemodeOpenAnimShowChanged(isOpen)
	if isOpen then
		self.showAnimName = "remodel_open"
	end

	self:_onCheckShowView()
end

function RoomInventorySelectView:_onCheckShowView()
	local isBackMore = RoomMapBlockModel.instance:isBackMore()
	local isBuildingShow = RoomBuildingController.instance:isBuildingListShow()
	local isWaterReform = RoomWaterReformModel.instance:isWaterReform()
	local isStransportPath = RoomTransportController.instance:isTransportPathShow()
	local isShow = true

	isShow = (isBackMore or isBuildingShow or isWaterReform or isStransportPath) and false

	if self._isViewShowing ~= ((isBackMore or isBuildingShow or isWaterReform or isStransportPath) and false) then
		self._isViewShowing = isShow

		TaskDispatcher.cancelTask(self._delayOpenOrClose, self)
		TaskDispatcher.runDelay(self._delayOpenOrClose, self, 0.13333333333333333)

		if not isShow then
			self._animator:Play((isWaterReform or isBackMore or isStransportPath) and "remodel_close", 0, 0)
		end
	end
end

function RoomInventorySelectView:_refreshCountHandler(count, bonus)
	self:_refreshUI()
end

function RoomInventorySelectView:_refreshBlockPackageHandler()
	local scene = GameSceneMgr.instance:getCurScene()

	scene.inventorymgr:moveForward()
	scene.fsm:triggerEvent(RoomSceneEvent.CancelPlaceBlock)
	RoomShowBlockListModel.instance:initShowBlock()
	self:_refreshUI()
end

function RoomInventorySelectView:_refreshUI()
	local blockPackageMO = RoomInventoryBlockModel.instance:getCurPackageMO()

	if blockPackageMO then
		if not blockPackageMO.id then
			local packageId

			if self._lastPacageId ~= packageId then
				self._lastPacageId = packageId

				local packageCfg = RoomConfig.instance:getBlockPackageConfig(packageId)

				if packageCfg then
					self._blockBuildDegree = packageCfg.blockBuildDegree or 0
				end

				self:_refresPackageUI(packageCfg)
			end

			local blockNum = blockPackageMO and blockPackageMO:getUnUseCount() or 0
			local isEmpty = blockNum < 1

			self:_refresFinishUI()

			self._txtnum.text = isEmpty and 0 or blockNum
			self._txtdegree.text = isEmpty and 0 or self._blockBuildDegree * blockNum

			if self._lastIsEmpty ~= isEmpty then
				self._lastIsEmpty = isEmpty

				local colorStr = isEmpty and "#D97373" or "#FFFFFF"

				SLFramework.UGUI.GuiHelper.SetColor(self._txtnum, colorStr)
				SLFramework.UGUI.GuiHelper.SetColor(self._txtdegree, colorStr)
			end

			RoomMapController.instance:dispatchEvent(RoomEvent.SelectBlock)
		end
	end
end

function RoomInventorySelectView:_refresFinishUI()
	gohelper.setActive(self._gofinished, RoomShowBlockListModel.instance:getCount() < 1)
end

function RoomInventorySelectView:_refresPackageUI(packageCfg)
	local isShow = not not packageCfg

	gohelper.setActive(self._simageicon.gameObject, isShow)

	if packageCfg then
		self._txtname.text = packageCfg.name or ""
	end

	if isShow then
		self._simageicon:LoadImage(ResUrl.getRoomImage("blockpackage/" .. packageCfg.icon))

		if not RoomBlockPackageEnum.RareBigIcon[packageCfg.rare] then
			local splitName = RoomBlockPackageEnum.RareBigIcon[1]

			UISpriteSetMgr.instance:setRoomSprite(self._imagerare, splitName)
		end
	end
end

function RoomInventorySelectView:_refreshFristEffect()
	self._firstObtainPackage = self:_getFristPackageObtainState()
	self._firstObtainBuilding = self:_getFristBuildingObtainState()

	gohelper.setActive(self._govxchickdown, self._firstObtainPackage == RoomEnum.ObtainReadState.FristObtain)
	gohelper.setActive(self._govxchilckup, self._firstObtainPackage == RoomEnum.ObtainReadState.FristObtain)

	if self._lastbuilingObtainState ~= self._firstObtainBuilding then
		self._lastbuilingObtainState = self._firstObtainBuilding

		local animName = self._firstObtainBuilding == RoomEnum.ObtainReadState.FristObtain and "loop" or "idle"

		self._animbuilding:Play(animName, 0, 0)
	end
end

function RoomInventorySelectView:_delayOpenOrClose()
	local isBackMore = RoomMapBlockModel.instance:isBackMore()
	local isWaterReform = RoomWaterReformModel.instance:isWaterReform()
	local isBuilindShow = RoomBuildingController.instance:isBuildingListShow()
	local isTransportPath = RoomTransportController.instance:isTransportPathShow()

	gohelper.setActive(self._gocontent, self._isViewShowing)
	gohelper.setActive(self._gobtns, self._isViewShowing)
	gohelper.setActive(self._goblurmask, self._isViewShowing)

	local isShowBtns = not isBackMore and not isWaterReform and not isTransportPath

	gohelper.setActive(self._gounfold, isShowBtns)
	gohelper.setActive(self._goswitch, isShowBtns)
	gohelper.setActive(self._gonoblurmask, (isWaterReform or isBackMore) and not isBuilindShow)

	if self._isViewShowing then
		local animName = "roominventoryselectview_in"

		if not string.nilorempty(self.showAnimName) then
			animName = self.showAnimName
			self.showAnimName = nil
		end

		self._animator:Play(animName, 0, 0)
	end
end

function RoomInventorySelectView:onDestroyView()
	if self._initRT == true then
		self._initRT = false

		OrthCameraRTMgr.instance:destroyRT()
	end

	self._simageicon:UnLoadImage()

	self.showAnimName = nil
end

function RoomInventorySelectView._resetYesCallback()
	RoomMapController.instance:resetRoom()
end

function RoomInventorySelectView.confirmYesCallback()
	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.RoomForbidBtn) then
		GameFacade.showToast(RoomEnum.GuideForbidEscapeToast)
	elseif RoomMapController.instance:isResetEdit() then
		GameFacade.showMessageBox(MessageBoxIdDefine.RoomConfirm, MsgBoxEnum.BoxType.Yes_No, RoomView._confirmYesCallback)
	else
		RoomView._confirmYesCallback()
	end
end

function RoomInventorySelectView:_revertYesCallback()
	RoomMapController.instance:revertRoom()
end

function RoomInventorySelectView:_onEscBtnClick()
	if RoomMapBlockModel.instance:isBackMore() then
		RoomMapController.instance:switchBackBlock(false)

		return
	end

	local isWaterReform = RoomWaterReformModel.instance:isWaterReform()

	if isWaterReform then
		RoomWaterReformController.instance:saveReform()

		return
	end

	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.RoomForbidBtn) then
		GameFacade.showToast(RoomEnum.GuideForbidEscapeToast)

		return
	end

	local scene = GameSceneMgr.instance:getCurScene()

	if scene.camera:isTweening() then
		return
	end

	RoomController.instance:exitRoom()
end

function RoomInventorySelectView:_getFristBuildingObtainState()
	local state = self:_getFristStateByKey(PlayerPrefsKey.RoomFirstObtainBuildingShow)

	if state == RoomEnum.ObtainReadState.None then
		local infoList = RoomModel.instance:getBuildingInfoList()

		if infoList and #infoList > 0 then
			state = RoomEnum.ObtainReadState.FristObtain
		end
	end

	return state
end

function RoomInventorySelectView:_getFristPackageObtainState()
	local state = self:_getFristStateByKey(PlayerPrefsKey.RoomFirstObtainBlockPackageShow)

	if state == RoomEnum.ObtainReadState.None then
		local packageMOList = RoomInventoryBlockModel.instance:getInventoryBlockPackageMOList()

		if packageMOList and #packageMOList > 1 then
			state = RoomEnum.ObtainReadState.FristObtain
		end
	end

	return state
end

function RoomInventorySelectView:_getFristStateByKey(playerPrefsKey)
	local key = playerPrefsKey .. "#" .. tostring(PlayerModel.instance:getPlayinfo().userId)

	return PlayerPrefsHelper.getNumber(key, RoomEnum.ObtainReadState.None)
end

function RoomInventorySelectView:_setFristStateByKey(playerPrefsKey, state)
	local key = playerPrefsKey .. "#" .. tostring(PlayerModel.instance:getPlayinfo().userId)

	return PlayerPrefsHelper.setNumber(key, state)
end

function RoomInventorySelectView:_openTransportPathView()
	if RoomBuildingController.instance:isBuildingListShow() then
		RoomBuildingController.instance:setBuildingListShow(false, true)
		self:_setSwithBtnSelectId(1)
	else
		local scene = GameSceneMgr.instance:getCurScene()

		scene.fsm:triggerEvent(RoomSceneEvent.CancelBackBlock)
		scene.fsm:triggerEvent(RoomSceneEvent.CancelPlaceBlock)
	end

	RoomTransportController.instance:openTransportPathView()
	self:_onCheckShowView()
end

return RoomInventorySelectView
