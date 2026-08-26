-- chunkname: @modules/logic/bossrush/view/v3a9/V3a9_BossRush_MainSwitchModeView.lua

module("modules.logic.bossrush.view.v3a9.V3a9_BossRush_MainSwitchModeView", package.seeall)

local V3a9_BossRush_MainSwitchModeView = class("V3a9_BossRush_MainSwitchModeView", BaseView)

function V3a9_BossRush_MainSwitchModeView:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a9_BossRush_MainSwitchModeView:addEvents()
	self.addEventCb(self, RedDotController.instance, RedDotEvent.UpdateRelateDotInfo, self._refreshReddot, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self._onRefreshActivityState, self)
end

function V3a9_BossRush_MainSwitchModeView:removeEvents()
	self.removeEventCb(self, RedDotController.instance, RedDotEvent.UpdateRelateDotInfo, self._refreshReddot, self)
	self.removeEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self._onRefreshActivityState, self)
end

function V3a9_BossRush_MainSwitchModeView:_onClickTab(tab)
	if self._selectTab == tab or self._isPlayingAnim then
		return
	end

	local actId = BossRushConfig.instance:getActivityId(tab)
	local status, toastId, paramList = ActivityHelper.getActivityStatusAndToast(actId)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		GameFacade.showToastWithTableParam(toastId, paramList)

		return
	end

	self._isPlayingAnim = true
	self._selectTab = tab

	BossRushRpc.instance:sendAct128ChangeActModeRequest(tab == V3a9BossRushEnum.Mode.Act)
	self.playAnimator(self, "switch", self._playAnifinish, self)
	AudioMgr.instance:trigger(BossRushAudioEnum.Audio.play_ui_molu_chapter_switch)
	TaskDispatcher.runDelay(self._onCutMode, self, 0.3)
end

function V3a9_BossRush_MainSwitchModeView:_onRefreshActivityState()
	if self._tabItems then
		for i, item in ipairs(self._tabItems) do
			local actId = BossRushConfig.instance:getActivityId(i)
			local isOpen = ActivityHelper.isOpen(actId)

			ZProj.UGUIHelper.SetGrayscale(item.gobtn.gameObject, not isOpen)

			if item.golockIcon then
				gohelper.setActive(item.golockIcon, not isOpen)
			end
		end
	end

	self:_onRefreshTime()
end

function V3a9_BossRush_MainSwitchModeView:_onRefreshTime()
	local tab = V3a9BossRushEnum.Mode.Act
	local actId = BossRushConfig.instance:getActivityId(tab)

	if self._tabItems then
		if not actId or not self._tabItems then
			return
		end

		local txt = luaLang("p_v3a9_bossrushmainview_txt_Tab1_1")
		local isOpen = ActivityHelper.isOpen(actId)

		if not isOpen then
			local actInfoMo = ActivityModel.instance:getActMO(actId)

			if actInfoMo then
				local offsetSecond = actInfoMo:getRealStartTimeStamp() - ServerTime.now()

				if offsetSecond > 0 then
					txt = TimeUtil.SecondToActivityTimeFormat(offsetSecond)
				end
			end
		end

		self._tabItems.txtTab1.text = txt
		self._tabItems.txtTab2.text = txt
	end
end

function V3a9_BossRush_MainSwitchModeView:playAnimator(animName, cb, cbobj)
	self._animatorPlayer:Play(animName, cb, cbobj)
end

function V3a9_BossRush_MainSwitchModeView:_onCutMode()
	self.viewContainer:cutTab(self._selectTab)
	self:_onRefreshTab()
end

function V3a9_BossRush_MainSwitchModeView:_playAnifinish()
	self._isPlayingAnim = false
end

function V3a9_BossRush_MainSwitchModeView:_editableInitView()
	self._tabItems = self:getUserDataTb_()

	for i = 1, 2 do
		local tab = self:getUserDataTb_()

		tab.go = gohelper.findChild(self.viewGO, "mode/Tab" .. i)
		tab.gobtn = gohelper.findChild(tab.go, "Image_TabBG")
		tab.txtTab1 = gohelper.findChildText(tab.go, "txt_Tab")
		tab.golockIcon = gohelper.findChild(tab.go, "txt_Tab/icon")
		tab.txtTab2 = gohelper.findChildText(tab.go, "#go_Selected/txt_Tab")
		tab.btn = gohelper.getClick(tab.gobtn)
		tab.goselect = gohelper.findChild(tab.go, "#go_Selected")
		tab.goreddot = gohelper.findChild(tab.go, "#go_reddot")

		table.insert(self._tabItems, tab)
		gohelper.setActive(item.golockIcon, false)
		tab.btn:AddClickListener(self._onClickTab, self, i)
	end

	self._animatorPlayer = SLFramework.AnimatorPlayer.Get(self.viewGO.gameObject)

	local actId = BossRushConfig.instance:getActivityId(V3a9BossRushEnum.Mode.Act)
	local isOpen = ActivityHelper.isOpen(actId)

	if not isOpen then
		TaskDispatcher.runRepeat(self._onRefreshTime, self, 1)
	end
end

function V3a9_BossRush_MainSwitchModeView:_onRefreshTab()
	if self._tabItems then
		for tab, item in pairs(self._tabItems) do
			gohelper.setActive(item.goselect, tab == self._selectTab)
		end
	end

	self:_refreshReddot()
end

function V3a9_BossRush_MainSwitchModeView:onUpdateParam()
	return
end

function V3a9_BossRush_MainSwitchModeView:onOpen()
	if self.viewParam then
		self._selectTab = self.viewParam.enterMode or V3a9_BossRushModel.instance:getMode()
	end

	self:_onRefreshTab()
	self.viewContainer:playAnimator("open", self._selectTab)

	if self.viewParam and self.viewParam.isOpenLevelDetail then
		local stage = self.viewParam.stage
		local layer = self.viewParam.layer
		local viewParam = {
			stage = stage,
			layer = layer
		}

		if not self.viewParam.actId then
			local actId = BossRushConfig.instance:getActivityId(self._selectTab)

			V3a9_BossRushController.instance:openV3a9LevelDetailView(self.viewParam.actId, viewParam)
		end
	end

	self:_onRefreshActivityState()
end

function V3a9_BossRush_MainSwitchModeView:onOpenFinish()
	StatViewController.instance:trackViewName(StatViewNameEnum.ChineseViewName[self.viewName] or self.viewName)
end

function V3a9_BossRush_MainSwitchModeView:_refreshReddot()
	if self._tabItems then
		gohelper.setActive(self._tabItems[1].goreddot, self:_isShowTabReddot1())
		gohelper.setActive(self._tabItems[2].goreddot, self:_isShowTabReddot2())
	end
end

function V3a9_BossRush_MainSwitchModeView:_isShowTabReddot1()
	local actId = BossRushConfig.instance:getActivityId()
	local stages = BossRushConfig.instance:getStages(actId)

	for _, v in pairs(stages) do
		if RedDotModel.instance:isDotShow(RedDotEnum.DotNode.BossRushNewBoss, v.stage) then
			return true
		end

		if RedDotModel.instance:isDotShow(RedDotEnum.DotNode.BossRushBossReward, v.stage) then
			return true
		end
	end

	if RedDotModel.instance:isDotShow(RedDotEnum.DotNode.BossRushRankBonus, 0) then
		return true
	end

	if RedDotModel.instance:isDotShow(RedDotEnum.DotNode.BossRushHankBookBossMainView) then
		return true
	end

	return false
end

function V3a9_BossRush_MainSwitchModeView:_isShowTabReddot2()
	local actId = BossRushConfig.instance:getActivityId(V3a9BossRushEnum.Mode.Act)
	local stages = BossRushConfig.instance:getStages(actId)

	for _, v in pairs(stages) do
		if RedDotModel.instance:isDotShow(RedDotEnum.DotNode.V3a9BossRushActNewBoss, v.stage) then
			return true
		end
	end

	if RedDotModel.instance:isDotShow(RedDotEnum.DotNode.V3a9BossRushAct, 0) then
		return true
	end
end

function V3a9_BossRush_MainSwitchModeView:onClose()
	for _, item in ipairs(self._tabItems) do
		item.btn:RemoveClickListener()
	end

	TaskDispatcher.cancelTask(self._onCutMode, self)
	TaskDispatcher.cancelTask(self._onRefreshTime, self)
end

function V3a9_BossRush_MainSwitchModeView:onDestroyView()
	return
end

return V3a9_BossRush_MainSwitchModeView
