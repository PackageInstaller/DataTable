-- chunkname: @modules/logic/versionactivity2_2/tianshinana/view/TianShiNaNaTaskView.lua

module("modules.logic.versionactivity2_2.tianshinana.view.TianShiNaNaTaskView", package.seeall)

local TianShiNaNaTaskView = class("TianShiNaNaTaskView", BaseView)

function TianShiNaNaTaskView:onInitView()
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_LimitTime")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TianShiNaNaTaskView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.Act1_6DungeonEnterTaskView)
	self.addEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self._oneClaimReward, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._onFinishTask, self)
	TianShiNaNaTaskListModel.instance:clear()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity167
	}, self._oneClaimReward, self)
	TaskDispatcher.runRepeat(self._showLeftTime, self, 60)
	self:_showLeftTime()
end

function TianShiNaNaTaskView:_oneClaimReward()
	TianShiNaNaTaskListModel.instance:init(VersionActivity2_2Enum.ActivityId.TianShiNaNa)
end

function TianShiNaNaTaskView:_onFinishTask(taskId)
	if TianShiNaNaTaskListModel.instance:getById(taskId) then
		TianShiNaNaTaskListModel.instance:init(VersionActivity2_2Enum.ActivityId.TianShiNaNa)
	end
end

function TianShiNaNaTaskView:_showLeftTime()
	self._txtLimitTime.text = TianShiNaNaHelper.getLimitTimeStr()
end

function TianShiNaNaTaskView:onClose()
	TaskDispatcher.cancelTask(self._showLeftTime, self)
end

return TianShiNaNaTaskView
