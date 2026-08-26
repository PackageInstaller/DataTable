-- chunkname: @modules/logic/versionactivity3_9/naxisuosi/view/NaxisuosiTaskView.lua

module("modules.logic.versionactivity3_9.naxisuosi.view.NaxisuosiTaskView", package.seeall)

local NaxisuosiTaskView = class("NaxisuosiTaskView", BaseView)

function NaxisuosiTaskView:onInitView()
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_LimitTime")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function NaxisuosiTaskView:addEvents()
	self.addEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self._oneClaimReward, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._onFinishTask, self)
end

function NaxisuosiTaskView:removeEvents()
	self.removeEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self._oneClaimReward, self)
	self.removeEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._onFinishTask, self)
end

function NaxisuosiTaskView:_oneClaimReward()
	Activity220TaskListModel.instance:init(self._actId)
end

function NaxisuosiTaskView:_onFinishTask(taskId)
	if Activity220TaskListModel.instance:getById(taskId) then
		Activity220TaskListModel.instance:init(self._actId)
	end
end

function NaxisuosiTaskView:_editableInitView()
	return
end

function NaxisuosiTaskView:onUpdateParam()
	return
end

function NaxisuosiTaskView:onOpen()
	self._actId = self.viewParam.actId

	AudioMgr.instance:trigger(AudioEnum.UI.Act1_6DungeonEnterTaskView)
	Activity220TaskListModel.instance:clear()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity220
	}, self._oneClaimReward, self)
	self:showLeftTime()
	TaskDispatcher.runRepeat(self.showLeftTime, self, TimeUtil.OneMinuteSecond)
end

function NaxisuosiTaskView:showLeftTime()
	self._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(self._actId)
end

function NaxisuosiTaskView:onClose()
	TaskDispatcher.cancelTask(self.showLeftTime, self)
end

return NaxisuosiTaskView
