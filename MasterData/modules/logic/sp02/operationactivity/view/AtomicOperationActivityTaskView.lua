-- chunkname: @modules/logic/sp02/operationactivity/view/AtomicOperationActivityTaskView.lua

module("modules.logic.sp02.operationactivity.view.AtomicOperationActivityTaskView", package.seeall)

local AtomicOperationActivityTaskView = class("AtomicOperationActivityTaskView", BaseView)

function AtomicOperationActivityTaskView:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function AtomicOperationActivityTaskView:addEvents()
	self.addEventCb(self, Activity186Controller.instance, Activity186Event.UpdateInfo, self.onUpdateInfo, self)
	self.addEventCb(self, Activity186Controller.instance, Activity186Event.UpdateTask, self.onUpdateTask, self)
	self.addEventCb(self, Activity186Controller.instance, Activity186Event.FinishTask, self.onFinishTask, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self.refreshTask, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self.refreshTask, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.UpdateTaskList, self.refreshTask, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.SetTaskList, self.refreshTask, self)
end

function AtomicOperationActivityTaskView:removeEvents()
	self.removeEventCb(self, Activity186Controller.instance, Activity186Event.UpdateInfo, self.onUpdateInfo, self)
	self.removeEventCb(self, Activity186Controller.instance, Activity186Event.UpdateTask, self.onUpdateTask, self)
	self.removeEventCb(self, Activity186Controller.instance, Activity186Event.FinishTask, self.onFinishTask, self)
	self.removeEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self.refreshTask, self)
	self.removeEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self.refreshTask, self)
	self.removeEventCb(self, TaskController.instance, TaskEvent.UpdateTaskList, self.refreshTask, self)
	self.removeEventCb(self, TaskController.instance, TaskEvent.SetTaskList, self.refreshTask, self)
end

function AtomicOperationActivityTaskView:_editableInitView()
	return
end

function AtomicOperationActivityTaskView:onUpdateInfo()
	self:refreshTask()
end

local finish_screen_key = "AtomicOperationActivityTaskViewRefreshTask"
local pause_popup_key = "AtomicOperationActivityTaskView_Popup"

function AtomicOperationActivityTaskView:onFinishTask()
	self.isHaveDelayRefresh = true

	PopupController.instance:setPause(pause_popup_key, true)
	UIBlockHelper.instance:startBlock(finish_screen_key, AtomicOperationActivityEnum.DelayTime.TaskFinishTime)
	TaskDispatcher.cancelTask(self.onDelayRefreshTask, self)
	TaskDispatcher.runDelay(self.onDelayRefreshTask, self, AtomicOperationActivityEnum.DelayTime.TaskFinishTime)
end

function AtomicOperationActivityTaskView:onDelayRefreshTask()
	self.isHaveDelayRefresh = false

	UIBlockHelper.instance:endBlock(finish_screen_key)
	PopupController.instance:setPause(pause_popup_key, false)
	TaskDispatcher.cancelTask(self.onDelayRefreshTask, self)
	self:refreshTask()
end

function AtomicOperationActivityTaskView:onUpdateTask()
	if not self.isHaveDelayRefresh then
		TaskDispatcher.cancelTask(self.onDelayRefreshTask, self)
		UIBlockHelper.instance:startBlock(finish_screen_key, AtomicOperationActivityEnum.DelayTime.TaskUpdateTime)
		TaskDispatcher.runDelay(self.onDelayRefreshTask, self, AtomicOperationActivityEnum.DelayTime.TaskUpdateTime)
	end
end

function AtomicOperationActivityTaskView:onUpdateParam()
	self:refreshTask()
end

function AtomicOperationActivityTaskView:onOpen()
	self:refreshUI()
end

function AtomicOperationActivityTaskView:refreshParam()
	self.actId = self.viewParam.actId
	self.actMo = Activity186Model.instance:getById(self.actId)

	AtomicOperationActivityTaskListModel.instance:init(self.actId)
end

function AtomicOperationActivityTaskView:refreshUI()
	self:refreshParam()
	self:refreshTask()
end

function AtomicOperationActivityTaskView:refreshTask()
	AtomicOperationActivityTaskListModel.instance:refresh()
end

function AtomicOperationActivityTaskView:onClose()
	return
end

function AtomicOperationActivityTaskView:onDestroyView()
	TaskDispatcher.cancelTask(self.onDelayRefreshTask, self)
	UIBlockHelper.instance:endBlock(finish_screen_key)
	PopupController.instance:setPause(pause_popup_key, false)
end

return AtomicOperationActivityTaskView
