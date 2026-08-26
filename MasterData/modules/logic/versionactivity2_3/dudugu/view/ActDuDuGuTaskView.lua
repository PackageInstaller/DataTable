-- chunkname: @modules/logic/versionactivity2_3/dudugu/view/ActDuDuGuTaskView.lua

module("modules.logic.versionactivity2_3.dudugu.view.ActDuDuGuTaskView", package.seeall)

local ActDuDuGuTaskView = class("ActDuDuGuTaskView", BaseView)

function ActDuDuGuTaskView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._simagelangtxt = gohelper.findChildSingleImage(self.viewGO, "Left/#simage_langtxt")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_LimitTime")
	self._scrollTaskList = gohelper.findChildScrollRect(self.viewGO, "#scroll_TaskList")
	self._goBackBtns = gohelper.findChild(self.viewGO, "#go_lefttop")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ActDuDuGuTaskView:addEvents()
	return
end

function ActDuDuGuTaskView:removeEvents()
	return
end

function ActDuDuGuTaskView:_editableInitView()
	self.actId = VersionActivity2_3Enum.ActivityId.DuDuGu
end

function ActDuDuGuTaskView:onUpdateParam()
	return
end

function ActDuDuGuTaskView:onOpen()
	self.addEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self._oneClaimReward, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._onFinishTask, self)
	RoleActivityTaskListModel.instance:init(self.actId)
	TaskDispatcher.runRepeat(self._showLeftTime, self, TimeUtil.OneMinuteSecond)
	self:_showLeftTime()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mission_open)
end

function ActDuDuGuTaskView:_oneClaimReward()
	RoleActivityTaskListModel.instance:refreshData()
end

function ActDuDuGuTaskView:_onFinishTask(taskId)
	if RoleActivityTaskListModel.instance:getById(taskId) then
		RoleActivityTaskListModel.instance:refreshData()
	end
end

function ActDuDuGuTaskView:_showLeftTime()
	self._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(self.actId)
end

function ActDuDuGuTaskView:onClose()
	TaskDispatcher.cancelTask(self._showLeftTime, self)
	RoleActivityTaskListModel.instance:clearData()
end

function ActDuDuGuTaskView:onDestroyView()
	return
end

return ActDuDuGuTaskView
