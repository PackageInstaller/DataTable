-- chunkname: @modules/logic/versionactivity1_5/aizila/view/AiZiLaTaskView.lua

module("modules.logic.versionactivity1_5.aizila.view.AiZiLaTaskView", package.seeall)

local AiZiLaTaskView = class("AiZiLaTaskView", BaseView)

function AiZiLaTaskView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._simagelangtxt = gohelper.findChildSingleImage(self.viewGO, "Left/#simage_langtxt")
	self._goLimitTime = gohelper.findChild(self.viewGO, "Left/LimitTime")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_LimitTime")
	self._scrollTaskList = gohelper.findChildScrollRect(self.viewGO, "#scroll_TaskList")
	self._goBackBtns = gohelper.findChild(self.viewGO, "#go_BackBtns")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AiZiLaTaskView:addEvents()
	return
end

function AiZiLaTaskView:removeEvents()
	return
end

function AiZiLaTaskView:_editableInitView()
	gohelper.setActive(self._goLimitTime, false)
end

function AiZiLaTaskView:onUpdateParam()
	return
end

function AiZiLaTaskView:onOpen()
	if self.viewContainer then
		NavigateMgr.instance:addEscape(self.viewContainer.viewName, self.closeThis, self)
	end

	self.addEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self._oneClaimReward, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._onFinishTask, self)
	AiZiLaTaskListModel.instance:init()
	TaskDispatcher.runRepeat(self._showLeftTime, self, 1)
	self:_showLeftTime()
	AudioMgr.instance:trigger(AudioEnum.V1a5AiZiLa.play_ui_mission_open)
end

function AiZiLaTaskView:_oneClaimReward()
	AiZiLaTaskListModel.instance:init()
end

function AiZiLaTaskView:_onFinishTask(taskId)
	if AiZiLaTaskListModel.instance:getById(taskId) then
		AiZiLaTaskListModel.instance:init()
	end
end

function AiZiLaTaskView:_showLeftTime()
	self._txtLimitTime.text = AiZiLaHelper.getLimitTimeStr()
end

function AiZiLaTaskView:onClose()
	TaskDispatcher.cancelTask(self._showLeftTime, self)
end

function AiZiLaTaskView:onDestroyView()
	self._simageFullBG:UnLoadImage()
end

return AiZiLaTaskView
