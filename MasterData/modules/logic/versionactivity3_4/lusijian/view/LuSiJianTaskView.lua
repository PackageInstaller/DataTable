-- chunkname: @modules/logic/versionactivity3_4/lusijian/view/LuSiJianTaskView.lua

module("modules.logic.versionactivity3_4.lusijian.view.LuSiJianTaskView", package.seeall)

local LuSiJianTaskView = class("LuSiJianTaskView", BaseView)

function LuSiJianTaskView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._simagelangtxt = gohelper.findChildSingleImage(self.viewGO, "Left/#simage_langtxt")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_LimitTime")
	self._scrollTaskList = gohelper.findChildScrollRect(self.viewGO, "#scroll_TaskList")
	self._goBackBtns = gohelper.findChild(self.viewGO, "#go_lefttop")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function LuSiJianTaskView:addEvents()
	return
end

function LuSiJianTaskView:removeEvents()
	return
end

function LuSiJianTaskView:_editableInitView()
	self._actId = VersionActivity3_4Enum.ActivityId.LuSiJian
end

function LuSiJianTaskView:onUpdateParam()
	return
end

function LuSiJianTaskView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.Act1_6DungeonEnterTaskView)
	self.addEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self._oneClaimReward, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._onFinishTask, self)
	LuSiJianTaskListModel.instance:clear()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity220
	}, self._oneClaimReward, self)
	TaskDispatcher.runRepeat(self.showLeftTime, self, TimeUtil.OneMinuteSecond)
	self:showLeftTime()
end

function LuSiJianTaskView:_oneClaimReward()
	LuSiJianTaskListModel.instance:init(self._actId)
end

function LuSiJianTaskView:_onFinishTask(taskId)
	if LuSiJianTaskListModel.instance:getById(taskId) then
		LuSiJianTaskListModel.instance:init(self._actId)
	end
end

function LuSiJianTaskView:showLeftTime()
	self._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(self._actId)
end

function LuSiJianTaskView:onClose()
	TaskDispatcher.cancelTask(self.showLeftTime, self)
end

return LuSiJianTaskView
