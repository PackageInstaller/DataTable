-- chunkname: @modules/logic/versionactivity3_5/lamona/view/LamonaTaskView.lua

module("modules.logic.versionactivity3_5.lamona.view.LamonaTaskView", package.seeall)

local LamonaTaskView = class("LamonaTaskView", BaseView)

function LamonaTaskView:onInitView()
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_LimitTime")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function LamonaTaskView:addEvents()
	self.addEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self._oneClaimReward, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._onFinishTask, self)
end

function LamonaTaskView:removeEvents()
	self.removeEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self._oneClaimReward, self)
	self.removeEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._onFinishTask, self)
end

function LamonaTaskView:_oneClaimReward()
	Activity220TaskListModel.instance:init(self._actId)
end

function LamonaTaskView:_onFinishTask(taskId)
	if Activity220TaskListModel.instance:getById(taskId) then
		Activity220TaskListModel.instance:init(self._actId)
	end
end

function LamonaTaskView:_editableInitView()
	return
end

function LamonaTaskView:onUpdateParam()
	return
end

function LamonaTaskView:onOpen()
	self._actId = self.viewParam.actId

	AudioMgr.instance:trigger(AudioEnum.UI.Act1_6DungeonEnterTaskView)
	Activity220TaskListModel.instance:clear()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity220
	}, self._oneClaimReward, self)
	self:showLeftTime()
	TaskDispatcher.runRepeat(self.showLeftTime, self, TimeUtil.OneMinuteSecond)
end

function LamonaTaskView:showLeftTime()
	self._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(self._actId)
end

function LamonaTaskView:onClose()
	TaskDispatcher.cancelTask(self.showLeftTime, self)
end

return LamonaTaskView
