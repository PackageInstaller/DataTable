-- chunkname: @modules/logic/versionactivity3_1/yeshumei/view/YeShuMeiTaskView.lua

module("modules.logic.versionactivity3_1.yeshumei.view.YeShuMeiTaskView", package.seeall)

local YeShuMeiTaskView = class("YeShuMeiTaskView", BaseView)

function YeShuMeiTaskView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._simagelangtxt = gohelper.findChildSingleImage(self.viewGO, "Left/#simage_langtxt")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_limittime")
	self._scrollTaskList = gohelper.findChildScrollRect(self.viewGO, "#scroll_TaskList")
	self._goBackBtns = gohelper.findChild(self.viewGO, "#go_lefttop")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function YeShuMeiTaskView:addEvents()
	return
end

function YeShuMeiTaskView:removeEvents()
	return
end

function YeShuMeiTaskView:_editableInitView()
	self._actId = VersionActivity3_1Enum.ActivityId.YeShuMei
end

function YeShuMeiTaskView:onUpdateParam()
	return
end

function YeShuMeiTaskView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.Act1_6DungeonEnterTaskView)
	self.addEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self._oneClaimReward, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._onFinishTask, self)
	YeShuMeiTaskListModel.instance:clear()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity211
	}, self._oneClaimReward, self)
	TaskDispatcher.runRepeat(self.showLeftTime, self, TimeUtil.OneMinuteSecond)
	self:showLeftTime()
end

function YeShuMeiTaskView:_oneClaimReward()
	YeShuMeiTaskListModel.instance:init(self._actId)
end

function YeShuMeiTaskView:_onFinishTask(taskId)
	if YeShuMeiTaskListModel.instance:getById(taskId) then
		YeShuMeiTaskListModel.instance:init(self._actId)
	end
end

function YeShuMeiTaskView:showLeftTime()
	self._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(self._actId)
end

function YeShuMeiTaskView:onClose()
	TaskDispatcher.cancelTask(self.showLeftTime, self)
end

return YeShuMeiTaskView
