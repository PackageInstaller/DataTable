-- chunkname: @modules/logic/versionactivity2_5/dungeon/view/task/VersionActivity2_5TaskView.lua

module("modules.logic.versionactivity2_5.dungeon.view.task.VersionActivity2_5TaskView", package.seeall)

local VersionActivity2_5TaskView = class("VersionActivity2_5TaskView", BaseView)

function VersionActivity2_5TaskView:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity2_5TaskView:addEvents()
	return
end

function VersionActivity2_5TaskView:removeEvents()
	return
end

function VersionActivity2_5TaskView:_editableInitView()
	self._txtremaintime = gohelper.findChildText(self.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_time")
end

function VersionActivity2_5TaskView:onUpdateParam()
	return
end

function VersionActivity2_5TaskView:onOpen()
	self.addEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self.refreshRight, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self.refreshRight, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.UpdateTaskList, self.refreshRight, self)
	AudioMgr.instance:trigger(AudioEnum.UI.Act1_6DungeonEnterTaskView)
	TaskDispatcher.runRepeat(self.refreshRemainTime, self, TimeUtil.OneMinuteSecond)
	VersionActivity2_5TaskListModel.instance:initTask()
	self:refreshLeft()
	self:refreshRight()
end

function VersionActivity2_5TaskView:refreshLeft()
	self:refreshRemainTime()
end

function VersionActivity2_5TaskView:refreshRemainTime()
	local actInfoMo = ActivityModel.instance:getActivityInfo()[VersionActivity2_5Enum.ActivityId.Dungeon]
	local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()

	self._txtremaintime.text = TimeUtil.SecondToActivityTimeFormat(offsetSecond)
end

function VersionActivity2_5TaskView:refreshRight()
	VersionActivity2_5TaskListModel.instance:sortTaskMoList()
	VersionActivity2_5TaskListModel.instance:refreshList()
end

function VersionActivity2_5TaskView:onClose()
	TaskDispatcher.cancelTask(self.refreshRemainTime, self)
end

function VersionActivity2_5TaskView:onDestroyView()
	return
end

return VersionActivity2_5TaskView
