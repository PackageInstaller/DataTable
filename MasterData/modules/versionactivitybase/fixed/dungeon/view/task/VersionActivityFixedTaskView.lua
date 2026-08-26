-- chunkname: @modules/versionactivitybase/fixed/dungeon/view/task/VersionActivityFixedTaskView.lua

module("modules.versionactivitybase.fixed.dungeon.view.task.VersionActivityFixedTaskView", package.seeall)

local VersionActivityFixedTaskView = class("VersionActivityFixedTaskView", BaseView)

function VersionActivityFixedTaskView:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivityFixedTaskView:addEvents()
	return
end

function VersionActivityFixedTaskView:removeEvents()
	return
end

function VersionActivityFixedTaskView:_editableInitView()
	self._bigVersion, self._smallVersion = VersionActivityFixedDungeonController.instance:getEnterVerison()
	self._txtremaintime = gohelper.findChildText(self.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_LimitTime")
end

function VersionActivityFixedTaskView:onUpdateParam()
	return
end

function VersionActivityFixedTaskView:onOpen()
	self.addEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self.refreshRight, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self.refreshRight, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.UpdateTaskList, self.refreshRight, self)
	AudioMgr.instance:trigger(AudioEnum.UI.Act1_6DungeonEnterTaskView)
	TaskDispatcher.runRepeat(self.refreshRemainTime, self, TimeUtil.OneMinuteSecond)
	VersionActivityFixedTaskListModel.instance:initTask()
	self:refreshLeft()
	self:refreshRight()
end

function VersionActivityFixedTaskView:refreshLeft()
	self:refreshRemainTime()
end

function VersionActivityFixedTaskView:refreshRemainTime()
	local actInfoMo = ActivityModel.instance:getActivityInfo()[VersionActivityFixedHelper.getVersionActivityEnum(self._bigVersion, self._smallVersion).ActivityId.Dungeon]
	local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()

	self._txtremaintime.text = TimeUtil.SecondToActivityTimeFormat(offsetSecond)
end

function VersionActivityFixedTaskView:refreshRight()
	VersionActivityFixedTaskListModel.instance:sortTaskMoList()
	VersionActivityFixedTaskListModel.instance:refreshList()
end

function VersionActivityFixedTaskView:onClose()
	TaskDispatcher.cancelTask(self.refreshRemainTime, self)
end

function VersionActivityFixedTaskView:onDestroyView()
	return
end

return VersionActivityFixedTaskView
