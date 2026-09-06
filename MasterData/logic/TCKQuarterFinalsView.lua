-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/teenchampionking/view/TCKQuarterFinalsView.lua

module("logic.extensions.teenchampionking.view.TCKQuarterFinalsView", package.seeall)

local TCKQuarterFinalsView = class("TCKQuarterFinalsView", ViewComponent)

function TCKQuarterFinalsView:ctor()
	TCKQuarterFinalsView.super.ctor(self)
end

function TCKQuarterFinalsView:unbindEvents()
	TCKQuarterFinalsView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnVoteRecord)
	GameUtil.rmClickHandler(self._btnGainCoin)
end

function TCKQuarterFinalsView:bindEvents()
	TCKQuarterFinalsView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnVoteRecord, self._onClickVoteRecord, self)
	GameUtil.addClickHandler(self._btnGainCoin, self._onClickGainCoin, self)
end

function TCKQuarterFinalsView:buildUI()
	TCKQuarterFinalsView.super.buildUI(self)

	self._btnVoteRecord = self:getGo("btnCol/btnVoteRecord")
	self._btnGainCoin = self:getGo("btnCol/btnGainCoin")
	self._txtTitle = self:getTxt("title/txt")
	self._txtTime = self:getTxt("txtTime")
	self._cellGo = self:getGo("tableview/tablecell")
	self._tableviewGo = self:getGo("tableview")
	self._tableview = ScrollerList.create(self._tableviewGo, self._cellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._redPoint = self:getGo("btnCol/btnGainCoin/redPoint")
end

function TCKQuarterFinalsView:onExit()
	TCKQuarterFinalsView.super.onExit(self)
	removetimer(self._updateTimer, self)
	RedPointController.instance:unregRedPoint(self._redPoint)
end

function TCKQuarterFinalsView:onEnter()
	TCKQuarterFinalsView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_TCKStepChange, self._onStepChange, self)
	self.addGEvent(self, GlobalNotify.PM_TCKKnockoutSchedule, self._handleGetInfo, self)
	self.addGEvent(self, GlobalNotify.PM_TCKGuessKnockout, self._handleGuess, self)

	local params = self:getOpenParam()

	self._activityId = params and checknumber(params[1]) or 501001
	self._enterRoundId = params and checknumber(params[2]) or TeenChampionKingController.ROUND_QUARTERFINALS

	self:_updateUIByCfg()
	self:_updateTimeTxt()
	TeenChampionKingController.instance:getKnockoutSchedule(self._activityId, 1, self._enterRoundId)
	RedPointController.instance:regRedPoint(self._redPoint, RedPointModel.ID_TEEN_CHAMPION_KING_GUESS_ITEM)
end

function TCKQuarterFinalsView:_updateUIByCfg()
	return
end

function TCKQuarterFinalsView:_updateTimeTxt()
	self._startRoundId = TeenChampionKingController.ROUND_QUARTERFINALS
	self._endRoundId = TeenChampionKingController.ROUND_QUARTERFINALS

	local curStepId = 0
	local info = TeenChampionKingModel.instance:getGlobalInfo(self._activityId)

	if info then
		curStepId = info.curStepId
	end

	self._curStepCfg = TeenChampionKingConfig.instance:getStepCfgByStepId(self._activityId, curStepId)

	local nextStepCfg = TeenChampionKingConfig.instance:getStepCfgByStepId(self._activityId, curStepId + 1)
	local curRoundId = TeenChampionKingConfig.instance:getRoundIdByStepId(self._activityId, curStepId)

	self._txtTime.text = ""

	if curRoundId < self._startRoundId then
		self._txtTime.text = ""
	elseif curRoundId > self._endRoundId then
		local roundCfg = TeenChampionKingConfig.instance:getRoundCfgByRoundId(self._activityId, self._endRoundId)

		self._txtTitle.text = roundCfg.roundName
		self._txtTime.text = "本轮比赛已结束"
	else
		self._nextStageTime = GameUtil.string2time(nextStepCfg.startTime)

		local roundCfg = TeenChampionKingConfig.instance:getRoundCfgByRoundId(self._activityId, curRoundId)

		self._txtTitle.text = roundCfg.roundName
		self._txtTime.text = ""

		settimer(1, self._updateTimer, self, true)
	end
end

function TCKQuarterFinalsView:_updateTimer()
	local timer = self._nextStageTime - ServerTime.now()

	if timer <= 0 then
		removetimer(self._updateTimer, self)
		self:_updateTimeTxt()
	end

	local timeStr = GameUtil.FormatTimeSymbol(timer)

	self._txtTime.text = (not self._curStepCfg.needKnockoutRoom and "距离战斗开始剩余：" or "距离战斗结束剩余：") .. timeStr
end

function TCKQuarterFinalsView:_onClickVoteRecord()
	UIStateManager.instance:push(ViewName.TCKGuessRecordView, self._activityId)
end

function TCKQuarterFinalsView:_onClickGainCoin()
	UIStateManager.instance:push(ViewName.TeenChampionKingGainCoinView, self._activityId)
end

function TCKQuarterFinalsView:_onStepChange(newStepId)
	TeenChampionKingController.instance:getKnockoutSchedule(self._activityId, 1, self._enterRoundId)
end

function TCKQuarterFinalsView:_handleGetInfo(viewGroupId)
	self._curStepId = 0
	self._curRoundId = 0

	local globalinfo = TeenChampionKingModel.instance:getGlobalInfo(self._activityId)

	if globalinfo then
		self._curStepId = globalinfo.curStepId
	end

	self._curRoundId = TeenChampionKingConfig.instance:getRoundIdByStepId(self._activityId, self._curStepId)

	local info = TeenChampionKingModel.instance:getKnockoutScheduleInfo(self._activityId, 1, self._enterRoundId)

	self._tableview:reloadData((info or nil) and (info.groupList or {}))
end

function TCKQuarterFinalsView:_handleGuess()
	TeenChampionKingController.instance:getKnockoutSchedule(self._activityId, 1, self._enterRoundId)
end

function TCKQuarterFinalsView:_updateCell(view, cell, data)
	local txtTitle = goutil.findChildTextComponent(cell.gameObject, "txtTitle")

	txtTitle.text = string.format("第  %s  组", data.index)

	local fight = goutil.findChild(cell.gameObject, "fight")

	goutil.setActive(fight, false)

	if self._curRoundId == self._enterRoundId and self._curStepCfg.needKnockoutRoom then
		goutil.setActive(fight, true)
	end

	local btnRecord = goutil.findChild(cell.gameObject, "btnRecord")
	local btnVote = goutil.findChild(cell.gameObject, "btnVote")

	goutil.setActive(btnRecord, false)
	goutil.setActive(btnVote, false)

	local winerId, loserId
	local reports = data.reports
	local isCanVote = self._curRoundId == data.roundId

	if reports then
		goutil.setActive(btnRecord, true)
		GameUtil.addClickHandler(btnRecord, GameUtil.handler(self._onClickBtnRecord, self, data))

		if checknumber(reports.winPlayerId) == checknumber(data.playerA.headInfo.headInfo.userId) then
			winerId = checknumber(data.playerA.headInfo.headInfo.userId)
			loserId = checknumber(data.playerB.headInfo.headInfo.userId)
		else
			winerId = checknumber(data.playerB.headInfo.headInfo.userId)
			loserId = checknumber(data.playerA.headInfo.headInfo.userId)
		end

		isCanVote = false
	end

	GameUtil.addClickHandler(btnVote, GameUtil.handler(self._onClickBtnVote, self, data))

	if isCanVote then
		goutil.setActive(btnVote, true)
	end

	local seatCellA = goutil.findChild(cell.gameObject, "seatCellA")
	local playerA = goutil.findChild(seatCellA, "player")
	local headA = goutil.findChild(playerA, "head")
	local txtNamePlayerA = goutil.findChildTextComponent(playerA, "name/txt")
	local txtRankA = goutil.findChildTextComponent(playerA, "rank/txt")
	local tagsA = goutil.findChild(seatCellA, "tags")
	local tagFailA = goutil.findChild(tagsA, "fail")
	local tagWinA = goutil.findChild(tagsA, "win")
	local tagMyA = goutil.findChild(tagsA, "my")
	local tagEmptyA = goutil.findChild(tagsA, "empty")
	local tagMySupportA = goutil.findChild(tagsA, "mySupport")
	local childCntA = tagsA.transform.childCount - 1

	for i = 0, childCntA do
		local child = tagsA.transform:GetChild(i)

		goutil.setActive(child.gameObject, false)
	end

	HeadItemController.instance:setHeadCellByInfo(headA, data.playerA.headInfo.headInfo, true)

	txtNamePlayerA.text = data.playerA.headInfo.headInfo.userName
	txtRankA.text = string.format("战区%s-第%s名", data.playerA.headInfo.zoneId, data.playerA.headInfo.zoneRank)

	local isMyA = checknumber(data.playerA.headInfo.headInfo.userId) == checknumber(RoleModel.instance:getUserId())

	goutil.setActive(tagMyA, isMyA)
	goutil.setActive(tagWinA, winerId == checknumber(data.playerA.headInfo.headInfo.userId))
	goutil.setActive(tagFailA, loserId == checknumber(data.playerA.headInfo.headInfo.userId))

	local isMySupport = checknumber(data.playerA.headInfo.headInfo.userId) == checknumber(data.guessPlayerId)

	goutil.setActive(tagMySupportA, isMySupport)

	local seatCellB = goutil.findChild(cell.gameObject, "seatCellB")
	local playerB = goutil.findChild(seatCellB, "player")
	local headB = goutil.findChild(playerB, "head")
	local txtNamePlayerB = goutil.findChildTextComponent(playerB, "name/txt")
	local txtRankB = goutil.findChildTextComponent(playerB, "rank/txt")
	local tagsB = goutil.findChild(seatCellB, "tags")
	local tagFailB = goutil.findChild(tagsB, "fail")
	local tagWinB = goutil.findChild(tagsB, "win")
	local tagMyB = goutil.findChild(tagsB, "my")
	local tagEmptyB = goutil.findChild(tagsB, "empty")
	local tagMySupportB = goutil.findChild(tagsB, "mySupport")
	local childCntB = tagsB.transform.childCount - 1

	for i = 0, childCntB do
		local child = tagsB.transform:GetChild(i)

		goutil.setActive(child.gameObject, false)
	end

	HeadItemController.instance:setHeadCellByInfo(headB, data.playerB.headInfo.headInfo, true)

	txtNamePlayerB.text = data.playerB.headInfo.headInfo.userName
	txtRankB.text = string.format("战区%s-第%s名", data.playerB.headInfo.zoneId, data.playerB.headInfo.zoneRank)

	local isMyB = checknumber(data.playerB.headInfo.headInfo.userId) == checknumber(RoleModel.instance:getUserId())

	goutil.setActive(tagMyB, isMyB)
	goutil.setActive(tagWinB, winerId == checknumber(data.playerB.headInfo.headInfo.userId))
	goutil.setActive(tagFailB, loserId == checknumber(data.playerB.headInfo.headInfo.userId))

	isMySupport = checknumber(data.playerB.headInfo.headInfo.userId) == checknumber(data.guessPlayerId)

	goutil.setActive(tagMySupportB, isMySupport)
end

function TCKQuarterFinalsView:_clearCell(cell)
	local seatCellA = goutil.findChild(cell.gameObject, "seatCellA")
	local playerA = goutil.findChild(seatCellA, "player")
	local headA = goutil.findChild(playerA, "head")
	local seatCellB = goutil.findChild(cell.gameObject, "seatCellB")
	local playerB = goutil.findChild(seatCellB, "player")
	local headB = goutil.findChild(playerB, "head")
	local btnRecord = goutil.findChild(cell.gameObject, "btnRecord")
	local btnVote = goutil.findChild(cell.gameObject, "btnVote")

	GameUtil.rmClickHandler(btnRecord)
	GameUtil.rmClickHandler(btnVote)
	HeadItemController.instance:resetHeadCell(headA)
	HeadItemController.instance:resetHeadCell(headB)
end

function TCKQuarterFinalsView:_onClickBtnRecord(info)
	local reports = info.reports

	if not reports then
		TipsFacade.instance:openCommonTips("未出结果")

		return
	end

	local dataList = {}
	local data = {}

	data.leftHeadInfo = info.playerA.headInfo.headInfo
	data.leftZdl = reports.playerAZdl
	data.rightHeadInfo = info.playerB.headInfo.headInfo
	data.rightZdl = reports.playerBZdl
	data.showTxt = TeenChampionKingController.instance:getRoundNameByStepId(self._activityId, reports.stepId)
	data.isLeftWin = checknumber(reports.winPlayerId) == checknumber(data.leftHeadInfo.userId)
	data.battleId = reports.battleId

	table.insert(dataList, data)
	UIStateManager.instance:push(ViewName.TCKBattleResultView, dataList)
end

function TCKQuarterFinalsView:_onClickBtnVote(info)
	UIStateManager.instance:push(ViewName.TCKGuessView, self._activityId, self._enterRoundId, 1, info)
end

return TCKQuarterFinalsView
