-- chunkname: @modules/logic/versionactivity3_9/hedone/view/HedoneTaskView.lua

module("modules.logic.versionactivity3_9.hedone.view.HedoneTaskView", package.seeall)

local HedoneTaskView = class("HedoneTaskView", BaseView)

function HedoneTaskView:onInitView()
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_LimitTime")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function HedoneTaskView:addEvents()
	self.addEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self._oneClaimReward, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._onFinishTask, self)
end

function HedoneTaskView:removeEvents()
	self.removeEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self._oneClaimReward, self)
	self.removeEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._onFinishTask, self)
end

function HedoneTaskView:_oneClaimReward()
	Activity220TaskListModel.instance:init(self._actId)
end

function HedoneTaskView:_onFinishTask(taskId)
	if Activity220TaskListModel.instance:getById(taskId) then
		Activity220TaskListModel.instance:init(self._actId)
	end
end

function HedoneTaskView:_editableInitView()
	return
end

function HedoneTaskView:onUpdateParam()
	return
end

function HedoneTaskView:onOpen()
	self._actId = self.viewParam.actId

	AudioMgr.instance:trigger(AudioEnum.UI.Act1_6DungeonEnterTaskView)
	Activity220TaskListModel.instance:clear()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity220
	}, self._oneClaimReward, self)
	self:showLeftTime()
	TaskDispatcher.runRepeat(self.showLeftTime, self, TimeUtil.OneMinuteSecond)
end

function HedoneTaskView:showLeftTime()
	self._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(self._actId)
end

function HedoneTaskView:onClose()
	TaskDispatcher.cancelTask(self.showLeftTime, self)
end

return HedoneTaskView
