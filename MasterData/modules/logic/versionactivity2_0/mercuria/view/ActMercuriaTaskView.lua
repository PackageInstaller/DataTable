-- chunkname: @modules/logic/versionactivity2_0/mercuria/view/ActMercuriaTaskView.lua

module("modules.logic.versionactivity2_0.mercuria.view.ActMercuriaTaskView", package.seeall)

local ActMercuriaTaskView = class("ActMercuriaTaskView", BaseView)

function ActMercuriaTaskView:onInitView()
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

function ActMercuriaTaskView:addEvents()
	return
end

function ActMercuriaTaskView:removeEvents()
	return
end

function ActMercuriaTaskView:_editableInitView()
	self.actId = VersionActivity2_0Enum.ActivityId.Mercuria

	gohelper.setActive(self._gotime, false)
end

function ActMercuriaTaskView:onUpdateParam()
	return
end

function ActMercuriaTaskView:onOpen()
	self.addEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self._oneClaimReward, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._onFinishTask, self)
	RoleActivityTaskListModel.instance:init(self.actId)
	TaskDispatcher.runRepeat(self._showLeftTime, self, TimeUtil.OneMinuteSecond)
	self:_showLeftTime()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mission_open)
end

function ActMercuriaTaskView:_oneClaimReward()
	RoleActivityTaskListModel.instance:refreshData()
end

function ActMercuriaTaskView:_onFinishTask(taskId)
	if RoleActivityTaskListModel.instance:getById(taskId) then
		RoleActivityTaskListModel.instance:refreshData()
	end
end

function ActMercuriaTaskView:_showLeftTime()
	self._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(self.actId)
end

function ActMercuriaTaskView:onClose()
	TaskDispatcher.cancelTask(self._showLeftTime, self)
	RoleActivityTaskListModel.instance:clearData()
end

function ActMercuriaTaskView:onDestroyView()
	return
end

return ActMercuriaTaskView
