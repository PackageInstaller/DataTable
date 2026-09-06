-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/teenchampionking/view/TCKKnockout8PlayerView.lua

module("logic.extensions.teenchampionking.view.TCKKnockout8PlayerView", package.seeall)

local TCKKnockout8PlayerView = class("TCKKnockout8PlayerView", ViewComponent)

function TCKKnockout8PlayerView:ctor()
	TCKKnockout8PlayerView.super.ctor(self)
end

function TCKKnockout8PlayerView:unbindEvents()
	TCKKnockout8PlayerView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnVoteRecord)
	GameUtil.rmClickHandler(self._btnGainCoin)
	GameUtil.rmClickHandler(self._btnSwtich)

	for _, cell in ipairs(self._matchCellList) do
		GameUtil.rmClickHandler(cell.btnCell.btnVote)
		GameUtil.rmClickHandler(cell.btnCell.btnRecord)
	end
end

function TCKKnockout8PlayerView:bindEvents()
	TCKKnockout8PlayerView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnVoteRecord, self._onClickVoteRecord, self)
	GameUtil.addClickHandler(self._btnGainCoin, self._onClickGainCoin, self)
	GameUtil.addClickHandler(self._btnSwtich, self._onClickBtnSwtich, self)

	for _, cell in ipairs(self._matchCellList) do
		GameUtil.addClickHandler(cell.btnCell.btnVote, GameUtil.handler(self._onClickBtnVote, self, cell))
		GameUtil.addClickHandler(cell.btnCell.btnRecord, GameUtil.handler(self._onClickBtnRecord, self, cell))
	end
end

function TCKKnockout8PlayerView:buildUI()
	TCKKnockout8PlayerView.super.buildUI(self)

	self._btnVoteRecord = self:getGo("btnCol/btnVoteRecord")
	self._btnGainCoin = self:getGo("btnCol/btnGainCoin")
	self._redPointBtnGainCoin = self:getGo("btnCol/btnGainCoin/redPoint")
	self._btnSwtich = self:getGo("colGroup/btnSwtich")
	self._txtBtnSwtich = self:getTxt("colGroup/btnSwtich/txt")
	self._cellGoGroup = self:getGo("colGroup/cell")
	self._tableviewGoGroup = self:getGo("colGroup/tableview")
	self._tableviewGroup = ScrollerList.create(self._tableviewGoGroup, self._cellGoGroup, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._seatCell = self:getGo("seatCell")
	self._btnCell = self:getGo("btnCell")
	self._txtTitle = self:getTxt("title/txt")
	self._txtTime = self:getTxt("txtTime")
	self._matchCellMap = {}
	self._matchCellList = {}
	self._totalRoundNum = 3

	for roundId = 1, self._totalRoundNum do
		local temNum = self._totalRoundNum - roundId
		local matchNum = 1

		for k = 1, temNum do
			matchNum = matchNum * 2
		end

		for matchId = 1, matchNum do
			local matchCell = self:buildMatchCell(roundId, matchId)

			matchCell.matchTotalNum = matchNum
			matchCell.isLastMatch = matchNum == 1
			self._matchCellMap[roundId] = self._matchCellMap[roundId] or {}
			self._matchCellMap[roundId][matchId] = matchCell

			table.insert(self._matchCellList, matchCell)
		end
	end

	goutil.setActive(self._seatCell, false)
	goutil.setActive(self._btnCell, false)

	self._playerCellEnd = self:getPlayerCell(self:getGo("colMatch/endPos"))
end

function TCKKnockout8PlayerView:buildMatchCell(roundId, matchId)
	local cell = {}

	cell.go = self:getGo(string.format("colMatch/match_cell_%s_%s", roundId, matchId))
	cell.lineGo = self:getGo(string.format("colLine/match_cell_%s_%s", roundId, matchId))

	if not cell.go then
		printError(string.format("检查空节点_%s_%s", roundId, matchId))
	end

	cell.lineA = goutil.findChild(cell.lineGo, "lineA")
	cell.lineB = goutil.findChild(cell.lineGo, "lineB")
	cell.playerPosA = goutil.findChild(cell.go, "playerPosA")
	cell.playerPosB = goutil.findChild(cell.go, "playerPosB")
	cell.btnPos = goutil.findChild(cell.go, "btnPos")
	cell.btnCell = self:getBtnCell(cell.btnPos)
	cell.playerCellA = self:getPlayerCell(cell.playerPosA)
	cell.playerCellB = self:getPlayerCell(cell.playerPosB)
	cell.roundId = roundId
	cell.matchId = matchId
	cell.isLastMatch = false
	cell.info = nil

	return cell
end

function TCKKnockout8PlayerView:getPlayerCell(pos)
	local cell = {}

	cell.go = goutil.findChild(pos, "seatCell") or goutil.cloneAndSetParent(self._seatCell, pos.transform, "seatCell")

	GameUtil.setAnchoredPos(cell.go, 0, 0)
	goutil.setActive(cell.go, true)

	cell.player = goutil.findChild(cell.go, "player")
	cell.head = goutil.findChild(cell.player, "head")
	cell.txtNamePlayer = goutil.findChildTextComponent(cell.player, "name/txt")
	cell.txtRank = goutil.findChildTextComponent(cell.player, "rank/txt")
	cell.tags = goutil.findChild(cell.go, "tags")
	cell.tagFail = goutil.findChild(cell.tags, "fail")
	cell.tagChampionship = goutil.findChild(cell.tags, "championship")
	cell.tagThirdPlaceMatch = goutil.findChild(cell.tags, "thirdPlaceMatch")
	cell.tagWin = goutil.findChild(cell.tags, "win")
	cell.tagMy = goutil.findChild(cell.tags, "my")
	cell.tagEmpty = goutil.findChild(cell.tags, "empty")
	cell.tagMySupport = goutil.findChild(cell.tags, "mySupport")
	cell.tagWinLast = goutil.findChild(cell.go, "winLast")

	return cell
end

function TCKKnockout8PlayerView:getBtnCell(pos)
	local cell = {}

	cell.go = goutil.findChild(pos, "btnCell") or goutil.cloneAndSetParent(self._btnCell, pos.transform, "btnCell")

	GameUtil.setAnchoredPos(cell.go, 0, 0)
	goutil.setActive(cell.go, true)

	cell.btnVote = goutil.findChild(cell.go, "btnVote")
	cell.btnRecord = goutil.findChild(cell.go, "btnRecord")

	return cell
end

function TCKKnockout8PlayerView:onExit()
	TCKKnockout8PlayerView.super.onExit(self)
	self._tableviewGroup:dispose()

	for _, cell in ipairs(self._matchCellList) do
		HeadItemController.instance:resetHeadCell(cell.playerCellA.head)
		HeadItemController.instance:resetHeadCell(cell.playerCellB.head)
	end

	removetimer(self._updateTimer, self)
	RedPointController.instance:unregRedPoint(self._redPointBtnGainCoin)
end

function TCKKnockout8PlayerView:onEnter()
	TCKKnockout8PlayerView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_TCKStepChange, self._onStepChange, self)
	self.addGEvent(self, GlobalNotify.PM_TCKKnockoutSchedule, self._handleGetInfo, self)
	self.addGEvent(self, GlobalNotify.PM_TCKGuessKnockout, self._handleGuess, self)
	self.addGEvent(self, GlobalNotify.PM_TCKGetMyKnockoutInfo, self._handleGetRoomInfo, self)

	local params = self:getOpenParam()

	self._activityId = params and checknumber(params[1]) or 501001
	self._enterRoundId = params and checknumber(params[2]) or TeenChampionKingController.ROUND_KNOCKOUT_MIN

	self:_updateUIByCfg()
	self:_onSwitchGroup(1)
	self:_updateTimeTxt()
	TeenChampionKingController.instance:getMyKnockoutInfo(self._activityId)
	RedPointController.instance:regRedPoint(self._redPointBtnGainCoin, RedPointModel.ID_TEEN_CHAMPION_KING_GUESS_ITEM)
end

function TCKKnockout8PlayerView:_updateUIByCfg()
	self._totalGroupNum = 16
	self._curGroupIdList = {}

	for i = 1, self._totalGroupNum do
		table.insert(self._curGroupIdList, i)
	end
end

function TCKKnockout8PlayerView:_updateTimeTxt()
	self._startRoundId = TeenChampionKingController.ROUND_KNOCKOUT_MIN
	self._endRoundId = TeenChampionKingController.ROUND_KNOCKOUT_MAX

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

function TCKKnockout8PlayerView:_updateTimer()
	local timer = self._nextStageTime - ServerTime.now()

	if timer <= 0 then
		removetimer(self._updateTimer, self)
		self:_updateTimeTxt()
	end

	local timeStr = GameUtil.FormatTimeSymbol(timer)

	self._txtTime.text = (self._curStepCfg.canGuss and "距离战斗开始剩余：" or "距离战斗结束剩余：") .. timeStr
end

function TCKKnockout8PlayerView:_handleGetRoomInfo()
	self._groupId = 1
	self._myGroupId = -1

	local info = TeenChampionKingModel.instance:getMyKnockoutInfo(self._activityId)
	local myKnockoutInfo = info.knockoutInfo

	if myKnockoutInfo then
		local matchId = myKnockoutInfo.groupId
		local matchRoundId = myKnockoutInfo.roundId

		if matchRoundId == TeenChampionKingController.ROUND_KNOCKOUT_MIN then
			self._groupId = math.ceil(matchId / 4)
		elseif matchRoundId == 4 then
			self._groupId = math.ceil(matchId / 2)
		elseif matchRoundId == TeenChampionKingController.ROUND_KNOCKOUT_MAX then
			self._groupId = matchId
		end

		self._myGroupId = self._groupId
	end

	self:_onSwitchGroup(self._groupId)
end

function TCKKnockout8PlayerView:_onSwitchGroup(groupId)
	TeenChampionKingController.instance:getKnockoutSchedule(self._activityId, groupId, self._enterRoundId)
end

function TCKKnockout8PlayerView:_updateCell(view, cell, data)
	GameUtil.addClickHandler(cell.gameObject, GameUtil.handler(self._onSwitchGroup, self, data))

	local txtName = goutil.findChildTextComponent(cell.gameObject, "txtName")

	txtName.text = string.format("第%s组", GameUtil.getChineseNumber(data))

	local changeGroup = cell.gameObject:GetComponent(ComponentType.UIChangeGroup)

	changeGroup:SetState(self._curGroupId == data and 1 or 0)

	local mark = goutil.findChild(cell.gameObject, "mark")

	goutil.setActive(mark, self._myGroupId == data)
end

function TCKKnockout8PlayerView:_clearCell(cell)
	GameUtil.rmClickHandler(cell.gameObject)
end

function TCKKnockout8PlayerView:_onClickVoteRecord()
	UIStateManager.instance:push(ViewName.TCKGuessRecordView, self._activityId)
end

function TCKKnockout8PlayerView:_onClickGainCoin()
	UIStateManager.instance:push(ViewName.TeenChampionKingGainCoinView, self._activityId)
end

function TCKKnockout8PlayerView:_onClickBtnSwtich()
	local isShow = GameUtil.GetActive(self._tableviewGoGroup)

	goutil.setActive(self._tableviewGoGroup, not isShow)

	if not isShow then
		self._tableviewGroup:reloadData(self._curGroupIdList)
	end
end

function TCKKnockout8PlayerView:_onClickBtnVote(cell)
	UIStateManager.instance:push(ViewName.TCKGuessView, self._activityId, self._enterRoundId, self._curGroupId, cell.info)
end

function TCKKnockout8PlayerView:_onClickBtnRecord(cell)
	local info = cell and cell.info
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

function TCKKnockout8PlayerView:_onStepChange(newStepId)
	self:_onSwitchGroup(self._curGroupId)
end

function TCKKnockout8PlayerView:_handleGetInfo(viewGroupId)
	self._curGroupId = viewGroupId

	goutil.setActive(self._tableviewGoGroup, false)

	self._txtBtnSwtich.text = string.format("第%s组", GameUtil.getChineseNumber(self._curGroupId))

	self:_updateGroupMatch()
end

function TCKKnockout8PlayerView:_handleGuess()
	self:_onSwitchGroup(self._curGroupId)
end

function TCKKnockout8PlayerView:_updateGroupMatch()
	self._curStepId = 0
	self._curRoundId = 0

	local info = TeenChampionKingModel.instance:getGlobalInfo(self._activityId)

	if info then
		self._curStepId = info.curStepId
	end

	self._curRoundId = TeenChampionKingConfig.instance:getRoundIdByStepId(self._activityId, self._curStepId)
	self._curStepCfg = TeenChampionKingConfig.instance:getStepCfgByStepId(self._activityId, self._curStepId)

	self:_setPlayerInfo(self._playerCellEnd)
	goutil.setActive(self._playerCellEnd.tagEmpty, false)
	goutil.setActive(self._playerCellEnd.tagWinLast, true)

	for i, cell in ipairs(self._matchCellList) do
		local trueRoundId = cell.roundId + self._enterRoundId - 1
		local tureMatchId = cell.matchTotalNum * (self._curGroupId - 1) + cell.matchId
		local matchInfo = self:_getKnockoutScheduleMatchInfo(trueRoundId, self._curGroupId, tureMatchId)

		self:_resetMatchCell(cell)

		cell.info = matchInfo

		self:_updateMatchCell(cell)
	end
end

function TCKKnockout8PlayerView:_getKnockoutScheduleMatchInfo(roundId, groupId, matchId)
	local info = TeenChampionKingModel.instance:getKnockoutScheduleInfo(self._activityId, groupId, self._enterRoundId)

	if info then
		if not info.groupList then
			for _, matchInfo in ipairs(info.groupList) do
				if matchInfo.roundId == roundId and matchInfo.index == matchId then
					return matchInfo
				end
			end
		end
	end
end

function TCKKnockout8PlayerView:_resetMatchCell(cell)
	goutil.setActive(cell.lineA, false)
	goutil.setActive(cell.lineB, false)
	self:_setPlayerInfo(cell.playerCellA)
	self:_setPlayerInfo(cell.playerCellB)
	goutil.setActive(cell.btnCell.btnRecord, false)
	goutil.setActive(cell.btnCell.btnVote, false)
end

function TCKKnockout8PlayerView:_setPlayerInfo(cell, info)
	if cell then
		HeadItemController.instance:resetHeadCell(cell.head)

		local childCnt = cell.tags.transform.childCount - 1

		for i = 0, childCnt do
			local child = cell.tags.transform:GetChild(i)

			goutil.setActive(child.gameObject, false)
		end

		if info then
			HeadItemController.instance:setHeadCellByInfo(cell.head, info.headInfo.headInfo, true)

			cell.txtNamePlayer.text = info.headInfo.headInfo.userName
			cell.txtRank.text = string.format("战区%s-第%s名", info.headInfo.zoneId, info.headInfo.zoneRank)

			goutil.setActive(cell.player, true)

			local isMy = checknumber(info.headInfo.headInfo.userId) == checknumber(RoleModel.instance:getUserId())

			goutil.setActive(cell.tagMy, isMy)
		else
			goutil.setActive(cell.tagEmpty, true)
			goutil.setActive(cell.player, false)
		end
	end
end

function TCKKnockout8PlayerView:_setPlayerWinInfo(cell, isWin, roundId)
	if cell then
		goutil.setActive(cell.tagWin, isWin)
		goutil.setActive(cell.tagFail, not isWin)
	end
end

function TCKKnockout8PlayerView:_updateMatchCell(cell)
	local info = cell.info

	if not info then
		self:_setPlayerInfo(cell.playerCellA)
		self:_setPlayerInfo(cell.playerCellB)

		return
	end

	self:_setPlayerInfo(cell.playerCellA, info.playerA)
	self:_setPlayerInfo(cell.playerCellB, info.playerB)

	local isMySupport = checknumber(info.playerA.headInfo.headInfo.userId) == checknumber(info.guessPlayerId)

	goutil.setActive(cell.playerCellA.tagMySupport, isMySupport)

	isMySupport = checknumber(info.playerB.headInfo.headInfo.userId) == checknumber(info.guessPlayerId)

	goutil.setActive(cell.playerCellB.tagMySupport, isMySupport)

	local reports = info.reports
	local isCanVote = self._curRoundId == info.roundId

	if reports then
		goutil.setActive(cell.btnCell.btnRecord, true)

		local winer = self:_getWinerInfo(info)

		goutil.setActive(cell.lineA, winer == info.playerA)
		goutil.setActive(cell.lineB, winer == info.playerB)
		self:_setPlayerWinInfo(cell.playerCellA, winer == info.playerA, info.roundId)
		self:_setPlayerWinInfo(cell.playerCellB, winer == info.playerB, info.roundId)

		if cell.isLastMatch then
			self:_setPlayerInfo(self._playerCellEnd, winer)
			goutil.setActive(self._playerCellEnd.tagEmpty, false)
			goutil.setActive(self._playerCellEnd.tagWinLast, true)
		end

		isCanVote = false
	end

	if isCanVote then
		goutil.setActive(cell.btnCell.btnVote, true)
	end
end

function TCKKnockout8PlayerView:_getWinerInfo(info)
	local records = info and info.reports
	local playerA = info.playerA
	local playerB = info.playerB
	local winNumA = 0
	local winNumB = 0

	if checknumber(records.winPlayerId) == checknumber(playerA.headInfo.headInfo.userId) then
		winNumA = winNumA + 1
	else
		winNumB = winNumB + 1
	end

	return winNumB < winNumA and playerA or playerB
end

return TCKKnockout8PlayerView
