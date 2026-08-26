-- chunkname: @modules/logic/versionactivity2_6/dungeon/view/task/VersionActivity2_6TaskView.lua

module("modules.logic.versionactivity2_6.dungeon.view.task.VersionActivity2_6TaskView", package.seeall)

local VersionActivity2_6TaskView = class("VersionActivity2_6TaskView", BaseView)

function VersionActivity2_6TaskView:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity2_6TaskView:addEvents()
	return
end

function VersionActivity2_6TaskView:removeEvents()
	return
end

function VersionActivity2_6TaskView:_editableInitView()
	self._txtremaintime = gohelper.findChildText(self.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_LimitTime")
end

function VersionActivity2_6TaskView:onUpdateParam()
	return
end

function VersionActivity2_6TaskView:onOpen()
	self.addEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self.refreshRight, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self.refreshRight, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.UpdateTaskList, self.refreshRight, self)
	AudioMgr.instance:trigger(AudioEnum.UI.Act1_6DungeonEnterTaskView)
	TaskDispatcher.runRepeat(self.refreshRemainTime, self, TimeUtil.OneMinuteSecond)
	VersionActivity2_6TaskListModel.instance:initTask()
	self:refreshLeft()
	self:refreshRight()
end

function VersionActivity2_6TaskView:refreshLeft()
	self:refreshRemainTime()
end

function VersionActivity2_6TaskView:refreshRemainTime()
	local actInfoMo = ActivityModel.instance:getActivityInfo()[VersionActivity2_6Enum.ActivityId.Dungeon]
	local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()

	self._txtremaintime.text = TimeUtil.SecondToActivityTimeFormat(offsetSecond)
end

function VersionActivity2_6TaskView:refreshRight()
	VersionActivity2_6TaskListModel.instance:sortTaskMoList()
	VersionActivity2_6TaskListModel.instance:refreshList()
end

function VersionActivity2_6TaskView:onClose()
	TaskDispatcher.cancelTask(self.refreshRemainTime, self)
end

function VersionActivity2_6TaskView:onDestroyView()
	return
end

return VersionActivity2_6TaskView
