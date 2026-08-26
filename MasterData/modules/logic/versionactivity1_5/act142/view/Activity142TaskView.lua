-- chunkname: @modules/logic/versionactivity1_5/act142/view/Activity142TaskView.lua

module("modules.logic.versionactivity1_5.act142.view.Activity142TaskView", package.seeall)

local Activity142TaskView = class("Activity142TaskView", BaseViewExtended)

function Activity142TaskView:onInitView()
	self._goLimitTime = gohelper.findChild(self.viewGO, "Left/LimitTime")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_LimitTime")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity142TaskView:addEvents()
	self.addEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self._oneClaimReward, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._onFinishTask, self)
	self.addEventCb(self, Activity142Controller.instance, Activity142Event.ClickEpisode, self._onGotoTaskEpisode, self)
end

function Activity142TaskView:removeEvents()
	self.removeEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self._oneClaimReward, self)
	self.removeEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._onFinishTask, self)
	self.removeEventCb(self, Activity142Controller.instance, Activity142Event.ClickEpisode, self._onGotoTaskEpisode, self)
end

function Activity142TaskView:_oneClaimReward()
	local actId = Activity142Model.instance:getActivityId()

	Activity142TaskListModel.instance:init(actId)
end

function Activity142TaskView:_onFinishTask(taskId)
	if Activity142TaskListModel.instance:getById(taskId) then
		local actId = Activity142Model.instance:getActivityId()

		Activity142TaskListModel.instance:init(actId)
	end
end

function Activity142TaskView:_onGotoTaskEpisode()
	self:closeThis()
end

function Activity142TaskView:_editableInitView()
	gohelper.setActive(self._goLimitTime, false)
end

function Activity142TaskView:onUpdateParam()
	return
end

function Activity142TaskView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mission_open)

	local actId = Activity142Model.instance:getActivityId()

	Activity142TaskListModel.instance:init(actId)
	TaskDispatcher.runRepeat(self._showLeftTime, self, TimeUtil.OneMinuteSecond)
	self:_showLeftTime()
end

function Activity142TaskView:_showLeftTime()
	local actId = Activity142Model.instance:getActivityId()

	self._txtLimitTime.text = Activity142Model.instance:getRemainTimeStr(actId)
end

function Activity142TaskView:onClose()
	TaskDispatcher.cancelTask(self._showLeftTime, self)
end

function Activity142TaskView:onDestroyView()
	return
end

return Activity142TaskView
