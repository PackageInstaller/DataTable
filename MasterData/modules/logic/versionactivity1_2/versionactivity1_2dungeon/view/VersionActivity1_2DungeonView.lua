-- chunkname: @modules/logic/versionactivity1_2/versionactivity1_2dungeon/view/VersionActivity1_2DungeonView.lua

module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.view.VersionActivity1_2DungeonView", package.seeall)

local VersionActivity1_2DungeonView = class("VersionActivity1_2DungeonView", BaseViewExtended)

function VersionActivity1_2DungeonView:onInitView()
	self._topLeftGo = gohelper.findChild(self.viewGO, "top_left")
	self._topRight = gohelper.findChild(self.viewGO, "topRight")
	self._topRightGo = gohelper.findChild(self.viewGO, "#go_topright")
	self._topLeftElementGo = gohelper.findChild(self.viewGO, "top_left_element")
	self._gotasklist = gohelper.findChild(self.viewGO, "#go_tasklist")
	self._goversionactivity = gohelper.findChild(self.viewGO, "#go_tasklist/#go_versionActivity")
	self._gomain = gohelper.findChild(self.viewGO, "#go_main")
	self._gores = gohelper.findChild(self.viewGO, "#go_res")
	self._gointeractiveroot = gohelper.findChild(self.viewGO, "#go_interactive_root")
	self._txtstorenum = gohelper.findChildText(self.viewGO, "#go_topright/#btn_activitystore/#txt_num")
	self._btn3 = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_3")
	self._gohardmodelock = gohelper.findChild(self.viewGO, "#go_tasklist/#go_versionActivity/#go_hardmode/#go_hardModeLock")
	self._txtunlocktime = gohelper.findChildText(self.viewGO, "#go_tasklist/#go_versionActivity/#go_hardmode/#go_hardModeLock/#txt_unlockTime")
	self._hardBtnAni = gohelper.onceAddComponent(self._gohardmodelock, typeof(UnityEngine.Animator))
	self._btnAni1 = gohelper.findChildComponent(self.viewGO, "#go_tasklist/#go_versionActivity", typeof(UnityEngine.Animator))
	self._btnAni2 = gohelper.findChildComponent(self.viewGO, "#go_tasklist/#go_taskitem", typeof(UnityEngine.Animator))
	self._btnAni3 = gohelper.findChildComponent(self.viewGO, "#btn_3", typeof(UnityEngine.Animator))
	self._btnAni4 = gohelper.findChildComponent(self.viewGO, "#btn_4", typeof(UnityEngine.Animator))
	self._rightBtnAni = gohelper.findChildComponent(self.viewGO, "#go_topright", typeof(UnityEngine.Animator))
	self._currencyNum = gohelper.findChildText(self.viewGO, "#btn_4/icon/cost/num")
	self._currencyNumLvHuEMen = gohelper.findChildText(self.viewGO, "#go_topright/GameObject/#btn_1/node/num")
	self._focusBtnStateOff = gohelper.findChild(self.viewGO, "#btn_4/icon/#go_off")
	self._focusBtnStateOn = gohelper.findChild(self.viewGO, "#btn_4/icon/#go_on")
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#go_versionActivityBg/#simage_bg")
	self._simagebgeffect = gohelper.findChildSingleImage(self.viewGO, "#go_versionActivityBg/#simage_bgeffect")
	self._simagehardbg = gohelper.findChildSingleImage(self.viewGO, "#go_versionActivityBg/#simage_hardbg")
	self._btncloseview = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_closeview")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity1_2DungeonView:addEvents()
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseView, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.refreshActivityCurrency, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnUpdateDungeonInfo, self._onUpdateDungeonInfo, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnSetEpisodeListVisible, self._onSetEpisodeListVisible, self)
	self.addEventCb(self, VersionActivity1_2DungeonController.instance, VersionActivity1_2DungeonEvent.showNoteUnlock, self._showNoteUnlock, self)
	self.addEventCb(self, VersionActivity1_2DungeonController.instance, VersionActivity1_2DungeonEvent.onReceiveAct121UpdatePush, self._onReceiveAct121UpdatePush, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._onCurrencyChange, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnRemoveElement, self._OnRemoveElement, self)
	self._btn3:AddClickListener(self._onClickBtn3, self)
	self._storeBtn:AddClickListener(self._onClickStoreBtn, self)
	self._taskBtn:AddClickListener(self._onClickTaskBtn, self)
	self._btncloseview:AddClickListener(self._btncloseviewOnClick, self)
end

function VersionActivity1_2DungeonView:removeEvents()
	self._btn3:RemoveClickListener()
	self._storeBtn:RemoveClickListener()
	self._taskBtn:RemoveClickListener()
	self._btncloseview:RemoveClickListener()
end

function VersionActivity1_2DungeonView:_editableInitView()
	gohelper.setActive(self._gotasklist, true)
	gohelper.setActive(self._goversionactivity, true)
	gohelper.setActive(self._gomain, false)
	gohelper.setActive(self._gores, false)

	self._storeBtn = gohelper.findChildButtonWithAudio(self.viewGO, "#go_topright/GameObject/#btn_1")
	self._taskBtn = gohelper.findChildButtonWithAudio(self.viewGO, "#go_topright/GameObject/#btn_2", AudioEnum.UI.play_ui_mission_open)

	local goTaskRedDot = gohelper.findChild(self._taskBtn.gameObject, "reddot")

	RedDotController.instance:addRedDot(goTaskRedDot, RedDotEnum.DotNode.LvHuEMenTask)
	self._simagebg:LoadImage(ResUrl.getVersionActivityDungeon_1_2("bj_zasehuahen"))
	self._simagebgeffect:LoadImage(ResUrl.getVersionActivityDungeon_1_2("bj_zasehuahen"))
	self._simagehardbg:LoadImage(ResUrl.getVersionActivityDungeon_1_2("lvjing_kunnan"))
	gohelper.removeUIClickAudio(self._btncloseview.gameObject)

	self._scrollcontent = gohelper.findChildScrollRect(self.viewGO, "#scroll_content")
	self._rectmask2D = self._scrollcontent:GetComponent(typeof(UnityEngine.UI.RectMask2D))

	gohelper.setActive(self._storeBtn, false)
	gohelper.setActive(self._taskBtn, false)
end

function VersionActivity1_2DungeonView:_btncloseviewOnClick()
	ViewMgr.instance:closeView(ViewName.VersionActivity1_2DungeonMapLevelView)
end

function VersionActivity1_2DungeonView:_onUpdateDungeonInfo()
	self:_detectHardModel()
end

function VersionActivity1_2DungeonView:_onClickStoreBtn()
	ReactivityController.instance:openReactivityStoreView(VersionActivity1_2Enum.ActivityId.Dungeon)
end

function VersionActivity1_2DungeonView:_onClickTaskBtn()
	ReactivityController.instance:openReactivityTaskView(VersionActivity1_2Enum.ActivityId.Dungeon)
end

function VersionActivity1_2DungeonView:_onClickBtn3()
	ViewMgr.instance:openView(ViewName.VersionActivity_1_2_StoryCollectView)
end

function VersionActivity1_2DungeonView:onUpdateParam()
	self:refreshUI()
end

function VersionActivity1_2DungeonView:_onEscBtnClick()
	if self._interActiveItem then
		local childViews = self._interActiveItem:getChildViews()

		if childViews and #childViews > 0 then
			VersionActivity1_2DungeonController.instance:dispatchEvent(VersionActivity1_2DungeonEvent.closeChildElementView)

			return
		end
	end

	self:closeThis()
end

function VersionActivity1_2DungeonView:_dimBgm(state)
	if state then
		AudioMgr.instance:trigger(AudioEnum.UI.set_state_bgm_decrease)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.set_state_bgm_redecrease)
	end
end

function VersionActivity1_2DungeonView:onOpen()
	self:refreshUI()
	NavigateMgr.instance:addEscape(ViewName.VersionActivity1_2DungeonView, self._onEscBtnClick, self)
	self:_detectHardModel()
	gohelper.setActive(self._btn3.gameObject, DungeonMapModel.instance:elementIsFinished(12101103))
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, self.dailyRefresh, self)
	self:_dimBgm(true)
	self:_showNoteRedPoint()
	self:_showClueTips()
	self:_showCurrencyNum()

	if DungeonMapModel.instance:getElementById(12101091) then
		DungeonRpc.instance:sendMapElementRequest(12101091)
	end
end

function VersionActivity1_2DungeonView:_onCurrencyChange()
	self:_showCurrencyNum()
end

function VersionActivity1_2DungeonView:_showCurrencyNum()
	local currencyMO = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.DryForest)

	if currencyMO then
		if not currencyMO.quantity then
			local quantity = 0

			self._currencyNum.text = GameUtil.numberDisplay(quantity)

			local currencyId = ReactivityModel.instance:getActivityCurrencyId(VersionActivity1_2Enum.ActivityId.Dungeon)

			currencyMO = CurrencyModel.instance:getCurrency(currencyId)
			quantity = currencyMO and currencyMO.quantity or 0
			self._currencyNumLvHuEMen.text = GameUtil.numberDisplay(quantity)
		end
	end
end

function VersionActivity1_2DungeonView:dailyRefresh()
	self:_detectHardModel()
end

function VersionActivity1_2DungeonView:_detectHardModel()
	local isOpen = VersionActivity1_2DungeonMapEpisodeView.hardModelIsOpen(self)

	gohelper.setActive(self._gohardmodelock, not isOpen)

	if not isOpen then
		local chapterId = VersionActivity1_2DungeonEnum.DungeonChapterId.Activity1_2DungeonHard

		self._hardBtnAni:Play("idle", 0, 0)

		local openTimeStamp = VersionActivityConfig.instance:getAct113DungeonChapterOpenTimeStamp(chapterId)
		local serverTime = ServerTime.now()

		if serverTime < openTimeStamp then
			local timeStampOffset = openTimeStamp - serverTime
			local day = Mathf.Floor(timeStampOffset / TimeUtil.OneDaySecond)
			local hourSecond = timeStampOffset % TimeUtil.OneDaySecond
			local hour = Mathf.Floor(hourSecond / TimeUtil.OneHourSecond)
			local actInfoMo = ActivityModel.instance:getActivityInfo()[VersionActivity1_2Enum.ActivityId.Dungeon]

			if day > 0 then
				local tempStr = actInfoMo:getRemainTimeStr2(timeStampOffset)

				if hour > 0 then
					tempStr = tempStr .. hour .. luaLang("time_hour2")
				end

				self._txtunlocktime.text = string.format(luaLang("seasonmainview_timeopencondition"), tempStr)
			else
				self._txtunlocktime.text = string.format(luaLang("seasonmainview_timeopencondition"), actInfoMo:getRemainTimeStr2(timeStampOffset))
			end

			return
		end

		local isOpen, unLockEpisodeId = DungeonModel.instance:chapterIsUnLock(VersionActivity1_2DungeonEnum.DungeonChapterId.Activity1_2DungeonHard)
		local chapterConfig = DungeonConfig.instance:getChapterCO(chapterId)

		self._txtunlocktime.text = string.format(luaLang("dungeon_unlock_episode_mode"), chapterConfig.chapterIndex .. "-" .. VersionActivity1_2DungeonConfig.instance:getEpisodeIndex(unLockEpisodeId))
	elseif VersionActivity1_2DungeonView.getHardModelUnlockAniFinish() == 0 then
		gohelper.setActive(self._gohardmodelock, true)

		self._txtunlocktime.text = ""

		gohelper.setActive(gohelper.findChild(self._gohardmodelock, "icon"), false)
		VersionActivity1_2DungeonView.setHardModelUnlockAniFinish()
		self._hardBtnAni:Play("unlock")
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_unlock)
	end
end

function VersionActivity1_2DungeonView.getHardModelUnlockAniFinish()
	return PlayerPrefsHelper.getNumber(PlayerModel.instance:getMyUserId() .. PlayerPrefsKey.Fight1_2HardModelUnlockAniFinish, 0)
end

function VersionActivity1_2DungeonView.setHardModelUnlockAniFinish()
	return PlayerPrefsHelper.setNumber(PlayerModel.instance:getMyUserId() .. PlayerPrefsKey.Fight1_2HardModelUnlockAniFinish, 1)
end

function VersionActivity1_2DungeonView:_onReceiveGet116InfosReply()
	return
end

function VersionActivity1_2DungeonView:refreshUI()
	local viewParam = self.viewParam

	if viewParam and viewParam.jumpParam then
		if viewParam.jumpParam == JumpEnum.Activity1_2DungeonJump.Shop then
			ReactivityController.instance:openReactivityStoreView(VersionActivity1_2Enum.ActivityId.Dungeon)
		elseif viewParam.jumpParam == JumpEnum.Activity1_2DungeonJump.Task then
			ReactivityController.instance:openReactivityTaskView(VersionActivity1_2Enum.ActivityId.Dungeon)
		end

		viewParam.jumpParam = nil
	end
end

function VersionActivity1_2DungeonView:refreshActivityCurrency()
	return
end

function VersionActivity1_2DungeonView:_onReceiveAct121UpdatePush()
	self:_showClueTips()
end

function VersionActivity1_2DungeonView:openMapInteractiveItem()
	self._interActiveItem = self._interActiveItem or self:openSubView(DungeonMapInteractive1_2Item, self._gointeractiveroot)

	DungeonController.instance:dispatchEvent(DungeonEvent.OnSetEpisodeListVisible, false)

	return self._interActiveItem
end

function VersionActivity1_2DungeonView:_onSetEpisodeListVisible(state)
	self:_setViewVisible(state)
end

function VersionActivity1_2DungeonView:_setViewVisible(open)
	if open then
		self._btnAni1:Play("open")
		self._btnAni2:Play("taskitem_in")
		self._btnAni3:Play("open")
		self._btnAni4:Play("open")
		self._rightBtnAni:Play("open")

		self._rectmask2D.padding = Vector4(0, 0, 0, 0)
	else
		self._btnAni1:Play("close")
		self._btnAni2:Play("taskitem_out")
		self._btnAni3:Play("close")
		self._btnAni4:Play("close")
		self._rightBtnAni:Play("close")

		self._rectmask2D.padding = Vector4(0, 0, 600, 0)
	end

	gohelper.setActive(self._topLeftGo, open)
	gohelper.setActive(self._topRight, open)
	gohelper.setActive(self._btncloseview, not open)
end

function VersionActivity1_2DungeonView:_onOpenView(viewName)
	if viewName == ViewName.VersionActivity1_2DungeonMapLevelView then
		self:_setViewVisible()
	end
end

function VersionActivity1_2DungeonView:_onCloseView(viewName)
	if viewName == ViewName.VersionActivity1_2DungeonMapLevelView then
		self:_setViewVisible(true)
	elseif viewName == ViewName.VersionActivity_1_2_StoryCollectView then
		self:_showNoteRedPoint()
	elseif viewName == ViewName.CommonPropView and self._needShowNoteUnlock then
		self._needShowNoteUnlock = false

		gohelper.setActive(self._btn3.gameObject, true)
		gohelper.onceAddComponent(self._btn3.gameObject, typeof(UnityEngine.Animator)):Play("unlock")
	end
end

function VersionActivity1_2DungeonView:_showNoteUnlock()
	self._needShowNoteUnlock = true
end

function VersionActivity1_2DungeonView:_showNoteRedPoint()
	local redPoint = gohelper.findChild(self._btn3.gameObject, "redPoint")

	gohelper.setActive(redPoint, VersionActivity_1_2_StoryCollectView.getRedPoint())
end

function VersionActivity1_2DungeonView:_showClueTips()
	self._clueTips = FlowSequence.New()

	self._clueTips:addWork(FightWork1_2ClueTips.New())
	self._clueTips:start()
end

function VersionActivity1_2DungeonView:_OnRemoveElement(id)
	if id == 12101091 then
		VersionActivity1_2DungeonController.instance:dispatchEvent(VersionActivity1_2DungeonEvent.afterCollectLastShow)
	end
end

function VersionActivity1_2DungeonView:onClose()
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, self.dailyRefresh, self)
	UIBlockMgr.instance:endBlock(self.viewName)
	self:_dimBgm(false)

	if self._clueTips then
		self._clueTips:stop()

		self._clueTips = nil
	end
end

function VersionActivity1_2DungeonView:onDestroyView()
	self._simagebg:UnLoadImage()
	self._simagebgeffect:UnLoadImage()
	self._simagehardbg:UnLoadImage()
end

return VersionActivity1_2DungeonView
