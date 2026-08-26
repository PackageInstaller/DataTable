-- chunkname: @modules/logic/versionactivity3_8/echosong/view/V3a8EchoSongTaskView.lua

module("modules.logic.versionactivity3_8.echosong.view.V3a8EchoSongTaskView", package.seeall)

local V3a8EchoSongTaskView = class("V3a8EchoSongTaskView", BaseView)

function V3a8EchoSongTaskView:onInitView()
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_LimitTime")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a8EchoSongTaskView:addEvents()
	self.addEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self._oneClaimReward, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._onFinishTask, self)
end

function V3a8EchoSongTaskView:removeEvents()
	self.removeEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self._oneClaimReward, self)
	self.removeEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._onFinishTask, self)
end

function V3a8EchoSongTaskView:_oneClaimReward()
	Activity220TaskListModel.instance:init(self._actId)
end

function V3a8EchoSongTaskView:_onFinishTask(taskId)
	if Activity220TaskListModel.instance:getById(taskId) then
		Activity220TaskListModel.instance:init(self._actId)
	end
end

function V3a8EchoSongTaskView:_editableInitView()
	return
end

function V3a8EchoSongTaskView:onUpdateParam()
	return
end

function V3a8EchoSongTaskView:onOpen()
	self._actId = self.viewParam.actId

	AudioMgr.instance:trigger(AudioEnum.UI.Act1_6DungeonEnterTaskView)
	Activity220TaskListModel.instance:clear()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity220
	}, self._oneClaimReward, self)
	self:showLeftTime()
	TaskDispatcher.runRepeat(self.showLeftTime, self, TimeUtil.OneMinuteSecond)
end

function V3a8EchoSongTaskView:showLeftTime()
	self._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(self._actId)
end

function V3a8EchoSongTaskView:onClose()
	TaskDispatcher.cancelTask(self.showLeftTime, self)
end

return V3a8EchoSongTaskView
