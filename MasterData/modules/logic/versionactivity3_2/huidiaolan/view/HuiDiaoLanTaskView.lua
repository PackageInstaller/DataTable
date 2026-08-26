-- chunkname: @modules/logic/versionactivity3_2/huidiaolan/view/HuiDiaoLanTaskView.lua

module("modules.logic.versionactivity3_2.huidiaolan.view.HuiDiaoLanTaskView", package.seeall)

local HuiDiaoLanTaskView = class("HuiDiaoLanTaskView", BaseView)

function HuiDiaoLanTaskView:onInitView()
	self._scrollTaskList = gohelper.findChildScrollRect(self.viewGO, "#scroll_TaskList")
	self._txtlimittime = gohelper.findChildText(self.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_limittime")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function HuiDiaoLanTaskView:addEvents()
	return
end

function HuiDiaoLanTaskView:removeEvents()
	return
end

function HuiDiaoLanTaskView:_editableInitView()
	return
end

function HuiDiaoLanTaskView:onUpdateParam()
	return
end

function HuiDiaoLanTaskView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.Act1_6DungeonEnterTaskView)

	self.actId = self.viewParam.activityId

	self.addEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self._oneClaimReward, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._onFinishTask, self)
	HuiDiaoLanTaskListModel.instance:clear()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity220
	}, self._oneClaimReward, self)
	TaskDispatcher.runRepeat(self.showLeftTime, self, TimeUtil.OneMinuteSecond)
	self:showLeftTime()
end

function HuiDiaoLanTaskView:_oneClaimReward()
	HuiDiaoLanTaskListModel.instance:init(self.actId)
end

function HuiDiaoLanTaskView:_onFinishTask(taskId)
	if HuiDiaoLanTaskListModel.instance:getById(taskId) then
		HuiDiaoLanTaskListModel.instance:init(self.actId)
	end
end

function HuiDiaoLanTaskView:showLeftTime()
	self._txtlimittime.text = ActivityHelper.getActivityRemainTimeStr(self.actId)
end

function HuiDiaoLanTaskView:onClose()
	TaskDispatcher.cancelTask(self.showLeftTime, self)
end

function HuiDiaoLanTaskView:onDestroyView()
	return
end

return HuiDiaoLanTaskView
