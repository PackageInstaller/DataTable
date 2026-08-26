-- chunkname: @modules/logic/rouge/view/RougeActivityTaskView.lua

module("modules.logic.rouge.view.RougeActivityTaskView", package.seeall)

local RougeActivityTaskView = class("RougeActivityTaskView", BaseView)
local finish_screen_key = "RougeActivityTaskViewRefreshTask"
local pause_popup_key = "RougeActivityTaskView_Popup"
local TaskFinishTime = 0.8
local TaskUpdateTime = 0.1

function RougeActivityTaskView:onInitView()
	self._txtTime = gohelper.findChildText(self.viewGO, "bg/time/#txt_time")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeActivityTaskView:addEvents()
	self.addEventCb(self, Activity186Controller.instance, Activity186Event.UpdateInfo, self.onUpdateInfo, self)
	self.addEventCb(self, Activity186Controller.instance, Activity186Event.UpdateTask, self.onUpdateTask, self)
	self.addEventCb(self, Activity186Controller.instance, Activity186Event.FinishAllTask, self.onFinishTask, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self.refreshTask, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self.refreshTask, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.UpdateTaskList, self.refreshTask, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.SetTaskList, self.refreshTask, self)
end

function RougeActivityTaskView:removeEvents()
	return
end

function RougeActivityTaskView:onUpdateInfo()
	self:refreshTask()
end

function RougeActivityTaskView:onFinishTask()
	self.isHaveDelayRefresh = true

	PopupController.instance:setPause(pause_popup_key, true)
	UIBlockHelper.instance:startBlock(finish_screen_key, TaskFinishTime)
	TaskDispatcher.cancelTask(self.onDelayRefreshTask, self)
	TaskDispatcher.runDelay(self.onDelayRefreshTask, self, TaskFinishTime)
end

function RougeActivityTaskView:onDelayRefreshTask()
	self.isHaveDelayRefresh = false

	UIBlockHelper.instance:endBlock(finish_screen_key)
	PopupController.instance:setPause(pause_popup_key, false)
	TaskDispatcher.cancelTask(self.onDelayRefreshTask, self)
	self:refreshTask()
end

function RougeActivityTaskView:onUpdateTask()
	if not self.isHaveDelayRefresh then
		TaskDispatcher.cancelTask(self.onDelayRefreshTask, self)
		UIBlockHelper.instance:startBlock(finish_screen_key, TaskUpdateTime)
		TaskDispatcher.runDelay(self.onDelayRefreshTask, self, TaskUpdateTime)
	end
end

function RougeActivityTaskView:_editableInitView()
	return
end

function RougeActivityTaskView:onUpdateParam()
	self:refreshTask()
end

function RougeActivityTaskView:onOpen()
	self:refreshUI()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mission_open)
end

function RougeActivityTaskView:refreshParam()
	self.actId = self.viewParam.actId
	self.actMo = Activity186Model.instance:getById(self.actId)

	RougeActivityTaskListModel.instance:init(self.actId)
end

function RougeActivityTaskView:refreshUI()
	self:refreshParam()
	self:refreshTask()
	self:refreshRemainTime()
	self:tickRefreshRemainTime()
end

function RougeActivityTaskView:refreshRemainTime()
	self._txtTime.text = ActivityHelper.getActivityRemainTimeStr(self.actId)
end

function RougeActivityTaskView:tickRefreshRemainTime()
	TaskDispatcher.cancelTask(self.refreshRemainTime, self)
	TaskDispatcher.runRepeat(self.refreshRemainTime, self, 30)
end

function RougeActivityTaskView:refreshTask()
	RougeActivityTaskListModel.instance:refresh()
end

function RougeActivityTaskView:onClose()
	TaskDispatcher.cancelTask(self.refreshRemainTime, self)
end

function RougeActivityTaskView:onDestroyView()
	return
end

return RougeActivityTaskView
