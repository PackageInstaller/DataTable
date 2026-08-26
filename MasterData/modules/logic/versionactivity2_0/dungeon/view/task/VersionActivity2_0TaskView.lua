-- chunkname: @modules/logic/versionactivity2_0/dungeon/view/task/VersionActivity2_0TaskView.lua

module("modules.logic.versionactivity2_0.dungeon.view.task.VersionActivity2_0TaskView", package.seeall)

local VersionActivity2_0TaskView = class("VersionActivity2_0TaskView", BaseView)
local TASK_ITEM_OPEN_ANIM_TIME = 0.8

function VersionActivity2_0TaskView:onInitView()
	self._simagelangtxt = gohelper.findChildSingleImage(self.viewGO, "Left/#simage_langtxt")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_LimitTime")
	self._scrollTaskList = gohelper.findChildScrollRect(self.viewGO, "#scroll_TaskList")
	self._golefttop = gohelper.findChild(self.viewGO, "#go_lefttop")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity2_0TaskView:addEvents()
	self.addEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self.refreshTaskList, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self.refreshTaskList, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.UpdateTaskList, self.refreshTaskList, self)
	self.addEventCb(self, JumpController.instance, JumpEvent.BeforeJump, self.closeThis, self)
end

function VersionActivity2_0TaskView:removeEvents()
	return
end

function VersionActivity2_0TaskView:_editableInitView()
	return
end

function VersionActivity2_0TaskView:onUpdateParam()
	return
end

function VersionActivity2_0TaskView:onOpen()
	VersionActivity2_0TaskListModel.instance:initTask()
	self:refreshRemainTime()
	TaskDispatcher.runRepeat(self.refreshRemainTime, self, TimeUtil.OneMinuteSecond)
	UIBlockMgr.instance:startBlock(VersionActivity2_0DungeonEnum.BlockKey.OpenTaskView)
	TaskDispatcher.runDelay(self._delayEndBlock, self, TASK_ITEM_OPEN_ANIM_TIME)
	self:refreshTaskList()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mission_open)
end

function VersionActivity2_0TaskView:_delayEndBlock()
	UIBlockMgr.instance:endBlock(VersionActivity2_0DungeonEnum.BlockKey.OpenTaskView)
end

function VersionActivity2_0TaskView:refreshTaskList()
	VersionActivity2_0TaskListModel.instance:sortTaskMoList()
	VersionActivity2_0TaskListModel.instance:refreshList()
end

function VersionActivity2_0TaskView:refreshRemainTime()
	local actInfoMo = ActivityModel.instance:getActivityInfo()[VersionActivity2_0Enum.ActivityId.Dungeon]

	if actInfoMo then
		self._txtLimitTime.text = actInfoMo:getRemainTimeStr3(false, true)
	end
end

function VersionActivity2_0TaskView:onClose()
	TaskDispatcher.cancelTask(self.refreshRemainTime, self)
	TaskDispatcher.cancelTask(self._delayEndBlock, self)
	UIBlockMgr.instance:endBlock(VersionActivity2_0DungeonEnum.BlockKey.OpenTaskView)
end

function VersionActivity2_0TaskView:onDestroyView()
	return
end

return VersionActivity2_0TaskView
