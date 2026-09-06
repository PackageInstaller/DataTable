-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/youtharenathird/view/YouthArenaThirdChampionRaceRoundView.lua

module("logic.extensions.youtharenathird.view.YouthArenaThirdChampionRaceRoundView", package.seeall)

local YouthArenaThirdChampionRaceRoundView = class("YouthArenaThirdChampionRaceRoundView", ViewComponent)
local GROUP_MATCH_COUNT = 4
local TOTAL_ROUND_NUM = 3
local BUFF_VIEWED_KEY = "YouthArenaThirdBuffViewed_%s_%s"
local MATCH_COUNT_BY_ROUND = {
	[YouthArenaThirdEnum.ChampionRoundId.KnockoutStart] = 64,
	[YouthArenaThirdEnum.ChampionRoundId.KnockoutStart + 1] = 32,
	[YouthArenaThirdEnum.ChampionRoundId.KnockoutStart + 2] = 16
}

function YouthArenaThirdChampionRaceRoundView:ctor()
	YouthArenaThirdChampionRaceRoundView.super.ctor(self)
end

function YouthArenaThirdChampionRaceRoundView:buildUI()
	YouthArenaThirdChampionRaceRoundView.super.buildUI(self)

	self._btnSwitch = self:getGo("groupCol/btnSwtich")
	self._txtBtnSwitch = self:getTxt("groupCol/btnSwtich/txt")
	self._groupListGo = self:getGo("groupCol/scrView")
	self._groupScroller = ScrollerList.create(self:getGo("groupCol/scrView"), self:getGo("groupCol/scrCell"), GameUtil.handler(self._updateGroupCell, self), GameUtil.handler(self._clearGroupCell, self))
	self._seatCell = self:getGo("seatCell")
	self._btnRecordTemplate = self:getGo("btnRecord")
	self._txtTitle = self:getTxt("title/txt")
	self._txtScheduleTime = self:getTxt("scheduleTime/txt")
	self._btnScoreRule = self:getGo("btnScoreRule")
	self._btnBuff = self:getGo("btnBuff")
	self._bubbleBuff = goutil.findChild(self._btnBuff, "bubble")
	self._matchCellList = {}
	self._matchCellMap = {}

	for roundId = 1, TOTAL_ROUND_NUM do
		local matchCount = 2^(TOTAL_ROUND_NUM - roundId)

		for matchId = 1, matchCount do
			local cell = self:_buildMatchCell(roundId, matchId)

			cell.matchTotalNum = matchCount
			cell.isLastMatch = matchCount == 1
			self._matchCellMap[roundId] = self._matchCellMap[roundId] or {}
			self._matchCellMap[roundId][matchId] = cell

			table.insert(self._matchCellList, cell)
		end
	end

	self._endPos = self:getGo("colMatch/endPos")
	self._playerCellEnd = self:_getPlayerCell(self._endPos)

	goutil.setActive(self._seatCell, false)
	goutil.setActive(self._btnRecordTemplate, false)
	goutil.setActive(self._groupListGo, false)
	self:_clearGroupMatch()
end

function YouthArenaThirdChampionRaceRoundView:bindEvents()
	YouthArenaThirdChampionRaceRoundView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSwitch, self._onClickBtnSwitch, self)
	GameUtil.addClickHandler(self._btnScoreRule, self._onClickBtnScoreRule, self)
	GameUtil.addClickHandler(self._btnBuff, self._onClickBtnBuff, self)

	for _, cell in ipairs(self._matchCellList or {}) do
		GameUtil.addClickHandler(cell.btnRecord, GameUtil.handler(self._onClickBtnRecord, self, cell))
	end
end

function YouthArenaThirdChampionRaceRoundView:unbindEvents()
	YouthArenaThirdChampionRaceRoundView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSwitch)
	GameUtil.rmClickHandler(self._btnScoreRule)
	GameUtil.rmClickHandler(self._btnBuff)

	for _, cell in ipairs(self._matchCellList or {}) do
		GameUtil.rmClickHandler(cell.btnRecord)
	end
end

function YouthArenaThirdChampionRaceRoundView:onEnter()
	YouthArenaThirdChampionRaceRoundView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.HandlePM_YoungArenaKingS3GetKnockoutScheduleRes, self._handleGetScheduleRes, self)
	self.addGEvent(self, GlobalNotify.HandlePM_YoungArenaKingS3MyKnockoutInfoRes, self._handleMyKnockoutInfoRes, self)
	self.addGEvent(self, GlobalNotify.HandlePM_YoungArenaKingS3NotifyStepChangeRes, self._handleStepChange, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._displayStartRoundId = YouthArenaThirdEnum.ChampionRoundId.KnockoutStart
	self._displayEndRoundId = self._displayStartRoundId + TOTAL_ROUND_NUM - 1
	self._curGroupId = 1
	self._myGroupId = 0
	self._hasManualSwitch = false

	self:_refreshStaticInfo()
	self:_initGroupData()
	self:_refreshMyGroup()
	self:_refreshTimeInfo()
	self:_refreshBuffBubble()
	self:_onSwitchGroup((self._myGroupId > 0 or nil) and (self._myGroupId or 1))
	self:_sendMyKnockoutInfoReq()
end

function YouthArenaThirdChampionRaceRoundView:onExit()
	YouthArenaThirdChampionRaceRoundView.super.onExit(self)
	removetimer(self._updateTimer, self)
	goutil.setActive(self._groupListGo, false)

	for _, cell in ipairs(self._matchCellList or {}) do
		self:_clearPlayerCell(cell.playerCellA)
		self:_clearPlayerCell(cell.playerCellB)
	end

	self:_clearPlayerCell(self._playerCellEnd)
end

function YouthArenaThirdChampionRaceRoundView:destroyUI()
	YouthArenaThirdChampionRaceRoundView.super.destroyUI(self)

	if self._groupScroller then
		self._groupScroller:dispose()

		self._groupScroller = nil
	end
end

function YouthArenaThirdChampionRaceRoundView:_buildMatchCell(roundId, matchId)
	local cell = {}

	cell.go = self:getGo(string.format("colMatch/match_cell_%s_%s", roundId, matchId))
	cell.lineGo = self:getGo(string.format("colLine/match_cell_%s_%s", roundId, matchId))
	cell.lineA = goutil.findChild(cell.lineGo, "lineA")
	cell.lineB = goutil.findChild(cell.lineGo, "lineB")
	cell.playerPosA = goutil.findChild(cell.go, "playerPosA")
	cell.playerPosB = goutil.findChild(cell.go, "playerPosB")
	cell.btnPos = goutil.findChild(cell.go, "btnPos")
	cell.playerCellA = self:_getPlayerCell(cell.playerPosA)
	cell.playerCellB = self:_getPlayerCell(cell.playerPosB)
	cell.btnRecord = goutil.findChild(cell.btnPos, "btnRecord") or goutil.cloneAndSetParent(self._btnRecordTemplate, cell.btnPos.transform, "btnRecord")
	cell.roundId = roundId
	cell.matchId = matchId
	cell.matchInfo = nil

	GameUtil.setAnchoredPos(cell.btnRecord, 0, 0)
	goutil.setActive(cell.btnRecord, false)

	return cell
end

function YouthArenaThirdChampionRaceRoundView:_getPlayerCell(pos)
	local cell = {}

	cell.go = goutil.findChild(pos, "seatCell") or goutil.cloneAndSetParent(self._seatCell, pos.transform, "seatCell")

	GameUtil.setAnchoredPos(cell.go, 0, 0)
	goutil.setActive(cell.go, true)

	cell.player = goutil.findChild(cell.go, "player")
	cell.head = goutil.findChild(cell.player, "head")
	cell.txtNamePlayer = goutil.findChildTextComponent(cell.player, "name/txt")
	cell.txtScore = goutil.findChildTextComponent(cell.player, "score/txt")
	cell.tags = goutil.findChild(cell.go, "tags")
	cell.tagFail = goutil.findChild(cell.tags, "fail")
	cell.tagChampionship = goutil.findChild(cell.tags, "championship")
	cell.tagThirdPlaceMatch = goutil.findChild(cell.tags, "thirdPlaceMatch")
	cell.tagWin = goutil.findChild(cell.tags, "win")
	cell.tagMy = goutil.findChild(cell.tags, "my")
	cell.tagEmpty = goutil.findChild(cell.tags, "empty")
	cell.tagWinLast = goutil.findChild(cell.go, "winLast")

	return cell
end

function YouthArenaThirdChampionRaceRoundView:_refreshStaticInfo()
	local roundData = YouthArenaThirdConfig.instance:getRoundData(self._activityId, self._displayStartRoundId)

	if roundData then
		self._txtTitle.text = roundData.roundName or ""
	end
end

function YouthArenaThirdChampionRaceRoundView:_initGroupData()
	self._groupIdList = {}

	if not MATCH_COUNT_BY_ROUND[self._displayStartRoundId] then
		local matchCount = 0
		local groupCount = math.ceil(matchCount / GROUP_MATCH_COUNT)

		for i = 1, groupCount do
			table.insert(self._groupIdList, i)
		end
	end
end

function YouthArenaThirdChampionRaceRoundView:_refreshMyGroup()
	self._myGroupId = 0

	local subMo = self:_getSubMo()
	local myInfo = subMo and subMo:getMyKnockoutInfo()
	local matchRoundId = checknumber(myInfo and myInfo.roundId)

	if matchRoundId < self._displayStartRoundId or matchRoundId > self._displayEndRoundId then
		return
	end

	local groupId = YouthArenaThirdController.instance:getChampionScheduleViewGroupId(self._activityId, matchRoundId, checknumber(myInfo.groupId))

	if groupId > 0 and groupId <= #self._groupIdList then
		self._myGroupId = groupId
	end
end

function YouthArenaThirdChampionRaceRoundView:_refreshTimeInfo()
	removetimer(self._updateTimer, self)

	local curRoundId = self:_getCurRoundId()

	self._nextStageTime = 0
	self._timerPrefix = ""
	self._txtScheduleTime.text = ""

	if curRoundId <= 0 then
		return
	end

	if curRoundId > self._displayEndRoundId then
		local roundData = YouthArenaThirdConfig.instance:getRoundData(self._activityId, self._displayEndRoundId)

		if roundData then
			self._txtTitle.text = roundData.roundName or self._txtTitle.text
		end

		self._txtScheduleTime.text = "本轮比赛已结束"

		return
	end

	if curRoundId < self._displayStartRoundId then
		local stepData = self:_getStepDataByRoundId(self._displayStartRoundId)
		local roundData = YouthArenaThirdConfig.instance:getRoundData(self._activityId, self._displayStartRoundId)

		if roundData then
			self._txtTitle.text = roundData.roundName or self._txtTitle.text
		end

		self._nextStageTime = stepData and GameUtil.string2time(stepData.startTime) or 0
		self._timerPrefix = "距离本轮开始剩余："
	else
		local curStepId = self:_getCurStepId()
		local curStepData = YouthArenaThirdConfig.instance:getStepData(self._activityId, curStepId)
		local nextStepData = YouthArenaThirdConfig.instance:getStepData(self._activityId, curStepId + 1)
		local roundData = YouthArenaThirdConfig.instance:getRoundData(self._activityId, curRoundId)

		if roundData then
			self._txtTitle.text = roundData.roundName or self._txtTitle.text
		end

		self._nextStageTime = nextStepData and GameUtil.string2time(nextStepData.startTime) or 0
		self._timerPrefix = curStepData and checkbool(curStepData.canSetForm) and "距离战斗开始剩余：" or "距离战斗结束剩余："
	end

	if self._nextStageTime > 0 then
		self:_updateTimer()

		if self._nextStageTime > ServerTime.now() then
			settimer(1, self._updateTimer, self, true)
		end
	end
end

function YouthArenaThirdChampionRaceRoundView:_updateTimer()
	local timer = self._nextStageTime - ServerTime.now()

	if timer <= 0 then
		removetimer(self._updateTimer, self)

		timer = 0
	end

	self._txtScheduleTime.text = self._timerPrefix .. GameUtil.FormatTimeSymbol(timer)
end

function YouthArenaThirdChampionRaceRoundView:_onSwitchGroup(groupId)
	groupId = math.max(1, math.min(checknumber(groupId), #self._groupIdList))
	self._curGroupId = groupId
	self._txtBtnSwitch.text = string.format("第%s组", GameUtil.getChineseNumber(groupId))

	goutil.setActive(self._groupListGo, false)
	self:_clearGroupMatch()
	self:_refreshGroupMatch()

	local reqRoundId = self:_getScheduleReqRoundId()

	if self._activityId > 0 and reqRoundId > 0 then
		YouthArenaThirdController.instance:sendPM_YoungArenaKingS3GetKnockoutScheduleReq(self._activityId, groupId, reqRoundId)
	end
end

function YouthArenaThirdChampionRaceRoundView:_clearGroupMatch()
	for _, cell in ipairs(self._matchCellList or {}) do
		goutil.setActive(cell.go, true)
		goutil.setActive(cell.lineGo, true)
		self:_resetMatchCell(cell)
	end

	self:_setPlayerInfo(self._playerCellEnd)

	if self._playerCellEnd then
		goutil.setActive(self._playerCellEnd.tagWinLast, false)
	end
end

function YouthArenaThirdChampionRaceRoundView:_refreshGroupMatch()
	local scheduleInfo = self:_getScheduleInfo()

	self:_setPlayerInfo(self._playerCellEnd)

	for _, cell in ipairs(self._matchCellList or {}) do
		local matchRoundId = self._displayStartRoundId + cell.roundId - 1
		local matchIndex = cell.matchTotalNum * (self._curGroupId - 1) + cell.matchId

		cell.matchInfo = self:_getMatchInfo(scheduleInfo, matchRoundId, matchIndex)

		self:_resetMatchCell(cell)
		self:_updateMatchCell(cell)
	end
end

function YouthArenaThirdChampionRaceRoundView:_getMatchInfo(scheduleInfo, matchRoundId, matchIndex)
	for _, matchInfo in ipairs((scheduleInfo or nil) and (scheduleInfo.groupList or {})) do
		if checknumber(matchInfo.roundId) == matchRoundId and checknumber(matchInfo.index) == matchIndex then
			return matchInfo
		end
	end
end

function YouthArenaThirdChampionRaceRoundView:_resetMatchCell(cell)
	goutil.setActive(cell.lineA, false)
	goutil.setActive(cell.lineB, false)
	goutil.setActive(cell.btnRecord, false)
	self:_setPlayerInfo(cell.playerCellA)
	self:_setPlayerInfo(cell.playerCellB)
end

function YouthArenaThirdChampionRaceRoundView:_updateMatchCell(cell)
	local info = cell.matchInfo

	if not info then
		return
	end

	local result = info.result
	local scoreA = self:_getMatchScore(result, true)
	local scoreB = self:_getMatchScore(result, false)

	self:_setPlayerInfo(cell.playerCellA, info.playerA, scoreA)
	self:_setPlayerInfo(cell.playerCellB, info.playerB, scoreB)
	goutil.setActive(cell.btnRecord, true)

	if not result then
		return
	end

	local winPlayerId = checknumber(result.winPlayerId)
	local playerAId = self:_getPlayerUserId(info.playerA)
	local playerBId = self:_getPlayerUserId(info.playerB)
	local isAWin = winPlayerId > 0 and winPlayerId == playerAId
	local isBWin = winPlayerId > 0 and winPlayerId == playerBId

	goutil.setActive(cell.lineA, isAWin)
	goutil.setActive(cell.lineB, isBWin)
	goutil.setActive(cell.playerCellA.tagWin, isAWin)
	goutil.setActive(cell.playerCellA.tagFail, isBWin)
	goutil.setActive(cell.playerCellB.tagWin, isBWin)
	goutil.setActive(cell.playerCellB.tagFail, isAWin)

	if cell.isLastMatch then
		if not isAWin then
			if isBWin then
				self:_setPlayerInfo(self._playerCellEnd, (isAWin or nil) and (info.playerA or info.playerB), isAWin and scoreA or scoreB)

				if self._playerCellEnd then
					goutil.setActive(self._playerCellEnd.tagEmpty, false)
					goutil.setActive(self._playerCellEnd.tagWinLast, true)
				end
			end
		end
	end
end

function YouthArenaThirdChampionRaceRoundView:_getMatchScore(result, isPlayerA)
	if isPlayerA then
		return checknumber(result and result.score1v1A) + checknumber(result and result.score3v3A)
	end

	return checknumber(result and result.score1v1B) + checknumber(result and result.score3v3B)
end

function YouthArenaThirdChampionRaceRoundView:_setPlayerInfo(cell, info, score)
	if not cell then
		return
	end

	self:_clearPlayerCell(cell)

	local playerHeadInfo = info and info.headInfo
	local headInfo = playerHeadInfo and playerHeadInfo.headInfo

	if not headInfo or checknumber(headInfo.userId) <= 0 then
		goutil.setActive(cell.tagEmpty, true)
		goutil.setActive(cell.player, false)

		return
	end

	HeadItemController.instance:setHeadCellByInfo(cell.head, headInfo, true)

	cell.txtNamePlayer.text = headInfo.userName or ""
	cell.txtScore.text = string.format("积分：%s", checknumber(score))

	goutil.setActive(cell.player, true)
	goutil.setActive(cell.tagMy, checknumber(headInfo.userId) == checknumber(RoleModel.instance:getUserId()))
end

function YouthArenaThirdChampionRaceRoundView:_clearPlayerCell(cell)
	if not cell then
		return
	end

	HeadItemController.instance:resetHeadCell(cell.head)

	local childCnt = cell.tags.transform.childCount - 1

	for i = 0, childCnt do
		local child = cell.tags.transform:GetChild(i)

		goutil.setActive(child.gameObject, false)
	end

	goutil.setActive(cell.tagWinLast, false)
	goutil.setActive(cell.player, false)
end

function YouthArenaThirdChampionRaceRoundView:_getPlayerUserId(playerInfo)
	local playerHeadInfo = playerInfo and playerInfo.headInfo
	local headInfo = playerHeadInfo and playerHeadInfo.headInfo

	return checknumber(headInfo and headInfo.userId)
end

function YouthArenaThirdChampionRaceRoundView:_updateGroupCell(view, cell, groupId, tag)
	if not cell.gameObject then
		local go = cell
		local txtName = goutil.findChildTextComponent(go, "txtName")
		local redPoint = goutil.findChild(go, "redPoint")
		local lock = goutil.findChild(go, "lock")
		local mark = goutil.findChild(go, "mark")
		local changeGroup = GameUtil.getUIChangeGroup(cell)

		GameUtil.rmClickHandler(go)

		txtName.text = string.format("第%s组", GameUtil.getChineseNumber(groupId))

		goutil.setActive(redPoint, false)
		goutil.setActive(lock, false)
		goutil.setActive(mark, self._myGroupId == groupId)

		if changeGroup then
			changeGroup:SetState(self._curGroupId == groupId and 1 or 0)
		end

		GameUtil.addClickHandler(go, GameUtil.handler(self._onClickGroupCell, self, groupId))
	end
end

function YouthArenaThirdChampionRaceRoundView:_clearGroupCell(cell)
	if not cell.gameObject then
		GameUtil.rmClickHandler(cell.gameObject)
	end
end

function YouthArenaThirdChampionRaceRoundView:_onClickBtnSwitch()
	local isShow = GameUtil.GetActive(self._groupListGo)

	goutil.setActive(self._groupListGo, not isShow)

	if not isShow then
		self._groupScroller:reloadData(self._groupIdList)
	end
end

function YouthArenaThirdChampionRaceRoundView:_onClickGroupCell(groupId)
	self._hasManualSwitch = true

	self:_onSwitchGroup(groupId)
end

function YouthArenaThirdChampionRaceRoundView:_onClickBtnRecord(cell)
	local roundId = self:_getScheduleReqRoundId()

	if self._activityId <= 0 or self._curGroupId <= 0 or roundId <= 0 then
		return
	end

	local matchInfo = cell and cell.matchInfo

	UIStateManager.instance:push(ViewName.YouthArenaThirdChampionScheduleReportView, self._activityId, self._curGroupId, roundId, 0, checknumber(matchInfo and matchInfo.index), checknumber(matchInfo and matchInfo.roundId))
end

function YouthArenaThirdChampionRaceRoundView:_onClickBtnScoreRule()
	if self._activityId <= 0 then
		return
	end

	local roundId = self:_getOperableRoundId(true)

	if roundId <= 0 then
		return
	end

	local curStepData = YouthArenaThirdConfig.instance:getStepData(self._activityId, self:_getCurStepId())

	UIStateManager.instance:push(ViewName.YouthArenaThirdScoreRuleTipsView, self._activityId, roundId, (checknumber(curStepData and curStepData.roundId) == roundId and curStepData.mode == "MODE_3V3" or nil) and YouthArenaThirdEnum.BattleMode.Three)
end

function YouthArenaThirdChampionRaceRoundView:_onClickBtnBuff()
	if self._activityId <= 0 then
		return
	end

	local roundId = self:_getOperableRoundId(true)

	if roundId <= 0 then
		return
	end

	if not YouthArenaThirdConfig.instance:hasKnockoutBuffPlanDataByRound(self._activityId, roundId) then
		FloatWordMgr.instance:show("暂无加成")

		return
	end

	local curStepData = YouthArenaThirdConfig.instance:getStepData(self._activityId, self:_getCurStepId())

	UIStateManager.instance:push(ViewName.YouthArenaThirdZdlBuffPopView, self._activityId, roundId, (checknumber(curStepData and curStepData.roundId) == roundId and curStepData.mode == "MODE_3V3" or nil) and YouthArenaThirdEnum.BattleMode.Three)
	self:_markBuffViewed(roundId)
	self:_refreshBuffBubble()
end

function YouthArenaThirdChampionRaceRoundView:_handleGetScheduleRes()
	self:_refreshGroupMatch()
end

function YouthArenaThirdChampionRaceRoundView:_handleMyKnockoutInfoRes()
	self:_refreshMyGroup()

	if not self._hasManualSwitch and self._myGroupId > 0 and self._myGroupId ~= self._curGroupId then
		self:_onSwitchGroup(self._myGroupId)

		return
	end

	if GameUtil.GetActive(self._groupListGo) then
		self._groupScroller:reloadData(self._groupIdList)
	end
end

function YouthArenaThirdChampionRaceRoundView:_handleStepChange()
	self:_refreshTimeInfo()
	self:_refreshBuffBubble()
	self:_onSwitchGroup(self._curGroupId)
end

function YouthArenaThirdChampionRaceRoundView:_sendMyKnockoutInfoReq()
	if self._activityId > 0 then
		YouthArenaThirdController.instance:sendPM_YoungArenaKingS3MyKnockoutInfoReq(self._activityId)
	end
end

function YouthArenaThirdChampionRaceRoundView:_getScheduleInfo()
	local subMo = self:_getSubMo()

	return subMo and subMo:getKnockoutScheduleInfo(self._curGroupId, self:_getScheduleReqRoundId())
end

function YouthArenaThirdChampionRaceRoundView:_getScheduleReqRoundId()
	local curRoundId = self:_getCurRoundId()

	if curRoundId <= 0 or curRoundId < self._displayStartRoundId then
		return self._displayStartRoundId
	end

	if curRoundId > self._displayEndRoundId then
		return self._displayEndRoundId
	end

	return curRoundId
end

function YouthArenaThirdChampionRaceRoundView:_getOperableRoundId(showToast)
	local curRoundId = self:_getCurRoundId()
	local startRoundId = YouthArenaThirdEnum.ChampionRoundId.KnockoutStart
	local endRoundId = startRoundId + TOTAL_ROUND_NUM - 1

	if curRoundId < startRoundId then
		if showToast then
			FloatWordMgr.instance:show("比赛尚未开启")
		end

		return 0
	end

	if endRoundId < curRoundId then
		if showToast then
			FloatWordMgr.instance:show("比赛已结束")
		end

		return 0
	end

	return curRoundId
end

function YouthArenaThirdChampionRaceRoundView:_getBuffViewedKey(roundId)
	return string.format(BUFF_VIEWED_KEY, checknumber(self._activityId), checknumber(roundId))
end

function YouthArenaThirdChampionRaceRoundView:_isBuffViewed(roundId)
	return GameUtil.getUserData(self:_getBuffViewedKey(roundId)) ~= nil
end

function YouthArenaThirdChampionRaceRoundView:_markBuffViewed(roundId)
	GameUtil.saveUserData(self:_getBuffViewedKey(roundId), 1)
end

function YouthArenaThirdChampionRaceRoundView:_setBuffBubbleActive(active)
	if self._bubbleBuff then
		goutil.setActive(self._bubbleBuff, active)
	end
end

function YouthArenaThirdChampionRaceRoundView:_refreshBuffBubble()
	local roundId = self:_getOperableRoundId(false)
	local buffStepCfg = roundId > 0 and YouthArenaThirdConfig.instance:getBuffStepDataByRoundId(self._activityId, roundId) or nil
	local hasBuff = buffStepCfg and not string.nilorempty(buffStepCfg.buffDesc)

	self:_setBuffBubbleActive(hasBuff and not self:_isBuffViewed(roundId))
end

function YouthArenaThirdChampionRaceRoundView:_getSubMo()
	return YouthArenaThirdModel.instance:getSubMo(self._activityId)
end

function YouthArenaThirdChampionRaceRoundView:_getCurStepId()
	local subMo = self:_getSubMo()

	return checknumber(subMo and subMo:getCurStepId())
end

function YouthArenaThirdChampionRaceRoundView:_getCurRoundId()
	local stepData = YouthArenaThirdConfig.instance:getStepData(self._activityId, self:_getCurStepId())

	return checknumber(stepData and stepData.roundId)
end

function YouthArenaThirdChampionRaceRoundView:_getStepDataByRoundId(roundId)
	for _, stepData in pairs(YouthArenaThirdConfig.instance:getStepDatas(self._activityId) or {}) do
		if checknumber(stepData.roundId) == checknumber(roundId) then
			return stepData
		end
	end
end

return YouthArenaThirdChampionRaceRoundView
