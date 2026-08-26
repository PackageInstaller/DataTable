-- chunkname: @modules/logic/versionactivity2_1/lanshoupa/view/LanShouPaTaskView.lua

module("modules.logic.versionactivity2_1.lanshoupa.view.LanShouPaTaskView", package.seeall)

local LanShouPaTaskView = class("LanShouPaTaskView", BaseView)

function LanShouPaTaskView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._simagelangtxt = gohelper.findChildSingleImage(self.viewGO, "Left/#simage_langtxt")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_LimitTime")
	self._scrollTaskList = gohelper.findChildScrollRect(self.viewGO, "#scroll_TaskList")
	self._goBackBtns = gohelper.findChild(self.viewGO, "#go_BackBtns")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function LanShouPaTaskView:addEvents()
	return
end

function LanShouPaTaskView:removeEvents()
	return
end

function LanShouPaTaskView:_editableInitView()
	self.image_LimitTimeBGGo = gohelper.findChild(self.viewGO, "Left/LimitTime/image_LimitTimeBG")

	gohelper.setActive(self.image_LimitTimeBGGo, false)
end

function LanShouPaTaskView:onUpdateParam()
	return
end

function LanShouPaTaskView:onOpen()
	self.addEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self._oneClaimReward, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._onFinishTask, self)
	Activity164TaskListModel.instance:clear()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity164
	}, self._oneClaimReward, self)
	TaskDispatcher.runRepeat(self._showLeftTime, self, 60)
	self:_showLeftTime()
end

function LanShouPaTaskView:_oneClaimReward()
	Activity164TaskListModel.instance:init(VersionActivity2_1Enum.ActivityId.LanShouPa)
end

function LanShouPaTaskView:_onFinishTask(taskId)
	if Activity164TaskListModel.instance:getById(taskId) then
		Activity164TaskListModel.instance:init(VersionActivity2_1Enum.ActivityId.LanShouPa)
	end
end

function LanShouPaTaskView:_showLeftTime()
	self._txtLimitTime.text = LanShouPaHelper.getLimitTimeStr()
end

function LanShouPaTaskView:onClose()
	TaskDispatcher.cancelTask(self._showLeftTime, self)
end

function LanShouPaTaskView:onDestroyView()
	self._simageFullBG:UnLoadImage()
end

return LanShouPaTaskView
