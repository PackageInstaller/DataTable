-- chunkname: @modules/logic/autochess/main/view/AutoChessTaskView.lua

module("modules.logic.autochess.main.view.AutoChessTaskView", package.seeall)

local AutoChessTaskView = class("AutoChessTaskView", BaseView)

function AutoChessTaskView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._simagelangtxt = gohelper.findChildSingleImage(self.viewGO, "Left/#simage_langtxt")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_LimitTime")
	self._scrollTaskList = gohelper.findChildScrollRect(self.viewGO, "#scroll_TaskList")
	self._goWarning = gohelper.findChild(self.viewGO, "#go_Warning")
	self._golefttop = gohelper.findChild(self.viewGO, "#go_lefttop")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AutoChessTaskView:_editableInitView()
	local go = self:getResInst(AutoChessStrEnum.ResPath.WarningItem, self._goWarning)
	local warningItem = MonoHelper.addNoUpdateLuaComOnceToGo(go, AutoChessWarningItem)

	warningItem:refresh()
end

function AutoChessTaskView:onOpen()
	self.actId = Activity182Model.instance:getCurActId()

	AudioMgr.instance:trigger(AudioEnum.UI.Act1_6DungeonEnterTaskView)
	self.addEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self._oneClaimReward, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._onFinishTask, self)
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.AutoChess
	}, self._oneClaimReward, self)
	TaskDispatcher.runRepeat(self._showLeftTime, self, TimeUtil.OneMinuteSecond)
	self:_showLeftTime()
end

function AutoChessTaskView:_oneClaimReward()
	AutoChessTaskListModel.instance:init(self.actId)
end

function AutoChessTaskView:_onFinishTask(taskId)
	if AutoChessTaskListModel.instance:getById(taskId) then
		AutoChessTaskListModel.instance:init(self.actId)
	end
end

function AutoChessTaskView:_showLeftTime()
	self._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(self.actId)
end

function AutoChessTaskView:onClose()
	TaskDispatcher.cancelTask(self._showLeftTime, self)
	AutoChessTaskListModel.instance:clear()
end

return AutoChessTaskView
