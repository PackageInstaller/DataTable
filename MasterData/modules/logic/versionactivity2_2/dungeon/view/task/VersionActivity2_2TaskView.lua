-- chunkname: @modules/logic/versionactivity2_2/dungeon/view/task/VersionActivity2_2TaskView.lua

module("modules.logic.versionactivity2_2.dungeon.view.task.VersionActivity2_2TaskView", package.seeall)

local VersionActivity2_2TaskView = class("VersionActivity2_2TaskView", BaseView)

function VersionActivity2_2TaskView:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity2_2TaskView:addEvents()
	return
end

function VersionActivity2_2TaskView:removeEvents()
	return
end

function VersionActivity2_2TaskView:_editableInitView()
	self._txtremaintime = gohelper.findChildText(self.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_LimitTime")
end

function VersionActivity2_2TaskView:onUpdateParam()
	return
end

function VersionActivity2_2TaskView:onOpen()
	self.addEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self.refreshRight, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self.refreshRight, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.UpdateTaskList, self.refreshRight, self)
	AudioMgr.instance:trigger(AudioEnum.UI.Act1_6DungeonEnterTaskView)
	TaskDispatcher.runRepeat(self.refreshRemainTime, self, TimeUtil.OneMinuteSecond)
	VersionActivity2_2TaskListModel.instance:initTask()
	self:refreshLeft()
	self:refreshRight()
end

function VersionActivity2_2TaskView:refreshLeft()
	self:refreshRemainTime()
end

function VersionActivity2_2TaskView:refreshRemainTime()
	local actInfoMo = ActivityModel.instance:getActivityInfo()[VersionActivity2_2Enum.ActivityId.Dungeon]
	local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()

	self._txtremaintime.text = TimeUtil.SecondToActivityTimeFormat(offsetSecond)
end

function VersionActivity2_2TaskView:refreshRight()
	VersionActivity2_2TaskListModel.instance:sortTaskMoList()
	VersionActivity2_2TaskListModel.instance:refreshList()
end

function VersionActivity2_2TaskView:onClose()
	TaskDispatcher.cancelTask(self.refreshRemainTime, self)
end

function VersionActivity2_2TaskView:onDestroyView()
	return
end

return VersionActivity2_2TaskView
