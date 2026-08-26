-- chunkname: @modules/logic/versionactivity1_6/getian/view/ActGeTianTaskView.lua

module("modules.logic.versionactivity1_6.getian.view.ActGeTianTaskView", package.seeall)

local ActGeTianTaskView = class("ActGeTianTaskView", BaseView)

function ActGeTianTaskView:onInitView()
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

function ActGeTianTaskView:addEvents()
	return
end

function ActGeTianTaskView:removeEvents()
	return
end

function ActGeTianTaskView:_editableInitView()
	gohelper.setActive(self._gotime, false)
end

function ActGeTianTaskView:onUpdateParam()
	return
end

function ActGeTianTaskView:onOpen()
	self.addEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self._oneClaimReward, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._onFinishTask, self)
	ActGeTianTaskListModel.instance:init()
	TaskDispatcher.runRepeat(self._showLeftTime, self, 60)
	self:_showLeftTime()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mission_open)
end

function ActGeTianTaskView:_oneClaimReward()
	ActGeTianTaskListModel.instance:refreshData()
end

function ActGeTianTaskView:_onFinishTask(taskId)
	if ActGeTianTaskListModel.instance:getById(taskId) then
		ActGeTianTaskListModel.instance:refreshData()
	end
end

function ActGeTianTaskView:_showLeftTime()
	self._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(ActGeTianEnum.ActivityId)
end

function ActGeTianTaskView:onClose()
	TaskDispatcher.cancelTask(self._showLeftTime, self)
	ActGeTianTaskListModel.instance:clear()
end

function ActGeTianTaskView:onDestroyView()
	return
end

return ActGeTianTaskView
