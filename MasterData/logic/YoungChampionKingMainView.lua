-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/youngchampionking/view/YoungChampionKingMainView.lua

module("logic.extensions.youngchampionking.view.YoungChampionKingMainView", package.seeall)

local YoungChampionKingMainView = class("YoungChampionKingMainView", ViewComponent)
local ID_ENTERTAINMENT_AND_PRESELECTION = 1
local ID_SCORE_MATCH = 2
local ID_WARZONE = 3
local ID_CHAMPION = 4

function YoungChampionKingMainView:ctor()
	YoungChampionKingMainView.super.ctor(self)
end

function YoungChampionKingMainView:unbindEvents()
	YoungChampionKingMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnShop)
	GameUtil.rmClickHandler(self._btnReward)
	GameUtil.rmClickHandler(self._btnTask)
	GameUtil.rmClickHandler(self._btnBattleResult)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnFameHall)

	for i, cell in ipairs(self._enterList) do
		GameUtil.rmClickHandler(cell.go)
	end
end

function YoungChampionKingMainView:bindEvents()
	YoungChampionKingMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnShop, self._onClickBtnShop, self)
	GameUtil.addClickHandler(self._btnReward, self._onClickBtnReward, self)
	GameUtil.addClickHandler(self._btnTask, self._onClickBtnTask, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickBtnRank, self)
	GameUtil.addClickHandler(self._btnBattleResult, self._onClickBattleResult, self)
	GameUtil.addClickHandler(self._btnFameHall, self._onClickFameHall, self)

	for i, cell in ipairs(self._enterList) do
		GameUtil.addClickHandler(cell.go, GameUtil.handler(self._onClickEnter, self, i))
	end
end

function YoungChampionKingMainView:buildUI()
	YoungChampionKingMainView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnShop = self:getGo("leftBottomBtns/btnShop")
	self._btnReward = self:getGo("leftBottomBtns/btnReward")
	self._btnTask = self:getGo("leftBottomBtns/btnTask")
	self._redBtnTask = goutil.findChild(self._btnTask, "redPoint")
	self._btnBattleResult = self:getGo("leftBottomBtns/btnBattleResult")
	self._btnRank = self:getGo("leftBottomBtns/btnRank")
	self._btnFameHall = self:getGo("leftBottomBtns/btnFameHall")
	self._goldBarCon = self:getGo("goldBarCon")
	self._enterList = {}

	for i = 1, 4 do
		local cell = {}

		cell.id = i
		cell.go = self:getGo("enterList/enterCell" .. i)
		cell.bg = goutil.findChild(cell.go, "bg")
		cell.txtOpTime = goutil.findChildTextComponent(cell.go, "txtOpTime")
		cell.txtTime = goutil.findChildTextComponent(cell.go, "txtTime")
		cell.tagOp = goutil.findChild(cell.go, "tagOp")
		cell.tagNotOp = goutil.findChild(cell.go, "tagNotOp")
		cell.tagEnd = goutil.findChild(cell.go, "tagEnd")
		cell.tagPass = goutil.findChild(cell.go, "tagPass")
		cell.tagNotPass = goutil.findChild(cell.go, "tagNotPass")
		cell.redPoint = goutil.findChild(cell.go, "redpoint")

		table.insert(self._enterList, cell)
	end
end

function YoungChampionKingMainView:onExit()
	YoungChampionKingMainView.super.onExit(self)
	RedPointController.instance:unregRedPoint(self._redBtnTask)
end

function YoungChampionKingMainView:onEnter()
	YoungChampionKingMainView.super.onEnter(self)

	self._activityId = YoungChampionKingModel.instance:getCurActId()

	self:_updateUIByCfg()
	self.addGEvent(self, GlobalNotify.PM_YCKStepChange, self._onStepChange, self)
	self.addGEvent(self, GlobalNotify.PM_YCKGetInfoRes, self._updateUIByInfo, self)
	self.addGEvent(self, GlobalNotify.PM_YCKQualifierRecords, self._handleGetBattleResult, self)
	YoungChampionKingController.instance:sendPM_YCKGetInfoReq(self._activityId)

	local taskRedId = EventTaskSummaryController.instance:getCurRedIdByActivityId(self._activityId)

	if taskRedId > 0 then
		RedPointController.instance:regRedPoint(self._redBtnTask, taskRedId)
	end
end

function YoungChampionKingMainView:_updateUIByCfg()
	self._actCfg = YoungChampionKingConfig.instance:getActCfg(self._activityId)

	local btn_list = {
		{
			showAdd = true,
			id = self._actCfg.guessItem
		},
		{
			showAdd = true,
			id = self._actCfg.exchangeItem
		}
	}

	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, btn_list, false)
end

function YoungChampionKingMainView:_updateUIByInfo()
	for i, cell in ipairs(self._enterList) do
		self:_updateEnterCell(i)
	end
end

function YoungChampionKingMainView:_updateEnterCell(id)
	local cell = self._enterList[id]

	goutil.setActive(cell.tagOp, false)
	goutil.setActive(cell.tagNotOp, false)
	goutil.setActive(cell.tagEnd, false)
	goutil.setActive(cell.tagPass, false)
	goutil.setActive(cell.tagNotPass, false)
	goutil.setActive(cell.redPoint, false)

	local curStepId = YoungChampionKingModel.instance:getCurStepId()
	local curRoundId = YoungChampionKingController.instance:getRoundIdByStepId(curStepId)
	local isOpEntertainmentStepId = YoungChampionKingController.instance:getIsOpEntertainmentStepId(curStepId)
	local playerRoundId = YoungChampionKingModel.instance:getPlayerRoundId()
	local isKnockout = playerRoundId < curRoundId

	if id == ID_ENTERTAINMENT_AND_PRESELECTION then
		if not isOpEntertainmentStepId then
			if not YoungChampionKingEnum.Qualify_Step_Id then
				local useStepId = YoungChampionKingEnum.Entertainment_Step_Id
				local leftTime = YoungChampionKingController.instance:getCurLeftChanllegeTimes(useStepId)

				cell.txtTime.text = string.format("今日剩余挑战次数:%s", leftTime)

				goutil.setActive(cell.redPoint, leftTime > 0)

				if isOpEntertainmentStepId then
					goutil.setActive(cell.tagPass, playerRoundId > YoungChampionKingEnum.Qualify_Round_Id)
					goutil.setActive(cell.tagNotPass, playerRoundId == YoungChampionKingEnum.Qualify_Round_Id)

					if not isKnockout then
						cell.txtTime.text = ""

						goutil.setActive(cell.redPoint, false)
					end
				end

				goutil.setActive(cell.tagOp, true)

				local startTime1, endTime1 = YoungChampionKingController.instance:getStartTimeAndEndTimeByStepId(YoungChampionKingEnum.Qualify_Step_Id)
				local startDate1 = GameUtil.time2date(startTime1)
				local endDate1 = GameUtil.time2date(endTime1)
				local startTime2, endTime2 = YoungChampionKingController.instance:getStartTimeAndEndTimeByStepId(YoungChampionKingEnum.Entertainment_Step_Id)
				local startDate2 = GameUtil.time2date(startTime2)
				local endDate2 = GameUtil.time2date(endTime2)

				cell.txtOpTime.text = string.format("比赛模式：%02d.%02d-%02d.%02d\n娱乐模式：%02d.%02d-%02d.%02d", startDate1.month, startDate1.day, endDate1.month, endDate1.day, startDate2.month, startDate2.day, endDate2.month, endDate2.day)
			end
		end
	elseif id == ID_SCORE_MATCH then
		local enterRoundId = YoungChampionKingController.instance:getRoundIdByStepId(YoungChampionKingEnum.Score_Match_Step_Id)

		goutil.setActive(cell.tagOp, curRoundId == enterRoundId)
		goutil.setActive(cell.tagNotOp, curRoundId < enterRoundId)
		goutil.setActive(cell.tagEnd, enterRoundId < curRoundId)

		if enterRoundId < curRoundId then
			goutil.setActive(cell.tagPass, enterRoundId < playerRoundId)
			goutil.setActive(cell.tagNotPass, playerRoundId == enterRoundId)
		end

		local startTime, endTime = YoungChampionKingController.instance:getStartTimeAndEndTimeByStepId(YoungChampionKingEnum.Score_Match_Step_Id)
		local startDate = GameUtil.time2date(startTime)
		local endDate = GameUtil.time2date(endTime)

		cell.txtOpTime.text = string.format("比赛时间：%02d.%02d-%02d.%02d", startDate.month, startDate.day, endDate.month, endDate.day)

		if curRoundId == enterRoundId and not isKnockout then
			local leftTime = YoungChampionKingController.instance:getCurLeftChanllegeTimes(YoungChampionKingEnum.Score_Match_Step_Id)

			cell.txtTime.text = string.format("今日剩余挑战次数:%s", leftTime)

			goutil.setActive(cell.redPoint, leftTime > 0)
		else
			cell.txtTime.text = ""
		end
	elseif id == ID_WARZONE then
		cell.txtTime.text = ""

		goutil.setActive(cell.tagOp, curRoundId >= YoungChampionKingEnum.War_Zone_Start_Round_Id and curRoundId <= YoungChampionKingEnum.War_Zone_End_Round_Id)
		goutil.setActive(cell.tagNotOp, curRoundId < YoungChampionKingEnum.War_Zone_Start_Round_Id)
		goutil.setActive(cell.tagEnd, curRoundId > YoungChampionKingEnum.War_Zone_End_Round_Id)

		local startDate = GameUtil.time2date(YoungChampionKingController.instance:getStartTimeByStepId(YoungChampionKingEnum.War_Zone_Start_Step_Id))
		local endDate = GameUtil.time2date(YoungChampionKingController.instance:getEndTimeByStepId(YoungChampionKingEnum.War_Zone_End_Step_Id))

		cell.txtOpTime.text = string.format("比赛时间：%02d.%02d-%02d.%02d", startDate.month, startDate.day, endDate.month, endDate.day)

		if curRoundId >= YoungChampionKingEnum.War_Zone_Start_Round_Id then
			goutil.setActive(cell.redPoint, RedPointModel.instance:isActive(RedPointModel.ID_YOUNG_CHAMPION_KING_GAIN_COIN))

			if curRoundId >= YoungChampionKingEnum.Common_Knockout_4To2_Id then
				goutil.setActive(cell.tagNotPass, playerRoundId <= YoungChampionKingEnum.War_Zone_End_Round_Id)
			else
				goutil.setActive(cell.tagNotPass, playerRoundId < curRoundId)
			end
		end

		goutil.setActive(cell.tagPass, playerRoundId > YoungChampionKingEnum.War_Zone_End_Round_Id)
	elseif id == ID_CHAMPION then
		cell.txtTime.text = ""

		goutil.setActive(cell.tagOp, curRoundId >= YoungChampionKingEnum.Champion_Start_Round_Id and curRoundId <= YoungChampionKingEnum.Champion_End_Round_Id)
		goutil.setActive(cell.tagNotOp, curRoundId < YoungChampionKingEnum.Champion_Start_Round_Id)
		goutil.setActive(cell.tagEnd, curRoundId > YoungChampionKingEnum.Champion_End_Round_Id)

		local startDate = GameUtil.time2date(YoungChampionKingController.instance:getStartTimeByStepId(YoungChampionKingEnum.Champion_Start_Step_Id))
		local endDate = GameUtil.time2date(YoungChampionKingController.instance:getEndTimeByStepId(YoungChampionKingEnum.Champion_End_Step_Id))

		cell.txtOpTime.text = string.format("比赛时间：%02d.%02d-%02d.%02d", startDate.month, startDate.day, endDate.month, endDate.day)

		if curRoundId >= YoungChampionKingEnum.War_Zone_Start_Round_Id then
			goutil.setActive(cell.redPoint, RedPointModel.instance:isActive(RedPointModel.ID_YOUNG_CHAMPION_KING_GAIN_COIN))
		end

		if playerRoundId >= YoungChampionKingEnum.Champion_Start_Round_Id and playerRoundId <= YoungChampionKingEnum.Common_Knockout_8To4_Id then
			goutil.setActive(cell.tagNotPass, playerRoundId < curRoundId)
		end
	end
end

function YoungChampionKingMainView:_onStepChange(newStepId)
	YoungChampionKingController.instance:sendPM_YCKGetInfoReq(self._activityId)
end

function YoungChampionKingMainView:_onClickBtnTip()
	local key = self._actCfg.ruleKey

	TipsFacade.instance:openRulesView(key)
end

function YoungChampionKingMainView:_onClickBtnShop()
	local str = self._actCfg.shopGotoStr

	if not GameUtil.isEmptyString(str) then
		GotoMgr.gotoByString(str)
	end
end

function YoungChampionKingMainView:_onClickBtnReward()
	UIStateManager.instance:push(ViewName.YoungChampionKingRewardView)
end

function YoungChampionKingMainView:_onClickBtnTask()
	local cfg = EventTaskSummaryConfig.instance:getPlanCfg(self._activityId)

	if cfg then
		UIStateManager.instance:push(ViewName.CommonGroupTaskMainView, self._activityId)
	else
		printError("运营活动任务为空：" .. self._activityId)
	end
end

function YoungChampionKingMainView:_onClickBattleResult()
	YoungChampionKingController.instance:sendPM_YCKQualifierRecordsReq(self._activityId)
end

function YoungChampionKingMainView:_onClickBtnRank()
	UIStateManager.instance:push(ViewName.YoungchampionkingrankView, self._activityId)
end

function YoungChampionKingMainView:_onClickEnter(id)
	local curStepId = YoungChampionKingModel.instance:getCurStepId()
	local curRoundId = YoungChampionKingController.instance:getRoundIdByStepId(curStepId)
	local isOpEntertainmentStepId = YoungChampionKingController.instance:getIsOpEntertainmentStepId(curStepId)
	local playerRoundId = YoungChampionKingModel.instance:getPlayerRoundId()
	local isKnockout = playerRoundId < curRoundId

	if id == ID_ENTERTAINMENT_AND_PRESELECTION then
		if isOpEntertainmentStepId then
			if isKnockout then
				UIStateManager.instance:push(ViewName.YoungChampionKingQualifyView, self._activityId, YoungChampionKingEnum.Entertainment_Step_Id)
			else
				TipsFacade.instance:openCommonTips("已晋级")
			end
		else
			UIStateManager.instance:push(ViewName.YoungChampionKingQualifyView, self._activityId, YoungChampionKingEnum.Qualify_Step_Id)
		end
	elseif id == ID_SCORE_MATCH then
		local enterRoundId = YoungChampionKingController.instance:getRoundIdByStepId(YoungChampionKingEnum.Score_Match_Step_Id)

		if curRoundId == enterRoundId then
			if isKnockout then
				TipsFacade.instance:openCommonTips("未晋级")

				return
			end

			UIStateManager.instance:push(ViewName.YoungChampionKingQualifyView, self._activityId, YoungChampionKingEnum.Score_Match_Step_Id)
		elseif curRoundId < enterRoundId then
			TipsFacade.instance:openCommonTips("该阶段未开始")
		elseif enterRoundId < curRoundId then
			TipsFacade.instance:openCommonTips("该阶段已结束")
		end
	elseif id == ID_WARZONE then
		if curRoundId >= YoungChampionKingEnum.War_Zone_Start_Round_Id and curRoundId <= YoungChampionKingEnum.War_Zone_End_Round_Id then
			UIStateManager.instance:push(ViewName.YoungChampionKingKnockoutMainView, self._activityId, YoungChampionKingEnum.War_Zone_Start_Round_Id)
		elseif curRoundId < YoungChampionKingEnum.War_Zone_Start_Round_Id then
			TipsFacade.instance:openCommonTips("该阶段未开始")
		else
			UIStateManager.instance:push(ViewName.YoungChampionKingKnockoutMainView, self._activityId, YoungChampionKingEnum.War_Zone_Start_Round_Id)
		end
	elseif id == ID_CHAMPION then
		if curRoundId >= YoungChampionKingEnum.Champion_Start_Round_Id and curRoundId <= YoungChampionKingEnum.Champion_End_Round_Id then
			UIStateManager.instance:push(ViewName.YoungChampionKingKnockoutMainView, self._activityId, YoungChampionKingEnum.Champion_Start_Round_Id)
		elseif curRoundId < YoungChampionKingEnum.Champion_Start_Round_Id then
			TipsFacade.instance:openCommonTips("该阶段未开始")
		else
			UIStateManager.instance:push(ViewName.YoungChampionKingKnockoutMainView, self._activityId, YoungChampionKingEnum.Champion_Start_Round_Id)
		end
	end
end

function YoungChampionKingMainView:_onClickFameHall()
	GotoMgr.gotoByString("func#1137#1")
end

function YoungChampionKingMainView:_handleGetBattleResult()
	local records = YoungChampionKingModel.instance:getCurMyBattleRecords()
	local dataList = {}

	for i, record in ipairs(records) do
		local data = {}

		data.leftHeadInfo = nil
		data.leftZdl = record.myZdl
		data.rightHeadInfo = record.opHeadInfo
		data.rightZdl = record.enemyZdl
		data.stepId = record.stepId
		data.showTxt = YoungChampionKingController.instance:getCurRoundNameByStepId(data.stepId)
		data.incScore = (data.stepId == YoungChampionKingEnum.Qualify_Step_Id or data.stepId == YoungChampionKingEnum.Score_Match_Step_Id) and record.incScore or 0
		data.roundId = YoungChampionKingController.instance:getRoundIdByStepId(record.stepId)
		data.isLeftWin = record.isChallengerWin
		data.battleId = record.battleId

		table.insert(dataList, data)
	end

	UIStateManager.instance:push(ViewName.YoungChampionKingBattleResultView, dataList)
end

return YoungChampionKingMainView
