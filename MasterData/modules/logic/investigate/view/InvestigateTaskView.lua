-- chunkname: @modules/logic/investigate/view/InvestigateTaskView.lua

module("modules.logic.investigate.view.InvestigateTaskView", package.seeall)

local InvestigateTaskView = class("InvestigateTaskView", BaseView)

function InvestigateTaskView:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function InvestigateTaskView:addEvents()
	return
end

function InvestigateTaskView:removeEvents()
	return
end

function InvestigateTaskView:_editableInitView()
	return
end

function InvestigateTaskView:onUpdateParam()
	return
end

function InvestigateTaskView:onOpen()
	self.addEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self.refreshRight, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self.refreshRight, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.UpdateTaskList, self.refreshRight, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenViewFinish, self._onOpenViewFinish, self)
	AudioMgr.instance:trigger(AudioEnum.UI.Act1_6DungeonEnterTaskView)
	self:refreshLeft()
	InvestigateTaskListModel.instance:clear()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Investigate
	}, self._oneClaimReward, self)
end

function InvestigateTaskView:_oneClaimReward()
	self:refreshRight()
end

function InvestigateTaskView:refreshLeft()
	self:refreshRemainTime()
end

function InvestigateTaskView:refreshRemainTime()
	return
end

function InvestigateTaskView:refreshRight()
	InvestigateTaskListModel.instance:initTask()
	InvestigateTaskListModel.instance:sortTaskMoList()
	InvestigateTaskListModel.instance:refreshList()
end

function InvestigateTaskView:_onOpenViewFinish(viewName)
	if viewName == ViewName.InvestigateOpinionTabView then
		self:closeThis()
	end
end

function InvestigateTaskView:onClose()
	return
end

function InvestigateTaskView:onDestroyView()
	return
end

return InvestigateTaskView
