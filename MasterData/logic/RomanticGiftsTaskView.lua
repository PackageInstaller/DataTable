-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/romanticgifts/view/RomanticGiftsTaskView.lua

module("logic.extensions.romanticgifts.view.RomanticGiftsTaskView", package.seeall)

local RomanticGiftsTaskView = class("RomanticGiftsTaskView", ViewComponent)
local selectState = {
	achievement = 2,
	dayTask = 1
}

function RomanticGiftsTaskView:ctor()
	RomanticGiftsTaskView.super.ctor(self)
end

function RomanticGiftsTaskView:unbindEvents()
	RomanticGiftsTaskView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnDayTask:RemoveClickListener()
	self._btnAchievement:RemoveClickListener()
end

function RomanticGiftsTaskView:bindEvents()
	RomanticGiftsTaskView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._closeView, self)
	self._btnDayTask:AddClickListener(self._dayTaskOnClick, self)
	self._btnAchievement:AddClickListener(self._achievementOnClick, self)
end

function RomanticGiftsTaskView:onExit()
	RomanticGiftsTaskView.super.onExit(self)
	self._tabList:dispose()

	for k, v in pairs(self._taskRewardTabList) do
		if v then
			v:dispose()
		end
	end

	GlobalDispatcher:removeListener(GlobalNotify.PM_IF_GETINFORES, self._openTaskList, self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_IF_FORMULATASKRES, self._openTaskList, self)
end

function RomanticGiftsTaskView:buildUI()
	RomanticGiftsTaskView.super.buildUI(self)

	self._btnClose = self:getBtn("closeBtn")
	self._btnDayTask = self:getBtn("btns/btnDayTask")
	self._btnAchievement = self:getBtn("btns/btnAchievement")
	self._openDate = self:getTxt("time/txtTime")
	self._btnDayTaskSelect = self:getGo("btns/btnDayTask/select")
	self._btnAchievementSelect = self:getGo("btns/btnAchievement/select")
	self._tabGo = self:getGo("rightScrollGo/taskItemSR")
	self._tabCell = self:getGo("rightScrollGo/taskItem")
	self._tabList = ScrollerList.create(self._tabGo, self._tabCell, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))
	self._taskRewardTabList = {}
end

function RomanticGiftsTaskView:onEnter()
	RomanticGiftsTaskView.super.onEnter(self)

	self._curActId = RomanticGiftsModel.instance:getActId()

	if not self._curActId then
		FloatWordMgr.instance:show("不在活动时间")
		self:close()

		return
	end

	local startDate, endDate = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.QIXI_SEND, self._curActId)
	local startDateTable = GameUtil.time2date(startDate)
	local endDateTable = GameUtil.time2date(endDate)

	self._openDate.text = string.format("活动时间：%02d.%02d %02d:%02d-%02d.%02d %02d:%02d", startDateTable.month, startDateTable.day, startDateTable.hour, startDateTable.min, endDateTable.month, endDateTable.day, endDateTable.hour, endDateTable.min)
	self._dayTaskCfg = {}
	self._achievementCfg = {}
	self._selectState = 1

	EventTaskSummaryController.instance:onSendEventTaskSummaryGetInfoReq(self._curActId)
	GlobalDispatcher:addListener(GlobalNotify.PM_IF_GETINFORES, self._openTaskList, self)
	GlobalDispatcher:addListener(GlobalNotify.PM_IF_FORMULATASKRES, self._openTaskList, self)
end

function RomanticGiftsTaskView:_updateTabCell(view, cell, data)
	local receiveBtn = goutil.findChild(cell, "receiveBtn")
	local jumpBtn = goutil.findChild(cell, "jumpBtn")
	local finishGo = goutil.findChild(cell, "finishGo")
	local rewardGo = goutil.findChild(cell, "cell")
	local rewardTab = goutil.findChild(cell, "tableview")
	local nameTxt = goutil.findChildTextComponent(cell, "nameTxt")
	local descTxt = goutil.findChildTextComponent(cell, "descTxt")
	local progerTxt = goutil.findChildTextComponent(cell, "progerTxt")

	goutil.setActive(receiveBtn, data.state == RomanticGiftsModel.taskState.complete)
	goutil.setActive(jumpBtn, data.state == RomanticGiftsModel.taskState.unComplete)
	goutil.setActive(finishGo, data.state == RomanticGiftsModel.taskState.completed)

	nameTxt.text = data.title
	descTxt.text = data.desc
	progerTxt.text = string.format("%s/%s", (data.curProgress > data.maxProgress or nil) and (data.maxProgress or data.curProgress), data.maxProgress)

	GameUtil.rmClickHandler(jumpBtn)
	GameUtil.addClickHandler(jumpBtn, function()
		GotoMgr.gotoByString(data.jumpTo)
	end, self)
	GameUtil.rmClickHandler(receiveBtn)
	GameUtil.addClickHandler(receiveBtn, function()
		EventTaskSummaryController.instance:onSendEventTaskSummaryGainTaskPrizeReq(self._curActId, data.taskId)
	end, self)

	local rewardData = string.split(data.prize, "#")

	self._taskRewardTabList[cell] = self._taskRewardTabList[cell] or ScrollerList.create(rewardTab, rewardGo, GameUtil.handler(self._updateRewardList, self), GameUtil.handler(self._clearRewardCell, self))

	self._taskRewardTabList[cell]:reloadData(rewardData)
end

function RomanticGiftsTaskView:_clearTabCell(cell)
	local rewardGo = goutil.findChild(cell, "goodsPos_1")
	local receiveBtn = goutil.findChild(cell, "receiveBtn")
	local jumpBtn = goutil.findChild(cell, "jumpBtn")

	GameUtil.rmClickHandler(jumpBtn)
	GameUtil.rmClickHandler(receiveBtn)
	MaterialMgr.resetAll(rewardGo)
end

function RomanticGiftsTaskView:_updateRewardList(view, cell, data)
	MaterialMgr.resetAll(cell.gameObject)
	MaterialMgr.setCellByCfg(data, cell.gameObject)
end

function RomanticGiftsTaskView:_clearRewardCell(cell)
	return
end

function RomanticGiftsTaskView:_closeView()
	self:close()
end

function RomanticGiftsTaskView:_dayTaskOnClick()
	local dayTaskCfg = RomanticGiftsModel.instance:getDayTaskCfg(self._curActId)

	self._tabList:reloadData(dayTaskCfg)

	self._selectState = selectState.dayTask

	self:_btnState(true)
end

function RomanticGiftsTaskView:_achievementOnClick()
	local achievementCfg = RomanticGiftsModel.instance:getAchievementCfg(self._curActId)

	self._tabList:reloadData(achievementCfg)

	self._selectState = selectState.achievement

	self:_btnState(false)
end

function RomanticGiftsTaskView:_openTaskList()
	if self._selectState == selectState.dayTask then
		self:_dayTaskOnClick()
	else
		self:_achievementOnClick()
	end
end

function RomanticGiftsTaskView:_btnState(isShow)
	goutil.setActive(self._btnDayTaskSelect, isShow)
	goutil.setActive(self._btnAchievementSelect, not isShow)
end

return RomanticGiftsTaskView
