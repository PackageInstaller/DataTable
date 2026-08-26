-- chunkname: @modules/logic/versionactivity3_3/igor/view/IgorTaskView.lua

module("modules.logic.versionactivity3_3.igor.view.IgorTaskView", package.seeall)

local IgorTaskView = class("IgorTaskView", BaseView)

function IgorTaskView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._simagelangtxt = gohelper.findChildSingleImage(self.viewGO, "Left/#simage_langtxt")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_limittime")
	self._scrollTaskList = gohelper.findChildScrollRect(self.viewGO, "#scroll_TaskList")
	self._goBackBtns = gohelper.findChild(self.viewGO, "#go_lefttop")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function IgorTaskView:addEvents()
	return
end

function IgorTaskView:removeEvents()
	return
end

function IgorTaskView:_editableInitView()
	return
end

function IgorTaskView:onUpdateParam()
	return
end

function IgorTaskView:onOpen()
	self._actId = self.viewParam.actId

	AudioMgr.instance:trigger(AudioEnum.UI.Act1_6DungeonEnterTaskView)
	self.addEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self._oneClaimReward, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._onFinishTask, self)
	Activity220TaskListModel.instance:clear()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity220
	}, self._oneClaimReward, self)
	TaskDispatcher.runRepeat(self.showLeftTime, self, TimeUtil.OneMinuteSecond)
	self:showLeftTime()
end

function IgorTaskView:_oneClaimReward()
	Activity220TaskListModel.instance:init(self._actId)
end

function IgorTaskView:_onFinishTask(taskId)
	if Activity220TaskListModel.instance:getById(taskId) then
		Activity220TaskListModel.instance:init(self._actId)
	end
end

function IgorTaskView:showLeftTime()
	self._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(self._actId)
end

function IgorTaskView:onClose()
	TaskDispatcher.cancelTask(self.showLeftTime, self)
end

return IgorTaskView
