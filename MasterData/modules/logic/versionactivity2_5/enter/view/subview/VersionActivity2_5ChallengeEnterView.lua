-- chunkname: @modules/logic/versionactivity2_5/enter/view/subview/VersionActivity2_5ChallengeEnterView.lua

module("modules.logic.versionactivity2_5.enter.view.subview.VersionActivity2_5ChallengeEnterView", package.seeall)

local VersionActivity2_5ChallengeEnterView = class("VersionActivity2_5ChallengeEnterView", BaseView)
local Locked_EnterBtn_GrayFactor = 0.8
local Locked_TaskBtn_GrayFactor = 0.8

function VersionActivity2_5ChallengeEnterView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._simageTitle = gohelper.findChildSingleImage(self.viewGO, "Right/#simage_Title")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Right/#txt_limittime")
	self._txtDescr = gohelper.findChildText(self.viewGO, "Right/#txt_Descr")
	self._gorewards = gohelper.findChild(self.viewGO, "Right/scroll_Reward/Viewport/#go_rewards")
	self._btnEnter = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_Enter")
	self._btnReward = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_Reward")
	self._gorewardreddot = gohelper.findChild(self.viewGO, "Right/#btn_Reward/#go_rewardreddot")
	self._goTips = gohelper.findChild(self.viewGO, "Right/#btn_Enter/#go_Tips")
	self._txtUnLocked = gohelper.findChildText(self.viewGO, "Right/#btn_Enter/#go_Tips/#txt_UnLocked")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity2_5ChallengeEnterView:addEvents()
	self._btnEnter:AddClickListener(self._btnEnterOnClick, self)
	self._btnReward:AddClickListener(self._btnRewardOnClick, self)
end

function VersionActivity2_5ChallengeEnterView:removeEvents()
	self._btnEnter:RemoveClickListener()
	self._btnReward:RemoveClickListener()
end

function VersionActivity2_5ChallengeEnterView:_btnEnterOnClick()
	local status, toastId, paramList = ActivityHelper.getActivityStatusAndToast(self.actId)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		GameFacade.showToastWithTableParam(toastId, paramList)

		return
	end

	Act183Controller.instance:openAct183MainView()
end

function VersionActivity2_5ChallengeEnterView:_btnRewardOnClick()
	local status, toastId, paramList = ActivityHelper.getActivityStatusAndToast(self.actId)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		GameFacade.showToastWithTableParam(toastId, paramList)

		return
	end

	Act183Controller.instance:openAct183TaskView()
end

function VersionActivity2_5ChallengeEnterView:_editableInitView()
	self.actId = self.viewContainer.activityId
	self.config = ActivityConfig.instance:getActivityCo(self.actId)
	self._txtDescr.text = self.config.actDesc
	self._animator = gohelper.onceAddComponent(self.viewGO, gohelper.Type_Animator)
	self._rewardReddotAnim = gohelper.findChildComponent(self._btnReward.gameObject, "ani", gohelper.Type_Animator)

	RedDotController.instance:addRedDot(self._gorewardreddot, RedDotEnum.DotNode.V2a5_Act183Task, nil, self._taskReddotFunc, self)
	Act183Model.instance:setActivityId(self.actId)
	RedDotRpc.instance:sendGetRedDotInfosRequest({
		RedDotEnum.DotNode.V2a5_Act183Task
	})

	self._imagetaskicon = gohelper.findChildImage(self.viewGO, "Right/#btn_Reward/ani/baoxiang")

	self.addEventCb(self, VersionActivityBaseController.instance, VersionActivityEnterViewEvent.SelectActId, self.onSelectActId, self, LuaEventSystem.Low)
end

function VersionActivity2_5ChallengeEnterView:_taskReddotFunc(reddotIcon)
	reddotIcon:defaultRefreshDot()
	self._rewardReddotAnim:Play(reddotIcon.show and "loop" or "idle", 0, 0)
end

function VersionActivity2_5ChallengeEnterView:onOpen()
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self._onActStatusChange, self)
	self:_freshLockStatus()
	self:_showLeftTime()
	TaskDispatcher.runRepeat(self._showLeftTime, self, 1)
end

function VersionActivity2_5ChallengeEnterView:onDestroyView()
	TaskDispatcher.cancelTask(self._showLeftTime, self)
end

function VersionActivity2_5ChallengeEnterView:_freshLockStatus()
	local status = ActivityHelper.getActivityStatus(self.actId)
	local isNotUnlock = status == ActivityEnum.ActivityStatus.NotUnlock

	ZProj.UGUIHelper.SetGrayscale(self._btnEnter.gameObject, isNotUnlock)
	ZProj.UGUIHelper.SetGrayscale(self._imagetaskicon.gameObject, isNotUnlock)
	gohelper.setActive(self._goTips, isNotUnlock)

	if isNotUnlock then
		ZProj.UGUIHelper.SetGrayFactor(self._btnEnter.gameObject, Locked_EnterBtn_GrayFactor)
		ZProj.UGUIHelper.SetGrayFactor(self._imagetaskicon.gameObject, Locked_TaskBtn_GrayFactor)

		self._txtUnLocked.text = OpenHelper.getActivityUnlockTxt(self.config.openId)
	end
end

function VersionActivity2_5ChallengeEnterView:_showLeftTime()
	self._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(self.actId)
end

function VersionActivity2_5ChallengeEnterView:_onActStatusChange()
	self:_freshLockStatus()
end

function VersionActivity2_5ChallengeEnterView:onSelectActId(actId)
	if self.actId ~= actId then
		return
	end

	self._animator:Play("open", 0, 0)
end

return VersionActivity2_5ChallengeEnterView
