-- chunkname: @modules/logic/versionactivity1_3/jialabona/view/JiaLaBoNaTaskView.lua

module("modules.logic.versionactivity1_3.jialabona.view.JiaLaBoNaTaskView", package.seeall)

local JiaLaBoNaTaskView = class("JiaLaBoNaTaskView", BaseView)

function JiaLaBoNaTaskView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._simagelangtxt = gohelper.findChildSingleImage(self.viewGO, "Left/#simage_langtxt")
	self._scrollTaskList = gohelper.findChildScrollRect(self.viewGO, "#scroll_TaskList")
	self._goBackBtns = gohelper.findChild(self.viewGO, "#go_BackBtns")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function JiaLaBoNaTaskView:addEvents()
	return
end

function JiaLaBoNaTaskView:removeEvents()
	return
end

function JiaLaBoNaTaskView:_editableInitView()
	self._simageFullBG:LoadImage(ResUrl.getJiaLaBoNaIcon("v1a3_role1_mission_fullbg"))
end

function JiaLaBoNaTaskView:onUpdateParam()
	return
end

function JiaLaBoNaTaskView:onOpen()
	self.addEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self._oneClaimReward, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._onFinishTask, self)
	Activity120TaskListModel.instance:init(Va3ChessEnum.ActivityId.Act120)
end

function JiaLaBoNaTaskView:_oneClaimReward()
	Activity120TaskListModel.instance:init(Va3ChessEnum.ActivityId.Act120)
end

function JiaLaBoNaTaskView:_onFinishTask(taskId)
	if Activity120TaskListModel.instance:getById(taskId) then
		Activity120TaskListModel.instance:init(Va3ChessEnum.ActivityId.Act120)
	end
end

function JiaLaBoNaTaskView:onDestroyView()
	self._simageFullBG:UnLoadImage()
end

return JiaLaBoNaTaskView
