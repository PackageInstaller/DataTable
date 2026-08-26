-- chunkname: @modules/logic/task/view/TaskWeeklyView.lua

module("modules.logic.task.view.TaskWeeklyView", package.seeall)

local TaskWeeklyView = class("TaskWeeklyView", BaseView)

function TaskWeeklyView:onInitView()
	self._goleft = gohelper.findChild(self.viewGO, "#go_left")
	self._goallcomplete = gohelper.findChild(self.viewGO, "#go_allcomplete")
	self._gonormaltask = gohelper.findChild(self.viewGO, "#go_left/Viewport/#go_normaltask")
	self._gotasklevel = gohelper.findChild(self.viewGO, "#go_left/Viewport/#go_normaltask/#go_tasklevel")
	self._goright = gohelper.findChild(self.viewGO, "#go_right")
	self._gotaskitemcontent = gohelper.findChild(self.viewGO, "#go_right/viewport/#go_taskitemcontent")
	self._txtLeftTime = gohelper.findChildText(self.viewGO, "#go_right/#txtLeftTime")
	self._allCompleteAni = self._goallcomplete:GetComponent(typeof(UnityEngine.Animator))

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TaskWeeklyView:addEvents()
	return
end

function TaskWeeklyView:removeEvents()
	return
end

function TaskWeeklyView:_editableInitView()
	gohelper.setActive(self._goallcomplete, false)

	self._tasklevels = {}
	self._taskItems = {}
end

function TaskWeeklyView:onUpdateParam()
	self:_refreshWeekly()
end

function TaskWeeklyView:onOpen()
	self.addEventCb(self, TaskController.instance, TaskEvent.UpdateTaskList, self._updateWeekly, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.SetTaskList, self._updateWeekly, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self._updateWeekly, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.OnShowTaskFinished, self._onShowTaskFinished, self)

	local totalStage = TaskModel.instance:getMaxStage(TaskEnum.TaskType.Weekly)
	local curStage = TaskModel.instance:getTaskActivityMO(TaskEnum.TaskType.Weekly).defineId + 1

	if totalStage - curStage >= 5 then
		if not (160 * (curStage - 1)) then
			local y = 160 * (totalStage - 5)

			transformhelper.setLocalPosXY(self._gonormaltask.transform, 0, y)

			local initType = TaskView.getInitTaskType()
			local count = TaskModel.instance:getRefreshCount()

			if count == 0 and initType ~= TaskEnum.TaskType.Weekly then
				return
			end

			if #self._taskItems < 1 then
				self:_refreshWeekly()
			end

			self:_showAllComplete()
		end
	end
end

function TaskWeeklyView:_onShowTaskFinished(taskType)
	if taskType == TaskEnum.TaskType.Weekly then
		return
	end

	self:_refreshWeekly()
end

function TaskWeeklyView:_refreshWeekly()
	local open = TaskModel.instance:getRefreshCount() < 2

	self:_refreshLeftTime()
	TaskDispatcher.cancelTask(self._refreshLeftTime, self)
	TaskDispatcher.runRepeat(self._refreshLeftTime, self, 1)
	self:_refreshTaskLevelItem(open)
	self:_setCommonTaskItem(open)
end

function TaskWeeklyView:_updateWeekly()
	local totalStage = TaskModel.instance:getMaxStage(TaskEnum.TaskType.Weekly)
	local curStage = TaskModel.instance:getTaskActivityMO(TaskEnum.TaskType.Weekly).defineId + 1

	if totalStage - curStage >= 5 then
		if not (160 * (curStage - 1)) then
			local y = 160 * (totalStage - 5)

			transformhelper.setLocalPosXY(self._gonormaltask.transform, 0, y)
			TaskDispatcher.cancelTask(self._refreshLeftTime, self)
			TaskDispatcher.cancelTask(self._updateItems, self)
			UIBlockMgr.instance:startBlock("taskupdateitems")
			TaskDispatcher.runDelay(self._updateItems, self, 0.4)
		end
	end
end

function TaskWeeklyView:_updateItems()
	self:_refreshTaskLevelItem()
	self:_setCommonTaskItem()
	self:_refreshLeftTime()
	TaskDispatcher.cancelTask(self._refreshLeftTime, self)
	TaskDispatcher.runRepeat(self._refreshLeftTime, self, 1)
	self:_showAllComplete()
	UIBlockMgr.instance:endBlock("taskupdateitems")
end

function TaskWeeklyView:_showAllComplete()
	local isAllRewardGet = TaskModel.instance:isAllRewardGet(TaskEnum.TaskType.Weekly)

	gohelper.setActive(self._goallcomplete, isAllRewardGet)

	if isAllRewardGet then
		for _, v in pairs(self._tasklevels) do
			v:showAllComplete()
		end

		for _, v in pairs(self._taskItems) do
			v:showAllComplete()
		end
	end
end

function TaskWeeklyView:_refreshLeftTime()
	local leftSecond = TaskModel.instance:getTaskTypeExpireTime(TaskEnum.TaskType.Weekly) - ServerTime.now()

	if leftSecond > 0 then
		local date = TimeUtil.secondToRoughTime3(leftSecond, false)

		self._txtLeftTime.text = date and luaLang("task_remaintime") .. date or ""
	else
		self._txtLeftTime.text = luaLang("bp_dateLeft_timeout")
	end
end

function TaskWeeklyView:_refreshTaskLevelItem(open)
	local actCo = TaskConfig.instance:getTaskActivityBonusConfig(TaskEnum.TaskType.Weekly)
	local isAllRewardGet = TaskModel.instance:isAllRewardGet(TaskEnum.TaskType.Weekly)

	for i = 1, #actCo do
		if not self._tasklevels[i] then
			local child = gohelper.cloneInPlace(self._gotasklevel.gameObject)

			gohelper.setActive(child, true)

			self._tasklevels[i] = TaskListCommonLevelItem.New()

			self._tasklevels[i]:init(child, self._goleft)
		end

		self._tasklevels[i]:setItem(i, actCo[i], TaskEnum.TaskType.Weekly, open)
	end

	self:_showAllComplete()

	if isAllRewardGet then
		if open then
			self._allCompleteAni:Play(UIAnimationName.Open)
		else
			self._allCompleteAni:Play(UIAnimationName.Idle)
		end
	end
end

function TaskWeeklyView:_setCommonTaskItem(open)
	if self._taskItems then
		for _, v in pairs(self._taskItems) do
			gohelper.setActive(v.go, false)
		end
	end

	local isAllRewardGet = TaskModel.instance:isAllRewardGet(TaskEnum.TaskType.Weekly)

	if isAllRewardGet then
		local var_14_0 = {}

		if not var_14_0 then
			var_14_0 = TaskModel.instance:getAllRewardUnreceivedTasks(TaskEnum.TaskType.Weekly)

			local rewardTasks = var_14_0
			local list = TaskListModel.instance:getTaskList(TaskEnum.TaskType.Weekly)

			if #rewardTasks >= 2 then
				if not (#list + 1) then
					local count = #list

					if open then
						UIBlockMgr.instance:startBlock("taskani")

						self._repeatCount = 0

						TaskDispatcher.runRepeat(self.showByLine, self, 0.04, count)
					else
						for i = 1, count do
							local co

							self:setItem(#rewardTasks >= 2 and (i ~= 1 or true) and list[i - 1] or list[i], i, false)
						end
					end
				end
			end
		end
	end
end

function TaskWeeklyView:showByLine()
	self._repeatCount = self._repeatCount + 1

	local isAllRewardGet = TaskModel.instance:isAllRewardGet(TaskEnum.TaskType.Weekly)

	if isAllRewardGet then
		local var_15_0 = {}

		if not var_15_0 then
			var_15_0 = TaskModel.instance:getAllRewardUnreceivedTasks(TaskEnum.TaskType.Weekly)

			local rewardTasks = var_15_0
			local list = TaskListModel.instance:getTaskList(TaskEnum.TaskType.Weekly)

			if #rewardTasks >= 2 then
				if not (#list + 1) then
					local count = #list
					local co

					self:setItem(#rewardTasks >= 2 and (self._repeatCount ~= 1 or true) and list[self._repeatCount - 1] or list[self._repeatCount], self._repeatCount, true)

					if count <= self._repeatCount then
						UIBlockMgr.instance:endBlock("taskani")
						TaskDispatcher.cancelTask(self.showByLine, self)
						TaskDispatcher.runDelay(self._onStartTaskFinished, self, 0.5)
					end
				end
			end
		end
	end
end

function TaskWeeklyView:_onStartTaskFinished()
	local count = TaskModel.instance:getRefreshCount()

	TaskModel.instance:setRefreshCount(count + 1)
	TaskController.instance:dispatchEvent(TaskEvent.OnShowTaskFinished, TaskEnum.TaskType.Weekly)
end

function TaskWeeklyView:setItem(co, index, open)
	self._taskItems = self._taskItems or {}

	if self._taskItems[index] then
		self._taskItems[index]:showIdle()
		self._taskItems[index]:reset(TaskEnum.TaskType.Weekly, index, co)
	else
		local res = self.viewContainer:getSetting().otherRes[1]
		local go = self:getResInst(res, self._gotaskitemcontent, "item" .. index)

		self._taskItems[index] = TaskListCommonItem.New()

		self._taskItems[index]:init(go, TaskEnum.TaskType.Weekly, index, co, open)
	end

	gohelper.setSibling(self._taskItems[index].go, index)
end

function TaskWeeklyView:onClose()
	return
end

function TaskWeeklyView:onDestroyView()
	self.removeEventCb(self, TaskController.instance, TaskEvent.UpdateTaskList, self._updateWeekly, self)
	self.removeEventCb(self, TaskController.instance, TaskEvent.SetTaskList, self._updateWeekly, self)
	self.removeEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self._updateWeekly, self)
	self.removeEventCb(self, TaskController.instance, TaskEvent.OnShowTaskFinished, self._onShowTaskFinished, self)
	TaskDispatcher.cancelTask(self.showByLine, self)
	TaskDispatcher.cancelTask(self._updateItems, self)
	TaskDispatcher.cancelTask(self._refreshLeftTime, self)

	if self._tasklevels then
		for _, tasklevel in pairs(self._tasklevels) do
			tasklevel:destroy()
		end

		self._tasklevels = nil
	end

	if self._taskItems then
		for i, taskItem in ipairs(self._taskItems) do
			taskItem:destroy()
		end

		self._taskItems = nil
	end
end

return TaskWeeklyView
