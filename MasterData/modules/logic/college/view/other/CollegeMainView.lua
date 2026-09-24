-- chunkname: @modules/logic/college/view/other/CollegeMainView.lua

module("modules.logic.college.view.other.CollegeMainView", package.seeall)

local CollegeMainView = class("CollegeMainView", BaseView)

function CollegeMainView:onInitView()
	self._gocloud = gohelper.findChild(self.viewGO, "#go_cloud")
	self._gocity = gohelper.findChild(self.viewGO, "#go_full/#go_city")
	self._gomap = gohelper.findChild(self.viewGO, "#go_full/#go_map")
	self._btngomap = gohelper.findChildButtonWithAudio(self.viewGO, "#go_full/#go_city/#btn_gomap")
	self._btngocity = gohelper.findChildButtonWithAudio(self.viewGO, "#go_full/#go_map/#btn_backcity")
	self._btnHide = gohelper.findChildButtonWithAudio(self.viewGO, "Left/Btns/#btn_hide")
	self._btnEnd = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_end")
	self._btnTips = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_tips")
	self._goTips = gohelper.findChild(self.viewGO, "Right/#go_tips")
	self._txtTips = gohelper.findChildTextMesh(self.viewGO, "Right/#go_tips/#txt_desc")
	self._btnPerson = gohelper.findChildButtonWithAudio(self.viewGO, "Left/Btns/#btn_person")
	self._btnBuff = gohelper.findChildButtonWithAudio(self.viewGO, "Left/Btns/#btn_buff")
	self._goNewBuff = gohelper.findChild(self.viewGO, "Left/Btns/#btn_buff/go_new")
	self._btnMilestone = gohelper.findChildButtonWithAudio(self.viewGO, "Left/Btns/#btn_progress")
	self._goMilestoneRedDot = gohelper.findChild(self.viewGO, "Left/Btns/#btn_progress/go_reddot")
	self._goUnlockMilestone = gohelper.findChild(self.viewGO, "Left/Btns/#btn_progress/go_canFix")
	self._viewAnim = gohelper.findComponentAnim(self.viewGO)

	gohelper.setActive(self._goNewBuff, false)
	gohelper.setActive(self._goUnlockMilestone, false)
	gohelper.setActive(self._goTips, false)
	gohelper.setActive(self._gocloud, false)
	RedDotController.instance:addRedDot(self._goMilestoneRedDot, RedDotEnum.DotNode.CollegeMileStone)
	RedDotController.instance:addRedDotTag(self._goUnlockMilestone, RedDotEnum.DotNode.CollegeMileStoneStoryEntry)
end

function CollegeMainView:addEvents()
	self._btngocity:AddClickListener(self._changeScene, self, CollegeEnum.SceneType.City)
	self._btngomap:AddClickListener(self._changeScene, self, CollegeEnum.SceneType.Map)
	self._btnHide:AddClickListener(self._onHideView, self)
	self._btnEnd:AddClickListener(self._onEndClick, self)
	self._btnTips:AddClickListener(self._openCloseTips, self)
	self._btnPerson:AddClickListener(self._btnPersonOnClick, self)
	self._btnBuff:AddClickListener(self._btnBuffOnClick, self)
	self._btnMilestone:AddClickListener(self._btnMilestoneOnClick, self)
	CollegeController.instance:registerCallback(CollegeEvent.OnMapClick, self._onMapClick, self)
	CollegeController.instance:registerCallback(CollegeEvent.UpdateState, self._onUpdateState, self)
	CollegeController.instance:registerCallback(CollegeEvent.OnGetNewState, self._onGetNewState, self)
	CollegeController.instance:registerCallback(CollegeEvent.OnServerMsgUpdate, self._checkOpenEventView, self)
	CollegeController.instance:registerCallback(CollegeEvent.OnStoryPlayEnd, self._checkOpenEventView, self)
	CollegeController.instance:registerCallback(CollegeEvent.RealSwitchScene, self.refreshUI, self)
	CollegeController.instance:registerCallback(CollegeEvent.MilestoneUpdate, self.refreshUI, self)
	CollegeController.instance:registerCallback(CollegeEvent.UnlockMap, self.refreshUI, self)
	CollegeController.instance:registerCallback(CollegeEvent.OnFocusCancelEnd, self.onFocusCancelEnd, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onViewClose, self)
	GameStateMgr.instance:registerCallback(GameStateEvent.OnTouchScreen, self._onTouchScreen, self)
end

function CollegeMainView:removeEvents()
	self._btngocity:RemoveClickListener()
	self._btngomap:RemoveClickListener()
	self._btnHide:RemoveClickListener()
	self._btnEnd:RemoveClickListener()
	self._btnTips:RemoveClickListener()
	self._btnPerson:RemoveClickListener()
	self._btnBuff:RemoveClickListener()
	self._btnMilestone:RemoveClickListener()
	CollegeController.instance:unregisterCallback(CollegeEvent.OnMapClick, self._onMapClick, self)
	CollegeController.instance:unregisterCallback(CollegeEvent.UpdateState, self._onUpdateState, self)
	CollegeController.instance:unregisterCallback(CollegeEvent.OnGetNewState, self._onGetNewState, self)
	CollegeController.instance:unregisterCallback(CollegeEvent.OnServerMsgUpdate, self._checkOpenEventView, self)
	CollegeController.instance:unregisterCallback(CollegeEvent.OnStoryPlayEnd, self._checkOpenEventView, self)
	CollegeController.instance:unregisterCallback(CollegeEvent.RealSwitchScene, self.refreshUI, self)
	CollegeController.instance:unregisterCallback(CollegeEvent.MilestoneUpdate, self.refreshUI, self)
	CollegeController.instance:unregisterCallback(CollegeEvent.UnlockMap, self.refreshUI, self)
	CollegeController.instance:unregisterCallback(CollegeEvent.OnFocusCancelEnd, self.onFocusCancelEnd, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onViewClose, self)
	GameStateMgr.instance:unregisterCallback(GameStateEvent.OnTouchScreen, self._onTouchScreen, self)
end

function CollegeMainView:onOpen()
	CollegeStatHelper.instance:startStat()

	self._sceneMo = CollegeModel.instance:getSceneMo()

	CollegeController.instance:dispatchEvent(CollegeEvent.ChangeSceneType, CollegeEnum.SceneType.City)
	self:refreshUI()

	local comp = MonoHelper.addNoUpdateLuaComOnceToGo(gohelper.findChild(self.viewGO, "Right/#btn_end"), CollegeCostComp)

	comp:setIconAndTxt(gohelper.findChildImage(self.viewGO, "Right/#btn_end/#go_cost/currency/icon/simage_material"), gohelper.findChildTextMesh(self.viewGO, "Right/#btn_end/#go_cost/currency/txt_materialNum"))
	comp:setEnoughGo(gohelper.findChild(self.viewGO, "Right/#btn_end/#go_bg/enough"), gohelper.findChild(self.viewGO, "Right/#btn_end/#go_bg/lack"))
	comp:setColor(nil, "FF9D8C")
	comp:isShowCurNum(true)
	comp:setCost(CollegeConfig.instance:getConstVal(CollegeEnum.ConstId.EndTurnCoinCost))
	self:_checkPlayStory()
	self:_checkOpenEventView()

	if self._sceneMo.worldMap.isUnlock then
		CollegeController.instance:dispatchEvent(CollegeEvent.UnlockMap)
	end

	CollegeController.instance:dispatchEvent(CollegeEvent.OnBuildingLvChange, CollegeHelper.checkBuildingLv)

	if ViewMgr.instance:isOpen(ViewName.CollegeEnterAnimView) then
		self._viewAnim.enabled = true

		self._viewAnim:Play("close", 0, 1)
	end

	local co = lua_college_item.configDict[CollegeConfig.instance:getConstNum(CollegeEnum.ConstId.CoinId)]

	self._txtTips.text = co and co.desc

	self:resetOpenAnim()
end

function CollegeMainView:_checkOpenEventView()
	if not CollegeStoryHelper.instance:isPlayingStory() and self._sceneMo.eventBox.co then
		CollegeHelper.instance:setViewVisible(ViewName.CollegeOptionView, true)
		ViewMgr.instance:openView(ViewName.CollegeOptionView)
	end
end

function CollegeMainView:_checkPlayStory()
	local clientMo = self._sceneMo.prop.clientDataMo

	if clientMo:updateNeedPlayFirstStory() then
		local storyId

		for i, v in ipairs(self._sceneMo.milestoneBox.themes) do
			if v.activeId[1] then
				storyId = v.activeId[1]

				break
			end
		end

		if storyId then
			CollegeStoryHelper.instance:playStory(storyId)
		end

		clientMo:updateLastCoin()
	else
		clientMo:getNeedPlayCoinChange()
	end
end

function CollegeMainView:refreshUI()
	gohelper.setActive(self._gocity, CollegeModel.instance.curSceneType == CollegeEnum.SceneType.City)
	gohelper.setActive(self._gomap, CollegeModel.instance.curSceneType == CollegeEnum.SceneType.Map)
	gohelper.setActive(self._gocloud, CollegeModel.instance.curSceneType == CollegeEnum.SceneType.Map)
	gohelper.setActive(self._btngomap, self._sceneMo.worldMap.isUnlock)

	local statusBox = self._sceneMo.player.statusBox

	if statusBox.statuses then
		local hasStatus = #statusBox.statuses > 0

		gohelper.setActive(self._btnBuff.gameObject, hasStatus)
	end
end

function CollegeMainView:_changeScene(type)
	if type == CollegeEnum.SceneType.Map then
		CollegeStatHelper.instance:statBtnClick(CollegeStatEnum.ViewName.Main, CollegeStatEnum.BtnName.Explore)
	end

	CollegeController.instance:dispatchEvent(CollegeEvent.ChangeSceneType, type)
end

function CollegeMainView:_onHideView()
	CollegeStatHelper.instance:statBtnClick(CollegeStatEnum.ViewName.Main, CollegeStatEnum.BtnName.HideUI)
	self:setHide(true)
	self.viewContainer:setCloseFunc(self._onMapClick, self)
end

function CollegeMainView:setHide(isHide)
	self.isHide = isHide
	self._viewAnim.enabled = true

	self._viewAnim:Play(isHide and "hide" or "open")

	self._canvasGroup = self._canvasGroup or gohelper.onceAddComponent(self.viewGO, gohelper.Type_CanvasGroup)
	self._canvasGroup.blocksRaycasts = not isHide
end

function CollegeMainView:_onMapClick()
	if not self.isHide then
		return
	end

	self:setHide(false)
	self.viewContainer:setCloseFunc()
end

function CollegeMainView:_onEndClick()
	if not CollegeModel.instance:isEnoughItems((CollegeConfig.instance:getConstVal(CollegeEnum.ConstId.EndTurnCoinCost))) then
		GameFacade.showToast(ToastEnum.CollegeItemNotEnough)

		return
	end

	CollegeModel.instance:setMsgLock(true)
	CollegeRpc.instance:sendCollegeEndRound(self._onEndRound, self)
end

function CollegeMainView:_onEndRound(cmd, resultCode, msg)
	if resultCode == 0 then
		ViewMgr.instance:openView(ViewName.CollegeRoundEndAnimView)
	end
end

function CollegeMainView:resetOpenAnim()
	self._viewAnim.enabled = true
	self._viewAnim.speed = 0

	self._viewAnim:Play("open", 0, 0)
	self._viewAnim:Update(0)
end

function CollegeMainView:_onViewClose(viewName)
	if viewName == ViewName.CollegeRoundEndAnimView then
		CollegeModel.instance:setMsgLock(false)
	elseif viewName == ViewName.CollegeEnterAnimView then
		if CollegeStoryHelper.instance:isPlayingStory() then
			CollegeController.instance:registerCallback(CollegeEvent.OnStoryPlayEnd, self.playOpenAnim, self)
		else
			self:playOpenAnim()
		end
	end
end

function CollegeMainView:onFocusCancelEnd()
	self._viewAnim.enabled = true

	self._viewAnim:Play("open", 0, 0)
end

function CollegeMainView:playOpenAnim()
	CollegeController.instance:unregisterCallback(CollegeEvent.OnStoryPlayEnd, self.playOpenAnim, self)

	self._viewAnim.speed = 1

	CollegeController.instance:dispatchEvent(CollegeEvent.OnMainViewPlayOpenAnim)
end

function CollegeMainView:_btnPersonOnClick()
	CollegeStatHelper.instance:statBtnClick(CollegeStatEnum.ViewName.Main, CollegeStatEnum.BtnName.Role)
	ViewMgr.instance:openView(ViewName.CollegeRoleBagView)
end

function CollegeMainView:_btnBuffOnClick()
	gohelper.setActive(self._goNewBuff, false)

	local screenPos = recthelper.uiPosToScreenPos(self._btnBuff.transform)

	ViewMgr.instance:openView(ViewName.CollegeStatusView, {
		baseScreenPos = screenPos
	})
end

function CollegeMainView:_btnMilestoneOnClick()
	CollegeStatHelper.instance:statBtnClick(CollegeStatEnum.ViewName.Main, CollegeStatEnum.BtnName.Milestone)
	ViewMgr.instance:openView(ViewName.CollegeMilestoneView)
end

function CollegeMainView:_onUpdateState()
	self:refreshUI()
end

function CollegeMainView:_onGetNewState()
	local isOpen = ViewMgr.instance:isOpen(ViewName.CollegeStatusView)

	gohelper.setActive(self._goNewBuff, not isOpen)
end

function CollegeMainView:_openCloseTips()
	CollegeStatHelper.instance:statBtnClick(CollegeStatEnum.ViewName.Main, CollegeStatEnum.BtnName.CoinTips)
	gohelper.setActive(self._goTips, not self._goTips.activeSelf)
end

function CollegeMainView:_onTouchScreen()
	if not self._goTips.activeSelf then
		return
	end

	if gohelper.isMouseOverGo(self._goTips) or gohelper.isMouseOverGo(self._btnTips) then
		return
	end

	gohelper.setActive(self._goTips, false)
end

function CollegeMainView:onClose()
	CollegeStatHelper.instance:statExit()
	CollegeController.instance:unregisterCallback(CollegeEvent.OnStoryPlayEnd, self.playOpenAnim, self)
	CollegeHelper.instance:clear()
	CollegeStoryHelper.instance:clear()
	CollegeAudioHelper.instance:clear()
end

return CollegeMainView
