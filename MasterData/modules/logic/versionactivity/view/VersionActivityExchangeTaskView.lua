-- chunkname: @modules/logic/versionactivity/view/VersionActivityExchangeTaskView.lua

module("modules.logic.versionactivity.view.VersionActivityExchangeTaskView", package.seeall)

local VersionActivityExchangeTaskView = class("VersionActivityExchangeTaskView", BaseView)

function VersionActivityExchangeTaskView:onInitView()
	self._btnclose1 = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close1")
	self._scrolltasklist = gohelper.findChildScrollRect(self.viewGO, "#scroll_tasklist")
	self._gotaskitem = gohelper.findChild(self.viewGO, "#scroll_tasklist/Viewport/Content/#go_taskitem")
	self._btnclose2 = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close2")
	self._godailytask = gohelper.findChild(self.viewGO, "option/#go_dailytask")
	self._godailyselected = gohelper.findChild(self.viewGO, "option/#go_dailytask/#go_daily_selected")
	self._godailyunselected = gohelper.findChild(self.viewGO, "option/#go_dailytask/#go_daily_unselected")
	self._btndailyclick = gohelper.findChildButtonWithAudio(self.viewGO, "option/#go_dailytask/#btn_daily_click")
	self._gochallengetask = gohelper.findChild(self.viewGO, "option/#go_challengetask")
	self._gochallengeselected = gohelper.findChild(self.viewGO, "option/#go_challengetask/#go_challenge_selected")
	self._gochallengeunselected = gohelper.findChild(self.viewGO, "option/#go_challengetask/#go_challenge_unselected")
	self._btnchallengeclick = gohelper.findChildButtonWithAudio(self.viewGO, "option/#go_challengetask/#btn_challenge_click")
	self._txtremaintime = gohelper.findChildText(self.viewGO, "#txt_remaintime")
	self._gotaskdayreddot1 = gohelper.findChild(self.viewGO, "option/#go_dailytask/#go_daily_selected/#go_taskdayreddot")
	self._gotaskdayreddot2 = gohelper.findChild(self.viewGO, "option/#go_dailytask/#go_daily_unselected/#go_taskdayreddot")
	self._gotaskchallengereddot1 = gohelper.findChild(self.viewGO, "option/#go_challengetask/#go_challenge_unselected/#go_taskchallengereddot")
	self._gotaskchallengereddot2 = gohelper.findChild(self.viewGO, "option/#go_challengetask/#go_challenge_selected/#go_taskchallengereddot")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivityExchangeTaskView:addEvents()
	self._btnclose1:AddClickListener(self._btnclose1OnClick, self)
	self._btnclose2:AddClickListener(self._btnclose2OnClick, self)
	self._btndailyclick:AddClickListener(self._btndailyclickOnClick, self)
	self._btnchallengeclick:AddClickListener(self._btnchallengeclickOnClick, self)
end

function VersionActivityExchangeTaskView:removeEvents()
	self._btnclose1:RemoveClickListener()
	self._btnclose2:RemoveClickListener()
	self._btndailyclick:RemoveClickListener()
	self._btnchallengeclick:RemoveClickListener()
end

function VersionActivityExchangeTaskView:_btndailyclickOnClick()
	self._isDailyTaskType = true

	self:_refreshTop()
	self:_refreshTask()
end

function VersionActivityExchangeTaskView:_btnchallengeclickOnClick()
	self._isDailyTaskType = false

	self:_refreshTop()
	self:_refreshTask()
end

function VersionActivityExchangeTaskView:_btnclose1OnClick()
	self:closeThis()
end

function VersionActivityExchangeTaskView:_btnclose2OnClick()
	self:closeThis()
end

function VersionActivityExchangeTaskView:_editableInitView()
	self.taskItemList = {}

	gohelper.setActive(self._gotaskitem, false)
	RedDotController.instance:addRedDot(self._gotaskdayreddot1, RedDotEnum.DotNode.VersionActivityExchangeTaskDay)
	RedDotController.instance:addRedDot(self._gotaskdayreddot2, RedDotEnum.DotNode.VersionActivityExchangeTaskDay)
	RedDotController.instance:addRedDot(self._gotaskchallengereddot1, RedDotEnum.DotNode.VersionActivityExchangeTaskChallenge)
	RedDotController.instance:addRedDot(self._gotaskchallengereddot2, RedDotEnum.DotNode.VersionActivityExchangeTaskChallenge)
end

function VersionActivityExchangeTaskView:onUpdateParam()
	return
end

function VersionActivityExchangeTaskView:onOpen()
	self.addEventCb(self, VersionActivityController.instance, VersionActivityEvent.VersionActivity112TaskGetBonus, self.onGetBonus, self)
	self.addEventCb(self, VersionActivityController.instance, VersionActivityEvent.VersionActivity112TaskUpdate, self._refreshTask, self)
	TaskDispatcher.runRepeat(self.updateDeadline, self, 60)

	self._isDailyTaskType = true
	self.actId = self.viewParam.actId
	self._actMO = ActivityModel.instance:getActMO(self.actId)

	self:_refreshTop()
	self:_refreshTask(true)
	self:updateDeadline()
end

function VersionActivityExchangeTaskView:onClose()
	self.removeEventCb(self, VersionActivityController.instance, VersionActivityEvent.VersionActivity112TaskGetBonus, self.onGetBonus, self)
	self.removeEventCb(self, VersionActivityController.instance, VersionActivityEvent.VersionActivity112TaskUpdate, self._refreshTask, self)
	TaskDispatcher.cancelTask(self.updateDeadline, self)
end

function VersionActivityExchangeTaskView:onDestroyView()
	for i, v in ipairs(self.taskItemList) do
		v:onDestroyView()
	end

	self.taskItemList = nil
end

function VersionActivityExchangeTaskView:_refreshTop()
	gohelper.setActive(self._godailyselected, self._isDailyTaskType)
	gohelper.setActive(self._godailyunselected, self._isDailyTaskType == false)
	gohelper.setActive(self._gochallengeselected, self._isDailyTaskType == false)
	gohelper.setActive(self._gochallengeunselected, self._isDailyTaskType)
end

function VersionActivityExchangeTaskView:_refreshTask(isOpen)
	VersionActivity112TaskListModel.instance:updateTaksList(self.actId, self._isDailyTaskType)

	local list = VersionActivity112TaskListModel.instance:getList()

	for i, v in ipairs(list) do
		local item = self.taskItemList[i]

		if item == nil then
			local itemGo = gohelper.cloneInPlace(self._gotaskitem, "item" .. i)

			gohelper.setActive(itemGo, true)

			item = MonoHelper.addLuaComOnceToGo(itemGo, VersionActivityExchangeTaskItem, self)
			self.taskItemList[i] = item
		end

		item:onUpdateMO(v, i, isOpen)
		gohelper.setActive(item.go, true)
	end

	for i = #list + 1, #self.taskItemList do
		gohelper.setActive(self.taskItemList[i].go, false)
	end
end

function VersionActivityExchangeTaskView:onGetBonus(taskId)
	self:_refreshTask()
end

function VersionActivityExchangeTaskView:updateDeadline()
	local endTime = ActivityModel.instance:getActEndTime(self.actId)

	endTime = endTime / 1000

	local endTime = endTime - tonumber(self._actMO.config.param) * 3600
	local offsetSecond = endTime - ServerTime.now()

	offsetSecond = math.max(0, offsetSecond)

	local date, dateformate = TimeUtil.secondToRoughTime2(offsetSecond)

	self._txtremaintime.text = string.format(luaLang("activity_task_remain_time"), string.format("%s%s", date, dateformate))
end

return VersionActivityExchangeTaskView
