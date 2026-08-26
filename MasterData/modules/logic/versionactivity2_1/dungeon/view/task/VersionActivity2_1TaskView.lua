-- chunkname: @modules/logic/versionactivity2_1/dungeon/view/task/VersionActivity2_1TaskView.lua

module("modules.logic.versionactivity2_1.dungeon.view.task.VersionActivity2_1TaskView", package.seeall)

local VersionActivity2_1TaskView = class("VersionActivity2_1TaskView", BaseView)
local TASK_ITEM_OPEN_ANIM_TIME = 0.8

function VersionActivity2_1TaskView:onInitView()
	self._simagelangtxt = gohelper.findChildSingleImage(self.viewGO, "Left/#simage_langtxt")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_LimitTime")
	self._scrollTaskList = gohelper.findChildScrollRect(self.viewGO, "#scroll_TaskList")
	self._golefttop = gohelper.findChild(self.viewGO, "#go_lefttop")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity2_1TaskView:addEvents()
	self.addEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self.refreshTaskList, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self.refreshTaskList, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.UpdateTaskList, self.refreshTaskList, self)
	self.addEventCb(self, JumpController.instance, JumpEvent.BeforeJump, self.closeThis, self)
end

function VersionActivity2_1TaskView:removeEvents()
	return
end

function VersionActivity2_1TaskView:_editableInitView()
	return
end

function VersionActivity2_1TaskView:onUpdateParam()
	return
end

function VersionActivity2_1TaskView:onOpen()
	VersionActivity2_1TaskListModel.instance:initTask()
	self:refreshRemainTime()
	TaskDispatcher.runRepeat(self.refreshRemainTime, self, TimeUtil.OneMinuteSecond)
	UIBlockMgr.instance:startBlock(VersionActivity2_1DungeonEnum.BlockKey.OpenTaskView)
	TaskDispatcher.runDelay(self._delayEndBlock, self, TASK_ITEM_OPEN_ANIM_TIME)
	self:refreshTaskList()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mission_open)
end

function VersionActivity2_1TaskView:_delayEndBlock()
	UIBlockMgr.instance:endBlock(VersionActivity2_1DungeonEnum.BlockKey.OpenTaskView)
end

function VersionActivity2_1TaskView:refreshTaskList()
	VersionActivity2_1TaskListModel.instance:sortTaskMoList()
	VersionActivity2_1TaskListModel.instance:refreshList()
end

function VersionActivity2_1TaskView:refreshRemainTime()
	local actInfoMo = ActivityModel.instance:getActivityInfo()[VersionActivity2_1Enum.ActivityId.Dungeon]

	if actInfoMo then
		self._txtLimitTime.text = actInfoMo:getRemainTimeStr3(false, false)
	end
end

function VersionActivity2_1TaskView:onClose()
	TaskDispatcher.cancelTask(self.refreshRemainTime, self)
	TaskDispatcher.cancelTask(self._delayEndBlock, self)
	UIBlockMgr.instance:endBlock(VersionActivity2_1DungeonEnum.BlockKey.OpenTaskView)
end

function VersionActivity2_1TaskView:onDestroyView()
	return
end

return VersionActivity2_1TaskView
