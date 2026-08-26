-- chunkname: @modules/logic/room/view/manufacture/RoomCritterBuildingView.lua

module("modules.logic.room.view.manufacture.RoomCritterBuildingView", package.seeall)

local RoomCritterBuildingView = class("RoomCritterBuildingView", BaseView)

function RoomCritterBuildingView:onInitView()
	self._goBackBtns = gohelper.findChild(self.viewGO, "#go_BackBtns")
	self._scrolltabbtn = gohelper.findChildScrollRect(self.viewGO, "tabLayout/#scroll_tabbtn")
	self._gotablayout = gohelper.findChild(self.viewGO, "tabLayout")
	self._gotabItem = gohelper.findChild(self.viewGO, "tabLayout/#scroll_tabbtn/Viewport/Content/#go_tabItem")
	self._gorighttop = gohelper.findChild(self.viewGO, "righttop")
	self._btnrule = gohelper.findChildButtonWithAudio(self.viewGO, "#go_BackBtns/#btn_rule")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomCritterBuildingView:addEvents()
	self._btnrule:AddClickListener(self._btnruleOnClick, self)
	self.addEventCb(self, CritterController.instance, CritterEvent.CritterBuildingHideView, self.hideView, self)
	self.addEventCb(self, CritterController.instance, CritterEvent.CritterBuildingShowView, self.showView, self)
	self.addEventCb(self, CritterSummonController.instance, CritterSummonEvent.onStartSummon, self.hideView, self)
	self.addEventCb(self, CritterSummonController.instance, CritterSummonEvent.onCloseGetCritter, self.showView, self)
	self.addEventCb(self, CritterController.instance, CritterEvent.CritterBuildingViewRefreshCamera, self.refreshCamera, self)
	self.addEventCb(self, CritterController.instance, CritterEvent.CritterBuildingViewChangeBuilding, self._onChangeRestBuilding, self)
end

function RoomCritterBuildingView:removeEvents()
	self._btnrule:RemoveClickListener()
	self.removeEventCb(self, CritterController.instance, CritterEvent.CritterBuildingHideView, self.hideView, self)
	self.removeEventCb(self, CritterController.instance, CritterEvent.CritterBuildingShowView, self.showView, self)
	self.removeEventCb(self, CritterSummonController.instance, CritterSummonEvent.onStartSummon, self.hideView, self)
	self.removeEventCb(self, CritterSummonController.instance, CritterSummonEvent.onCloseGetCritter, self.showView, self)
	self.removeEventCb(self, CritterController.instance, CritterEvent.CritterBuildingViewRefreshCamera, self.refreshCamera, self)
	self.removeEventCb(self, CritterController.instance, CritterEvent.CritterBuildingViewChangeBuilding, self._onChangeRestBuilding, self)
end

function RoomCritterBuildingView:_btnruleOnClick()
	if self._helpCallback then
		self._helpCallback()
	end
end

function RoomCritterBuildingView:_btnTabOnClick(tabId)
	local checkResult = self.viewContainer:checkTabId(tabId)

	if not checkResult then
		logError(string.format("RoomCritterBuildingView._btnTabOnClick error, no subview, tabId:%s", tabId))

		return
	end

	if self._curSelectTab == tabId then
		return
	end

	self.viewContainer:switchTab(tabId)

	self._curSelectTab = tabId

	self:refreshTab()
	self:refreshCamera()
	self:refreshSeatSlotIcon()

	if tabId == RoomCritterBuildingViewContainer.SubViewTabId.Training and RedDotModel.instance:isDotShow(RedDotEnum.DotNode.RoomCritterTrainHas, 0) then
		RedDotRpc.instance:sendGetRedDotInfosRequest({
			RedDotEnum.DotNode.RoomCritterTrainHas
		})
	end
end

function RoomCritterBuildingView:hideView(showNavigate, showSeatSlotIcon)
	gohelper.setActive(self._goBackBtns, showNavigate)
	self._animator:Play(UIAnimationName.Close, 0, 0)
	CritterController.instance:dispatchEvent(CritterEvent.CritterBuildingChangSeatSlotVisible, showSeatSlotIcon)
end

function RoomCritterBuildingView:showView()
	self:refreshSeatSlotIcon()
	self._animator:Play(UIAnimationName.Open, 0, 0)
	gohelper.setActive(self._goBackBtns, true)
end

function RoomCritterBuildingView:_onChangeRestBuilding()
	if ViewMgr.instance:isOpen(ViewName.RoomCritterPlaceView) then
		return
	end

	gohelper.setActive(self._goBackBtns, false)
	self._animator:Play(UIAnimationName.Close, 0, 0)
	TaskDispatcher.cancelTask(self._changeFinish, self)
	TaskDispatcher.runDelay(self._changeFinish, self, CritterEnum.CritterBuildingChangeBuildingAnimTime)
end

function RoomCritterBuildingView:_changeFinish()
	self._animator:Play(UIAnimationName.Open, 0, 0)
	gohelper.setActive(self._goBackBtns, true)
end

function RoomCritterBuildingView:_editableInitView()
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._scene = RoomCameraController.instance:getRoomScene()

	gohelper.setActive(self._gotabItem, false)

	self._tabDict = {}
end

function RoomCritterBuildingView:onUpdateParam()
	if not self.viewParam then
		return
	end

	self._curSelectTab = self.viewContainer:getDefaultSelectedTab()
end

function RoomCritterBuildingView:onOpen()
	self.addEventCb(self, RoomTradeController.instance, RoomTradeEvent.OnTradeLevelUpReply, self._tradeLevelUp, self)
	self:onUpdateParam()
	self:setTabItem()
	self:refreshTab()
	self:refreshSeatSlotIcon()

	if not GuideModel.instance:isGuideFinish(RoomTradeEnum.GuideUnlock.Summon) then
		self.addEventCb(self, GuideController.instance, GuideEvent.FinishStep, self._onFinishSetep, self)
		self:_setOpenByTabId(RoomCritterBuildingViewContainer.SubViewTabId.Summon, false)
	end

	local isOpen, isOpenAnim = self:_isOpenIncubate()

	if not isOpen or isOpenAnim then
		self:_setOpenByTabId(RoomCritterBuildingViewContainer.SubViewTabId.IncubatebId, false)
	end

	if isOpenAnim then
		TaskDispatcher.runDelay(self._tradeLevelUp, self, 2)
	end

	RoomBuildingController.instance:dispatchEvent(RoomEvent.SetBuildingColliderEnable, false)
end

function RoomCritterBuildingView:setTabItem()
	for tabId, tabSetting in ipairs(RoomCritterBuildingViewContainer.TabSettingList) do
		local tabItem = self._tabDict[tabId]

		if not tabItem then
			local go = gohelper.cloneInPlace(self._gotabItem, tabId)

			if not gohelper.isNil(go) then
				tabItem = self:getUserDataTb_()
				tabItem.go = go
				tabItem.goselect = gohelper.findChild(go, "select")
				tabItem.gonormal = gohelper.findChild(go, "normal")
				tabItem.selecticon = gohelper.findChildImage(go, "select/#image_icon")
				tabItem.normalicon = gohelper.findChildImage(go, "normal/#image_icon")
				tabItem.btn = gohelper.findChildButtonWithAudio(go, "#btn_click")
				tabItem.goreddot = gohelper.findChild(go, "#go_reddot")

				tabItem.btn:AddClickListener(self._btnTabOnClick, self, tabId)

				if tabSetting.openBtnCallBack then
					gohelper.setActive(go, tabSetting.openBtnCallBack())
				else
					gohelper.setActive(go, true)
				end

				UISpriteSetMgr.instance:setCritterSprite(tabItem.selecticon, tabSetting.icon)
				UISpriteSetMgr.instance:setCritterSprite(tabItem.normalicon, tabSetting.icon)

				self._tabDict[tabId] = tabItem
			end
		end
	end

	local trainTabItem = self._tabDict[RoomCritterBuildingViewContainer.SubViewTabId.Training]

	if trainTabItem then
		RedDotController.instance:addRedDot(trainTabItem.goreddot, RedDotEnum.DotNode.RoomCritterTrainTab)
	end
end

function RoomCritterBuildingView:refreshTab()
	for tabId, tab in pairs(self._tabDict) do
		local isSelected = tabId == self._curSelectTab

		gohelper.setActive(tab.goselect, isSelected)
		gohelper.setActive(tab.gonormal, not isSelected)
	end

	self._helpCallback = RoomCritterBuildingViewContainer.TabSettingList[self._curSelectTab].helpBtnCallBack

	gohelper.setActive(self._btnrule.gameObject, self._helpCallback ~= nil)
end

function RoomCritterBuildingView:_setOpenByTabId(tabId, isOpen, isPlayAnim)
	local tab = self._tabDict[tabId]

	if tab then
		gohelper.setActive(tab.go, isOpen)

		if isOpen and isPlayAnim then
			tab.animator = tab.animator or tab.go:GetComponent(RoomEnum.ComponentType.Animator)

			if tab.animator then
				tab.animator:Play(RoomTradeEnum.TradeAnim.Unlock, 0, 0)
			end
		end
	end

	return true
end

function RoomCritterBuildingView:_tradeLevelUp()
	local isOpen, isAnim = self:_isOpenIncubate()

	if isOpen and isAnim then
		isAnim = true

		RoomHelper.setNumberByKey(PlayerPrefsKey.RoomTradeLevelUnlockCritterIncubate, 1)
	end

	self:_setOpenByTabId(RoomCritterBuildingViewContainer.SubViewTabId.IncubatebId, isOpen, isAnim)
end

function RoomCritterBuildingView:_isOpenIncubate()
	local isOpen = ManufactureModel.instance:getTradeLevel() >= ManufactureConfig.instance:getUnlockSystemTradeLevel(RoomTradeEnum.LevelUnlock.CritterIncubate)

	return isOpen, (isOpen and RoomHelper.getNumberByKey(PlayerPrefsKey.RoomTradeLevelUnlockCritterIncubate) ~= 1 or nil) and true
end

function RoomCritterBuildingView:_onFinishSetep(guideId, setpId)
	if RoomTradeEnum.GuideUnlock.Summon == guideId and setpId == 4 then
		self:_setOpenByTabId(RoomCritterBuildingViewContainer.SubViewTabId.Summon, true, true)
	end
end

function RoomCritterBuildingView:refreshCamera()
	local curBuildingUid, curBuildingMO = self:getViewBuilding()

	if not curBuildingMO then
		return
	end

	local buildingId = curBuildingMO.buildingId
	local cameraId = ManufactureConfig.instance:getBuildingCameraIdByIndex(buildingId, self._curSelectTab)
	local roomCamera = RoomCameraController.instance:getRoomCamera()

	if roomCamera and cameraId then
		RoomCameraController.instance:tweenCameraFocusBuildingUseCameraId(curBuildingUid, cameraId, self._cameraTweenFinish, self)
	end
end

function RoomCritterBuildingView:_cameraTweenFinish()
	CritterController.instance:dispatchEvent(CritterEvent.CritterBuildingCameraTweenFinish, self._curSelectTab)
end

function RoomCritterBuildingView:refreshSeatSlotIcon()
	CritterController.instance:dispatchEvent(CritterEvent.CritterBuildingChangSeatSlotVisible, self._curSelectTab == RoomCritterBuildingViewContainer.SubViewTabId.Rest)
end

function RoomCritterBuildingView:getViewBuilding()
	local viewBuildingUid, viewBuildingMO = self.viewContainer:getContainerViewBuilding(true)

	return viewBuildingUid, viewBuildingMO
end

function RoomCritterBuildingView:onClose()
	TaskDispatcher.cancelTask(self._changeFinish, self)
	TaskDispatcher.cancelTask(self._tradeLevelUp, self)
	RoomBuildingController.instance:dispatchEvent(RoomEvent.SetBuildingColliderEnable, true)
	CritterController.instance:dispatchEvent(CritterEvent.CritterBuildingChangSeatSlotVisible, false)
	CritterController.instance:dispatchEvent(CritterEvent.CritterBuildingViewChange)
	ManufactureController.instance:dispatchEvent(ManufactureEvent.PlayCritterBuildingBgm, 0, false)
end

function RoomCritterBuildingView:onDestroyView()
	for _, tab in pairs(self._tabDict) do
		tab.btn:RemoveClickListener()
	end
end

return RoomCritterBuildingView
