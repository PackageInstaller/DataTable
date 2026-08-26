-- chunkname: @modules/logic/versionactivity3_7/xruianyi/view/XRuiAnYiTaskView.lua

module("modules.logic.versionactivity3_7.xruianyi.view.XRuiAnYiTaskView", package.seeall)

local XRuiAnYiTaskView = class("XRuiAnYiTaskView", BaseView)

function XRuiAnYiTaskView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._simagelangtxt = gohelper.findChildSingleImage(self.viewGO, "Left/#simage_langtxt")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_LimitTime")
	self._scrollTaskList = gohelper.findChildScrollRect(self.viewGO, "#scroll_TaskList")
	self._goBackBtns = gohelper.findChild(self.viewGO, "#go_lefttop")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function XRuiAnYiTaskView:addEvents()
	return
end

function XRuiAnYiTaskView:removeEvents()
	return
end

function XRuiAnYiTaskView:_editableInitView()
	self._actId = VersionActivity3_7Enum.ActivityId.XRuiAnYi
end

function XRuiAnYiTaskView:onUpdateParam()
	return
end

function XRuiAnYiTaskView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.Act1_6DungeonEnterTaskView)
	self.addEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self._oneClaimReward, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._onFinishTask, self)
	XRuiAnYiTaskListModel.instance:clear()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity220
	}, self._oneClaimReward, self)
	TaskDispatcher.runRepeat(self.showLeftTime, self, TimeUtil.OneMinuteSecond)
	self:showLeftTime()
end

function XRuiAnYiTaskView:_oneClaimReward()
	XRuiAnYiTaskListModel.instance:init(self._actId)
end

function XRuiAnYiTaskView:_onFinishTask(taskId)
	if XRuiAnYiTaskListModel.instance:getById(taskId) then
		XRuiAnYiTaskListModel.instance:init(self._actId)
	end
end

function XRuiAnYiTaskView:showLeftTime()
	self._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(self._actId)
end

function XRuiAnYiTaskView:onClose()
	TaskDispatcher.cancelTask(self.showLeftTime, self)
end

return XRuiAnYiTaskView
