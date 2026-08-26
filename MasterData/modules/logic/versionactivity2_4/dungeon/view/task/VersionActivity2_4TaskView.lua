-- chunkname: @modules/logic/versionactivity2_4/dungeon/view/task/VersionActivity2_4TaskView.lua

module("modules.logic.versionactivity2_4.dungeon.view.task.VersionActivity2_4TaskView", package.seeall)

local VersionActivity2_4TaskView = class("VersionActivity2_4TaskView", BaseView)

function VersionActivity2_4TaskView:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity2_4TaskView:addEvents()
	return
end

function VersionActivity2_4TaskView:removeEvents()
	return
end

function VersionActivity2_4TaskView:_editableInitView()
	self._txtremaintime = gohelper.findChildText(self.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_time")
end

function VersionActivity2_4TaskView:onUpdateParam()
	return
end

function VersionActivity2_4TaskView:onOpen()
	self.addEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self.refreshRight, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self.refreshRight, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.UpdateTaskList, self.refreshRight, self)
	AudioMgr.instance:trigger(AudioEnum.UI.Act1_6DungeonEnterTaskView)
	TaskDispatcher.runRepeat(self.refreshRemainTime, self, TimeUtil.OneMinuteSecond)
	VersionActivity2_4TaskListModel.instance:initTask()
	self:refreshLeft()
	self:refreshRight()
end

function VersionActivity2_4TaskView:refreshLeft()
	self:refreshRemainTime()
end

function VersionActivity2_4TaskView:refreshRemainTime()
	local actInfoMo = ActivityModel.instance:getActivityInfo()[VersionActivity2_4Enum.ActivityId.Dungeon]
	local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()

	self._txtremaintime.text = TimeUtil.SecondToActivityTimeFormat(offsetSecond)
end

function VersionActivity2_4TaskView:refreshRight()
	VersionActivity2_4TaskListModel.instance:sortTaskMoList()
	VersionActivity2_4TaskListModel.instance:refreshList()
end

function VersionActivity2_4TaskView:onClose()
	TaskDispatcher.cancelTask(self.refreshRemainTime, self)
end

function VersionActivity2_4TaskView:onDestroyView()
	return
end

return VersionActivity2_4TaskView
