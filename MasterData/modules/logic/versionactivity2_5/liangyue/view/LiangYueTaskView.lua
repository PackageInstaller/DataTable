-- chunkname: @modules/logic/versionactivity2_5/liangyue/view/LiangYueTaskView.lua

module("modules.logic.versionactivity2_5.liangyue.view.LiangYueTaskView", package.seeall)

local LiangYueTaskView = class("LiangYueTaskView", BaseView)

function LiangYueTaskView:onInitView()
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_time")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function LiangYueTaskView:onOpen()
	self._actId = VersionActivity2_5Enum.ActivityId.LiangYue

	AudioMgr.instance:trigger(AudioEnum.UI.Act1_6DungeonEnterTaskView)
	self.addEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self._oneClaimReward, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._onFinishTask, self)
	LiangYueTaskListModel.instance:clear()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity184
	}, self._oneClaimReward, self)
	TaskDispatcher.runRepeat(self.showLeftTime, self, TimeUtil.OneMinuteSecond)
	self:showLeftTime()
end

function LiangYueTaskView:_oneClaimReward()
	LiangYueTaskListModel.instance:init(self._actId)
end

function LiangYueTaskView:_onFinishTask(taskId)
	if LiangYueTaskListModel.instance:getById(taskId) then
		LiangYueTaskListModel.instance:init(self._actId)
	end
end

function LiangYueTaskView:showLeftTime()
	self._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(self._actId)
end

function LiangYueTaskView:onClose()
	LiangYueController.instance:dispatchEvent(LiangYueEvent.OnCloseTask)
	TaskDispatcher.cancelTask(self.showLeftTime, self)
end

return LiangYueTaskView
