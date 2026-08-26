-- chunkname: @modules/logic/turnback/view/turnback4/Turnback4RewardView.lua

module("modules.logic.turnback.view.turnback4.Turnback4RewardView", package.seeall)

local Turnback4RewardView = class("Turnback4RewardView", BaseView)

function Turnback4RewardView:onInitView()
	self._txtdesc = gohelper.findChildText(self.viewGO, "Left/#txt_desc")
	self._goallfinish = gohelper.findChild(self.viewGO, "#go_allfinish")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")
	self._btnhelp = gohelper.findChildButton(self.viewGO, "#btn_tips")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Turnback4RewardView:addEvents()
	self._btnhelp:AddClickListener(self._onClickHelpBtn, self)
	self.addEventCb(self, TurnbackController.instance, TurnbackEvent.OnRefreshReturnRewardTask, self._refresh, self)
	self.addEventCb(self, TurnbackController.instance, TurnbackEvent.OnTurnbackReturnRewardReply, self._refreshReward, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self._refreshTaskState, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._refreshTaskState, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.UpdateTaskList, self._refreshTaskState, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.SetTaskList, self._refreshTaskState, self)
	self.addEventCb(self, TurnbackController.instance, TurnbackEvent.OnFinishReturnRewardRefreshAnim, self._onFinishReturnRewardRefreshAnim, self)
	self.addEventCb(self, TimeDispatcher.instance, TimeDispatcher.OnDailyRefresh, self.onDailyRefresh, self)
	self.addEventCb(self, TurnbackController.instance, TurnbackEvent.RefreshView, self._refresh, self)
end

function Turnback4RewardView:removeEvents()
	self._btnhelp:RemoveClickListener()
	self.removeEventCb(self, TurnbackController.instance, TurnbackEvent.OnRefreshReturnRewardTask, self._refresh, self)
	self.removeEventCb(self, TurnbackController.instance, TurnbackEvent.OnTurnbackReturnRewardReply, self._refreshReward, self)
	self.removeEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self._refreshTaskState, self)
	self.removeEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._refreshTaskState, self)
	self.removeEventCb(self, TaskController.instance, TaskEvent.UpdateTaskList, self._refreshTaskState, self)
	self.removeEventCb(self, TaskController.instance, TaskEvent.SetTaskList, self._refreshTaskState, self)
	self.removeEventCb(self, TurnbackController.instance, TurnbackEvent.OnFinishReturnRewardRefreshAnim, self._onFinishReturnRewardRefreshAnim, self)
	self.removeEventCb(self, TimeDispatcher.instance, TimeDispatcher.OnDailyRefresh, self.onDailyRefresh, self)
	self.removeEventCb(self, TurnbackController.instance, TurnbackEvent.RefreshView, self._refresh, self)
end

function Turnback4RewardView:_onClickHelpBtn()
	HelpController.instance:openBpRuleTipsView(luaLang("Turnback3BpViewTipTitle"), "Rule Details", luaLang("return4_reward_rule"))
end

function Turnback4RewardView:_editableInitView()
	self._txtdesc.text = luaLang("return4_reward_desc")
	self._rewardItems = self:getUserDataTb_()
	self._taskItems = self:getUserDataTb_()

	for i = 1, 2 do
		local go = gohelper.findChild(self.viewGO, "task" .. i)

		self._rewardItems[i] = MonoHelper.addNoUpdateLuaComOnceToGo(go, Turnback4RewardItem)

		local go1 = gohelper.findChild(self.viewGO, "#task_item" .. i)

		self._taskItems[i] = MonoHelper.addNoUpdateLuaComOnceToGo(go1, Turnback4ReturnTaskItem)
	end
end

function Turnback4RewardView:onDailyRefresh()
	TurnbackController.instance:sendGetTurnbackInfoRequest()
end

function Turnback4RewardView:onUpdateParam()
	return
end

function Turnback4RewardView:onOpen()
	local parentGO = self.viewParam.parent

	gohelper.addChild(parentGO, self.viewGO)

	self._turnbackInfoMo = TurnbackModel.instance:getCurTurnbackMo()

	self:_refresh()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Turnback
	}, self._refreshTask, self)
end

function Turnback4RewardView:_refresh()
	self:_refreshReward(true)
	self:_refreshTask()
end

function Turnback4RewardView:_refreshReward(isNeedShowAllFinish)
	local mos = self:_getRewardMos()
	local isAllFinish = true

	if mos then
		for i = 1, 2 do
			self._rewardItems[i]:onUpdateMO(mos[i])

			if mos[i].state ~= TurnbackEnum.SearchState.HasGet then
				isAllFinish = false
			end
		end
	end

	gohelper.setActive(self._goallfinish, isNeedShowAllFinish and isAllFinish)
end

function Turnback4RewardView:_onFinishReturnRewardRefreshAnim()
	self:_refreshReward(true)
end

function Turnback4RewardView:_getRewardMos()
	local rewardMoList = self._turnbackInfoMo:getReturnRewardList()

	if not rewardMoList then
		return
	end

	local list = {}

	for _, mo in ipairs(rewardMoList) do
		if mo.state ~= TurnbackEnum.SearchState.HasGet then
			table.insert(list, mo)

			if #list == 2 then
				return list
			end
		end
	end

	local listCount = #list

	if listCount < 2 then
		for i = 1, 2 do
			local mo = rewardMoList[#rewardMoList - i + 1]

			if mo then
				list[3 - i] = mo
			end
		end
	end

	return list
end

function Turnback4RewardView:_refreshTask()
	self._turnbackInfoMo = TurnbackModel.instance:getCurTurnbackMo()

	if self._taskItems[1] then
		local type = TurnbackEnum.TaskType.DailyReset
		local mo = self:_getTaskMo(type)

		self._taskItems[1]:onUpdateMO(mo, type)
	end

	if self._taskItems[2] then
		local type = TurnbackEnum.TaskType.DailyRefresh
		local mo = self:_getTaskMo(type)

		self._taskItems[2]:onUpdateMO(mo, type)
	end

	self:_refreshTaskState()
end

function Turnback4RewardView:_refreshTaskState()
	if not self._taskItems then
		return
	end

	for _, item in ipairs(self._taskItems) do
		item:refreshTaskState()
	end
end

function Turnback4RewardView:_getTaskMo(type)
	local taskIdList = self._turnbackInfoMo:getReturnTaskIds()

	for i, id in ipairs(taskIdList) do
		local mo = TaskModel.instance:getTaskById(id)

		if mo then
			if not mo.config then
				local config = TurnbackConfig.instance:getTurnbackTaskCo(id)

				if config and config.turnbackTaskType == type then
					return mo
				end
			end
		end
	end
end

function Turnback4RewardView:onClose()
	return
end

function Turnback4RewardView:onDestroyView()
	return
end

return Turnback4RewardView
