-- chunkname: @modules/logic/versionactivity1_6/quniang/view/ActQuNiangTaskView.lua

module("modules.logic.versionactivity1_6.quniang.view.ActQuNiangTaskView", package.seeall)

local ActQuNiangTaskView = class("ActQuNiangTaskView", BaseView)

function ActQuNiangTaskView:onInitView()
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

function ActQuNiangTaskView:addEvents()
	return
end

function ActQuNiangTaskView:removeEvents()
	return
end

function ActQuNiangTaskView:_editableInitView()
	gohelper.setActive(self._gotime, false)
end

function ActQuNiangTaskView:onUpdateParam()
	return
end

function ActQuNiangTaskView:onOpen()
	self.addEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self._oneClaimReward, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._onFinishTask, self)
	ActQuNiangTaskListModel.instance:init()
	TaskDispatcher.runRepeat(self._showLeftTime, self, 60)
	self:_showLeftTime()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mission_open)
end

function ActQuNiangTaskView:_oneClaimReward()
	ActQuNiangTaskListModel.instance:refreshData()
end

function ActQuNiangTaskView:_onFinishTask(taskId)
	if ActQuNiangTaskListModel.instance:getById(taskId) then
		ActQuNiangTaskListModel.instance:refreshData()
	end
end

function ActQuNiangTaskView:_showLeftTime()
	self._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(ActQuNiangEnum.ActivityId)
end

function ActQuNiangTaskView:onClose()
	TaskDispatcher.cancelTask(self._showLeftTime, self)
	ActQuNiangTaskListModel.instance:clear()
end

function ActQuNiangTaskView:onDestroyView()
	return
end

return ActQuNiangTaskView
