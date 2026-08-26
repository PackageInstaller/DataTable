-- chunkname: @modules/logic/versionactivity1_4/act131/view/Activity131TaskView.lua

module("modules.logic.versionactivity1_4.act131.view.Activity131TaskView", package.seeall)

local Activity131TaskView = class("Activity131TaskView", BaseView)

function Activity131TaskView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._simagelangtxt = gohelper.findChildSingleImage(self.viewGO, "Left/#simage_langtxt")
	self._scrollTaskList = gohelper.findChildScrollRect(self.viewGO, "#scroll_TaskList")
	self._goBackBtns = gohelper.findChild(self.viewGO, "#go_BackBtns")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity131TaskView:addEvents()
	return
end

function Activity131TaskView:removeEvents()
	return
end

function Activity131TaskView:_editableInitView()
	self._simageFullBG:LoadImage(ResUrl.getV1a4Role6SingleBg("v1a4_role6_mission_fullbg"))
end

function Activity131TaskView:onUpdateParam()
	return
end

function Activity131TaskView:onOpen()
	self.addEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self._oneClaimReward, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._onFinishTask, self)
	Activity131TaskListModel.instance:init()
end

function Activity131TaskView:_oneClaimReward()
	Activity131TaskListModel.instance:refreshData()
end

function Activity131TaskView:_onFinishTask(taskId)
	if Activity131TaskListModel.instance:getById(taskId) then
		Activity131TaskListModel.instance:refreshData()
	end
end

function Activity131TaskView:onClose()
	return
end

function Activity131TaskView:onDestroyView()
	self._simageFullBG:UnLoadImage()
end

return Activity131TaskView
