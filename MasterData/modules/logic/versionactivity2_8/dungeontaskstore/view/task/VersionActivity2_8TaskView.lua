-- chunkname: @modules/logic/versionactivity2_8/dungeontaskstore/view/task/VersionActivity2_8TaskView.lua

module("modules.logic.versionactivity2_8.dungeontaskstore.view.task.VersionActivity2_8TaskView", package.seeall)

local VersionActivity2_8TaskView = class("VersionActivity2_8TaskView", BaseView)

function VersionActivity2_8TaskView:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity2_8TaskView:addEvents()
	return
end

function VersionActivity2_8TaskView:removeEvents()
	return
end

function VersionActivity2_8TaskView:_editableInitView()
	self._txtremaintime = gohelper.findChildText(self.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_LimitTime")
end

function VersionActivity2_8TaskView:onUpdateParam()
	return
end

function VersionActivity2_8TaskView:onOpen()
	self.addEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self.refreshRight, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self.refreshRight, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.UpdateTaskList, self.refreshRight, self)
	AudioMgr.instance:trigger(AudioEnum.UI.Act1_6DungeonEnterTaskView)
	TaskDispatcher.runRepeat(self.refreshRemainTime, self, TimeUtil.OneMinuteSecond)
	VersionActivity2_8TaskListModel.instance:initTask()
	self:refreshLeft()
	self:refreshRight()
end

function VersionActivity2_8TaskView:refreshLeft()
	self:refreshRemainTime()
end

function VersionActivity2_8TaskView:refreshRemainTime()
	local actInfoMo = ActivityModel.instance:getActivityInfo()[VersionActivity2_8DungeonTaskStoreController.instance:getModuleConfig().Dungeon]
	local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()

	self._txtremaintime.text = TimeUtil.SecondToActivityTimeFormat(offsetSecond)
end

function VersionActivity2_8TaskView:refreshRight()
	VersionActivity2_8TaskListModel.instance:sortTaskMoList()
	VersionActivity2_8TaskListModel.instance:refreshList()
end

function VersionActivity2_8TaskView:onClose()
	TaskDispatcher.cancelTask(self.refreshRemainTime, self)
end

function VersionActivity2_8TaskView:onDestroyView()
	return
end

return VersionActivity2_8TaskView
