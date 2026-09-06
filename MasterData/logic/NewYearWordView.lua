-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/partysummary/view/NewYearWordView.lua

module("logic.extensions.partysummary.view.NewYearWordView", package.seeall)

local NewYearWordView = class("NewYearWordView", ViewComponent)

function NewYearWordView:ctor()
	NewYearWordView.super.ctor(self)
end

function NewYearWordView:buildUI()
	NewYearWordView.super.buildUI(self)

	self._txtOpenTime = self:getTxt("timeGo/timeTxt")
	self._btnNotOpen = self:getGo("right/btnNotOpen")
	self._btnSend = self:getGo("right/btnSend")
	self._txtWord = self:getTxt("right/word/Text")
	self._tableview = self:getGo("right/tableview")
	self._cell = self:getGo("right/cell")
	self.scrollerList = ScrollerList.create(self._tableview, self._cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self.scrollerList:setCenterMode(true)

	self._btnNotOpen = self:getGo("right/btnNotOpen")
	self._btnSend = self:getGo("right/btnSend")
	self._closeBtn = self:getGo("bgGo/closeBtn")
	self._leftTime = self:getTxt("right/leftTime")
end

function NewYearWordView:bindEvents()
	NewYearWordView.super.bindEvents(self)
	GameUtil.addClickHandler(self._closeBtn, self.close, self)
	GameUtil.addClickHandler(self._btnSend, GameUtil.handler(self._onClickBtnSend, self, 1))
	GameUtil.addClickHandler(self._btnNotOpen, GameUtil.handler(self._onClickBtnSend, self, 2))
end

function NewYearWordView:unbindEvents()
	NewYearWordView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSend)
	GameUtil.rmClickHandler(self._btnNotOpen)
	GameUtil.rmClickHandler(self._closeBtn)
end

function NewYearWordView:onEnter()
	NewYearWordView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.GetCodeWordInfoRes, self._onSetUI, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._groupId = checknumber(params[2])

	if self._activityId <= 0 then
		self._activityId = PartySummaryConfig.instance:getPartyGiftActivityId()
	end

	if self._groupId <= 0 then
		printError("没有传GroupId")

		return
	end

	self._loginDay = 1
	self._activityType = PartySummaryController.instance:getActivityType()

	local isInTime = self:_isInTime()

	GameUtil.SetActive(self._btnSend, isInTime)
	GameUtil.SetActive(self._btnNotOpen, not isInTime)
	ChatAgent.instance:sendPM_GetCodeWordInfoReq()
end

function NewYearWordView:onExit()
	NewYearWordView.super.onExit(self)
	self.scrollerList:dispose()
end

function NewYearWordView:_onSetUI()
	if self._txtOpenTime and self:_isInTime() then
		self._txtOpenTime.text = self:_getTimeDesc()
	end

	local curModel = PartySummaryModel.instance:GetModel(self._activityId)
	local title, desc = PartySummaryConfig.instance:getTitleAndDesc(self._groupId, self._loginDay)

	self._txtWord.text = title .. "\n" .. desc

	local rewardData = PartySummaryConfig.instance:getRewardData(self._groupId)

	if rewardData then
		self.scrollerList:reloadData(rewardData)
	else
		printError("没读到奖励列表嘚?")
	end

	self._leftTime.text = self:_getRewardCountTxt(self._groupId, 1, 1)
end

function NewYearWordView:_updateCell(view, cell, data, tag)
	local item = goutil.findChild(cell, "item")

	MaterialMgr.setCellByCfg(data, item)
end

function NewYearWordView:_clearCell(cell)
	local item = goutil.findChild(cell, "item")

	MaterialMgr.resetAll(item)
end

function NewYearWordView:_onClickBtnSend(index)
	if index == 1 then
		if not self:_hasLeftNum(self._groupId, 1, 1) then
			FloatWordMgr.instance:show("已发送过一次奖励，无需再次发送~")

			return
		end

		local cfg = CodeWordConfig.instance:getWordGroupCfg(self._groupId)

		if cfg == nil or string.nilorempty(cfg.prize) then
			printError("口令组配置空？？")

			return
		end

		local channelIds = string.split(cfg.channelIds, "#")
		local textCfg = CodeWordConfig.instance:getTextCfg(self._groupId, self._loginDay)

		if textCfg == nil or string.nilorempty(textCfg.text) then
			printError("口令组配置空？？")

			return
		end

		local id = 2

		if channelIds and channelIds[1] then
			id = checknumber(channelIds[1])
		end

		self:close()
		UIStateManager.instance:push(ViewName.chat, id, textCfg.text)
	else
		FloatWordMgr.instance:show("活动暂未开启哦~")

		return
	end
end

function NewYearWordView:_isInTime()
	local startTime, endTime = PartySummaryConfig.instance:getStartAndEndTime(self._groupId)

	if startTime and endTime then
		return GameUtil.checkIsInTimePeriod(startTime, endTime)
	end
end

function NewYearWordView:_getTimeDesc()
	local startTimeStr, endTimeStr = PartySummaryConfig.instance:getStartAndEndTime(self._groupId)
	local startTime = GameUtil.string2time(startTimeStr)
	local endTime = GameUtil.string2time(endTimeStr)
	local timeTxt = GameUtil.getTimeTxt(startTime, endTime, GameEnum.TimeTxt.M_D_H)

	return "活动时间：" .. timeTxt
end

function NewYearWordView:_getRewardCountTxt(groupId, id, maxTimes)
	local curUseTimes = CodeWordModel.instance:getTotalPrizeTime(groupId, id)
	local leftTime = maxTimes - curUseTimes

	leftTime = Mathf.Max(leftTime, 0)

	return string.format("剩余奖励次数：%d/%d", leftTime, maxTimes)
end

function NewYearWordView:_hasLeftNum(groupId, id, maxTimes)
	local curUseTimes = CodeWordModel.instance:getTotalPrizeTime(groupId, id)

	return curUseTimes < maxTimes
end

return NewYearWordView
