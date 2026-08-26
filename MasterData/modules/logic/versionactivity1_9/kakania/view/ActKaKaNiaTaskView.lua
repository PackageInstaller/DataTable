-- chunkname: @modules/logic/versionactivity1_9/kakania/view/ActKaKaNiaTaskView.lua

module("modules.logic.versionactivity1_9.kakania.view.ActKaKaNiaTaskView", package.seeall)

local ActKaKaNiaTaskView = class("ActKaKaNiaTaskView", BaseView)

function ActKaKaNiaTaskView:onInitView()
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

function ActKaKaNiaTaskView:addEvents()
	return
end

function ActKaKaNiaTaskView:removeEvents()
	return
end

function ActKaKaNiaTaskView:_editableInitView()
	self.actId = VersionActivity1_9Enum.ActivityId.KaKaNia

	gohelper.setActive(self._gotime, false)
end

function ActKaKaNiaTaskView:onUpdateParam()
	return
end

function ActKaKaNiaTaskView:onOpen()
	self.addEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self._oneClaimReward, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._onFinishTask, self)
	RoleActivityTaskListModel.instance:init(self.actId)
	TaskDispatcher.runRepeat(self._showLeftTime, self, TimeUtil.OneMinuteSecond)
	self:_showLeftTime()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mission_open)
end

function ActKaKaNiaTaskView:_oneClaimReward()
	RoleActivityTaskListModel.instance:refreshData()
end

function ActKaKaNiaTaskView:_onFinishTask(taskId)
	if RoleActivityTaskListModel.instance:getById(taskId) then
		RoleActivityTaskListModel.instance:refreshData()
	end
end

function ActKaKaNiaTaskView:_showLeftTime()
	self._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(self.actId)
end

function ActKaKaNiaTaskView:onClose()
	TaskDispatcher.cancelTask(self._showLeftTime, self)
	RoleActivityTaskListModel.instance:clearData()
end

function ActKaKaNiaTaskView:onDestroyView()
	return
end

return ActKaKaNiaTaskView
