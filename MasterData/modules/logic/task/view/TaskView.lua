-- chunkname: @modules/logic/task/view/TaskView.lua

module("modules.logic.task.view.TaskView", package.seeall)

local TaskView = class("TaskView", BaseView)

function TaskView:onInitView()
	self._golineicon = gohelper.findChild(self.viewGO, "bg/#go_lineIcon")
	self._gonovice = gohelper.findChild(self.viewGO, "top/#go_novice")
	self._gonoviceunchoose = gohelper.findChild(self.viewGO, "top/#go_novice/#go_noviceunchoose")
	self._gonovicechoose = gohelper.findChild(self.viewGO, "top/#go_novice/#go_novicechoose")
	self._gotasknovicereddot = gohelper.findChild(self.viewGO, "top/#go_novice/#go_tasknovicereddot")
	self._btnnovice = gohelper.findChildButtonWithAudio(self.viewGO, "top/#go_novice/#btn_novice")
	self._goweek = gohelper.findChild(self.viewGO, "top/#go_week")
	self._goweekunchoose = gohelper.findChild(self.viewGO, "top/#go_week/#go_weekunchoose")
	self._goweekchoose = gohelper.findChild(self.viewGO, "top/#go_week/#go_weekchoose")
	self._gotaskweekreddot = gohelper.findChild(self.viewGO, "top/#go_week/#go_taskweekreddot")
	self._btnweek = gohelper.findChildButtonWithAudio(self.viewGO, "top/#go_week/#btn_week")
	self._goday = gohelper.findChild(self.viewGO, "top/#go_day")
	self._godayunchoose = gohelper.findChild(self.viewGO, "top/#go_day/#go_dayunchoose")
	self._godaychoose = gohelper.findChild(self.viewGO, "top/#go_day/#go_daychoose")
	self._gotaskdayreddot = gohelper.findChild(self.viewGO, "top/#go_day/#go_taskdayreddot")
	self._btnday = gohelper.findChildButtonWithAudio(self.viewGO, "top/#go_day/#btn_day")
	self._goline1 = gohelper.findChild(self.viewGO, "top/#go_line1")
	self._goline2 = gohelper.findChild(self.viewGO, "top/#go_line2")
	self._gocontainer = gohelper.findChild(self.viewGO, "#go_container")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TaskView:addEvents()
	self._btnnovice:AddClickListener(self._btnnoviceOnClick, self)
	self._btnweek:AddClickListener(self._btnweekOnClick, self)
	self._btnday:AddClickListener(self._btndayOnClick, self)
end

function TaskView:removeEvents()
	self._btnnovice:RemoveClickListener()
	self._btnweek:RemoveClickListener()
	self._btnday:RemoveClickListener()
end

function TaskView:_btnnoviceOnClick()
	if not ActivityModel.instance:isActOnLine(ActivityEnum.Activity.NoviceTask) then
		return
	end

	if self._taskType == TaskEnum.TaskType.Novice then
		return
	end

	self._taskType = TaskEnum.TaskType.Novice

	self:_refreshTop()
	self:_changeTask()
end

function TaskView:_btndayOnClick()
	if self._taskType == TaskEnum.TaskType.Daily then
		return
	end

	self._taskType = TaskEnum.TaskType.Daily

	self:_refreshTop()
	self:_changeTask()
end

function TaskView:_btnweekOnClick()
	if self._taskType == TaskEnum.TaskType.Weekly then
		return
	end

	self._taskType = TaskEnum.TaskType.Weekly

	self:_refreshTop()
	self:_changeTask()
end

function TaskView:_editableInitView()
	self.addEventCb(self, TaskController.instance, TaskEvent.SetTaskList, self._changeTask, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self._refreshView, self)
	gohelper.addUIClickAudio(self._btnnovice.gameObject, AudioEnum.UI.UI_Mission_switch)
	gohelper.addUIClickAudio(self._btnweek.gameObject, AudioEnum.UI.UI_Mission_switch)
	gohelper.addUIClickAudio(self._btnday.gameObject, AudioEnum.UI.UI_Mission_switch)
	RedDotController.instance:addRedDot(self._gotaskdayreddot, RedDotEnum.DotNode.DailyTask)
	RedDotController.instance:addRedDot(self._gotaskweekreddot, RedDotEnum.DotNode.WeeklyTask)
	RedDotController.instance:addRedDot(self._gotasknovicereddot, RedDotEnum.DotNode.NoviceTask)
	TaskModel.instance:setRefreshCount(0)
	gohelper.setActive(self._gocontainer, false)
end

function TaskView:_refreshView()
	local isNoviceUnlock = ActivityModel.instance:isActOnLine(ActivityEnum.Activity.NoviceTask)

	if isNoviceUnlock then
		self._taskType = TaskEnum.TaskType.Novice or TaskEnum.TaskType.Daily
	end

	if isNoviceUnlock and #TaskModel.instance:getAllRewardUnreceivedTasks(TaskEnum.TaskType.Novice) > 0 then
		self._taskType = TaskEnum.TaskType.Novice
	elseif #TaskModel.instance:getAllRewardUnreceivedTasks(TaskEnum.TaskType.Daily) > 0 and not TaskModel.instance:isAllRewardGet(TaskEnum.TaskType.Daily) then
		self._taskType = TaskEnum.TaskType.Daily
	elseif #TaskModel.instance:getAllRewardUnreceivedTasks(TaskEnum.TaskType.Weekly) > 0 and not TaskModel.instance:isAllRewardGet(TaskEnum.TaskType.Weekly) then
		self._taskType = TaskEnum.TaskType.Weekly
	elseif isNoviceUnlock and not TaskModel.instance:isTypeAllTaskFinished(TaskEnum.TaskType.Novice) then
		self._taskType = TaskEnum.TaskType.Novice
	elseif not TaskModel.instance:isTypeAllTaskFinished(TaskEnum.TaskType.Daily) and not TaskModel.instance:isAllRewardGet(TaskEnum.TaskType.Daily) then
		self._taskType = TaskEnum.TaskType.Daily
	elseif not TaskModel.instance:isTypeAllTaskFinished(TaskEnum.TaskType.Weekly) and not TaskModel.instance:isAllRewardGet(TaskEnum.TaskType.Weekly) then
		self._taskType = TaskEnum.TaskType.Weekly
	end

	self:_refreshTop()
	self:_changeTask()
end

function TaskView:onUpdateParam()
	if self.viewParam then
		self._taskType = self.viewParam
	end

	self:_refreshTop()
	self:_changeTask()
end

function TaskView:onOpen()
	self._taskType = self.viewParam and self.viewParam or TaskView.getInitTaskType()
	self._blurTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.35, self._onFrame, self._onFinish, self, nil, EaseType.Linear)
end

function TaskView:_onFrame(value)
	PostProcessingMgr.instance:setBlurWeight(value)
end

function TaskView.getInitTaskType()
	local isNoviceUnlock = ActivityModel.instance:isActOnLine(ActivityEnum.Activity.NoviceTask)

	if isNoviceUnlock then
		if not TaskEnum.TaskType.Novice then
			local type = TaskEnum.TaskType.Daily

			if isNoviceUnlock and #TaskModel.instance:getAllRewardUnreceivedTasks(TaskEnum.TaskType.Novice) > 0 then
				type = TaskEnum.TaskType.Novice
			elseif #TaskModel.instance:getAllRewardUnreceivedTasks(TaskEnum.TaskType.Daily) > 0 and not TaskModel.instance:isAllRewardGet(TaskEnum.TaskType.Daily) then
				type = TaskEnum.TaskType.Daily
			elseif #TaskModel.instance:getAllRewardUnreceivedTasks(TaskEnum.TaskType.Weekly) > 0 and not TaskModel.instance:isAllRewardGet(TaskEnum.TaskType.Weekly) then
				type = TaskEnum.TaskType.Weekly
			elseif isNoviceUnlock and not TaskModel.instance:isTypeAllTaskFinished(TaskEnum.TaskType.Novice) then
				type = TaskEnum.TaskType.Novice
			elseif not TaskModel.instance:isTypeAllTaskFinished(TaskEnum.TaskType.Daily) and not TaskModel.instance:isAllRewardGet(TaskEnum.TaskType.Daily) then
				type = TaskEnum.TaskType.Daily
			elseif not TaskModel.instance:isTypeAllTaskFinished(TaskEnum.TaskType.Weekly) and not TaskModel.instance:isAllRewardGet(TaskEnum.TaskType.Weekly) then
				type = TaskEnum.TaskType.Weekly
			end

			return type
		end
	end
end

function TaskView:_onFinish()
	PostProcessingMgr.instance:setBlurWeight(1)
end

function TaskView:onOpenFinish()
	gohelper.setActive(self._gocontainer, true)
	self:_refreshTop()
	self:_changeTask()
end

function TaskView:_refreshTop()
	local isNoviceUnlock = ActivityModel.instance:isActOnLine(ActivityEnum.Activity.NoviceTask)

	gohelper.setActive(self._gonovice, isNoviceUnlock)
	gohelper.setActive(self._goline1, isNoviceUnlock and self._taskType == TaskEnum.TaskType.Weekly)

	if isNoviceUnlock then
		gohelper.setActive(self._gonoviceunchoose, self._taskType ~= TaskEnum.TaskType.Novice)
		gohelper.setActive(self._gonovicechoose, self._taskType == TaskEnum.TaskType.Novice)
	end

	gohelper.setActive(self._goline2, self._taskType == TaskEnum.TaskType.Novice)
	gohelper.setActive(self._godayunchoose, self._taskType ~= TaskEnum.TaskType.Daily)
	gohelper.setActive(self._godaychoose, self._taskType == TaskEnum.TaskType.Daily)
	gohelper.setActive(self._goweekunchoose, self._taskType ~= TaskEnum.TaskType.Weekly)
	gohelper.setActive(self._goweekchoose, self._taskType == TaskEnum.TaskType.Weekly)
	gohelper.setActive(self._golineicon, self._taskType == TaskEnum.TaskType.Daily or self._taskType == TaskEnum.TaskType.Weekly)
end

function TaskView:_changeTask()
	local count = TaskModel.instance:getRefreshCount()

	TaskModel.instance:setRefreshCount(count + 1)

	if self._taskType == TaskEnum.TaskType.Novice then
		self.viewContainer:switchTab(1)
	elseif self._taskType == TaskEnum.TaskType.Daily then
		self.viewContainer:switchTab(2)
	elseif self._taskType == TaskEnum.TaskType.Weekly then
		self.viewContainer:switchTab(3)
	end
end

function TaskView:onClose()
	self.removeEventCb(self, TaskController.instance, TaskEvent.SetTaskList, self._changeTask, self)
	self.removeEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self._refreshView, self)

	if self._blurTweenId then
		PostProcessingMgr.instance:setBlurWeight(1)
		ZProj.TweenHelper.KillById(self._blurTweenId)
	end
end

function TaskView:onDestroyView()
	return
end

return TaskView
