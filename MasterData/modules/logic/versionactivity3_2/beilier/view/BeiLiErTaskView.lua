-- chunkname: @modules/logic/versionactivity3_2/beilier/view/BeiLiErTaskView.lua

module("modules.logic.versionactivity3_2.beilier.view.BeiLiErTaskView", package.seeall)

local BeiLiErTaskView = class("BeiLiErTaskView", BaseView)

function BeiLiErTaskView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._simagelangtxt = gohelper.findChildSingleImage(self.viewGO, "Left/#simage_langtxt")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_limittime")
	self._scrollTaskList = gohelper.findChildScrollRect(self.viewGO, "#scroll_TaskList")
	self._goBackBtns = gohelper.findChild(self.viewGO, "#go_lefttop")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function BeiLiErTaskView:addEvents()
	return
end

function BeiLiErTaskView:removeEvents()
	return
end

function BeiLiErTaskView:_editableInitView()
	self._actId = VersionActivity3_2Enum.ActivityId.BeiLiEr
end

function BeiLiErTaskView:onUpdateParam()
	return
end

function BeiLiErTaskView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.Act1_6DungeonEnterTaskView)
	self.addEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self._oneClaimReward, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._onFinishTask, self)
	BeiLiErTaskListModel.instance:clear()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity220
	}, self._oneClaimReward, self)
	TaskDispatcher.runRepeat(self.showLeftTime, self, TimeUtil.OneMinuteSecond)
	self:showLeftTime()
end

function BeiLiErTaskView:_oneClaimReward()
	BeiLiErTaskListModel.instance:init(self._actId)
end

function BeiLiErTaskView:_onFinishTask(taskId)
	if BeiLiErTaskListModel.instance:getById(taskId) then
		BeiLiErTaskListModel.instance:init(self._actId)
	end
end

function BeiLiErTaskView:showLeftTime()
	self._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(self._actId)
end

function BeiLiErTaskView:onClose()
	TaskDispatcher.cancelTask(self.showLeftTime, self)
end

return BeiLiErTaskView
