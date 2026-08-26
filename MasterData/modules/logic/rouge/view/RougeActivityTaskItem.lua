-- chunkname: @modules/logic/rouge/view/RougeActivityTaskItem.lua

module("modules.logic.rouge.view.RougeActivityTaskItem", package.seeall)

local RougeActivityTaskItem = class("RougeActivityTaskItem", ListScrollCellExtend)

RougeActivityTaskItem.BlockKey = "RougeActivityTaskItem_Finish"

function RougeActivityTaskItem:onInitView()
	self._scrollDesc = gohelper.findChildScrollRect(self.viewGO, "#scroll_Desc")
	self._txtDesc = gohelper.findChildTextMesh(self.viewGO, "#scroll_Desc/Viewport/Content/txt_Desc")
	self._btnjump = gohelper.findChildButtonWithAudio(self.viewGO, "btn/#btn_jump")
	self._btncanget = gohelper.findChildButtonWithAudio(self.viewGO, "btn/#btn_canget")
	self._gofinished = gohelper.findChild(self.viewGO, "btn/#go_finished")
	self._gotime = gohelper.findChild(self.viewGO, "time")
	self._txttime = gohelper.findChildText(self.viewGO, "time/#txt_time")
	self._txtcount = gohelper.findChildText(self.viewGO, "#scroll_Reward/Viewport/Content/#go_rewardItem/count")
	self._txtnum = gohelper.findChildText(self.viewGO, "progress/#txt_num")
	self._txttotal = gohelper.findChildText(self.viewGO, "progress/#txt_num/#txt_total")
	self._goLine = gohelper.findChild(self.viewGO, "go_line")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeActivityTaskItem:addEvents()
	self._btnjump:AddClickListener(self.onClickBtnJump, self)
	self._btncanget:AddClickListener(self.onClickBtnCanget, self)
	self.addEventCb(self, Activity186Controller.instance, Activity186Event.FinishAllTask, self.onTaskFinish, self)
end

function RougeActivityTaskItem:removeEvents()
	self._btnjump:RemoveClickListener()
	self._btncanget:RemoveClickListener()
end

function RougeActivityTaskItem:onClickBtnCanget()
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
		Activity186Rpc.instance:sendFinishAllAct186TaskRequest(config.activityId)
	end
end

function RougeActivityTaskItem:onTaskFinish(msg)
	if msg and tabletool.indexOf(msg.taskIds, self._mo.config.id) then
		gohelper.setActive(self._gofinished, true)
		self._animator:Play("finish", 0, 0)
		GameUtil.setActiveUIBlock(RougeActivityTaskItem.BlockKey, true, false)
		TaskDispatcher.cancelTask(self._onPlayFinishAnimDone, self)
		TaskDispatcher.runDelay(self._onPlayFinishAnimDone, self, 0.5)
	end
end

function RougeActivityTaskItem:_onPlayFinishAnimDone()
	GameUtil.setActiveUIBlock(RougeActivityTaskItem.BlockKey, false, true)
	self._view.viewContainer:removeTaskItemByIndex(self._index)
end

function RougeActivityTaskItem:onClickBtnJump()
	if not self._mo then
		return
	end

	local config = self._mo.config
	local jumpId = config.jumpId

	if jumpId and jumpId ~= 0 then
		GameFacade.jump(jumpId)
	end
end

function RougeActivityTaskItem:_editableInitView()
	self._animator = gohelper.onceAddComponent(self.viewGO, gohelper.Type_Animator)
	self._goNoJump = gohelper.findChild(self.viewGO, "btn/#go_nojump")
end

function RougeActivityTaskItem:_editableAddEvents()
	return
end

function RougeActivityTaskItem:_editableRemoveEvents()
	return
end

function RougeActivityTaskItem:onUpdateMO(mo)
	TaskDispatcher.cancelTask(self._onPlayFinishAnimDone, self)

	self._mo = mo
	self._config = self._mo.config
	self._loopType = self._config.loopType
	self._taskId = self._config.id

	self:refreshDesc()
	self:refreshJump()
	self:refreshRemainTime()
	self:refreshReward()
	self:refreshLine()
end

function RougeActivityTaskItem:getAnimator()
	return self._animator
end

function RougeActivityTaskItem:refreshDesc()
	local progress = self._mo.progress

	if self._config then
		if not self._config.maxProgress then
			if self._config then
				self._txtDesc.text = self._config.desc or ""
			end

			self._txttotal.text = 0
			self._txtnum.text = progress
		end
	end
end

function RougeActivityTaskItem:refreshJump()
	local canGetReward = self._mo.canGetReward
	local hasGetReward = self._mo.hasGetBonus

	gohelper.setActive(self._btncanget, canGetReward)
	gohelper.setActive(self._gofinished, hasGetReward)

	local jumpId = self._config.jumpId
	local canShowJump = jumpId and jumpId ~= 0 and not canGetReward and not hasGetReward

	gohelper.setActive(self._btnjump, canShowJump)
	gohelper.setActive(self._goNoJump, (not jumpId or jumpId == 0) and not hasGetReward and not canGetReward)
end

function RougeActivityTaskItem:refreshReward()
	local var_15_1 = GameUtil.splitString2(self._config and self._config.bonus, true)

	if not var_15_1 then
		var_15_1 = {}

		local rewards = var_15_1
		local rewardCo = rewards and rewards[1]
		local rewardNum = rewardCo and rewardCo[3]

		rewardNum = rewardNum or 0
		self._txtcount.text = rewardNum
	end
end

function RougeActivityTaskItem:refreshRemainTime()
	TaskDispatcher.runRepeat(self.tickUpdateTaskRemainTime, self, 1)
	self:tickUpdateTaskRemainTime()
end

function RougeActivityTaskItem:tickUpdateTaskRemainTime()
	if not self._mo.expireTime then
		local expireTime = 0
		local remainSec = expireTime / 1000 - ServerTime.now()
		local isExpired = remainSec <= 0
		local isRefreshTask = Activity186Config.instance:isRefreshTask(self._taskId)
		local showLimitTime = not isExpired and isRefreshTask

		gohelper.setActive(self._gotime, showLimitTime)

		if not showLimitTime then
			TaskDispatcher.cancelTask(self.tickUpdateTaskRemainTime, self)

			return
		end

		self._txttime.text = TimeUtil.secondToRoughTime3(remainSec)
	end
end

function RougeActivityTaskItem:refreshLine()
	local nextTaskMo = RougeActivityTaskListModel.instance:getByIndex(self._index + 1)
	local nextTaskCo = nextTaskMo and nextTaskMo.config
	local loopType = nextTaskCo and nextTaskCo.loopType

	gohelper.setActive(self._goLine, loopType and loopType ~= self._loopType)
end

function RougeActivityTaskItem:onDestroyView()
	TaskDispatcher.cancelTask(self.tickUpdateTaskRemainTime, self)
	TaskDispatcher.cancelTask(self._onPlayFinishAnimDone, self)
	GameUtil.setActiveUIBlock(RougeActivityTaskItem.BlockKey, false, true)
end

return RougeActivityTaskItem
