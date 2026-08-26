-- chunkname: @modules/logic/versionactivity1_7/marcus/view/ActMarcusTaskView.lua

module("modules.logic.versionactivity1_7.marcus.view.ActMarcusTaskView", package.seeall)

local ActMarcusTaskView = class("ActMarcusTaskView", BaseView)

function ActMarcusTaskView:onInitView()
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

function ActMarcusTaskView:addEvents()
	return
end

function ActMarcusTaskView:removeEvents()
	return
end

function ActMarcusTaskView:_editableInitView()
	gohelper.setActive(self._gotime, false)
end

function ActMarcusTaskView:onUpdateParam()
	return
end

function ActMarcusTaskView:onOpen()
	self.addEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self._oneClaimReward, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._onFinishTask, self)
	ActMarcusTaskListModel.instance:init()
	TaskDispatcher.runRepeat(self._showLeftTime, self, TimeUtil.OneMinuteSecond)
	self:_showLeftTime()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mission_open)
end

function ActMarcusTaskView:_oneClaimReward()
	ActMarcusTaskListModel.instance:refreshData()
end

function ActMarcusTaskView:_onFinishTask(taskId)
	if ActMarcusTaskListModel.instance:getById(taskId) then
		ActMarcusTaskListModel.instance:refreshData()
	end
end

function ActMarcusTaskView:_showLeftTime()
	self._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(VersionActivity1_7Enum.ActivityId.Marcus)
end

function ActMarcusTaskView:onClose()
	TaskDispatcher.cancelTask(self._showLeftTime, self)
	ActMarcusTaskListModel.instance:clear()
end

function ActMarcusTaskView:onDestroyView()
	return
end

return ActMarcusTaskView
