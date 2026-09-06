-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/youngchampionking/view/YoungChampionKingKnockout8playerView.lua

module("logic.extensions.youngchampionking.view.YoungChampionKingKnockout8playerView", package.seeall)

local YoungChampionKingKnockout8playerView = class("YoungChampionKingKnockout8playerView", ViewComponent)

function YoungChampionKingKnockout8playerView:ctor()
	YoungChampionKingKnockout8playerView.super.ctor(self)
end

function YoungChampionKingKnockout8playerView:unbindEvents()
	YoungChampionKingKnockout8playerView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnVoteRecord)
	GameUtil.rmClickHandler(self._btnGainCoin)
	GameUtil.rmClickHandler(self._btnSwtich)

	for _, cell in ipairs(self._matchCellList) do
		GameUtil.rmClickHandler(cell.btnCell.btnVote)
		GameUtil.rmClickHandler(cell.btnCell.btnRecord)
	end
end

function YoungChampionKingKnockout8playerView:bindEvents()
	YoungChampionKingKnockout8playerView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnVoteRecord, self._onClickVoteRecord, self)
	GameUtil.addClickHandler(self._btnGainCoin, self._onClickGainCoin, self)
	GameUtil.addClickHandler(self._btnSwtich, self._onClickBtnSwtich, self)

	for _, cell in ipairs(self._matchCellList) do
		GameUtil.addClickHandler(cell.btnCell.btnVote, GameUtil.handler(self._onClickBtnVote, self, cell))
		GameUtil.addClickHandler(cell.btnCell.btnRecord, GameUtil.handler(self._onClickBtnRecord, self, cell))
	end
end

function YoungChampionKingKnockout8playerView:buildUI()
	YoungChampionKingKnockout8playerView.super.buildUI(self)

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

function YoungChampionKingKnockout8playerView:buildMatchCell(roundId, matchId)
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

function YoungChampionKingKnockout8playerView:getPlayerCell(pos)
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
	cell.tagWinLast = goutil.findChild(cell.tags, "winLast")

	return cell
end

function YoungChampionKingKnockout8playerView:getBtnCell(pos)
	local cell = {}

	cell.go = goutil.findChild(pos, "btnCell") or goutil.cloneAndSetParent(self._btnCell, pos.transform, "btnCell")

	GameUtil.setAnchoredPos(cell.go, 0, 0)
	goutil.setActive(cell.go, true)

	cell.btnVote = goutil.findChild(cell.go, "btnVote")
	cell.btnRecord = goutil.findChild(cell.go, "btnRecord")

	return cell
end

function YoungChampionKingKnockout8playerView:onExit()
	YoungChampionKingKnockout8playerView.super.onExit(self)
	self._tableviewGroup:dispose()

	for _, cell in ipairs(self._matchCellList) do
		HeadItemController.instance:resetHeadCell(cell.playerCellA.head)
		HeadItemController.instance:resetHeadCell(cell.playerCellB.head)
	end

	removetimer(self._updateTimer, self)
	RedPointController.instance:unregRedPoint(self._redPointBtnGainCoin)
end

function YoungChampionKingKnockout8playerView:onEnter()
	YoungChampionKingKnockout8playerView.super.onEnter(self)

	self._activityId = YoungChampionKingModel.instance:getCurActId()

	local params = self:getOpenParam()

	self._enterRoundId = checknumber(params[1])

	self.addGEvent(self, GlobalNotify.PM_YCKStepChange, self._onStepChange, self)
	self.addGEvent(self, GlobalNotify.PM_YCKGetKnockoutScheduleRes, self._handleGetInfo, self)
	self.addGEvent(self, GlobalNotify.PM_YCKGetGuessRes, self._handleGuess, self)
	self.addGEvent(self, GlobalNotify.PM_YCKMyKnockoutInfoRes, self._handleGetRoomInfo, self)
	self:_updateUIByCfg()
	self:_updateTimeTxt()
	YoungChampionKingController.instance:sendPM_YCKMyKnockoutInfoReq(self._activityId)
	RedPointController.instance:regRedPoint(self._redPointBtnGainCoin, RedPointModel.ID_YOUNG_CHAMPION_KING_GAIN_COIN)
end

function YoungChampionKingKnockout8playerView:_updateUIByCfg()
	self._totalGroupNum = 16
	self._curGroupIdList = {}

	for i = 1, self._totalGroupNum do
		table.insert(self._curGroupIdList, i)
	end
end

function YoungChampionKingKnockout8playerView:_updateTimeTxt()
	self._startRoundId = YoungChampionKingEnum.Common_Knockout_128To64_Id
	self._endRoundId = YoungChampionKingEnum.Common_Knockout_32To16_Id

	local curStepId = YoungChampionKingModel.instance:getCurStepId()

	self._curStepCfg = YoungChampionKingConfig.instance:getStepCfg(self._activityId, curStepId)

	local nextStepCfg = YoungChampionKingConfig.instance:getStepCfg(self._activityId, curStepId + 1)
	local curRoundId = YoungChampionKingController.instance:getRoundIdByStepId(curStepId)

	self._txtTime.text = ""

	if curRoundId < self._startRoundId then
		self._txtTime.text = ""
	elseif curRoundId > self._endRoundId then
		local roundCfg = YoungChampionKingConfig.instance:getRoundCfg(self._activityId, self._endRoundId)

		self._txtTitle.text = roundCfg.roundName
		self._txtTime.text = "本轮比赛已结束"
	else
		self._nextStageTime = GameUtil.string2time(nextStepCfg.startTime)

		local roundCfg = YoungChampionKingConfig.instance:getRoundCfg(self._activityId, curRoundId)

		self._txtTitle.text = roundCfg.roundName
		self._txtTime.text = ""

		settimer(1, self._updateTimer, self, true)
	end
end

function YoungChampionKingKnockout8playerView:_updateTimer()
	local timer = self._nextStageTime - ServerTime.now()

	if timer <= 0 then
		removetimer(self._updateTimer, self)
		self:_updateTimeTxt()
	end

	local timeStr = GameUtil.FormatTimeSymbol(timer)

	self._txtTime.text = (self._curStepCfg.canGuss and "距离战斗开始剩余：" or "距离战斗结束剩余：") .. timeStr
end

function YoungChampionKingKnockout8playerView:_handleGetRoomInfo()
	self._groupId = 1
	self._myInfo = YoungChampionKingModel.instance:getCurKnockoutInfo()

	if self._myInfo then
		local matchId = self._myInfo.groupId
		local matchRoundId = self._myInfo.roundId

		if matchRoundId == YoungChampionKingEnum.Common_Knockout_128To64_Id then
			self._groupId = math.ceil(matchId / 4)
		elseif matchRoundId == YoungChampionKingEnum.Common_Knockout_64To32_Id then
			self._groupId = math.ceil(matchId / 2)
		elseif matchRoundId == YoungChampionKingEnum.Common_Knockout_32To16_Id then
			self._groupId = matchId
		end
	end

	self:_onSwitchGroup(self._groupId)
end

function YoungChampionKingKnockout8playerView:_onSwitchGroup(groupId)
	YoungChampionKingController.instance:sendPM_YCKGetKnockoutScheduleReq(self._activityId, groupId, self._enterRoundId)
end

function YoungChampionKingKnockout8playerView:_updateCell(view, goCell, data)
	local cell = self:_clearCell(goCell)

	cell.changeGroup:SetState(self._curGroupId == data and 1 or 0)
	GameUtil.addClickHandler(cell.go, GameUtil.handler(self._onSwitchGroup, self, data))

	cell.txtName.text = string.format("第%s组", GameUtil.getChineseNumber(data))

	goutil.setActive(cell.mark, self._curGroupId == data)
end

function YoungChampionKingKnockout8playerView:_clearCell(goCell)
	local cell = {}

	cell.go = goCell
	cell.txtName = goutil.findChildTextComponent(cell.go, "txtName")
	cell.mark = goutil.findChild(cell.go, "mark")
	cell.changeGroup = cell.go:GetComponent(ComponentType.UIChangeGroup)

	GameUtil.rmClickHandler(cell.go)

	return cell
end

function YoungChampionKingKnockout8playerView:_onClickVoteRecord()
	UIStateManager.instance:push(ViewName.YoungchampionkingsupportrecordView, self._activityId)
end

function YoungChampionKingKnockout8playerView:_onClickGainCoin()
	UIStateManager.instance:push(ViewName.YoungChampionKingGainCoinView)
end

function YoungChampionKingKnockout8playerView:_onClickBtnSwtich()
	local isShow = GameUtil.GetActive(self._tableviewGoGroup)

	goutil.setActive(self._tableviewGoGroup, not isShow)

	if not isShow then
		self._tableviewGroup:reloadData(self._curGroupIdList)
	end
end

function YoungChampionKingKnockout8playerView:_onClickBtnVote(cell)
	UIStateManager.instance:push(ViewName.YoungchampionkingsupportView, self._activityId, cell.info, self._curRoundId, self._curGroupId)
end

function YoungChampionKingKnockout8playerView:_onClickBtnRecord(cell)
	local info = cell and cell.info

	if info then
		if not info.reports then
			local records = {}

			if #records <= 0 then
				TipsFacade.instance:openCommonTips("未出结果")

				return
			end

			local dataList = {}

			for i, record in ipairs(records) do
				local data = {}

				data.leftHeadInfo = info.playerA.headInfo.headInfo
				data.leftZdl = record.playerAZdl
				data.rightHeadInfo = info.playerB.headInfo.headInfo
				data.rightZdl = record.playerBZdl
				data.showTxt = YoungChampionKingController.instance:getCurRoundNameByStepId(record.stepId)
				data.isLeftWin = checknumber(record.winPlayerId) == checknumber(data.leftHeadInfo.userId)
				data.battleId = record.battleId

				table.insert(dataList, data)
			end

			UIStateManager.instance:push(ViewName.YoungChampionKingBattleResultView, dataList)
		end
	end
end

function YoungChampionKingKnockout8playerView:_onStepChange(newStepId)
	self:_onSwitchGroup(self._curGroupId)
end

function YoungChampionKingKnockout8playerView:_handleGetInfo(viewGroupId)
	self._curGroupId = viewGroupId

	goutil.setActive(self._tableviewGoGroup, false)

	self._txtBtnSwtich.text = string.format("第%s组", GameUtil.getChineseNumber(self._curGroupId))

	self:_updateGroupMatch()
end

function YoungChampionKingKnockout8playerView:_handleGuess()
	self:_updateGroupMatch()
end

function YoungChampionKingKnockout8playerView:_updateGroupMatch()
	self._curStepId = YoungChampionKingModel.instance:getCurStepId()
	self._curRoundId = YoungChampionKingController.instance:getRoundIdByStepId(self._curStepId)
	self._curStepCfg = YoungChampionKingConfig.instance:getStepCfg(self._activityId, self._curStepId)

	self:_setPlayerInfo(self._playerCellEnd)

	for i, cell in ipairs(self._matchCellList) do
		local trueRoundId = cell.roundId + self._enterRoundId - 1
		local tureMatchId = cell.matchTotalNum * (self._curGroupId - 1) + cell.matchId
		local info = YoungChampionKingController.instance:getKnockoutScheduleMatchInfo(trueRoundId, self._curGroupId, tureMatchId)

		self:_resetMatchCell(cell)

		cell.info = info

		self:_updateMatchCell(cell)
	end
end

function YoungChampionKingKnockout8playerView:_resetMatchCell(cell)
	goutil.setActive(cell.lineA, false)
	goutil.setActive(cell.lineB, false)
	self:_setPlayerInfo(cell.playerCellA)
	self:_setPlayerInfo(cell.playerCellB)
	goutil.setActive(cell.btnCell.btnRecord, false)
	goutil.setActive(cell.btnCell.btnVote, false)
end

function YoungChampionKingKnockout8playerView:_setPlayerInfo(cell, info)
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

function YoungChampionKingKnockout8playerView:_setPlayerWinInfo(cell, isWin, roundId)
	if cell then
		goutil.setActive(cell.tagWin, isWin)
		goutil.setActive(cell.tagFail, not isWin)
	end
end

function YoungChampionKingKnockout8playerView:_updateMatchCell(cell)
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

	if not info.reports then
		if #info.reports > 0 then
			goutil.setActive(cell.btnCell.btnRecord, true)

			local winer = self:_getWinerInfo(info)

			goutil.setActive(cell.lineA, winer == info.playerA)
			goutil.setActive(cell.lineB, winer == info.playerB)
			self:_setPlayerWinInfo(cell.playerCellA, winer == info.playerA, info.roundId)
			self:_setPlayerWinInfo(cell.playerCellB, winer == info.playerB, info.roundId)

			if cell.isLastMatch then
				self:_setPlayerInfo(self._playerCellEnd, winer)
			end
		end

		local isCanVote = true

		goto label_29_0

		::label_29_0::

		if isCanVote then
			goutil.setActive(cell.btnCell.btnVote, true)
		end
	end
end

function YoungChampionKingKnockout8playerView:_getWinerInfo(info)
	if info then
		if not info.reports then
			local records = {}
			local playerA = info.playerA
			local playerB = info.playerB
			local winNumA = 0
			local winNumB = 0

			for i, record in ipairs(records) do
				if checknumber(record.winPlayerId) == checknumber(playerA.headInfo.headInfo.userId) then
					winNumA = winNumA + 1
				else
					winNumB = winNumB + 1
				end
			end

			return winNumB < winNumA and playerA or playerB
		end
	end
end

return YoungChampionKingKnockout8playerView
