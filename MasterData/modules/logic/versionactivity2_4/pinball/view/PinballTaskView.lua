-- chunkname: @modules/logic/versionactivity2_4/pinball/view/PinballTaskView.lua

module("modules.logic.versionactivity2_4.pinball.view.PinballTaskView", package.seeall)

local PinballTaskView = class("PinballTaskView", BaseView)

function PinballTaskView:onInitView()
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_LimitTime")
	self._txtmainlv = gohelper.findChildTextMesh(self.viewGO, "Left/#go_main/#txt_lv")
	self._goslider1 = gohelper.findChildImage(self.viewGO, "Left/#go_main/#go_slider/#go_slider1")
	self._goslider2 = gohelper.findChildImage(self.viewGO, "Left/#go_main/#go_slider/#go_slider2")
	self._goslider3 = gohelper.findChildImage(self.viewGO, "Left/#go_main/#go_slider/#go_slider3")
	self._txtmainnum = gohelper.findChildTextMesh(self.viewGO, "Left/#go_main/#txt_num")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function PinballTaskView:addEvents()
	PinballController.instance:registerCallback(PinballEvent.OnCurrencyChange, self._refreshMainLv, self)
	PinballController.instance:registerCallback(PinballEvent.DataInited, self._refreshMainLv, self)
end

function PinballTaskView:removeEvents()
	PinballController.instance:unregisterCallback(PinballEvent.OnCurrencyChange, self._refreshMainLv, self)
	PinballController.instance:unregisterCallback(PinballEvent.DataInited, self._refreshMainLv, self)
end

function PinballTaskView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.Act1_6DungeonEnterTaskView)
	self.addEventCb(self, TaskController.instance, TaskEvent.SuccessGetBonus, self._oneClaimReward, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.OnFinishTask, self._onFinishTask, self)
	PinballTaskListModel.instance:clear()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity178
	}, self._oneClaimReward, self)
	TaskDispatcher.runRepeat(self._showLeftTime, self, 60)
	self:_showLeftTime()
	self:_refreshMainLv()
end

function PinballTaskView:_refreshMainLv()
	local level, curScore, nextScore = PinballModel.instance:getScoreLevel()
	local score, changeNum = PinballModel.instance:getResNum(PinballEnum.ResType.Score)

	self._txtmainlv.text = level
	self._goslider1.fillAmount = 0
	self._goslider2.fillAmount = nextScore == curScore and 1 or (score - curScore) / (nextScore - curScore)
	self._goslider3.fillAmount = 0
	self._txtmainnum.text = string.format("%d/%d", score, nextScore)
end

function PinballTaskView:_oneClaimReward()
	PinballTaskListModel.instance:init(VersionActivity2_4Enum.ActivityId.Pinball)
end

function PinballTaskView:_onFinishTask(taskId)
	if PinballTaskListModel.instance:getById(taskId) then
		PinballTaskListModel.instance:init(VersionActivity2_4Enum.ActivityId.Pinball)
	end
end

function PinballTaskView:_showLeftTime()
	self._txtLimitTime.text = PinballHelper.getLimitTimeStr()
end

function PinballTaskView:onClose()
	TaskDispatcher.cancelTask(self._showLeftTime, self)
end

return PinballTaskView
