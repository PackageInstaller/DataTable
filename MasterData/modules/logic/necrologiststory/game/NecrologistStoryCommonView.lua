-- chunkname: @modules/logic/necrologiststory/game/NecrologistStoryCommonView.lua

module("modules.logic.necrologiststory.game.NecrologistStoryCommonView", package.seeall)

local NecrologistStoryCommonView = class("NecrologistStoryCommonView", BaseView)

function NecrologistStoryCommonView:ctor(rootPath)
	NecrologistStoryCommonView.super.ctor(self)

	self._rootPath = rootPath or ""
end

function NecrologistStoryCommonView:onInitView()
	self.rootGO = gohelper.findChild(self.viewGO, self._rootPath)
	self.btnReward = gohelper.findChildButtonWithAudio(self.rootGO, "#btn_reward")
	self.goRewardRed = gohelper.findChild(self.rootGO, "#btn_reward/#go_reddot")
	self.goRewardTime = gohelper.findChild(self.rootGO, "#btn_reward/#go_time")
	self.txtRewardTime = gohelper.findChildTextMesh(self.rootGO, "#btn_reward/#go_time/#txt_time")
	self.txtRewardTimeFormat = gohelper.findChildTextMesh(self.rootGO, "#btn_reward/#go_time/#txt_time/#txt_format")
	self.btnReview = gohelper.findChildButtonWithAudio(self.rootGO, "#btn_review")
	self.btnBranch = gohelper.findChildButtonWithAudio(self.rootGO, "#btn_branch")
	self.animReward = self.btnReward.gameObject:GetComponent(typeof(UnityEngine.Animator))

	if self.btnBranch then
		self.animBranch = gohelper.findComponentAnim(self.btnBranch.gameObject)
	end

	if self._editableInitView then
		self:_editableInitView()
	end
end

function NecrologistStoryCommonView:addEvents()
	self.addClickCb(self, self.btnReward, self.onClickBtnReward, self)
	self.addClickCb(self, self.btnReview, self.onClickBtnReview, self)

	if self.btnBranch then
		self.addClickCb(self, self.btnBranch, self.onClickBtnBranch, self)
	end

	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
end

function NecrologistStoryCommonView:removeEvents()
	self:removeClickCb(self.btnReward)
	self:removeClickCb(self.btnReview)

	if self.btnBranch then
		self:removeClickCb(self.btnBranch)
	end

	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
end

function NecrologistStoryCommonView:_editableInitView()
	return
end

function NecrologistStoryCommonView:onClickBtnBranch()
	if not self._isBranchVisible then
		return
	end

	if not self.gameBaseMO then
		return
	end

	NecrologistStoryController.instance:openBranchView(self.gameBaseMO.id)
end

function NecrologistStoryCommonView:onClickBtnReward()
	if not self.gameBaseMO then
		return
	end

	NecrologistStoryController.instance:openTaskView(self.gameBaseMO.id)
end

function NecrologistStoryCommonView:onClickBtnReview()
	if not self.gameBaseMO then
		return
	end

	NecrologistStoryController.instance:openReviewView(self.gameBaseMO.id)
end

function NecrologistStoryCommonView:_onCloseViewFinish(viewName)
	self:refreshView()
end

function NecrologistStoryCommonView:onOpen()
	self:refreshParam()
	self:refreshView()
end

function NecrologistStoryCommonView:onUpdateParam()
	self:refreshParam()
	self:refreshView()
end

function NecrologistStoryCommonView:refreshParam()
	local storyId = self.viewParam.roleStoryId

	self.gameBaseMO = NecrologistStoryModel.instance:getGameMO(storyId)

	RedDotController.instance:addRedDot(self.goRewardRed, RedDotEnum.DotNode.NecrologistStoryTask, storyId, self.refreshRed, self)
end

function NecrologistStoryCommonView:refreshView()
	self:refreshRewardTime()
	self:refreshButton()
end

function NecrologistStoryCommonView:refreshRed(redDot)
	redDot:defaultRefreshDot()

	if redDot.show then
		self.animReward:Play("lingqu")
	else
		self.animReward:Play("idle")
	end
end

function NecrologistStoryCommonView:refreshRewardTime()
	local hasLimitTaskNotFinish = NecrologistStoryTaskListModel.instance:hasLimitTaskNotFinish(self.gameBaseMO.id)

	gohelper.setActive(self.goRewardTime, hasLimitTaskNotFinish)

	if not hasLimitTaskNotFinish then
		return
	end

	self:_frameRefreshRewardTime()
	TaskDispatcher.cancelTask(self._frameRefreshRewardTime, self)
	TaskDispatcher.runDelay(self._frameRefreshRewardTime, self, 1)
end

function NecrologistStoryCommonView:_frameRefreshRewardTime()
	if not self.gameBaseMO then
		return
	end

	local cfg = RoleStoryConfig.instance:getStoryById(self.gameBaseMO.id)
	local activityId = cfg.activityId
	local actInfoMo = ActivityModel.instance:getActMO(activityId)

	if not actInfoMo then
		return
	end

	local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()

	if offsetSecond > 0 then
		local time, timeFormat = TimeUtil.secondToRoughTime2(offsetSecond, true)

		self.txtRewardTime.text = time
		self.txtRewardTimeFormat.text = timeFormat
	else
		gohelper.setActive(self.goRewardTime, false)
		TaskDispatcher.cancelTask(self._frameRefreshRewardTime, self)
	end
end

function NecrologistStoryCommonView:refreshButton()
	local hasPlotFinish = NecrologistStoryModel.instance:isReviewCanShow(self.gameBaseMO.id)

	gohelper.setActive(self.btnReview, hasPlotFinish)

	local isShowBranch, isUnlockBranch = NecrologistStoryModel.instance:isBranchCanShow(self.gameBaseMO.id)

	if isShowBranch then
		self:setBranchVisible(isUnlockBranch)
	else
		gohelper.setActive(self.btnBranch, false)
	end
end

function NecrologistStoryCommonView:setBranchVisible(isShow)
	if self._isBranchVisible == isShow then
		return
	end

	local lastVisible = self._isBranchVisible

	self._isBranchVisible = isShow

	if not self.animBranch then
		gohelper.setActive(self.btnBranch, isShow)

		return
	end

	gohelper.setActive(self.btnBranch, true)

	if isShow then
		if lastVisible == nil then
			self.animBranch:Play("unlock_idle")
		else
			self.animBranch:Play("unlock")
		end
	else
		self.animBranch:Play("idle")
	end
end

function NecrologistStoryCommonView:onDestroyView()
	TaskDispatcher.cancelTask(self._frameRefreshRewardTime, self)
end

return NecrologistStoryCommonView
