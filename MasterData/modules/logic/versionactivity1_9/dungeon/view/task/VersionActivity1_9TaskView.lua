-- chunkname: @modules/logic/versionactivity1_9/dungeon/view/task/VersionActivity1_9TaskView.lua

module("modules.logic.versionactivity1_9.dungeon.view.task.VersionActivity1_9TaskView", package.seeall)

local VersionActivity1_9TaskView = class("VersionActivity1_9TaskView", BaseView)

function VersionActivity1_9TaskView:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity1_9TaskView:addEvents()
	return
end

function VersionActivity1_9TaskView:removeEvents()
	return
end

function VersionActivity1_9TaskView:_editableInitView()
	self._txtremaintime = gohelper.findChildText(self.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_LimitTime")
end

function VersionActivity1_9TaskView:onUpdateParam()
	return
end

function VersionActivity1_9TaskView:onOpen()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.ActivityDungeon
	}, self._onOpen, self)
end

function VersionActivity1_9TaskView:_onOpen()
	self.addEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self.refreshRight, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self.refreshRight, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.UpdateTaskList, self.refreshRight, self)
	AudioMgr.instance:trigger(AudioEnum.UI.Act1_6DungeonEnterTaskView)
	TaskDispatcher.runRepeat(self.refreshRemainTime, self, TimeUtil.OneMinuteSecond)
	VersionActivity1_9TaskListModel.instance:initTask()
	self:refreshLeft()
	self:refreshRight()
end

function VersionActivity1_9TaskView:refreshLeft()
	self:refreshRemainTime()
end

function VersionActivity1_9TaskView:refreshRemainTime()
	local actInfoMo = ActivityModel.instance:getActivityInfo()[VersionActivity1_9Enum.ActivityId.Dungeon]
	local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()

	self._txtremaintime.text = TimeUtil.SecondToActivityTimeFormat(offsetSecond)
end

function VersionActivity1_9TaskView:refreshRight()
	VersionActivity1_9TaskListModel.instance:sortTaskMoList()
	VersionActivity1_9TaskListModel.instance:refreshList()
end

function VersionActivity1_9TaskView:onClose()
	TaskDispatcher.cancelTask(self.refreshRemainTime, self)
end

function VersionActivity1_9TaskView:onDestroyView()
	return
end

return VersionActivity1_9TaskView
