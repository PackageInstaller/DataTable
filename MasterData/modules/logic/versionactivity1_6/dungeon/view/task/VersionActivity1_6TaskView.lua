-- chunkname: @modules/logic/versionactivity1_6/dungeon/view/task/VersionActivity1_6TaskView.lua

module("modules.logic.versionactivity1_6.dungeon.view.task.VersionActivity1_6TaskView", package.seeall)

local VersionActivity1_6TaskView = class("VersionActivity1_6TaskView", BaseView)

function VersionActivity1_6TaskView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_LimitTime")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity1_6TaskView:addEvents()
	return
end

function VersionActivity1_6TaskView:removeEvents()
	return
end

function VersionActivity1_6TaskView:_editableInitView()
	self._simageFullBG:LoadImage("singlebg/v1a6_taskview_singlebg/v1a6_taskview_fullbg.png")

	self._txtremaintime = gohelper.findChildText(self.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_LimitTime")
end

function VersionActivity1_6TaskView:onUpdateParam()
	return
end

function VersionActivity1_6TaskView:onOpen()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.ActivityDungeon
	}, self._onOpen, self)
end

function VersionActivity1_6TaskView:_onOpen()
	self.addEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self.refreshRight, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self.refreshRight, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.UpdateTaskList, self.refreshRight, self)
	self.addEventCb(self, JumpController.instance, JumpEvent.BeforeJump, self.closeThis, self)
	TaskDispatcher.runRepeat(self.refreshRemainTime, self, TimeUtil.OneMinuteSecond)
	AudioMgr.instance:trigger(AudioEnum.UI.Act1_6DungeonEnterTaskView)
	VersionActivity1_6TaskListModel.instance:initTask()
	self:refreshLeft()
	self:refreshRight()
end

function VersionActivity1_6TaskView:refreshLeft()
	self:refreshRemainTime()
end

function VersionActivity1_6TaskView:refreshRemainTime()
	local actInfoMo = ActivityModel.instance:getActivityInfo()[VersionActivity1_6Enum.ActivityId.Dungeon]
	local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()
	local day = Mathf.Floor(offsetSecond / TimeUtil.OneDaySecond)
	local hourSecond = offsetSecond % TimeUtil.OneDaySecond
	local hour = Mathf.Floor(hourSecond / TimeUtil.OneHourSecond)

	self._txtremaintime.text = actInfoMo:getRemainTimeStr3(false, true)
end

function VersionActivity1_6TaskView:refreshRight()
	VersionActivity1_6TaskListModel.instance:sortTaskMoList()
	VersionActivity1_6TaskListModel.instance:refreshList()
end

function VersionActivity1_6TaskView:onClose()
	TaskDispatcher.cancelTask(self.refreshRemainTime, self)
end

function VersionActivity1_6TaskView:onDestroyView()
	self._simageFullBG:UnLoadImage()
end

return VersionActivity1_6TaskView
