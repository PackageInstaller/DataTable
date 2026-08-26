-- chunkname: @modules/logic/versionactivity1_7/dungeon/view/task/VersionActivity1_7TaskView.lua

module("modules.logic.versionactivity1_7.dungeon.view.task.VersionActivity1_7TaskView", package.seeall)

local VersionActivity1_7TaskView = class("VersionActivity1_7TaskView", BaseView)

function VersionActivity1_7TaskView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._simageLangTxt = gohelper.findChildSingleImage(self.viewGO, "Left/#simage_langtxt")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity1_7TaskView:addEvents()
	return
end

function VersionActivity1_7TaskView:removeEvents()
	return
end

function VersionActivity1_7TaskView:_editableInitView()
	self._simageFullBG:LoadImage("singlebg/v1a7_mainactivity_singlebg/v1a7_task_fullbg.png")
	self._simageLangTxt:LoadImage("singlebg_lang/txt_v1a7_mainactivity_singlebg/v1a7_task_title.png")

	self._txtremaintime = gohelper.findChildText(self.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_LimitTime")
end

function VersionActivity1_7TaskView:onUpdateParam()
	return
end

function VersionActivity1_7TaskView:onOpen()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.ActivityDungeon
	}, self._onOpen, self)
end

function VersionActivity1_7TaskView:_onOpen()
	self.addEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self.refreshRight, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self.refreshRight, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.UpdateTaskList, self.refreshRight, self)
	AudioMgr.instance:trigger(AudioEnum.UI.Act1_6DungeonEnterTaskView)
	TaskDispatcher.runRepeat(self.refreshRemainTime, self, TimeUtil.OneMinuteSecond)
	VersionActivity1_7TaskListModel.instance:initTask()
	self:refreshLeft()
	self:refreshRight()
end

function VersionActivity1_7TaskView:refreshLeft()
	self:refreshRemainTime()
end

function VersionActivity1_7TaskView:refreshRemainTime()
	local actInfoMo = ActivityModel.instance:getActivityInfo()[VersionActivity1_7Enum.ActivityId.Dungeon]
	local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()

	self._txtremaintime.text = TimeUtil.SecondToActivityTimeFormat(offsetSecond)
end

function VersionActivity1_7TaskView:refreshRight()
	VersionActivity1_7TaskListModel.instance:sortTaskMoList()
	VersionActivity1_7TaskListModel.instance:refreshList()
end

function VersionActivity1_7TaskView:onClose()
	TaskDispatcher.cancelTask(self.refreshRemainTime, self)
end

function VersionActivity1_7TaskView:onDestroyView()
	self._simageFullBG:UnLoadImage()
	self._simageLangTxt:UnLoadImage()
end

return VersionActivity1_7TaskView
