-- chunkname: @modules/logic/versionactivity2_2/act169/view/SummonNewCustomPickView.lua

module("modules.logic.versionactivity2_2.act169.view.SummonNewCustomPickView", package.seeall)

local SummonNewCustomPickView = class("SummonNewCustomPickView", BaseView)

SummonNewCustomPickView.DEFAULT_REFRESH_DELAY = 0.4
SummonNewCustomPickView.TIME_REFRESH_DURATION = 10

function SummonNewCustomPickView:onInitView()
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

function SummonNewCustomPickView:addEvents()
	self._btninvite:AddClickListener(self._btninviteOnClick, self)
	self._btnuninviteTips:AddClickListener(self._btnuninviteTipsOnClick, self)
	self._btninviteTips:AddClickListener(self._btninviteTipsOnClick, self)
	self.addEventCb(self, SummonNewCustomPickViewController.instance, SummonNewCustomPickEvent.OnGetReward, self._onGetReward, self)
	self.addEventCb(self, SummonNewCustomPickViewController.instance, SummonNewCustomPickEvent.OnGetServerInfoReply, self._refreshUI, self)
end

function SummonNewCustomPickView:removeEvents()
	self._btninvite:RemoveClickListener()
	self._btnuninviteTips:RemoveClickListener()
	self._btninviteTips:RemoveClickListener()
	self.removeEventCb(self, SummonNewCustomPickViewController.instance, SummonNewCustomPickEvent.OnGetReward, self._onGetReward, self)
	self.removeEventCb(self, SummonNewCustomPickViewController.instance, SummonNewCustomPickEvent.OnGetServerInfoReply, self._refreshUI, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._delayRefreshUI, self)
end

function SummonNewCustomPickView:_btnuninviteTipsOnClick()
	ViewMgr.instance:openView(ViewName.SummonNewCustomPickTipsView)
end

function SummonNewCustomPickView:_btninviteTipsOnClick()
	local activityMo = SummonNewCustomPickViewModel.instance:getActivityInfo(self._actId)

	if not activityMo or not activityMo.heroId then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_action_explore)
	ViewMgr.instance:openView(ViewName.SummonHeroDetailView, {
		heroId = activityMo.heroId
	})
end

function SummonNewCustomPickView:_btninviteOnClick()
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

function SummonNewCustomPickView:_onGetReward(activityId, heroId)
	if activityId ~= self._actId then
		return
	end

	if not SummonNewCustomPickChoiceListModel.instance:haveAllRole() then
		local instance = SummonNewCustomPickChoiceController.instance

		SummonController.instance:doVirtualSummonBehavior({
			heroId
		}, true, true, instance.backPage, instance, true)
	end

	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._delayRefreshUI, self)
end

function SummonNewCustomPickView:_editableInitView()
	self._goblackloading = gohelper.findChild(self.viewGO, "#blackloading")
	self._animLoading = self._goblackloading:GetComponent(typeof(UnityEngine.Animator))
	self._animUI = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._getRewardAnim = self._goinvited:GetComponent(typeof(UnityEngine.Animator))
end

function SummonNewCustomPickView:onUpdateParam()
	return
end

function SummonNewCustomPickView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.SummonNewCustomSkin.play_ui_youyu_liuxing_give)
	self:_checkParam()
	self:_refreshUI()
	self:_addTimeRefreshTask()
end

function SummonNewCustomPickView:_addTimeRefreshTask()
	if not self._actId then
		return
	end

	TaskDispatcher.runDelay(self._refreshTime, self, self.TIME_REFRESH_DURATION)
end

function SummonNewCustomPickView:_checkParam()
	self._actId = self.viewParam.actId

	SummonNewCustomPickViewModel.instance:setCurActId(self._actId)

	local parentGO = self.viewParam.parent

	if parentGO then
		gohelper.addChild(parentGO, self.viewGO)
	end

	if self.viewParam.refreshData == nil or self.viewParam.refreshData == true then
		SummonNewCustomPickViewController.instance:getSummonInfo(self._actId)
	end
end

function SummonNewCustomPickView:_delayRefreshUI(viewName)
	local currentViewName = SummonNewCustomPickChoiceController.instance:getCurrentListenViewName()

	if viewName == currentViewName then
		self:_refreshUI()
		ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._delayRefreshUI, self)
	end
end

function SummonNewCustomPickView:_refreshUI()
	local havePick = SummonNewCustomPickViewModel.instance:isGetReward(self._actId)

	gohelper.setActive(self._goinvited, havePick)
	gohelper.setActive(self._gouninvite, not havePick)

	if havePick then
		self:_refreshSelectRole()
	end

	self:_refreshTime()
	self:_checkShowFx()
end

function SummonNewCustomPickView:_checkShowFx()
	local actId = self._actId

	if SummonNewCustomPickViewModel.instance:getGetRewardFxState(actId) then
		self._getRewardAnim:Play(UIAnimationName.Open, 0, 0)
		SummonNewCustomPickViewModel.instance:setGetRewardFxState(actId, false)
	else
		self._getRewardAnim:Play(UIAnimationName.Idle, 0, 0)
	end
end

function SummonNewCustomPickView:_refreshTime()
	local actInfo = ActivityModel.instance:getActMO(self._actId)
	local endTime = actInfo:getRealEndTimeStamp()
	local nowTime = ServerTime.now()

	if endTime <= nowTime then
		self._txtremainTime.text = luaLang("ended")

		return
	end

	self._txtremainTime.text = TimeUtil.SecondToActivityTimeFormat(endTime - nowTime)
end

function SummonNewCustomPickView:_refreshSelectRole()
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

function SummonNewCustomPickView:onClose()
	TaskDispatcher.cancelTask(self._refreshTime, self)
end

function SummonNewCustomPickView:onDestroyView()
	self._simagerolehead:UnLoadImage()
end

return SummonNewCustomPickView
