-- chunkname: @modules/logic/versionactivity1_4/act130/view/Activity130TaskView.lua

module("modules.logic.versionactivity1_4.act130.view.Activity130TaskView", package.seeall)

local Activity130TaskView = class("Activity130TaskView", BaseView)

function Activity130TaskView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._simagelangtxt = gohelper.findChildSingleImage(self.viewGO, "Left/#simage_langtxt")
	self._scrollTaskList = gohelper.findChildScrollRect(self.viewGO, "#scroll_TaskList")
	self._goBackBtns = gohelper.findChild(self.viewGO, "#go_BackBtns")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity130TaskView:addEvents()
	return
end

function Activity130TaskView:removeEvents()
	return
end

function Activity130TaskView:_editableInitView()
	self._simageFullBG:LoadImage(ResUrl.getV1a4Role37SingleBg("v1a4_role37_mission_fullbg"))
end

function Activity130TaskView:onUpdateParam()
	return
end

function Activity130TaskView:onOpen()
	self.addEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self._oneClaimReward, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._onFinishTask, self)
	Activity130TaskListModel.instance:init()
end

function Activity130TaskView:_oneClaimReward()
	Activity130TaskListModel.instance:refreshData()
end

function Activity130TaskView:_onFinishTask(taskId)
	if Activity130TaskListModel.instance:getById(taskId) then
		Activity130TaskListModel.instance:refreshData()
	end
end

function Activity130TaskView:onClose()
	return
end

function Activity130TaskView:onDestroyView()
	self._simageFullBG:UnLoadImage()
end

return Activity130TaskView
