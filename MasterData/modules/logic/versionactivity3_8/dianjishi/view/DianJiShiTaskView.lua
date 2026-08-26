-- chunkname: @modules/logic/versionactivity3_8/dianjishi/view/DianJiShiTaskView.lua

module("modules.logic.versionactivity3_8.dianjishi.view.DianJiShiTaskView", package.seeall)

local DianJiShiTaskView = class("DianJiShiTaskView", BaseView)

function DianJiShiTaskView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._simagelangtxt = gohelper.findChildSingleImage(self.viewGO, "Left/#simage_langtxt")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_LimitTime")
	self._scrollTaskList = gohelper.findChildScrollRect(self.viewGO, "#scroll_TaskList")
	self._goBackBtns = gohelper.findChild(self.viewGO, "#go_lefttop")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function DianJiShiTaskView:addEvents()
	return
end

function DianJiShiTaskView:removeEvents()
	return
end

function DianJiShiTaskView:_editableInitView()
	self._actId = VersionActivity3_8Enum.ActivityId.DianJiShi
end

function DianJiShiTaskView:onUpdateParam()
	return
end

function DianJiShiTaskView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.Act1_6DungeonEnterTaskView)
	self.addEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self._oneClaimReward, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._onFinishTask, self)
	DianJiShiTaskListModel.instance:clear()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity220
	}, self._oneClaimReward, self)
	TaskDispatcher.runRepeat(self.showLeftTime, self, TimeUtil.OneMinuteSecond)
	self:showLeftTime()
end

function DianJiShiTaskView:_oneClaimReward()
	DianJiShiTaskListModel.instance:init(self._actId)
end

function DianJiShiTaskView:_onFinishTask(taskId)
	if DianJiShiTaskListModel.instance:getById(taskId) then
		DianJiShiTaskListModel.instance:init(self._actId)
	end
end

function DianJiShiTaskView:showLeftTime()
	self._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(self._actId)
end

function DianJiShiTaskView:onClose()
	TaskDispatcher.cancelTask(self.showLeftTime, self)
end

return DianJiShiTaskView
