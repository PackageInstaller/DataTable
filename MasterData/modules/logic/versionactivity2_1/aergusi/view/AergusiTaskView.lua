-- chunkname: @modules/logic/versionactivity2_1/aergusi/view/AergusiTaskView.lua

module("modules.logic.versionactivity2_1.aergusi.view.AergusiTaskView", package.seeall)

local AergusiTaskView = class("AergusiTaskView", BaseView)

function AergusiTaskView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._simagelangtxt = gohelper.findChildSingleImage(self.viewGO, "Left/#simage_langtxt")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_LimitTime")
	self._scrollTaskList = gohelper.findChildScrollRect(self.viewGO, "#scroll_TaskList")
	self._goBackBtns = gohelper.findChild(self.viewGO, "#go_BackBtns")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AergusiTaskView:addEvents()
	return
end

function AergusiTaskView:removeEvents()
	return
end

function AergusiTaskView:_editableInitView()
	self._drag = SLFramework.UGUI.UIDragListener.Get(self._scrollTaskList.gameObject)

	self._drag:AddDragBeginListener(self._onDragBegin, self)
	self._drag:AddDragEndListener(self._onDragEnd, self)

	self._image_LimitTimeBGGo = gohelper.findChild(self.viewGO, "Left/LimitTime/image_LimitTimeBG")

	gohelper.setActive(self._image_LimitTimeBGGo, false)
end

function AergusiTaskView:_onDragBegin()
	AergusiTaskListModel.instance:setAniDisable(true)
end

function AergusiTaskView:_onDragEnd()
	AergusiTaskListModel.instance:setAniDisable(false)
end

function AergusiTaskView:onUpdateParam()
	return
end

function AergusiTaskView:onOpen()
	AergusiTaskListModel.instance:init(VersionActivity2_1Enum.ActivityId.Aergusi)
	self:_addEvents()
	TaskDispatcher.runRepeat(self._refreshDeadline, self, TimeUtil.OneMinuteSecond)
	self:_refreshDeadline()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mission_open)
end

function AergusiTaskView:_addEvents()
	self.addEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self._oneClaimReward, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._onFinishTask, self)
end

function AergusiTaskView:_oneClaimReward()
	self:_refreshItems()
end

function AergusiTaskView:_onFinishTask(taskId)
	self:_refreshItems()
end

function AergusiTaskView:_refreshDeadline()
	self._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(VersionActivity2_1Enum.ActivityId.Aergusi)
end

function AergusiTaskView:_refreshItems()
	local taskDict = TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.Activity163)
end

function AergusiTaskView:onClose()
	return
end

function AergusiTaskView:_removeEvents()
	self.removeEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self._oneClaimReward, self)
	self.removeEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._onFinishTask, self)
end

function AergusiTaskView:onDestroyView()
	self._drag:RemoveDragBeginListener()
	self._drag:RemoveDragEndListener()
	self:_removeEvents()
	TaskDispatcher.cancelTask(self._refreshDeadline, self)
	self._simageFullBG:UnLoadImage()
end

return AergusiTaskView
