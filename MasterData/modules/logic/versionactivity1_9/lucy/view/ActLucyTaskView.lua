-- chunkname: @modules/logic/versionactivity1_9/lucy/view/ActLucyTaskView.lua

module("modules.logic.versionactivity1_9.lucy.view.ActLucyTaskView", package.seeall)

local ActLucyTaskView = class("ActLucyTaskView", BaseView)

function ActLucyTaskView:onInitView()
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

function ActLucyTaskView:addEvents()
	return
end

function ActLucyTaskView:removeEvents()
	return
end

function ActLucyTaskView:_editableInitView()
	self.actId = VersionActivity1_9Enum.ActivityId.Lucy

	gohelper.setActive(self._gotime, false)
end

function ActLucyTaskView:onUpdateParam()
	return
end

function ActLucyTaskView:onOpen()
	self.addEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self._oneClaimReward, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._onFinishTask, self)
	RoleActivityTaskListModel.instance:init(self.actId)
	TaskDispatcher.runRepeat(self._showLeftTime, self, TimeUtil.OneMinuteSecond)
	self:_showLeftTime()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mission_open)
end

function ActLucyTaskView:_oneClaimReward()
	RoleActivityTaskListModel.instance:refreshData()
end

function ActLucyTaskView:_onFinishTask(taskId)
	if RoleActivityTaskListModel.instance:getById(taskId) then
		RoleActivityTaskListModel.instance:refreshData()
	end
end

function ActLucyTaskView:_showLeftTime()
	self._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(self.actId)
end

function ActLucyTaskView:onClose()
	TaskDispatcher.cancelTask(self._showLeftTime, self)
	RoleActivityTaskListModel.instance:clearData()
end

function ActLucyTaskView:onDestroyView()
	return
end

return ActLucyTaskView
