-- chunkname: @modules/logic/versionactivity2_7/lengzhou6/view/LengZhou6TaskView.lua

module("modules.logic.versionactivity2_7.lengzhou6.view.LengZhou6TaskView", package.seeall)

local LengZhou6TaskView = class("LengZhou6TaskView", BaseView)

function LengZhou6TaskView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._simagelangtxt = gohelper.findChildSingleImage(self.viewGO, "Left/#simage_langtxt")
	self._txttime = gohelper.findChildText(self.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_time")
	self._scrollTaskList = gohelper.findChildScrollRect(self.viewGO, "#scroll_TaskList")
	self._golefttop = gohelper.findChild(self.viewGO, "#go_lefttop")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function LengZhou6TaskView:addEvents()
	self.addEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self._oneClaimReward, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._onFinishTask, self)
end

function LengZhou6TaskView:removeEvents()
	return
end

function LengZhou6TaskView:_oneClaimReward()
	LengZhou6TaskListModel.instance:init()
end

function LengZhou6TaskView:_onFinishTask(taskId)
	if LengZhou6TaskListModel.instance:getById(taskId) then
		LengZhou6TaskListModel.instance:init()
	end
end

function LengZhou6TaskView:_editableInitView()
	self.actId = LengZhou6Model.instance:getAct190Id()
end

function LengZhou6TaskView:onUpdateParam()
	return
end

function LengZhou6TaskView:onOpen()
	self:showLeftTime()
	TaskDispatcher.runRepeat(self.showLeftTime, self, TimeUtil.OneMinuteSecond)
end

function LengZhou6TaskView:showLeftTime()
	self._txttime.text = ActivityHelper.getActivityRemainTimeStr(self.actId)
end

function LengZhou6TaskView:onClose()
	TaskDispatcher.cancelTask(self.showLeftTime, self)
end

function LengZhou6TaskView:onDestroyView()
	return
end

return LengZhou6TaskView
