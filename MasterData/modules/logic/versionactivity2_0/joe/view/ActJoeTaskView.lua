-- chunkname: @modules/logic/versionactivity2_0/joe/view/ActJoeTaskView.lua

module("modules.logic.versionactivity2_0.joe.view.ActJoeTaskView", package.seeall)

local ActJoeTaskView = class("ActJoeTaskView", BaseView)

function ActJoeTaskView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._simagelangtxt = gohelper.findChildSingleImage(self.viewGO, "Left/#simage_langtxt")
	self._gotime = gohelper.findChild(self.viewGO, "Left/LimitTime/image_LimitTimeBG")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_LimitTime")
	self._scrollTaskList = gohelper.findChildScrollRect(self.viewGO, "#scroll_TaskList")
	self._goBackBtns = gohelper.findChild(self.viewGO, "#go_lefttop")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ActJoeTaskView:addEvents()
	return
end

function ActJoeTaskView:removeEvents()
	return
end

function ActJoeTaskView:_editableInitView()
	self.actId = VersionActivity2_0Enum.ActivityId.Joe

	gohelper.setActive(self._gotime, false)
end

function ActJoeTaskView:onUpdateParam()
	return
end

function ActJoeTaskView:onOpen()
	self.addEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self._oneClaimReward, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._onFinishTask, self)
	RoleActivityTaskListModel.instance:init(self.actId)
	TaskDispatcher.runRepeat(self._showLeftTime, self, TimeUtil.OneMinuteSecond)
	self:_showLeftTime()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mission_open)
end

function ActJoeTaskView:_oneClaimReward()
	RoleActivityTaskListModel.instance:refreshData()
end

function ActJoeTaskView:_onFinishTask(taskId)
	if RoleActivityTaskListModel.instance:getById(taskId) then
		RoleActivityTaskListModel.instance:refreshData()
	end
end

function ActJoeTaskView:_showLeftTime()
	self._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(self.actId)
end

function ActJoeTaskView:onClose()
	TaskDispatcher.cancelTask(self._showLeftTime, self)
	RoleActivityTaskListModel.instance:clearData()
end

function ActJoeTaskView:onDestroyView()
	return
end

return ActJoeTaskView
