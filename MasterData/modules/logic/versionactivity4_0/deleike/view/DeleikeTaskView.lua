-- chunkname: @modules/logic/versionactivity4_0/deleike/view/DeleikeTaskView.lua

module("modules.logic.versionactivity4_0.deleike.view.DeleikeTaskView", package.seeall)

local DeleikeTaskView = class("DeleikeTaskView", BaseView)

function DeleikeTaskView:onInitView()
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_LimitTime")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function DeleikeTaskView:addEvents()
	self.addEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self._oneClaimReward, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._onFinishTask, self)
end

function DeleikeTaskView:removeEvents()
	self.removeEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self._oneClaimReward, self)
	self.removeEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._onFinishTask, self)
end

function DeleikeTaskView:_oneClaimReward()
	Activity220TaskListModel.instance:init(self._actId)
end

function DeleikeTaskView:_onFinishTask(taskId)
	if Activity220TaskListModel.instance:getById(taskId) then
		Activity220TaskListModel.instance:init(self._actId)
	end
end

function DeleikeTaskView:_editableInitView()
	return
end

function DeleikeTaskView:onUpdateParam()
	return
end

function DeleikeTaskView:onOpen()
	self._actId = DeleikeController.instance:getActId()

	AudioMgr.instance:trigger(AudioEnum.UI.Act1_6DungeonEnterTaskView)
	Activity220TaskListModel.instance:clear()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity220
	}, self._oneClaimReward, self)
	self:showLeftTime()
	TaskDispatcher.cancelTask(self.showLeftTime, self)
	TaskDispatcher.runRepeat(self.showLeftTime, self, TimeUtil.OneMinuteSecond)
end

function DeleikeTaskView:showLeftTime()
	self._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(self._actId)
end

function DeleikeTaskView:onClose()
	TaskDispatcher.cancelTask(self.showLeftTime, self)
end

return DeleikeTaskView
