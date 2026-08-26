-- chunkname: @modules/logic/versionactivity3_0/maLiAnNaAct201/view/Activity201MaLiAnNaTaskView.lua

module("modules.logic.versionactivity3_0.maLiAnNaAct201.view.Activity201MaLiAnNaTaskView", package.seeall)

local Activity201MaLiAnNaTaskView = class("Activity201MaLiAnNaTaskView", BaseView)

function Activity201MaLiAnNaTaskView:onInitView()
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_time")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity201MaLiAnNaTaskView:onOpen()
	self._actId = VersionActivity3_0Enum.ActivityId.MaLiAnNa

	AudioMgr.instance:trigger(AudioEnum.UI.Act1_6DungeonEnterTaskView)
	self.addEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self._oneClaimReward, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._onFinishTask, self)
	Activity201MaLiAnNaTaskListModel.instance:clear()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity203
	}, self._oneClaimReward, self)
	TaskDispatcher.runRepeat(self.showLeftTime, self, TimeUtil.OneMinuteSecond)
	self:showLeftTime()
	gohelper.setActive(self._txtLimitTime.transform.parent, false)
end

function Activity201MaLiAnNaTaskView:_oneClaimReward()
	Activity201MaLiAnNaTaskListModel.instance:init(self._actId)
end

function Activity201MaLiAnNaTaskView:_onFinishTask(taskId)
	if Activity201MaLiAnNaTaskListModel.instance:getById(taskId) then
		Activity201MaLiAnNaTaskListModel.instance:init(self._actId)
	end
end

function Activity201MaLiAnNaTaskView:showLeftTime()
	self._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(self._actId)
end

function Activity201MaLiAnNaTaskView:onClose()
	TaskDispatcher.cancelTask(self.showLeftTime, self)
end

return Activity201MaLiAnNaTaskView
