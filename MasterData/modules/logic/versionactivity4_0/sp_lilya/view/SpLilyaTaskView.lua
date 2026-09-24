-- chunkname: @modules/logic/versionactivity4_0/sp_lilya/view/SpLilyaTaskView.lua

module("modules.logic.versionactivity4_0.sp_lilya.view.SpLilyaTaskView", package.seeall)

local SpLilyaTaskView = class("SpLilyaTaskView", BaseView)

function SpLilyaTaskView:onInitView()
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_LimitTime")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SpLilyaTaskView:addEvents()
	self.addEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self._oneClaimReward, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._onFinishTask, self)
end

function SpLilyaTaskView:removeEvents()
	self.removeEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self._oneClaimReward, self)
	self.removeEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._onFinishTask, self)
end

function SpLilyaTaskView:_oneClaimReward()
	Activity220TaskListModel.instance:init(self._actId)
end

function SpLilyaTaskView:_onFinishTask(taskId)
	if Activity220TaskListModel.instance:getById(taskId) then
		Activity220TaskListModel.instance:init(self._actId)
	end
end

function SpLilyaTaskView:_editableInitView()
	return
end

function SpLilyaTaskView:onUpdateParam()
	return
end

function SpLilyaTaskView:onOpen()
	self._actId = self.viewParam.actId

	AudioMgr.instance:trigger(AudioEnum.UI.Act1_6DungeonEnterTaskView)
	Activity220TaskListModel.instance:clear()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity220
	}, self._oneClaimReward, self)
	self:showLeftTime()
	TaskDispatcher.runRepeat(self.showLeftTime, self, TimeUtil.OneMinuteSecond)
end

function SpLilyaTaskView:showLeftTime()
	self._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(self._actId)
end

function SpLilyaTaskView:onClose()
	TaskDispatcher.cancelTask(self.showLeftTime, self)
end

return SpLilyaTaskView
