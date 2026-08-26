-- chunkname: @modules/logic/versionactivity2_3/dungeon/view/task/VersionActivity2_3TaskView.lua

module("modules.logic.versionactivity2_3.dungeon.view.task.VersionActivity2_3TaskView", package.seeall)

local VersionActivity2_3TaskView = class("VersionActivity2_3TaskView", BaseView)

function VersionActivity2_3TaskView:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity2_3TaskView:addEvents()
	return
end

function VersionActivity2_3TaskView:removeEvents()
	return
end

function VersionActivity2_3TaskView:_editableInitView()
	self._txtremaintime = gohelper.findChildText(self.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_LimitTime")
	self._dungeonActId = VersionActivity2_3Enum.ActivityId.Dungeon
end

function VersionActivity2_3TaskView:onUpdateParam()
	return
end

function VersionActivity2_3TaskView:onOpen()
	self.addEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self.refreshRight, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self.refreshRight, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.UpdateTaskList, self.refreshRight, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self._onRefreshActivityState, self)
	AudioMgr.instance:trigger(AudioEnum.UI.Act1_6DungeonEnterTaskView)
	TaskDispatcher.runRepeat(self.refreshRemainTime, self, TimeUtil.OneMinuteSecond)
	VersionActivity2_3TaskListModel.instance:initTask()
	self:refreshLeft()
	self:refreshRight()
end

function VersionActivity2_3TaskView:refreshLeft()
	self:refreshRemainTime()
end

function VersionActivity2_3TaskView:refreshRemainTime()
	local actInfoMo = ActivityModel.instance:getActivityInfo()[VersionActivity2_3Enum.ActivityId.Dungeon]
	local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()

	self._txtremaintime.text = TimeUtil.SecondToActivityTimeFormat(offsetSecond)
end

function VersionActivity2_3TaskView:refreshRight()
	VersionActivity2_3TaskListModel.instance:sortTaskMoList()
	VersionActivity2_3TaskListModel.instance:refreshList()
end

function VersionActivity2_3TaskView:onClose()
	TaskDispatcher.cancelTask(self.refreshRemainTime, self)
end

function VersionActivity2_3TaskView:onDestroyView()
	return
end

function VersionActivity2_3TaskView:_onRefreshActivityState(actId)
	if not actId or self._dungeonActId ~= actId then
		return
	end

	if not ActivityHelper.isOpen(actId) then
		self:closeThis()

		return
	end
end

return VersionActivity2_3TaskView
