-- chunkname: @modules/logic/versionactivity2_4/wuerlixi/view/WuErLiXiTaskView.lua

module("modules.logic.versionactivity2_4.wuerlixi.view.WuErLiXiTaskView", package.seeall)

local WuErLiXiTaskView = class("WuErLiXiTaskView", BaseView)

function WuErLiXiTaskView:onInitView()
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_LimitTime")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function WuErLiXiTaskView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.Act1_6DungeonEnterTaskView)
	self.addEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self._oneClaimReward, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._onFinishTask, self)
	WuErLiXiTaskListModel.instance:clear()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity180
	}, self._oneClaimReward, self)
	TaskDispatcher.runRepeat(self._showLeftTime, self, 60)
	self:_showLeftTime()
end

function WuErLiXiTaskView:_oneClaimReward()
	WuErLiXiTaskListModel.instance:init(VersionActivity2_4Enum.ActivityId.WuErLiXi)
end

function WuErLiXiTaskView:_onFinishTask(taskId)
	if WuErLiXiTaskListModel.instance:getById(taskId) then
		WuErLiXiTaskListModel.instance:init(VersionActivity2_4Enum.ActivityId.WuErLiXi)
	end
end

function WuErLiXiTaskView:_showLeftTime()
	self._txtLimitTime.text = WuErLiXiHelper.getLimitTimeStr()
end

function WuErLiXiTaskView:onClose()
	WuErLiXiController.instance:dispatchEvent(WuErLiXiEvent.OnCloseTask)
	TaskDispatcher.cancelTask(self._showLeftTime, self)
end

return WuErLiXiTaskView
