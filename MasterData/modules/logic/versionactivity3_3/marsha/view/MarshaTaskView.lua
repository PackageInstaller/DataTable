-- chunkname: @modules/logic/versionactivity3_3/marsha/view/MarshaTaskView.lua

module("modules.logic.versionactivity3_3.marsha.view.MarshaTaskView", package.seeall)

local MarshaTaskView = class("MarshaTaskView", BaseView)

function MarshaTaskView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._simagelangtxt = gohelper.findChildSingleImage(self.viewGO, "Left/#simage_langtxt")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_limittime")
	self._scrollTaskList = gohelper.findChildScrollRect(self.viewGO, "#scroll_TaskList")
	self._goBackBtns = gohelper.findChild(self.viewGO, "#go_lefttop")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MarshaTaskView:addEvents()
	return
end

function MarshaTaskView:removeEvents()
	return
end

function MarshaTaskView:_editableInitView()
	self._actId = VersionActivity3_3Enum.ActivityId.Marsha
end

function MarshaTaskView:onUpdateParam()
	return
end

function MarshaTaskView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.Act1_6DungeonEnterTaskView)
	self.addEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self._oneClaimReward, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._onFinishTask, self)
	MarshaTaskListModel.instance:clear()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity220
	}, self._oneClaimReward, self)
	TaskDispatcher.runRepeat(self.showLeftTime, self, TimeUtil.OneMinuteSecond)
	self:showLeftTime()
end

function MarshaTaskView:_oneClaimReward()
	MarshaTaskListModel.instance:init(self._actId)
end

function MarshaTaskView:_onFinishTask(taskId)
	if MarshaTaskListModel.instance:getById(taskId) then
		MarshaTaskListModel.instance:init(self._actId)
	end
end

function MarshaTaskView:showLeftTime()
	self._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(self._actId)
end

function MarshaTaskView:onClose()
	TaskDispatcher.cancelTask(self.showLeftTime, self)
end

return MarshaTaskView
