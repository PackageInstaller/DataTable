-- chunkname: @modules/logic/versionactivity2_8/molideer/view/MoLiDeErTaskView.lua

module("modules.logic.versionactivity2_8.molideer.view.MoLiDeErTaskView", package.seeall)

local MoLiDeErTaskView = class("MoLiDeErTaskView", BaseView)

function MoLiDeErTaskView:onInitView()
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_time")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MoLiDeErTaskView:onOpen()
	self._actId = VersionActivity2_8Enum.ActivityId.MoLiDeEr

	AudioMgr.instance:trigger(AudioEnum.UI.Act1_6DungeonEnterTaskView)
	self.addEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self._oneClaimReward, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._onFinishTask, self)
	MoLiDeErTaskListModel.instance:clear()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity194
	}, self._oneClaimReward, self)
	TaskDispatcher.runRepeat(self.showLeftTime, self, TimeUtil.OneMinuteSecond)
	self:showLeftTime()
	gohelper.setActive(self._txtLimitTime.transform.parent, false)
end

function MoLiDeErTaskView:_oneClaimReward()
	MoLiDeErTaskListModel.instance:init(self._actId)
end

function MoLiDeErTaskView:_onFinishTask(taskId)
	if MoLiDeErTaskListModel.instance:getById(taskId) then
		MoLiDeErTaskListModel.instance:init(self._actId)
	end
end

function MoLiDeErTaskView:showLeftTime()
	self._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(self._actId)
end

function MoLiDeErTaskView:onClose()
	TaskDispatcher.cancelTask(self.showLeftTime, self)
end

return MoLiDeErTaskView
