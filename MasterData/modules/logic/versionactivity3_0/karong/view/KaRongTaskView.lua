-- chunkname: @modules/logic/versionactivity3_0/karong/view/KaRongTaskView.lua

module("modules.logic.versionactivity3_0.karong.view.KaRongTaskView", package.seeall)

local KaRongTaskView = class("KaRongTaskView", BaseView)

function KaRongTaskView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._simagelangtxt = gohelper.findChildSingleImage(self.viewGO, "Left/#simage_langtxt")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_limittime")
	self._scrollTaskList = gohelper.findChildScrollRect(self.viewGO, "#scroll_TaskList")
	self._goBackBtns = gohelper.findChild(self.viewGO, "#go_lefttop")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function KaRongTaskView:addEvents()
	return
end

function KaRongTaskView:removeEvents()
	return
end

function KaRongTaskView:_editableInitView()
	self.actId = VersionActivity3_0Enum.ActivityId.KaRong
end

function KaRongTaskView:onUpdateParam()
	return
end

function KaRongTaskView:onOpen()
	self.addEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self._oneClaimReward, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._onFinishTask, self)
	RoleActivityTaskListModel.instance:init(self.actId)
	TaskDispatcher.runRepeat(self._showLeftTime, self, TimeUtil.OneMinuteSecond)
	self:_showLeftTime()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mission_open)
	gohelper.setActive(self._txtLimitTime.transform.parent, false)
end

function KaRongTaskView:_oneClaimReward()
	RoleActivityTaskListModel.instance:refreshData()
end

function KaRongTaskView:_onFinishTask(taskId)
	if RoleActivityTaskListModel.instance:getById(taskId) then
		RoleActivityTaskListModel.instance:refreshData()
	end
end

function KaRongTaskView:_showLeftTime()
	self._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(self.actId)
end

function KaRongTaskView:onClose()
	TaskDispatcher.cancelTask(self._showLeftTime, self)
	RoleActivityTaskListModel.instance:clearData()
end

function KaRongTaskView:onDestroyView()
	return
end

return KaRongTaskView
