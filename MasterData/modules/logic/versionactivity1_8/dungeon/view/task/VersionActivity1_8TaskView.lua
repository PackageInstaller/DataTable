-- chunkname: @modules/logic/versionactivity1_8/dungeon/view/task/VersionActivity1_8TaskView.lua

module("modules.logic.versionactivity1_8.dungeon.view.task.VersionActivity1_8TaskView", package.seeall)

local VersionActivity1_8TaskView = class("VersionActivity1_8TaskView", BaseView)
local TASK_ITEM_OPEN_ANIM_TIME = 0.8

function VersionActivity1_8TaskView:onInitView()
	self._simagelangtxt = gohelper.findChildSingleImage(self.viewGO, "Left/#simage_langtxt")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_LimitTime")
	self._scrollTaskList = gohelper.findChildScrollRect(self.viewGO, "#scroll_TaskList")
	self._golefttop = gohelper.findChild(self.viewGO, "#go_lefttop")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity1_8TaskView:addEvents()
	self.addEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self.refreshTaskList, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self.refreshTaskList, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.UpdateTaskList, self.refreshTaskList, self)
	self.addEventCb(self, JumpController.instance, JumpEvent.BeforeJump, self.closeThis, self)
end

function VersionActivity1_8TaskView:removeEvents()
	return
end

function VersionActivity1_8TaskView:_editableInitView()
	return
end

function VersionActivity1_8TaskView:onUpdateParam()
	return
end

function VersionActivity1_8TaskView:onOpen()
	VersionActivity1_8TaskListModel.instance:initTask()
	self:refreshRemainTime()
	TaskDispatcher.runRepeat(self.refreshRemainTime, self, TimeUtil.OneMinuteSecond)
	UIBlockMgr.instance:startBlock(VersionActivity1_8DungeonEnum.BlockKey.OpenTaskView)
	TaskDispatcher.runDelay(self._delayEndBlock, self, TASK_ITEM_OPEN_ANIM_TIME)
	self:refreshTaskList()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mission_open)
end

function VersionActivity1_8TaskView:_delayEndBlock()
	UIBlockMgr.instance:endBlock(VersionActivity1_8DungeonEnum.BlockKey.OpenTaskView)
end

function VersionActivity1_8TaskView:refreshTaskList()
	VersionActivity1_8TaskListModel.instance:sortTaskMoList()
	VersionActivity1_8TaskListModel.instance:refreshList()
end

function VersionActivity1_8TaskView:refreshRemainTime()
	local actInfoMo = ActivityModel.instance:getActivityInfo()[VersionActivity1_8Enum.ActivityId.Dungeon]

	if actInfoMo then
		self._txtLimitTime.text = actInfoMo:getRemainTimeStr3(false, true)
	end
end

function VersionActivity1_8TaskView:onClose()
	TaskDispatcher.cancelTask(self.refreshRemainTime, self)
	TaskDispatcher.cancelTask(self._delayEndBlock, self)
	UIBlockMgr.instance:endBlock(VersionActivity1_8DungeonEnum.BlockKey.OpenTaskView)
end

function VersionActivity1_8TaskView:onDestroyView()
	return
end

return VersionActivity1_8TaskView
