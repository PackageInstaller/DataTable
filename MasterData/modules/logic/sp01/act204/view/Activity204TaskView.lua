-- chunkname: @modules/logic/sp01/act204/view/Activity204TaskView.lua

module("modules.logic.sp01.act204.view.Activity204TaskView", package.seeall)

local Activity204TaskView = class("Activity204TaskView", BaseView)

function Activity204TaskView:onInitView()
	self._goreddot = gohelper.findChild(self.viewGO, "root/leftReward/dailyreward/#go_reddot")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity204TaskView:addEvents()
	self.addEventCb(self, Activity204Controller.instance, Activity204Event.UpdateInfo, self.onUpdateInfo, self)
	self.addEventCb(self, Activity204Controller.instance, Activity204Event.UpdateTask, self.refreshTask, self)
	self.addEventCb(self, Activity204Controller.instance, Activity204Event.FinishTask, self.onFinishTask, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self.refreshTask, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self.refreshTask, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.UpdateTaskList, self.refreshTask, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.SetTaskList, self.refreshTask, self)
	self.addEventCb(self, TimeDispatcher.instance, TimeDispatcher.OnDailyRefresh, self.onDailyRefresh, self)
end

function Activity204TaskView:removeEvents()
	return
end

function Activity204TaskView:_editableInitView()
	RedDotController.instance:addRedDot(self._goreddot, RedDotEnum.DotNode.V2a9_Act204DailyGet)
end

function Activity204TaskView:onUpdateInfo()
	self:refreshView()
end

function Activity204TaskView:onFinishTask()
	self:refreshTask()
end

function Activity204TaskView:onUpdateParam()
	self:refreshParam()
	self:refreshView()
end

function Activity204TaskView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.Act186.play_ui_mln_details_open)
	self:refreshParam()
	self:refreshView()
end

function Activity204TaskView:refreshParam()
	self.actId = self.viewParam.actId
	self.actMo = Activity204Model.instance:getById(self.actId)

	Activity204TaskListModel.instance:init(self.actId)
	Activity204Model.instance:recordHasReadNewTask(self.actId)
	RedDotController.instance:dispatchEvent(RedDotEvent.UpdateActTag)
end

function Activity204TaskView:refreshView()
	self:refreshTask()
end

function Activity204TaskView:refreshTask()
	TaskDispatcher.cancelTask(self.onDailyRefresh, self)
	Activity204TaskListModel.instance:refresh()

	local nextRefreshTime = Activity204TaskListModel.instance:getNextRefreshTime()
	local delayTime = nextRefreshTime and nextRefreshTime / 1000 - ServerTime.now()

	if delayTime and delayTime > 0 then
		TaskDispatcher.runDelay(self.onDailyRefresh, self, delayTime)
	end
end

function Activity204TaskView:onDailyRefresh()
	Activity204Controller.instance:sendRpc2GetMainTaskInfo()
end

function Activity204TaskView:onClose()
	TaskDispatcher.cancelTask(self.onDailyRefresh, self)
end

function Activity204TaskView:onDestroyView()
	return
end

return Activity204TaskView
