-- chunkname: @modules/logic/versionactivity2_5/feilinshiduo/view/FeiLinShiDuoTaskView.lua

module("modules.logic.versionactivity2_5.feilinshiduo.view.FeiLinShiDuoTaskView", package.seeall)

local FeiLinShiDuoTaskView = class("FeiLinShiDuoTaskView", BaseView)

function FeiLinShiDuoTaskView:onInitView()
	self._txttime = gohelper.findChildText(self.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_time")
	self._scrollTaskList = gohelper.findChildScrollRect(self.viewGO, "#scroll_TaskList")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function FeiLinShiDuoTaskView:addEvents()
	return
end

function FeiLinShiDuoTaskView:removeEvents()
	return
end

function FeiLinShiDuoTaskView:_editableInitView()
	return
end

function FeiLinShiDuoTaskView:onUpdateParam()
	return
end

function FeiLinShiDuoTaskView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.Act1_6DungeonEnterTaskView)

	self.actId = self.viewParam.activityId

	self.addEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self._oneClaimReward, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._onFinishTask, self)
	FeiLinShiDuoTaskListModel.instance:clear()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity185
	}, self._oneClaimReward, self)
	TaskDispatcher.runRepeat(self.showLeftTime, self, TimeUtil.OneMinuteSecond)
	self:showLeftTime()
end

function FeiLinShiDuoTaskView:_oneClaimReward()
	FeiLinShiDuoTaskListModel.instance:init(self.actId)
end

function FeiLinShiDuoTaskView:_onFinishTask(taskId)
	if FeiLinShiDuoTaskListModel.instance:getById(taskId) then
		FeiLinShiDuoTaskListModel.instance:init(self.actId)
	end
end

function FeiLinShiDuoTaskView:showLeftTime()
	self._txttime.text = ActivityHelper.getActivityRemainTimeStr(self.actId)
end

function FeiLinShiDuoTaskView:onClose()
	TaskDispatcher.cancelTask(self.showLeftTime, self)
end

function FeiLinShiDuoTaskView:onDestroyView()
	return
end

return FeiLinShiDuoTaskView
