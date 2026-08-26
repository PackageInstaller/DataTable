-- chunkname: @modules/logic/versionactivity2_2/act169/view/SummonNewCustomPickFullView.lua

module("modules.logic.versionactivity2_2.act169.view.SummonNewCustomPickFullView", package.seeall)

local SummonNewCustomPickFullView = class("SummonNewCustomPickFullView", BaseView)

SummonNewCustomPickFullView.DEFAULT_REFRESH_DELAY = 0.4
SummonNewCustomPickFullView.TIME_REFRESH_DURATION = 10

function SummonNewCustomPickFullView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._simagerole1 = gohelper.findChildSingleImage(self.viewGO, "role/#simage_role1")
	self._simagerole2 = gohelper.findChildSingleImage(self.viewGO, "role/#simage_role2")
	self._simagerole3 = gohelper.findChildSingleImage(self.viewGO, "role/#simage_role3")
	self._simagerole4 = gohelper.findChildSingleImage(self.viewGO, "role/#simage_role4")
	self._simagedecbg = gohelper.findChildSingleImage(self.viewGO, "role/#simage_decbg")
	self._simagetitle = gohelper.findChildSingleImage(self.viewGO, "logo/#simage_title")
	self._simagetitle2 = gohelper.findChildSingleImage(self.viewGO, "logo/#simage_title2")
	self._simagefrontbg = gohelper.findChildSingleImage(self.viewGO, "#simage_frontbg")
	self._txtremainTime = gohelper.findChildText(self.viewGO, "timebg/#txt_remainTime")
	self._goinviteContent = gohelper.findChild(self.viewGO, "#go_inviteContent")
	self._gouninvite = gohelper.findChild(self.viewGO, "#go_inviteContent/#go_uninvite")
	self._btninvite = gohelper.findChildButtonWithAudio(self.viewGO, "#go_inviteContent/#go_uninvite/#btn_invite")
	self._btnuninviteTips = gohelper.findChildButtonWithAudio(self.viewGO, "#go_inviteContent/#go_uninvite/#btn_uninviteTips")
	self._goinvited = gohelper.findChild(self.viewGO, "#go_inviteContent/#go_invited")
	self._btninviteTips = gohelper.findChildButtonWithAudio(self.viewGO, "#go_inviteContent/#go_invited/#btn_inviteTips")
	self._simagerolehead = gohelper.findChildSingleImage(self.viewGO, "#go_inviteContent/#go_invited/#btn_inviteTips/#simage_rolehead")
	self._txtrolename = gohelper.findChildText(self.viewGO, "#go_inviteContent/#go_invited/#txt_rolename")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SummonNewCustomPickFullView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btninvite:AddClickListener(self._btninviteOnClick, self)
	self._btnuninviteTips:AddClickListener(self._btnuninviteTipsOnClick, self)
	self._btninviteTips:AddClickListener(self._btninviteTipsOnClick, self)
	self.addEventCb(self, SummonNewCustomPickViewController.instance, SummonNewCustomPickEvent.OnGetReward, self._onGetReward, self)
	self.addEventCb(self, SummonNewCustomPickViewController.instance, SummonNewCustomPickEvent.OnGetServerInfoReply, self._refreshUI, self)
	self.addEventCb(self, SummonController.instance, SummonEvent.summonShowBlackScreen, self.onReceiveShowBlackScreen, self)
	self.addEventCb(self, SummonController.instance, SummonEvent.summonShowExitAnim, self.startExitLoading, self)
	self.addEventCb(self, SummonController.instance, SummonEvent.summonCloseBlackScreen, self.onReceiveCloseBlackScreen, self)
	self.addEventCb(self, SummonController.instance, SummonEvent.summonMainCloseImmediately, self.closeThis, self)
end

function SummonNewCustomPickFullView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btninvite:RemoveClickListener()
	self._btnuninviteTips:RemoveClickListener()
	self._btninviteTips:RemoveClickListener()
	self.removeEventCb(self, SummonNewCustomPickViewController.instance, SummonNewCustomPickEvent.OnGetReward, self._onGetReward, self)
	self.removeEventCb(self, SummonNewCustomPickViewController.instance, SummonNewCustomPickEvent.OnGetServerInfoReply, self._refreshUI, self)
	self.removeEventCb(self, SummonController.instance, SummonEvent.summonShowBlackScreen, self.onReceiveShowBlackScreen, self)
	self.removeEventCb(self, SummonController.instance, SummonEvent.summonShowExitAnim, self.startExitLoading, self)
	self.removeEventCb(self, SummonController.instance, SummonEvent.summonCloseBlackScreen, self.onReceiveCloseBlackScreen, self)
	self.removeEventCb(self, SummonController.instance, SummonEvent.summonMainCloseImmediately, self.closeThis, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._delayRefreshUI, self)
	TaskDispatcher.cancelTask(self._refreshTime, self)
end

function SummonNewCustomPickFullView:_btncloseOnClick()
	self:closeThis()
end

function SummonNewCustomPickFullView:_btnuninviteTipsOnClick()
	ViewMgr.instance:openView(ViewName.SummonNewCustomPickTipsView)
end

function SummonNewCustomPickFullView:_btninviteTipsOnClick()
	local activityMo = SummonNewCustomPickViewModel.instance:getActivityInfo(self._actId)

	if not activityMo or not activityMo.heroId then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_action_explore)
	ViewMgr.instance:openView(ViewName.SummonHeroDetailView, {
		heroId = activityMo.heroId
	})
end

function SummonNewCustomPickFullView:_btninviteOnClick()
	local curAct = self._actId

	if not curAct then
		return
	end

	if SummonNewCustomPickViewModel.instance:isGetReward(curAct) then
		return
	end

	local haveAllRole = SummonNewCustomPickChoiceListModel.instance:haveAllRole()

	if haveAllRole then
		ViewMgr.instance:openView(ViewName.SummonNewCustomPickChoiceView, {
			actId = curAct
		})
	else
		SummonNewCustomPickChoiceController.instance:trySendSummon()
	end
end

function SummonNewCustomPickFullView:_onGetReward(activityId, heroId)
	if activityId ~= self._actId then
		return
	end

	if not SummonNewCustomPickChoiceListModel.instance:haveAllRole() then
		local instance = SummonNewCustomPickChoiceController.instance

		SummonController.instance:doVirtualSummonBehavior({
			heroId
		}, true, true, instance.backFullPage, instance, true)
	end

	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._delayRefreshUI, self)
end

function SummonNewCustomPickFullView:_editableInitView()
	self._goblackloading = gohelper.findChild(self.viewGO, "#blackloading")
	self._animLoading = self._goblackloading:GetComponent(typeof(UnityEngine.Animator))
	self._animUI = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._getRewardAnim = self._goinvited:GetComponent(typeof(UnityEngine.Animator))
end

function SummonNewCustomPickFullView:onUpdateParam()
	return
end

function SummonNewCustomPickFullView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.SummonNewCustomSkin.play_ui_youyu_liuxing_give)
	self:_checkParam()
	self:_refreshUI()
	self:_addTimeRefreshTask()
end

function SummonNewCustomPickFullView:_addTimeRefreshTask()
	if not self._actId then
		return
	end

	TaskDispatcher.runRepeat(self._refreshTime, self, self.TIME_REFRESH_DURATION)
end

function SummonNewCustomPickFullView:_checkParam()
	local actId = self.viewParam.actId

	self._actId = actId

	SummonNewCustomPickViewModel.instance:setCurActId(actId)

	if self.viewParam.refreshData == nil or self.viewParam.refreshData == true then
		SummonNewCustomPickViewController.instance:getSummonInfo(actId)
	end
end

function SummonNewCustomPickFullView:_delayRefreshUI(viewName)
	local currentViewName = SummonNewCustomPickChoiceController.instance:getCurrentListenViewName()

	if viewName == currentViewName then
		self:_refreshUI()
		ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._delayRefreshUI, self)
	end
end

function SummonNewCustomPickFullView:_refreshUI()
	local havePick = SummonNewCustomPickViewModel.instance:isGetReward(self._actId)

	gohelper.setActive(self._goinvited, havePick)
	gohelper.setActive(self._gouninvite, not havePick)

	if havePick then
		self:_refreshSelectRole()
	end

	self:_refreshTime()
	self:_checkShowFx()
end

function SummonNewCustomPickFullView:_checkShowFx()
	local actId = self._actId

	if SummonNewCustomPickViewModel.instance:getGetRewardFxState(actId) then
		self._getRewardAnim:Play(UIAnimationName.Open, 0, 0)
		SummonNewCustomPickViewModel.instance:setGetRewardFxState(actId, false)
	else
		self._getRewardAnim:Play(UIAnimationName.Idle, 0, 0)
	end
end

function SummonNewCustomPickFullView:_refreshTime()
	local actInfo = ActivityModel.instance:getActMO(self._actId)
	local endTime = actInfo:getRealEndTimeStamp()
	local nowTime = ServerTime.now()

	if endTime <= nowTime then
		self._txtremainTime.text = luaLang("ended")

		return
	end

	self._txtremainTime.text = TimeUtil.SecondToActivityTimeFormat(endTime - nowTime)
end

function SummonNewCustomPickFullView:_refreshSelectRole()
	local info = SummonNewCustomPickViewModel.instance:getActivityInfo(self._actId)
	local heroId = info.heroId
	local heroConfig = HeroConfig.instance:getHeroCO(heroId)

	if not heroConfig then
		logError("SummonNewCustomPick.refreshUI error, heroConfig is nil, id:" .. tostring(heroId))

		return
	end

	local skinConfig = SkinConfig.instance:getSkinCo(heroConfig.skinId)

	if not skinConfig then
		logError("SummonNewCustomPick.refreshUI error,  skinCfg is nil, id:" .. tostring(heroConfig.skinId))

		return
	end

	self._simagerolehead:LoadImage(ResUrl.getRoomHeadIcon(skinConfig.headIcon))

	self._txtrolename.text = heroConfig.name
end

function SummonNewCustomPickFullView:onReceiveShowBlackScreen()
	gohelper.setActive(self._goblackloading, true)
	self._animLoading:Play("blackloading_open", 0, 0)

	self._isShowBlackScreen = true

	TaskDispatcher.runDelay(self.afterBlackLoading, self, 0.3)
end

function SummonNewCustomPickFullView:afterBlackLoading()
	TaskDispatcher.cancelTask(self.afterBlackLoading, self)
	gohelper.setActive(self.viewGO, false)
	SummonController.instance:onFirstLoadSceneBlock()
end

function SummonNewCustomPickFullView:onReceiveCloseBlackScreen()
	if not gohelper.isNil(self._animLoading) then
		self._animLoading:Play("blackloading_close", 0, 0)
	end

	TaskDispatcher.runDelay(self.afterCloseLoading, self, 0.3)
end

function SummonNewCustomPickFullView:afterCloseLoading()
	logNormal("close SummonNewCustomPickFullView")
	TaskDispatcher.cancelTask(self.afterCloseLoading, self)
	self:closeThis()
end

function SummonNewCustomPickFullView:startExitLoading()
	if not gohelper.isNil(self._animUI) then
		self._animUI:Play(UIAnimationName.Close, 0, 0)
	end

	return 0.16
end

function SummonNewCustomPickFullView:onClose()
	TaskDispatcher.cancelTask(self.afterBlackLoading, self)
	TaskDispatcher.cancelTask(self.afterCloseLoading, self)
	UIBlockMgr.instance:endAll()
	PostProcessingMgr.instance:forceRefreshCloseBlur()
end

function SummonNewCustomPickFullView:onDestroyView()
	self._simagerolehead:UnLoadImage()
end

return SummonNewCustomPickFullView
