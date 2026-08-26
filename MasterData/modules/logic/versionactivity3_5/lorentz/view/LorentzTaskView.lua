-- chunkname: @modules/logic/versionactivity3_5/lorentz/view/LorentzTaskView.lua

module("modules.logic.versionactivity3_5.lorentz.view.LorentzTaskView", package.seeall)

local LorentzTaskView = class("LorentzTaskView", BaseView)

function LorentzTaskView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._simagelangtxt = gohelper.findChildSingleImage(self.viewGO, "Left/#simage_langtxt")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_LimitTime")
	self._scrollTaskList = gohelper.findChildScrollRect(self.viewGO, "#scroll_TaskList")
	self._goBackBtns = gohelper.findChild(self.viewGO, "#go_lefttop")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function LorentzTaskView:addEvents()
	return
end

function LorentzTaskView:removeEvents()
	return
end

function LorentzTaskView:_editableInitView()
	self._actId = VersionActivity3_5Enum.ActivityId.Lorentz
end

function LorentzTaskView:onUpdateParam()
	return
end

function LorentzTaskView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.Act1_6DungeonEnterTaskView)
	self.addEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self._oneClaimReward, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._onFinishTask, self)
	LorentzTaskListModel.instance:clear()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity220
	}, self._oneClaimReward, self)
	TaskDispatcher.runRepeat(self.showLeftTime, self, TimeUtil.OneMinuteSecond)
	self:showLeftTime()
end

function LorentzTaskView:_oneClaimReward()
	LorentzTaskListModel.instance:init(self._actId)
end

function LorentzTaskView:_onFinishTask(taskId)
	if LorentzTaskListModel.instance:getById(taskId) then
		LorentzTaskListModel.instance:init(self._actId)
	end
end

function LorentzTaskView:showLeftTime()
	self._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(self._actId)
end

function LorentzTaskView:onClose()
	TaskDispatcher.cancelTask(self.showLeftTime, self)
end

return LorentzTaskView
