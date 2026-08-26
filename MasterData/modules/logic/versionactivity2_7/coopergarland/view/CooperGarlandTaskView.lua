-- chunkname: @modules/logic/versionactivity2_7/coopergarland/view/CooperGarlandTaskView.lua

module("modules.logic.versionactivity2_7.coopergarland.view.CooperGarlandTaskView", package.seeall)

local CooperGarlandTaskView = class("CooperGarlandTaskView", BaseView)

function CooperGarlandTaskView:onInitView()
	self._txttime = gohelper.findChildText(self.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_time")
	self._scrollTaskList = gohelper.findChildScrollRect(self.viewGO, "#scroll_TaskList")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CooperGarlandTaskView:addEvents()
	self.addEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self._oneClaimReward, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._onFinishTask, self)
end

function CooperGarlandTaskView:removeEvents()
	self.removeEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self._oneClaimReward, self)
	self.removeEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._onFinishTask, self)
end

function CooperGarlandTaskView:_oneClaimReward()
	CooperGarlandTaskListModel.instance:init()
end

function CooperGarlandTaskView:_onFinishTask(taskId)
	if CooperGarlandTaskListModel.instance:getById(taskId) then
		CooperGarlandTaskListModel.instance:init()
	end
end

function CooperGarlandTaskView:_editableInitView()
	self.actId = CooperGarlandModel.instance:getAct192Id()
end

function CooperGarlandTaskView:onUpdateParam()
	return
end

function CooperGarlandTaskView:onOpen()
	self:showLeftTime()
	TaskDispatcher.runRepeat(self.showLeftTime, self, TimeUtil.OneMinuteSecond)
end

function CooperGarlandTaskView:showLeftTime()
	self._txttime.text = ActivityHelper.getActivityRemainTimeStr(self.actId)
end

function CooperGarlandTaskView:onClose()
	TaskDispatcher.cancelTask(self.showLeftTime, self)
end

function CooperGarlandTaskView:onDestroyView()
	return
end

return CooperGarlandTaskView
