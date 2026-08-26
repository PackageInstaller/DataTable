-- chunkname: @modules/logic/versionactivity2_8/nuodika/view/NuoDiKaTaskView.lua

module("modules.logic.versionactivity2_8.nuodika.view.NuoDiKaTaskView", package.seeall)

local NuoDiKaTaskView = class("NuoDiKaTaskView", BaseView)

function NuoDiKaTaskView:onInitView()
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_LimitTime")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function NuoDiKaTaskView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.Act1_6DungeonEnterTaskView)
	self.addEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self._oneClaimReward, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._onFinishTask, self)
	NuoDiKaTaskListModel.instance:clear()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity180
	}, self._oneClaimReward, self)
	TaskDispatcher.runRepeat(self._showLeftTime, self, 60)
	self:_showLeftTime()
	gohelper.setActive(self._txtLimitTime.transform.parent, false)
end

function NuoDiKaTaskView:_oneClaimReward()
	NuoDiKaTaskListModel.instance:init(VersionActivity2_8Enum.ActivityId.NuoDiKa)
end

function NuoDiKaTaskView:_onFinishTask(taskId)
	if NuoDiKaTaskListModel.instance:getById(taskId) then
		NuoDiKaTaskListModel.instance:init(VersionActivity2_8Enum.ActivityId.NuoDiKa)
	end
end

function NuoDiKaTaskView:_showLeftTime()
	self._txtLimitTime.text = NuoDiKaTaskView.getLimitTimeStr()
end

function NuoDiKaTaskView.getLimitTimeStr()
	local actInfoMo = ActivityModel.instance:getActMO(VersionActivity2_8Enum.ActivityId.NuoDiKa)

	if not actInfoMo then
		return ""
	end

	local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()

	if offsetSecond > 0 then
		return TimeUtil.SecondToActivityTimeFormat(offsetSecond)
	end

	return ""
end

function NuoDiKaTaskView:onClose()
	NuoDiKaController.instance:dispatchEvent(NuoDiKaEvent.OnCloseTask)
	TaskDispatcher.cancelTask(self._showLeftTime, self)
end

function NuoDiKaTaskView:onDestroyView()
	return
end

return NuoDiKaTaskView
