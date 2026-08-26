-- chunkname: @modules/logic/versionactivity2_5/challenge/view/enter/Act183VersionActivityEnterView.lua

module("modules.logic.versionactivity2_5.challenge.view.enter.Act183VersionActivityEnterView", package.seeall)

local Act183VersionActivityEnterView = class("Act183VersionActivityEnterView", BaseViewExtended)
local Locked_EnterBtn_GrayFactor = 0.8
local Locked_TaskBtn_GrayFactor = 0.8

function Act183VersionActivityEnterView:onInitView()
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
	self._gostore = gohelper.findChild(self.viewGO, "Right/#go_store")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Act183VersionActivityEnterView:addEvents()
	self._btnEnter:AddClickListener(self._btnEnterOnClick, self)
	self._btnReward:AddClickListener(self._btnRewardOnClick, self)
end

function Act183VersionActivityEnterView:removeEvents()
	self._btnEnter:RemoveClickListener()
	self._btnReward:RemoveClickListener()
end

function Act183VersionActivityEnterView:_btnEnterOnClick()
	local status, toastId, paramList = ActivityHelper.getActivityStatusAndToast(self.actId)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		GameFacade.showToastWithTableParam(toastId, paramList)

		return
	end

	Act183Controller.instance:openAct183MainView()
end

function Act183VersionActivityEnterView:_btnRewardOnClick()
	local status, toastId, paramList = ActivityHelper.getActivityStatusAndToast(self.actId)

	if status ~= ActivityEnum.ActivityStatus.Normal then
		GameFacade.showToastWithTableParam(toastId, paramList)

		return
	end

	Act183Controller.instance:openAct183TaskView()
end

function Act183VersionActivityEnterView:_editableInitView()
	self.actId = self.viewContainer.activityId

	Act183Model.instance:setActivityId(self.actId)

	self.config = ActivityConfig.instance:getActivityCo(self.actId)
	self._txtDescr.text = self.config.actDesc
	self._animator = gohelper.onceAddComponent(self.viewGO, gohelper.Type_Animator)
	self._rewardReddotAnim = gohelper.findChildComponent(self._btnReward.gameObject, "ani", gohelper.Type_Animator)

	RedDotController.instance:addRedDot(self._gorewardreddot, RedDotEnum.DotNode.V2a5_Act183Task, nil, self._taskReddotFunc, self)
	RedDotRpc.instance:sendGetRedDotInfosRequest({
		RedDotEnum.DotNode.V2a5_Act183Task
	})

	self._imagetaskicon = gohelper.findChildImage(self.viewGO, "Right/#btn_Reward/ani/baoxiang")

	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self._onActStatusChange, self)
	self.addEventCb(self, VersionActivityBaseController.instance, VersionActivityEnterViewEvent.SelectActId, self.onSelectActId, self, LuaEventSystem.Low)
end

function Act183VersionActivityEnterView:_taskReddotFunc(reddotIcon)
	reddotIcon:defaultRefreshDot()
	self._rewardReddotAnim:Play(reddotIcon.show and "loop" or "idle", 0, 0)
end

function Act183VersionActivityEnterView:onOpen()
	self:_freshLockStatus()
	self:_showLeftTime()
	TaskDispatcher.runRepeat(self._showLeftTime, self, 1)
	self:openExclusiveView(nil, 1, Act183StoreEntry, Act183Enum.StoreEntryPrefabUrl, self._gostore)
end

function Act183VersionActivityEnterView:onDestroyView()
	TaskDispatcher.cancelTask(self._showLeftTime, self)
end

function Act183VersionActivityEnterView:_freshLockStatus()
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

function Act183VersionActivityEnterView:_showLeftTime()
	self._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(self.actId)
end

function Act183VersionActivityEnterView:_onActStatusChange()
	self:_freshLockStatus()
end

function Act183VersionActivityEnterView:onSelectActId(actId)
	if self.actId ~= actId then
		return
	end

	self._animator:Play("open", 0, 0)
end

return Act183VersionActivityEnterView
