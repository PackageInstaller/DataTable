-- chunkname: @modules/logic/versionactivity1_8/weila/view/ActWeilaTaskView.lua

module("modules.logic.versionactivity1_8.weila.view.ActWeilaTaskView", package.seeall)

local ActWeilaTaskView = class("ActWeilaTaskView", BaseView)

function ActWeilaTaskView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._simagelangtxt = gohelper.findChildSingleImage(self.viewGO, "Left/#simage_langtxt")
	self._goLimitTime = gohelper.findChild(self.viewGO, "Left/LimitTime/image_LimitTimeBG")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_LimitTime")
	self._scrollTaskList = gohelper.findChildScrollRect(self.viewGO, "#scroll_TaskList")
	self._goBackBtns = gohelper.findChild(self.viewGO, "#go_lefttop")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ActWeilaTaskView:addEvents()
	return
end

function ActWeilaTaskView:removeEvents()
	return
end

function ActWeilaTaskView:_editableInitView()
	return
end

function ActWeilaTaskView:onUpdateParam()
	return
end

function ActWeilaTaskView:onOpen()
	self.addEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self._oneClaimReward, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._onFinishTask, self)
	ActWeilaTaskListModel.instance:init()

	local actId = ActivityConfig.instance:getActivityCo(VersionActivity1_8Enum.ActivityId.Weila)
	local isRetroAcitivity = actId and actId.isRetroAcitivity == 2

	gohelper.setActive(self._goLimitTime.gameObject, not isRetroAcitivity)

	if not isRetroAcitivity then
		TaskDispatcher.runRepeat(self._showLeftTime, self, TimeUtil.OneMinuteSecond)
		self:_showLeftTime()
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mission_open)
end

function ActWeilaTaskView:_oneClaimReward()
	ActWeilaTaskListModel.instance:refreshData()
end

function ActWeilaTaskView:_onFinishTask(taskId)
	if ActWeilaTaskListModel.instance:getById(taskId) then
		ActWeilaTaskListModel.instance:refreshData()
	end
end

function ActWeilaTaskView:_showLeftTime()
	self._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(VersionActivity1_8Enum.ActivityId.Weila)
end

function ActWeilaTaskView:onClose()
	TaskDispatcher.cancelTask(self._showLeftTime, self)
	ActWeilaTaskListModel.instance:clear()
end

function ActWeilaTaskView:onDestroyView()
	return
end

return ActWeilaTaskView
