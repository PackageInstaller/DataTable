-- chunkname: @modules/logic/versionactivity2_2/lopera/view/LoperaTaskView.lua

module("modules.logic.versionactivity2_2.lopera.view.LoperaTaskView", package.seeall)

local LoperaTaskView = class("LoperaTaskView", BaseView)

function LoperaTaskView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._simagelangtxt = gohelper.findChildSingleImage(self.viewGO, "Left/#simage_langtxt")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_LimitTime")
	self._scrollTaskList = gohelper.findChildScrollRect(self.viewGO, "#scroll_TaskList")
	self._goBackBtns = gohelper.findChild(self.viewGO, "#go_BackBtns")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function LoperaTaskView:addEvents()
	return
end

function LoperaTaskView:removeEvents()
	return
end

function LoperaTaskView:_editableInitView()
	return
end

function LoperaTaskView:onUpdateParam()
	return
end

function LoperaTaskView:onOpen()
	self.addEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self._oneClaimReward, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._onFinishTask, self)
	Activity168TaskListModel.instance:clear()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity168
	}, self._oneClaimReward, self)
	TaskDispatcher.runRepeat(self._showLeftTime, self, 60)
	self:_showLeftTime()
end

function LoperaTaskView:_oneClaimReward()
	Activity168TaskListModel.instance:init(VersionActivity2_2Enum.ActivityId.Lopera)
end

function LoperaTaskView:_onFinishTask(taskId)
	if Activity168TaskListModel.instance:getById(taskId) then
		Activity168TaskListModel.instance:init(VersionActivity2_2Enum.ActivityId.Lopera)
	end
end

function LoperaTaskView:_showLeftTime()
	self._txtLimitTime.text = self:getLimitTimeStr()
end

function LoperaTaskView.getLimitTimeStr()
	local actInfoMo = ActivityModel.instance:getActMO(VersionActivity2_2Enum.ActivityId.Lopera)

	if not actInfoMo then
		return ""
	end

	local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()

	if offsetSecond > 0 then
		return TimeUtil.SecondToActivityTimeFormat(offsetSecond)
	end

	return ""
end

function LoperaTaskView:onClose()
	TaskDispatcher.cancelTask(self._showLeftTime, self)
end

function LoperaTaskView:onDestroyView()
	self._simageFullBG:UnLoadImage()
end

return LoperaTaskView
