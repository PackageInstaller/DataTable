-- chunkname: @modules/logic/explore/view/ExploreView.lua

module("modules.logic.explore.view.ExploreView", package.seeall)

local ExploreView = class("ExploreView", BaseView)

function ExploreView:onInitView()
	self._gofullscreen = gohelper.findChild(self.viewGO, "#go_fullscreen")
	self._btnback = gohelper.findChildButtonWithAudio(self.viewGO, "go_btns/#btn_back")
	self._btnhelp = gohelper.findChildButtonWithAudio(self.viewGO, "go_btns/#btn_help")
	self._btnfile = gohelper.findChildButtonWithAudio(self.viewGO, "go_btns/#btn_file")
	self._btnbag = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_bag")
	self._btnreward = gohelper.findChildButtonWithAudio(self.viewGO, "topright/#btn_reward")
	self._btnreset = gohelper.findChildButtonWithAudio(self.viewGO, "topright/#btn_reset")
	self._goshou = gohelper.findChild(self.viewGO, "shou")
	self._gotopright = gohelper.findChild(self.viewGO, "topright")
	self._gooptip = gohelper.findChild(self.viewGO, "#go_optip")
	self._txtoptip = gohelper.findChildTextMesh(self.viewGO, "#go_optip/tip")
	self._keyTipsBag = gohelper.findChild(self._btnbag.gameObject, "#go_pcbtn2")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ExploreView:addEvents()
	NavigateMgr.instance:addEscape(ViewName.ExploreView, self._btnbackOnClick, self)
	self._btnback:AddClickListener(self._btnbackOnClick, self)
	self._btnhelp:AddClickListener(self._btnhelpOnClick, self)
	self._btnfile:AddClickListener(self._btnfileOnClick, self)
	self._btnbag:AddClickListener(self._btnbagOnClick, self)
	self._btnreward:AddClickListener(self._btnrewardOnClick, self)
	self._btnreset:AddClickListener(self._btnresetOnClick, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnEnterFbFight, self.closeThis, self)
	self.addEventCb(self, ExploreController.instance, ExploreEvent.CoinCountUpdate, self.updateCoinCount, self)
	self.addEventCb(self, ExploreController.instance, ExploreEvent.MapStatusChange, self.onMapStatusChange, self)
	self.addEventCb(self, ExploreController.instance, ExploreEvent.HeroCarryChange, self.onHeroCarryChange, self)
	self.addEventCb(self, ExploreController.instance, ExploreEvent.ShowBagBtn, self.updateBagBtn, self)
	self.addEventCb(self, ExploreController.instance, ExploreEvent.ShowResetChange, self.updateResetBtn, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self.addEventCb(self, PCInputController.instance, PCInputEvent.NotifyThirdDoorOpenBook, self._btnfileOnClick, self)
	self.addEventCb(self, PCInputController.instance, PCInputEvent.NotifyThirdDoorHelp, self._btnhelpOnClick, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, self._checkDialogIsOpen, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, self._checkDialogIsOpen, self)
	self.addEventCb(self, GuideController.instance, GuideEvent.FinishGuideLastStep, self._gudieEnd, self)
end

function ExploreView:removeEvents()
	NavigateMgr.instance:removeEscape(ViewName.ExploreView)
	self._btnback:RemoveClickListener()
	self._btnhelp:RemoveClickListener()
	self._btnfile:RemoveClickListener()
	self._btnbag:RemoveClickListener()
	self._btnreward:RemoveClickListener()
	self._btnreset:RemoveClickListener()
	self.removeEventCb(self, DungeonController.instance, DungeonEvent.OnEnterFbFight, self.closeThis, self)
	self.removeEventCb(self, ExploreController.instance, ExploreEvent.CoinCountUpdate, self.updateCoinCount, self)
	self.removeEventCb(self, ExploreController.instance, ExploreEvent.MapStatusChange, self.onMapStatusChange, self)
	self.removeEventCb(self, ExploreController.instance, ExploreEvent.HeroCarryChange, self.onHeroCarryChange, self)
	self.removeEventCb(self, ExploreController.instance, ExploreEvent.ShowBagBtn, self.updateBagBtn, self)
	self.removeEventCb(self, ExploreController.instance, ExploreEvent.ShowResetChange, self.updateResetBtn, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self.removeEventCb(self, PCInputController.instance, PCInputEvent.NotifyThirdDoorOpenBook, self._btnfileOnClick, self)
	self.removeEventCb(self, PCInputController.instance, PCInputEvent.NotifyThirdDoorHelp, self._btnhelpOnClick, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, self._checkDialogIsOpen, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, self._checkDialogIsOpen, self)
	self.removeEventCb(self, GuideController.instance, GuideEvent.FinishGuideLastStep, self._gudieEnd, self)
end

function ExploreView:_btnbackOnClick()
	local map = ExploreController.instance:getMap()

	if map:getNowStatus() == ExploreEnum.MapStatus.UseItem then
		map:setMapStatus(ExploreEnum.MapStatus.Normal)

		return
	end

	ExploreController.instance:exit()
end

function ExploreView:_btnhelpOnClick()
	if self._btnhelp.gameObject.activeInHierarchy then
		HelpController.instance:showHelp(HelpEnum.HelpId.ExploreMap)
	end
end

function ExploreView:_gudieEnd()
	self:_updateHelpBtn()
end

function ExploreView:_updateHelpBtn()
	gohelper.setActive(self._btnhelp, HelpController.instance:checkGuideStepLock(HelpEnum.HelpId.ExploreMap))
end

function ExploreView:_checkDialogIsOpen()
	local isOpen = ViewMgr.instance:isOpen(ViewName.ExploreInteractView) or ViewMgr.instance:isOpen(ViewName.ExploreBonusSceneView) or ViewMgr.instance:isOpen(ViewName.ExploreGuideDialogueView)

	if isOpen then
		ViewMgr.instance:closeView(ViewName.ExploreBackpackView)
		gohelper.setActive(self.viewGO, false)
	else
		gohelper.setActive(self.viewGO, true)
	end
end

function ExploreView:_btnfileOnClick()
	local mapId = ExploreModel.instance:getMapId()
	local mapCo = ExploreConfig.instance:getMapIdConfig(mapId)

	ViewMgr.instance:openView(ViewName.ExploreArchivesView, {
		id = mapCo.chapterId
	})
end

function ExploreView:_btnbagOnClick()
	ViewMgr.instance:openView(ViewName.ExploreBackpackView)
end

function ExploreView:_btnrewardOnClick()
	local mapId = ExploreModel.instance:getMapId()
	local mapCo = ExploreConfig.instance:getMapIdConfig(mapId)
	local chapterCo = DungeonConfig.instance:getChapterCO(mapCo.chapterId)

	ViewMgr.instance:openView(ViewName.ExploreRewardView, chapterCo)
end

function ExploreView:_btnresetOnClick()
	if not ExploreModel.instance:isHeroInControl() then
		return
	end

	ExploreModel.instance.isShowingResetBoxMessage = true

	GameFacade.showMessageBox(ExploreConstValue.MessageBoxId.MapReset, MsgBoxEnum.BoxType.Yes_No, self._onResetReq, self._onCancel, nil, self, self)
end

function ExploreView:_onResetReq()
	ExploreRpc.instance:sendResetExploreRequest()

	ExploreModel.instance.isShowingResetBoxMessage = false
end

function ExploreView:_onCancel()
	ExploreModel.instance.isShowingResetBoxMessage = false
end

function ExploreView:_editableInitView()
	self._click = SLFramework.UGUI.UIClickListener.Get(self._gofullscreen)

	self._click:AddClickDownListener(self._onClickDown, self)
	self._click:AddClickUpListener(self._onClickUp, self)

	self._touchEventMgr = TouchEventMgrHepler.getTouchEventMgr(self._gofullscreen)

	self._touchEventMgr:SetIgnoreUI(true)
	self._touchEventMgr:SetOnMultiDragCb(self.onScaleHandler, self)
	self._touchEventMgr:SetScrollWheelCb(self.onMouseScrollWheelChange, self)

	self._progressItems = {}

	for i = 1, 3 do
		self._progressItems[i] = self:getUserDataTb_()
		self._progressItems[i].go = gohelper.findChild(self.viewGO, "topright/progresslist/#go_progress" .. i)
		self._progressItems[i].dark = gohelper.findChild(self._progressItems[i].go, "dark")
		self._progressItems[i].light = gohelper.findChild(self._progressItems[i].go, "light")
		self._progressItems[i].progress = gohelper.findChildTextMesh(self._progressItems[i].go, "txt_progress")
	end

	PCInputController.instance:showkeyTips(self._keyTipsBag, PCInputModel.Activity.thrityDoor, PCInputModel.thrityDoorFun.bag)
end

function ExploreView:updateBagBtn()
	gohelper.setActive(self._btnbag, ExploreSimpleModel.instance.isShowBag)
	gohelper.setActive(self._goshou, ExploreSimpleModel.instance.isShowBag)
end

function ExploreView:updateResetBtn()
	gohelper.setActive(self._btnreset, ExploreMapModel.instance:getIsShowResetBtn())
end

function ExploreView:onMouseScrollWheelChange(deltaData)
	if ViewMgr.instance:isOpen(ViewName.ExploreMapView) then
		return
	end

	local deltaScale = -deltaData

	ExploreController.instance:dispatchEvent(ExploreEvent.OnDeltaScaleMap, deltaScale)
end

function ExploreView:onScaleHandler(isEnLarger)
	if ViewMgr.instance:isOpen(ViewName.ExploreMapView) then
		return
	end

	self._scale = true

	if BootNativeUtil.isMobilePlayer() then
		self._clickDown = false
	end

	local deltaScale = isEnLarger and -0.02 or 0.02

	ExploreController.instance:dispatchEvent(ExploreEvent.OnDeltaScaleMap, deltaScale)
end

function ExploreView:_onClickDown()
	self._clickDown = true
end

function ExploreView:_onClickUp()
	if UIBlockMgr.instance:isBlock() or ZProj.TouchEventMgr.Fobidden then
		return
	end

	if self._clickDown then
		ExploreController.instance:dispatchEvent(ExploreEvent.OnClickMap, GamepadController.instance:getMousePosition())
	end
end

function ExploreView:onDestroyView()
	self._click:RemoveClickDownListener()
	self._click:RemoveClickUpListener()
end

function ExploreView:checkMove()
	if GuideController.instance:isAnyGuideRunning() then
		return
	end

	local inputController = PCInputController.instance
	local up, left, down, right = inputController:getThirdMoveKey()
	local dir = ExploreEnum.RoleMoveDir.None

	if inputController:getKeyPress(up) then
		dir = ExploreEnum.RoleMoveDir.Up
	elseif inputController:getKeyPress(left) then
		dir = ExploreEnum.RoleMoveDir.Left
	elseif inputController:getKeyPress(down) then
		dir = ExploreEnum.RoleMoveDir.Down
	elseif inputController:getKeyPress(right) then
		dir = ExploreEnum.RoleMoveDir.Right
	end

	if dir ~= ExploreEnum.RoleMoveDir.None and self._isTop == false then
		dir = ExploreEnum.RoleMoveDir.None
	end

	ExploreController.instance:dispatchEvent(ExploreEvent.UpdateMoveDir, dir)
end

function ExploreView:onOpen()
	gohelper.setActive(self._gooptip, false)

	self._isTop = true

	if BootNativeUtil.isWindows() or SDKMgr.instance:isEmulator() or BootNativeUtil.isMuMu() then
		TaskDispatcher.runRepeat(self.checkMove, self, 0)
	end

	self:updateResetBtn()
	self:updateBagBtn()
	self:updateCoinCount()
	self:_updateHelpBtn()
end

function ExploreView:onClose()
	TaskDispatcher.cancelTask(self.checkMove, self)
	ViewMgr.instance:closeView(ViewName.ExploreBackpackView)

	if self._touchEventMgr then
		self._touchEventMgr:ClearAllCallback()

		self._touchEventMgr = nil
	end
end

function ExploreView:_showBotBtn(v)
	gohelper.setActive(self._btnbag, v)
end

function ExploreView:updateCoinCount()
	local mapId = ExploreModel.instance:getMapId()
	local bonusNum, goldCoin, purpleCoin, bonusNumTotal, goldCoinTotal, purpleCoinTotal = ExploreSimpleModel.instance:getCoinCountByMapId(mapId)

	gohelper.setActive(self._progressItems[1].dark, purpleCoin ~= purpleCoinTotal)
	gohelper.setActive(self._progressItems[1].light, purpleCoin == purpleCoinTotal)

	self._progressItems[1].progress.text = string.format("%d/%d", purpleCoin, purpleCoinTotal)

	gohelper.setActive(self._progressItems[2].dark, goldCoin ~= goldCoinTotal)
	gohelper.setActive(self._progressItems[2].light, goldCoin == goldCoinTotal)

	self._progressItems[2].progress.text = string.format("%d/%d", goldCoin, goldCoinTotal)

	gohelper.setActive(self._progressItems[3].dark, bonusNum ~= bonusNumTotal)
	gohelper.setActive(self._progressItems[3].light, bonusNum == bonusNumTotal)

	self._progressItems[3].progress.text = string.format("%d/%d", bonusNum, bonusNumTotal)
end

function ExploreView:onHeroCarryChange()
	self:onMapStatusChange(ExploreController.instance:getMap():getNowStatus())
end

function ExploreView:onMapStatusChange(status)
	if status == ExploreEnum.MapStatus.MoveUnit or status == ExploreEnum.MapStatus.RotateUnit then
		self._txtoptip.text = luaLang("exploreview_optip_interact")

		gohelper.setActive(self._gooptip, true)
	elseif ExploreController.instance:getMap():getHero():getHeroStatus() == ExploreAnimEnum.RoleAnimStatus.Carry then
		self._txtoptip.text = luaLang("exploreview_optip_carry")

		gohelper.setActive(self._gooptip, true)
	else
		gohelper.setActive(self._gooptip, false)
	end

	gohelper.setActive(self._btnback, status ~= ExploreEnum.MapStatus.UseItem)
	gohelper.setActive(self._btnhelp, status ~= ExploreEnum.MapStatus.UseItem and HelpController.instance:checkGuideStepLock(HelpEnum.HelpId.ExploreMap))
	gohelper.setActive(self._btnfile, status ~= ExploreEnum.MapStatus.UseItem)
	gohelper.setActive(self._gotopright, status ~= ExploreEnum.MapStatus.UseItem)
end

function ExploreView:_onOpenView(viewName)
	if viewName == ViewName.ExploreBackpackView then
		self:_showBotBtn(false)
	end

	self:_checkIsTop()
end

function ExploreView:_onCloseView(viewName)
	if viewName == ViewName.ExploreBackpackView then
		self:_showBotBtn(true)
	end

	self:_checkIsTop()
end

ExploreView.ignoreView = {
	[ViewName.ToastView] = true,
	[ViewName.ExploreBackpackView] = true
}

function ExploreView:_checkIsTop()
	local viewNameList = ViewMgr.instance:getOpenViewNameList()
	local index = #viewNameList
	local topView = viewNameList[index]

	while ExploreView.ignoreView[topView] do
		index = index - 1
		topView = viewNameList[index]
	end

	self._isTop = topView == ViewName.ExploreView
end

return ExploreView
