-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lanternfestival/view/LanternFestivalChannelView.lua

module("logic.extensions.lanternfestival.view.LanternFestivalChannelView", package.seeall)

local LanternFestivalChannelView = class("LanternFestivalChannelView", ViewComponent)
local TimeStatus = {
	OutOfAnswerTimeBeforeAll = 2,
	InAnswerTime = 1,
	OutOfAnswerTimeBetween = 4,
	OutOfAnswerTimeAfterAll = 3
}
local OptionEnum = {
	"A",
	"B",
	"C"
}

function LanternFestivalChannelView:ctor()
	LanternFestivalChannelView.super.ctor(self)
end

function LanternFestivalChannelView:unbindEvents()
	LanternFestivalChannelView.super.unbindEvents(self)

	for i, v in ipairs(self._answerList) do
		GameUtil.rmClickHandler(v.go)
	end
end

function LanternFestivalChannelView:bindEvents()
	LanternFestivalChannelView.super.bindEvents(self)

	for i, v in ipairs(self._answerList) do
		GameUtil.addClickHandler(v.go, function()
			self:_onClickAnswer(i)
		end)
	end
end

function LanternFestivalChannelView:buildUI()
	LanternFestivalChannelView.super.buildUI(self)

	local tabChannel = self:getGo("com/prize/tableview")
	local cellChannel = self:getGo("com/prize/tableview/tablecell")

	self._tableviewChannel = ScrollerList.create(tabChannel, cellChannel, GameUtil.handler(self._updateCellChannel, self), GameUtil.handler(self._clearCellChannel, self))
	self._txtTitlePrize = self:getTxt("com/prize/txtTitle")
	self._txtTimes = self:getTxt("com/riddles/txtTimes")
	self._empty = self:getGo("com/empty")
	self._txtEmpty = self:getTxt("com/empty/txt")
	self._txtOpenTime = self:getTxt("com/empty/txtOpenTime")
	self._riddles = self:getGo("com/riddles")
	self._txttimerRiddles = self:getTxt("com/riddles/txttimer")
	self._txtQuestion = self:getTxt("com/riddles/question/txt")
	self._answerList = {}

	local answerGo = self:getGo("com/riddles/answer")

	for i = 1, 3 do
		local go = goutil.findChild(answerGo, "option" .. i)
		local element = {}

		element.go = go
		element.yes = goutil.findChild(go, "yes")
		element.no = goutil.findChild(go, "no")
		element.txt = goutil.findChildTextComponent(go, "txt")

		table.insert(self._answerList, element)
	end
end

function LanternFestivalChannelView:onExit()
	LanternFestivalChannelView.super.onExit(self)
	self._tableviewChannel:dispose()
	removetimer(self._onCountDown, self)
	removetimer(self._onCountDownRiddle, self)
end

function LanternFestivalChannelView:onEnter()
	LanternFestivalChannelView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_LanternFestivalInfoRes, self._updateUIByInfo, self)
	self.addGEvent(self, GlobalNotify.PM_LanternFestivalAnswerChannelQuestionRes, self._updateUIByInfo, self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = 566001
	end

	if not ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId) then
		self:close()

		return
	end

	self:_updateUIByCfg()
	self:_updateUIByInfo()
	LanternFestivalController.instance:getInfo(self._activityId)
end

function LanternFestivalChannelView:_updateUIByCfg()
	local curWeekDay = LanternFestivalController.instance:getCurrentWeekDay()
	local addWeekdayStr = GameUtil.getChineseNumber(curWeekDay)

	if curWeekDay == 0 then
		curWeekDay = 7
		addWeekdayStr = "日"
	end

	self._txtTitlePrize.text = string.format("周%s掉落灯谜奖励", addWeekdayStr)

	local prizeChannel = LanternFestivalConfig.instance:getChannelPrize(self._activityId, curWeekDay)
	local prizeChannelAttr = string.split(prizeChannel, "#")

	self._tableviewChannel:reloadData(prizeChannelAttr)
	self._tableviewChannel:setCenterMode(true)

	self._actCfg = LanternFestivalConfig.instance:getActivityCfg(self._activityId)
	self._groupCfgs = LanternFestivalConfig.instance:getGroupCfgs(self._activityId)

	local addStr = ""

	for i, cfg in ipairs(self._groupCfgs) do
		addStr = i == 1 and (cfg.showTimeStr or "") or addStr .. "\n" .. ((not cfg.showTimeStr or nil) and "")
	end

	self._txtOpenTime.text = addStr
	self._channelAnswerMaxCount = self._actCfg.dailyChannelPrizeLimit or 0
	self._groupTimeCfgs = {}

	for _, cfg in ipairs(self._groupCfgs) do
		if not cfg.openTime then
			local openTime = ""
			local timeStrs = string.split(openTime, "#")
			local timeCfg = {}

			timeCfg.startTime = GameUtil.string2time("0-0-0 " .. timeStrs[1])
			timeCfg.endTime = GameUtil.string2time("0-0-0 " .. timeStrs[2])

			if timeCfg.endTime <= timeCfg.startTime then
				timeCfg.endTime = timeCfg.endTime + 86400
			end

			table.insert(self._groupTimeCfgs, timeCfg)
		end
	end

	self:_updateTimeStatus()
end

function LanternFestivalChannelView:_updateUIByInfo()
	self._curChannelAnswerCount = 0
	self._lastChannelPrizeMillis = 0

	local info = LanternFestivalModel.instance:getInfoByActId(self._activityId)

	if info then
		self._curChannelAnswerCount = info.todayChannelPrizeTimes or 0
		self._lastChannelPrizeMillis = Mathf.Floor(checknumber(info.lastChannelPrizeMillis) / 1000)
	end

	self._curChannelAnswerCount = Mathf.Min(self._curChannelAnswerCount, self._channelAnswerMaxCount)
	self._txtTimes.text = string.format("今日剩余次数：<color=#20B376>%s/%s</color>", self._channelAnswerMaxCount - self._curChannelAnswerCount, self._channelAnswerMaxCount)
	self._isShowRiddle = self._curChannelAnswerCount < self._channelAnswerMaxCount

	if not self._isShowRiddle then
		self._txtEmpty.text = "今日已无答题次数"
	end

	self:_updateTimeStatus()
end

function LanternFestivalChannelView:_updateCellChannel(view, cell, data)
	local item = goutil.findChild(cell.gameObject, "item")

	MaterialMgr.setCellByCfg(data, item)
end

function LanternFestivalChannelView:_clearCellChannel(cell)
	local item = goutil.findChild(cell.gameObject, "item")

	MaterialMgr.resetAll(item)
end

function LanternFestivalChannelView:_updateTimeStatus()
	self:_updateCurrentGroupId()

	self._curTimeStatus = TimeStatus.OutOfAnswerTimeBeforeAll
	self._curTimeStatus = self._curGroupId < 0 and (self._nextGroupId < 0 and TimeStatus.OutOfAnswerTimeAfterAll or TimeStatus.OutOfAnswerTimeBetween) or TimeStatus.InAnswerTime

	removetimer(self._onCountDown, self)
	removetimer(self._onCountDownRiddle, self)

	local curTime = ServerTime.now()

	self._nextChangeTime = curTime

	goutil.setActive(self._riddles, false)
	goutil.setActive(self._empty, self._curTimeStatus ~= TimeStatus.InAnswerTime)

	if not self._isShowRiddle then
		goutil.setActive(self._empty, true)
	end

	if self._curTimeStatus == TimeStatus.OutOfAnswerTimeBeforeAll then
		self._nextChangeTime = self._groupTimeCfgs[1].startTime
	elseif self._curTimeStatus == TimeStatus.OutOfAnswerTimeAfterAll then
		-- block empty
	elseif self._curTimeStatus == TimeStatus.OutOfAnswerTimeBetween then
		self._nextChangeTime = self._groupTimeCfgs[self._nextGroupId].startTime
	elseif self._curTimeStatus == TimeStatus.InAnswerTime then
		self._nextChangeTime = self._groupTimeCfgs[self._curGroupId].endTime
	end

	if curTime < self._nextChangeTime then
		settimer(1, self._onCountDown, self, true)
	end

	if self._curTimeStatus == TimeStatus.InAnswerTime and self._isShowRiddle then
		self:_updateCurrentRiddle()
	end
end

function LanternFestivalChannelView:_onCountDown()
	local curTime = ServerTime.now()

	if curTime >= self._nextChangeTime then
		removetimer(self._onCountDown, self)
		self:_updateTimeStatus()
	end
end

function LanternFestivalChannelView:_updateCurrentGroupId()
	self._curGroupId = -1
	self._nextGroupId = -1

	local curTime = ServerTime.now()

	for index, timeCfg in ipairs(self._groupTimeCfgs) do
		local startTime = timeCfg.startTime
		local endTime = timeCfg.endTime

		if endTime <= startTime then
			endTime = endTime + 86400
		end

		if startTime <= curTime and curTime <= endTime then
			self._curGroupId = index

			break
		elseif curTime < startTime and self._nextGroupId < 0 then
			self._nextGroupId = index
		end
	end
end

function LanternFestivalChannelView:_updateCurrentRiddle()
	self._nextChangeTimeRiddle = ServerTime.now()
	self._curRiddleCfg = nil
	self._curRiddleIndex = -1

	goutil.setActive(self._riddles, false)

	if self._curTimeStatus ~= TimeStatus.InAnswerTime or not self._isShowRiddle then
		goutil.setActive(self._empty, true)

		return
	end

	local startTime = self._groupTimeCfgs[self._curGroupId].startTime
	local groupcfg = self._groupCfgs[self._curGroupId]
	local interval = groupcfg.interval * 60

	self._curInterval = interval

	local nowTime = ServerTime.now()
	local deltaTime = nowTime - startTime
	local periodIndex = math.floor(deltaTime / interval) + 1

	if deltaTime % interval == 0 then
		periodIndex = periodIndex - 1
	end

	if not groupcfg.questionPlan then
		local questionPlan = 1
		local activityDay = ActivityDefineController.instance:getActivityCurrentDay(self._activityId)
		local questionCfgs = LanternFestivalConfig.instance:getQuestionPlanCfgs(questionPlan, activityDay) or {}

		if #questionCfgs == 0 then
			return
		end

		local riddleId = periodIndex % #questionCfgs

		if riddleId == 0 then
			riddleId = #questionCfgs
		end

		if self._curRiddleIndex ~= periodIndex then
			self._curRiddleIndex = periodIndex
			self._nextChangeTimeRiddle = startTime + periodIndex * interval
			self._curRiddleCfg = questionCfgs[riddleId]
		end

		self:_updateCurrentRiddleShow()
		goutil.setActive(self._riddles, true)

		if nowTime < self._nextChangeTimeRiddle then
			settimer(1, self._onCountDownRiddle, self, true)
		end
	end
end

function LanternFestivalChannelView:_onCountDownRiddle()
	local curTime = ServerTime.now()

	if curTime > self._nextChangeTimeRiddle then
		removetimer(self._onCountDownRiddle, self)
		self:_updateCurrentRiddle()

		return
	end

	if self._nextChangeTimeRiddle <= self._nextChangeTime then
		local leftTime = self._nextChangeTimeRiddle - curTime
		local hour, min, sec = GameUtil.getTimeHHMMSS(leftTime)

		self._txttimerRiddles.text = string.format("距离下一灯谜更新：<color=#20B376>%s</color>", GameUtil.FormatTimeWords(leftTime, true))
	else
		self._txttimerRiddles.text = "距离本答题时间段结束时间：" .. GameUtil.formatTimeStamp(self._nextChangeTime - curTime)
	end
end

function LanternFestivalChannelView:_updateCurrentRiddleShow()
	if not self._curRiddleCfg then
		return
	end

	if not self._curRiddleCfg.title then
		self._txtQuestion.text = ""

		for i, v in ipairs(self._answerList) do
			local optionStr = self._curRiddleCfg["option" .. OptionEnum[i]]

			v.txt.text = string.format("%s. %s", OptionEnum[i], optionStr or "")

			goutil.setActive(v.yes, false)
			goutil.setActive(v.no, false)
		end

		self._curWorryAnswerMap = {}

		self:_updateCurrentAnswersShow()
	end
end

function LanternFestivalChannelView:_updateCurrentAnswersShow()
	self._isShowResult = false

	if self._lastChannelPrizeMillis > 0 then
		self._curInterval = self._curInterval or 0

		if self._lastChannelPrizeMillis + self._curInterval > self._nextChangeTimeRiddle then
			self._isShowResult = true
		end
	end

	self._curWorryAnswerMap = self._curWorryAnswerMap or {}

	for i, v in ipairs(self._answerList) do
		goutil.setActive(v.no, self._curWorryAnswerMap[i])
	end

	if self._isShowResult then
		for i, v in ipairs(self._answerList) do
			if OptionEnum[i] == self._curRiddleCfg.answer then
				goutil.setActive(v.yes, true)
				goutil.setActive(v.no, false)
			else
				goutil.setActive(v.yes, false)
				goutil.setActive(v.no, true)
			end
		end
	end
end

function LanternFestivalChannelView:_onClickAnswer(index)
	if not self._curRiddleCfg then
		FloatWordMgr.instance:show("当前无灯谜可答")

		return
	end

	if self._isShowResult then
		FloatWordMgr.instance:show("当前灯谜已揭晓答案，请等待下一题")

		return
	end

	local selectAnswer = OptionEnum[index]

	if not string.nilorempty(selectAnswer) and selectAnswer == self._curRiddleCfg.answer then
		LanternFestivalController.instance:answerChannelQuestion(self._activityId, selectAnswer)
		FloatWordMgr.instance:show("回答正确")
	else
		FloatWordMgr.instance:show("作答错误，再想想~")

		self._curWorryAnswerMap[index] = true

		self:_updateCurrentAnswersShow()
	end
end

return LanternFestivalChannelView
