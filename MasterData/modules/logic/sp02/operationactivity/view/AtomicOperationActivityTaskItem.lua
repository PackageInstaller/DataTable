-- chunkname: @modules/logic/sp02/operationactivity/view/AtomicOperationActivityTaskItem.lua

module("modules.logic.sp02.operationactivity.view.AtomicOperationActivityTaskItem", package.seeall)

local AtomicOperationActivityTaskItem = class("AtomicOperationActivityTaskItem", ListScrollCellExtend)

function AtomicOperationActivityTaskItem:onInitView()
	self._goSecretBG = gohelper.findChild(self.viewGO, "#go_SecretBG")
	self._scrollDesc = gohelper.findChildScrollRect(self.viewGO, "#scroll_Desc")
	self.txtDesc = gohelper.findChildTextMesh(self.viewGO, "#scroll_Desc/Viewport/Content/txt_Desc")
	self._btnjump = gohelper.findChildButtonWithAudio(self.viewGO, "btn/#btn_jump")
	self._btncanget = gohelper.findChildButtonWithAudio(self.viewGO, "btn/#btn_canget")
	self._gofinished = gohelper.findChild(self.viewGO, "btn/#go_finished")
	self._goreward = gohelper.findChild(self.viewGO, "#go_reward")
	self._gorewardItem = gohelper.findChild(self.viewGO, "#scroll_Reward/Viewport/Content/#go_rewardItem")
	self._gotime = gohelper.findChild(self.viewGO, "time")
	self._txttime = gohelper.findChildText(self.viewGO, "time/#txt_time")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AtomicOperationActivityTaskItem:addEvents()
	self._btnjump:AddClickListener(self.onClickBtnJump, self)
	self._btncanget:AddClickListener(self.onClickBtnCanget, self)
	self.addEventCb(self, Activity186Controller.instance, Activity186Event.FinishTask, self.onTaskFinish, self)
end

function AtomicOperationActivityTaskItem:removeEvents()
	self._btnjump:RemoveClickListener()
	self._btncanget:RemoveClickListener()
	self.removeEventCb(self, Activity186Controller.instance, Activity186Event.FinishTask, self.onTaskFinish, self)
end

function AtomicOperationActivityTaskItem:onClickBtnCanget()
	if not self._mo then
		return
	end

	if not self._mo.canGetReward then
		return
	end

	local config = self._mo.config

	if self._mo.isGlobalTask then
		TaskRpc.instance:sendFinishTaskRequest(config.id)
	else
		Activity186Rpc.instance:sendFinishAct186TaskRequest(config.activityId, config.id)
	end
end

function AtomicOperationActivityTaskItem:onTaskFinish(msg)
	if msg and msg.taskId == self._mo.config.id then
		gohelper.setActive(self._gofinished, true)
		self.anim:Play("finish", 0, 0)
	end
end

function AtomicOperationActivityTaskItem:onClickBtnJump()
	if not self._mo then
		return
	end

	local config = self._mo.config
	local jumpId = config.jumpId

	if jumpId and jumpId ~= 0 then
		GameFacade.jump(jumpId)
	end
end

function AtomicOperationActivityTaskItem:_editableInitView()
	self.anim = self.viewGO:GetComponent(gohelper.Type_Animator)
	self.txtIndex = gohelper.findChildTextMesh(self.viewGO, "#txtIndex")
	self._goDay = gohelper.findChild(self.viewGO, "Dec/#go_day")
	self._goWeek = gohelper.findChild(self.viewGO, "Dec/#go_week")
	self._goActivity = gohelper.findChild(self.viewGO, "Dec/#go_acticity")
	self._goNoJump = gohelper.findChild(self.viewGO, "btn/#go_nojump")
end

function AtomicOperationActivityTaskItem:_editableAddEvents()
	return
end

function AtomicOperationActivityTaskItem:_editableRemoveEvents()
	return
end

function AtomicOperationActivityTaskItem:onUpdateMO(mo)
	self._mo = mo
	self.config = self._mo.config

	self:refreshDesc()
	self:refreshJump()
	self:refreshRemainTime()
	self:refreshReward()
end

function AtomicOperationActivityTaskItem:getAnimator()
	return self.anim
end

function AtomicOperationActivityTaskItem:refreshDesc()
	self.txtIndex.text = tostring(self.config.minType)

	local progress = self._mo.progress

	if self.config then
		if not self.config.maxProgress then
			local maxProgress = 0

			self.txtDesc.text = string.format("%s\n(%s/%s)", (self.config or nil) and (self.config.desc or ""), progress, maxProgress)

			gohelper.setActive(self._goDay, self.config.loopType == AtomicOperationActivityEnum.LoopType.Day)
			gohelper.setActive(self._goWeek, self.config.loopType == AtomicOperationActivityEnum.LoopType.Week)
			gohelper.setActive(self._goActivity, self.config.loopType == AtomicOperationActivityEnum.LoopType.Activity)
		end
	end
end

function AtomicOperationActivityTaskItem:refreshJump()
	local canGetReward = self._mo.canGetReward
	local hasGetReward = self._mo.hasGetBonus

	gohelper.setActive(self._btncanget, canGetReward)
	gohelper.setActive(self._gofinished, hasGetReward)

	local config = self._mo.config
	local jumpId = config.jumpId
	local canShowJump = jumpId and jumpId ~= 0 and not canGetReward and not hasGetReward

	gohelper.setActive(self._btnjump, canShowJump)
	gohelper.setActive(self._goNoJump, (not jumpId or jumpId == 0) and not hasGetReward and not canGetReward)
end

function AtomicOperationActivityTaskItem:refreshReward()
	local var_14_1 = GameUtil.splitString2(self.config and self.config.bonus, true)

	if not var_14_1 then
		var_14_1 = {}

		local rewards = var_14_1

		gohelper.CreateObjList(self, self.onCreateRewardItem, rewards, nil, self._gorewardItem, CommonItemIcon)
	end
end

function AtomicOperationActivityTaskItem:onCreateRewardItem(rewardItem, rewardParam, index)
	rewardItem:setMOValue(rewardParam[1], rewardParam[2], rewardParam[3])
end

function AtomicOperationActivityTaskItem:refreshRemainTime()
	TaskDispatcher.runRepeat(self.tickUpdateTaskRemainTime, self, 1)
	self:tickUpdateTaskRemainTime()
end

function AtomicOperationActivityTaskItem:tickUpdateTaskRemainTime()
	if not self._mo.expireTime then
		local expireTime = 0
		local remainSec = expireTime / 1000 - ServerTime.now()
		local isExpired = remainSec <= 0
		local isLimitTimeTask = true
		local showLimitTime = not isExpired and not self._mo.hasGetBonus and isLimitTimeTask

		gohelper.setActive(self._gotime, showLimitTime)

		if not showLimitTime then
			TaskDispatcher.cancelTask(self.tickUpdateTaskRemainTime, self)

			return
		end

		self._txttime.text = TimeUtil.secondToRoughTime3(remainSec)
	end
end

function AtomicOperationActivityTaskItem:onDestroyView()
	TaskDispatcher.cancelTask(self.tickUpdateTaskRemainTime, self)
end

return AtomicOperationActivityTaskItem
