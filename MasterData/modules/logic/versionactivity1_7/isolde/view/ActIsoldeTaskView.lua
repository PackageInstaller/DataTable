-- chunkname: @modules/logic/versionactivity1_7/isolde/view/ActIsoldeTaskView.lua

module("modules.logic.versionactivity1_7.isolde.view.ActIsoldeTaskView", package.seeall)

local ActIsoldeTaskView = class("ActIsoldeTaskView", BaseView)

function ActIsoldeTaskView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._simagelangtxt = gohelper.findChildSingleImage(self.viewGO, "Left/#simage_langtxt")
	self._gotime = gohelper.findChild(self.viewGO, "Left/LimitTime")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_LimitTime")
	self._scrollTaskList = gohelper.findChildScrollRect(self.viewGO, "#scroll_TaskList")
	self._goBackBtns = gohelper.findChild(self.viewGO, "#go_lefttop")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ActIsoldeTaskView:addEvents()
	return
end

function ActIsoldeTaskView:removeEvents()
	return
end

function ActIsoldeTaskView:_editableInitView()
	gohelper.setActive(self._gotime, false)
end

function ActIsoldeTaskView:onUpdateParam()
	return
end

function ActIsoldeTaskView:onOpen()
	self.addEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self._oneClaimReward, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._onFinishTask, self)
	ActIsoldeTaskListModel.instance:init()
	TaskDispatcher.runRepeat(self._showLeftTime, self, TimeUtil.OneMinuteSecond)
	self:_showLeftTime()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mission_open)
end

function ActIsoldeTaskView:_oneClaimReward()
	ActIsoldeTaskListModel.instance:refreshData()
end

function ActIsoldeTaskView:_onFinishTask(taskId)
	if ActIsoldeTaskListModel.instance:getById(taskId) then
		ActIsoldeTaskListModel.instance:refreshData()
	end
end

function ActIsoldeTaskView:_showLeftTime()
	self._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(VersionActivity1_7Enum.ActivityId.Isolde)
end

function ActIsoldeTaskView:onClose()
	TaskDispatcher.cancelTask(self._showLeftTime, self)
	ActIsoldeTaskListModel.instance:clear()
end

function ActIsoldeTaskView:onDestroyView()
	return
end

return ActIsoldeTaskView
