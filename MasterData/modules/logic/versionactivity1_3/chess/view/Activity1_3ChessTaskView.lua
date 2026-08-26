-- chunkname: @modules/logic/versionactivity1_3/chess/view/Activity1_3ChessTaskView.lua

module("modules.logic.versionactivity1_3.chess.view.Activity1_3ChessTaskView", package.seeall)

local Activity1_3ChessTaskView = class("Activity1_3ChessTaskView", BaseViewExtended)

function Activity1_3ChessTaskView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._simagelangtxt = gohelper.findChildSingleImage(self.viewGO, "Left/#simage_langtxt")
	self._scrollTaskList = gohelper.findChildScrollRect(self.viewGO, "#scroll_TaskList")
	self._gotaskitemcontent = gohelper.findChild(self.viewGO, "#scroll_TaskList/Viewport/Content")
	self._goBackBtns = gohelper.findChild(self.viewGO, "#go_BackBtns")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity1_3ChessTaskView:addEvents()
	return
end

function Activity1_3ChessTaskView:removeEvents()
	return
end

function Activity1_3ChessTaskView:_btnnotfinishbgOnClick()
	return
end

function Activity1_3ChessTaskView:_btnfinishbgOnClick()
	return
end

function Activity1_3ChessTaskView:_btngetallOnClick()
	return
end

function Activity1_3ChessTaskView:_editableInitView()
	self._simageFullBG:LoadImage(ResUrl.get1_3ChessMapIcon("v1a3_role2_mission_fullbg"))
end

function Activity1_3ChessTaskView:onUpdateParam()
	return
end

function Activity1_3ChessTaskView:onOpen()
	self.addEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self._oneClaimReward, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._onFinishTask, self)
	self.addEventCb(self, Activity1_3ChessController.instance, Activity1_3ChessEvent.ClickEpisode, self._onGotoTaskEpisode, self)
	Activity122TaskListModel.instance:init(Va3ChessEnum.ActivityId.Act122)
end

function Activity1_3ChessTaskView:_oneClaimReward()
	Activity122TaskListModel.instance:init(Va3ChessEnum.ActivityId.Act122)
end

function Activity1_3ChessTaskView:_onFinishTask(taskId)
	if Activity122TaskListModel.instance:getById(taskId) then
		Activity122TaskListModel.instance:init(Va3ChessEnum.ActivityId.Act122)
	end
end

function Activity1_3ChessTaskView:_onGotoTaskEpisode()
	self:closeThis()
end

function Activity1_3ChessTaskView:onDestroyView()
	self._simageFullBG:UnLoadImage()
end

return Activity1_3ChessTaskView
