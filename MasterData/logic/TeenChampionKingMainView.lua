-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/teenchampionking/view/TeenChampionKingMainView.lua

module("logic.extensions.teenchampionking.view.TeenChampionKingMainView", package.seeall)

local TeenChampionKingMainView = class("TeenChampionKingMainView", ViewComponent)

function TeenChampionKingMainView:ctor()
	TeenChampionKingMainView.super.ctor(self)
end

function TeenChampionKingMainView:unbindEvents()
	TeenChampionKingMainView.super.unbindEvents(self)
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

function TeenChampionKingMainView:bindEvents()
	TeenChampionKingMainView.super.bindEvents(self)
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

function TeenChampionKingMainView:buildUI()
	TeenChampionKingMainView.super.buildUI(self)

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

	for i = 1, 5 do
		local cell = {}

		cell.id = i
		cell.go = self:getGo("enterList/enterCell" .. i)
		cell.bg = goutil.findChild(cell.go, "bg")
		cell.txtTitle = goutil.findChildTextComponent(cell.go, "txtTitle")
		cell.txtOpTime = goutil.findChildTextComponent(cell.go, "txtOpTime")
		cell.txtMatchTime = goutil.findChildTextComponent(cell.go, "txtMatchTime")
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

function TeenChampionKingMainView:onExit()
	TeenChampionKingMainView.super.onExit(self)

	for i, cell in ipairs(self._enterList) do
		RedPointController.instance:unregRedPoint(cell.redPoint)
	end
end

function TeenChampionKingMainView:onEnter()
	TeenChampionKingMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_TCKGetInfoRes, self._updateUIByInfo, self)
	self.addGEvent(self, GlobalNotify.PM_TCKStepChange, self._onStepChange, self)
	self.addGEvent(self, GlobalNotify.PM_TCKGetQualifierInfo, self._updateUIByQualifierInfo, self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId <= 0 then
		self._activityId = 501001
	end

	self:_updateUIByCfg()

	self._curStepId = 0
	self._playerRoundId = 0
	self._curRoundId = 0

	TeenChampionKingController.instance:getGlobalInfo(self._activityId)
end

function TeenChampionKingMainView:_updateUIByCfg()
	self._actCfg = TeenChampionKingConfig.instance:getActCfg(self._activityId)
	self._hudCfgs = TeenChampionKingConfig.instance:getHudCfgs(self._activityId)
	self._openTimeStr = TeenChampionKingConfig.instance:getCommonValue("MATCH_OPEN_TIME")

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

	for i, cell in ipairs(self._enterList) do
		local cfg = self._hudCfgs[i]

		if cfg then
			cell.txtOpTime.text = cfg.dateDesc
			cell.txtTitle.text = cfg.title
			cell.txtTime.text = ""

			if cell.txtMatchTime then
				cell.txtMatchTime.text = string.format("匹配时间：%s", self._openTimeStr)
			end
		end
	end
end

function TeenChampionKingMainView:_updateUIByInfo()
	local info = TeenChampionKingModel.instance:getGlobalInfo(self._activityId)

	if info then
		self._curStepId = info.curStepId
		self._playerRoundId = info.playerRoundId
		self._curRoundId = TeenChampionKingConfig.instance:getRoundIdByStepId(self._activityId, self._curStepId)
		self._isKnockout = self._curRoundId > self._playerRoundId

		for i, cell in ipairs(self._enterList) do
			local cfg = self._hudCfgs[i]

			if cfg then
				local startStepId = cfg.startStepId
				local endStepId = cfg.endStepId
				local startRoundId = TeenChampionKingConfig.instance:getRoundIdByStepId(self._activityId, startStepId)
				local endRoundId = TeenChampionKingConfig.instance:getRoundIdByStepId(self._activityId, endStepId)

				goutil.setActive(cell.redPoint, false)
				RedPointController.instance:unregRedPoint(cell.redPoint)

				cell.txtTime.text = ""

				goutil.setActive(cell.tagOp, startStepId <= self._curStepId and endStepId >= self._curStepId)
				goutil.setActive(cell.tagNotOp, startStepId > self._curStepId)
				goutil.setActive(cell.tagEnd, endStepId < self._curStepId)
				goutil.setActive(cell.tagPass, false)
				goutil.setActive(cell.tagNotPass, false)

				if startStepId > self._curStepId then
					goutil.setActive(cell.tagPass, false)
					goutil.setActive(cell.tagNotPass, false)
				elseif startStepId <= self._curStepId then
					goutil.setActive(cell.tagPass, endRoundId < self._playerRoundId)

					if self._isKnockout and endRoundId >= self._playerRoundId and startRoundId <= self._playerRoundId then
						goutil.setActive(cell.tagNotPass, true)
					end

					if startRoundId >= TeenChampionKingController.ROUND_KNOCKOUT_MIN then
						RedPointController.instance:regRedPoint(cell.redPoint, RedPointModel.ID_TEEN_CHAMPION_KING_GUESS_ITEM)
					end
				end

				if i == 5 then
					goutil.setActive(cell.tagPass, false)
					goutil.setActive(cell.tagNotPass, false)
				end
			end
		end

		goutil.setActive(self._enterList[1].go, not self._isKnockout)
		goutil.setActive(self._enterList[5].go, self._isKnockout)

		if not self._isKnockout then
			if self._curStepId == 1 or self._curRoundId == 2 then
				TeenChampionKingController.instance:getQualifierInfo(self._activityId, self._curStepId)
			end
		else
			TeenChampionKingController.instance:getQualifierInfo(self._activityId, TeenChampionKingController.EntertainmentStepId)
		end
	end
end

function TeenChampionKingMainView:_updateUIByQualifierInfo()
	if self._isKnockout then
		self:_updateQualifierInfo(TeenChampionKingController.EntertainmentStepId)
	elseif self._curStepId == 1 then
		self:_updateQualifierInfo(1)
	elseif self._curStepId == 2 then
		self:_updateQualifierInfo(2)
	end
end

function TeenChampionKingMainView:_updateQualifierInfo(stepId)
	local info = TeenChampionKingModel.instance:getQualifierInfo(self._activityId, stepId)

	if info then
		local timeLimit = self._actCfg.dailyFightTimes
		local time = checknumber(timeLimit) - checknumber(info.dailyPrizeTimes)
		local cell = self._enterList[stepId]

		if stepId == TeenChampionKingController.EntertainmentStepId then
			cell = self._enterList[5]
		end

		if cell then
			cell.txtTime.text = string.format("今日剩余奖励次数：%s", time)

			goutil.setActive(cell.redPoint, time > 0)
		end
	end
end

function TeenChampionKingMainView:_onStepChange()
	TeenChampionKingController.instance:getGlobalInfo(self._activityId)
end

function TeenChampionKingMainView:_onClickBtnTip()
	local key = self._actCfg.ruleKey

	TipsFacade.instance:openRulesView(key)
end

function TeenChampionKingMainView:_onClickBtnShop()
	local str = self._actCfg.shopGotoStr

	if not GameUtil.isEmptyString(str) then
		GotoMgr.gotoByString(str)
	end
end

function TeenChampionKingMainView:_onClickBtnReward()
	UIStateManager.instance:push(ViewName.TeenChampionKingRewardView, self._activityId)
end

function TeenChampionKingMainView:_onClickBtnTask()
	local cfg = EventTaskSummaryConfig.instance:getPlanCfg(self._activityId)

	if cfg then
		UIStateManager.instance:push(ViewName.CommonGroupTaskMainView, self._activityId)
	else
		printError("运营活动任务为空：" .. self._activityId)
	end
end

function TeenChampionKingMainView:_onClickBtnRank()
	UIStateManager.instance:push(ViewName.TCKRankMainView)
end

function TeenChampionKingMainView:_onClickBattleResult()
	UIStateManager.instance:push(ViewName.TeenChampionKingBattleResultView, self._activityId)
end

function TeenChampionKingMainView:_onClickFameHall()
	GotoMgr.gotoByString("func#1137#1")
end

function TeenChampionKingMainView:_onClickEnter(id)
	local cfg = self._hudCfgs[id]

	if cfg then
		local startStepId = cfg.startStepId
		local endStepId = cfg.endStepId

		if startStepId <= self._curStepId and endStepId >= self._curStepId then
			if id == 1 or id == 2 then
				if self._isKnockout then
					TipsFacade.instance:openCommonTips("未晋级")
				else
					UIStateManager.instance:push(ViewName.TCKQualifyView, self._activityId, id)
				end
			elseif id == 5 then
				if self._isKnockout then
					UIStateManager.instance:push(ViewName.TCKQualifyView, self._activityId, TeenChampionKingController.EntertainmentStepId)
				else
					TipsFacade.instance:openCommonTips("已晋级")
				end
			elseif id == 3 then
				UIStateManager.instance:push(ViewName.TCKKnockoutMainView, self._activityId)
			elseif id == 4 then
				UIStateManager.instance:push(ViewName.TCKChampionshipView, self._activityId)
			end
		elseif startStepId > self._curStepId then
			TipsFacade.instance:openCommonTips("该阶段未开始")
		elseif startStepId < self._curStepId then
			if id == 2 then
				TipsFacade.instance:openCommonTips("该阶段已结束")
			elseif id == 3 then
				UIStateManager.instance:push(ViewName.TCKKnockoutMainView, self._activityId)
			elseif id == 4 then
				UIStateManager.instance:push(ViewName.TCKChampionshipView, self._activityId)
			end
		end
	end
end

return TeenChampionKingMainView
