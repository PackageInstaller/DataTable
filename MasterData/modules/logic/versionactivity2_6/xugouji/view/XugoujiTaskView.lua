-- chunkname: @modules/logic/versionactivity2_6/xugouji/view/XugoujiTaskView.lua

module("modules.logic.versionactivity2_6.xugouji.view.XugoujiTaskView", package.seeall)

local XugoujiTaskView = class("XugoujiTaskView", BaseView)

function XugoujiTaskView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._simagelangtxt = gohelper.findChildSingleImage(self.viewGO, "Left/#simage_langtxt")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_time")
	self._scrollTaskList = gohelper.findChildScrollRect(self.viewGO, "#scroll_TaskList")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function XugoujiTaskView:addEvents()
	return
end

function XugoujiTaskView:removeEvents()
	return
end

function XugoujiTaskView:_editableInitView()
	return
end

function XugoujiTaskView:onUpdateParam()
	return
end

function XugoujiTaskView:onOpen()
	self.addEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self._oneClaimReward, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._onFinishTask, self)
	Activity188TaskListModel.instance:clear()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity188
	}, self._oneClaimReward, self)
	TaskDispatcher.runRepeat(self._showLeftTime, self, 60)
	self:_showLeftTime()
end

function XugoujiTaskView:_oneClaimReward()
	Activity188TaskListModel.instance:init(VersionActivity2_6Enum.ActivityId.Xugouji)
end

function XugoujiTaskView:_onFinishTask(taskId)
	if Activity188TaskListModel.instance:getById(taskId) then
		Activity188TaskListModel.instance:init(VersionActivity2_6Enum.ActivityId.Xugouji)
	end
end

function XugoujiTaskView:_showLeftTime()
	self._txtLimitTime.text = self:getLimitTimeStr()
end

function XugoujiTaskView.getLimitTimeStr()
	local actInfoMo = ActivityModel.instance:getActMO(VersionActivity2_6Enum.ActivityId.Xugouji)

	if not actInfoMo then
		return ""
	end

	local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()

	if offsetSecond > 0 then
		return TimeUtil.SecondToActivityTimeFormat(offsetSecond)
	end

	return ""
end

function XugoujiTaskView:onClose()
	TaskDispatcher.cancelTask(self._showLeftTime, self)
end

function XugoujiTaskView:onDestroyView()
	self._simageFullBG:UnLoadImage()
end

return XugoujiTaskView
