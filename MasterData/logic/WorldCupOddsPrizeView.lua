-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/worldcup/view/WorldCupOddsPrizeView.lua

module("logic.extensions.worldcup.view.WorldCupOddsPrizeView", package.seeall)

local WorldCupOddsPrizeView = class("WorldCupOddsPrizeView", ViewComponent)
local GROUP_STAGE = 1
local RACE_STATE_WAIT = 0
local RACE_STATE_PLAY = 1
local RACE_STATE_END = 2
local ODDS_TYPE_MAIN_WIN = "WIN"
local ODDS_TYPE_AWAY_WIN = "LOSE"
local ODDS_TYPE_DROW = "TIE"
local ODDS_TYPE_SCORE = "SCORE"
local ODDS_TYPE_OTHER_SCORE = "OTHER_SCORE"

function WorldCupOddsPrizeView:ctor()
	WorldCupOddsPrizeView.super.ctor(self)
end

function WorldCupOddsPrizeView:unbindEvents()
	WorldCupOddsPrizeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.addClickHandler(self._btnFilter)
	GameUtil.addClickHandler(self._btnFilterClose)
end

function WorldCupOddsPrizeView:bindEvents()
	WorldCupOddsPrizeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
	GameUtil.addClickHandler(self._btnFilter, self._onClickFilter, self)
	GameUtil.addClickHandler(self._btnFilterClose, self._onClickFilterClose, self)
end

function WorldCupOddsPrizeView:buildUI()
	WorldCupOddsPrizeView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnSure = self:getGo("btnSure")
	self._prizeTablecell = self:getGo("prizeTableview/prizeTablecell")
	self._prizeTableview = self:getGo("prizeTableview")
	self._matchTablecell = self:getGo("matchTableview/matchTablecell")
	self._matchTableview = self:getGo("matchTableview")
	self._oddsTableview = self:getGo("oddsTableview")
	self._oddsTablecell = self:getGo("oddsTableview/oddsTablecell")
	self._emptyMatch = self:getGo("emptyMatch")
	self._emptyOdds = self:getGo("emptyOdds")
	self._emptyPrize = self:getGo("emptyPrize")
	self._matchTableList = ScrollerList.create(self._matchTableview, self._matchTablecell, GameUtil.handler(self._updateMatchCell, self), GameUtil.handler(self._clearMatchCell, self))
	self._prizeTableList = ScrollerList.create(self._prizeTableview, self._prizeTablecell, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))
	self._oddsTableList = ScrollerList.create(self._oddsTableview, self._oddsTablecell, GameUtil.handler(self._updateOddsCell, self), GameUtil.handler(self._clearOddsCell, self))
	self._btnFilter = self:getGo("btnFilter")
	self._btnFilterClose = self:getGo("btnFilterClose")
	self._content = self:getGo("content")
	self._filterTablecell = self:getGo("content/filterTableview/filterTablecell")
	self._filterTableview = self:getGo("content/filterTableview")
	self._filerList = ScrollerList.create(self._filterTableview, self._filterTablecell, GameUtil.handler(self._updateFilterCell, self), GameUtil.handler(self._clearFilterCell, self))
end

function WorldCupOddsPrizeView:onExit()
	WorldCupOddsPrizeView.super.onExit(self)
	self._matchTableList:dispose()
	self._prizeTableList:dispose()
	self._oddsTableList:dispose()
	GameUtil.SetActive(self._btnFilterClose, false)
	GameUtil.SetActive(self._content, false)
end

function WorldCupOddsPrizeView:onEnter()
	WorldCupOddsPrizeView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_WorldCupGetInfoRes, self._refreshView, self)
	self.addGEvent(self, GlobalNotify.PM_WorldCupBetRes, self._refreshView, self)
	self.addGEvent(self, GlobalNotify.PM_WorldCupOneKeyGainPrizeRes, self._refreshView, self)
	GameUtil.SetActive(self._btnFilterClose, false)
	GameUtil.SetActive(self._content, false)

	self._activityId = checknumber(self:getFirstParam())
	self._actCfg = WorldCupConfig.instance:getActivityCfg(self._activityId)
	self._hasPrizeGain = false
	self._curMatchId = 0

	self:_refreshView()
end

function WorldCupOddsPrizeView:_refreshView()
	local matchList = WorldCupModel.instance:getMatchListWithBets(self._activityId, self._filterStageId)
	local curValid = false

	for _, m in ipairs(matchList) do
		if m.matchId == self._curMatchId then
			curValid = true

			break
		end
	end

	if not curValid then
		if #matchList > 0 then
			self._curMatchId = matchList[1].matchId or 0
		end
	end

	self._matchTableList:reloadData(matchList)
	GameUtil.SetActive(self._emptyMatch, #matchList <= 0)

	local matchInfo = WorldCupModel.instance:getMatchInfo(self._activityId, self._curMatchId)
	local oddsMap = {}

	if matchInfo then
		for i, v in ipairs(matchInfo.odds or {}) do
			oddsMap[v.defineId] = v.odds
		end
	end

	local myBetList = WorldCupModel.instance:getBetInfos(self._activityId, self._curMatchId)
	local oddsList = {}

	for i, v in pairs(myBetList or {}) do
		table.insert(oddsList, {
			betInfo = v,
			odds = oddsMap[v.defineId]
		})
	end

	self._oddsTableList:reloadData(oddsList)
	GameUtil.SetActive(self._emptyOdds, #oddsList <= 0)

	local prizeCount = 0

	for i, v in ipairs(WorldCupModel.instance:getAllBetInfo(self._activityId)) do
		if v.state == 0 then
			local checkMatchInfo = WorldCupModel.instance:getMatchInfo(self._activityId, v.matchId)

			if checkMatchInfo.result then
				for j, oddsInfo in ipairs(checkMatchInfo.odds or {}) do
					if oddsInfo.defineId == v.defineId then
						prizeCount = prizeCount + (self:_isOddsWin(checkMatchInfo, v.defineId) == true and math.ceil(oddsInfo.odds * v.score / 100) or math.ceil(v.score * self._actCfg.betFailPercent / 100))

						break
					end
				end
			end
		end
	end

	local prizeList = {}

	if prizeCount > 0 then
		self._hasPrizeGain = true

		table.insert(prizeList, string.format("%s:%s", self._actCfg.betItemKey, prizeCount))
		GameUtil.SetGray(self._btnSure, false)
	else
		GameUtil.SetGray(self._btnSure, true)
	end

	GameUtil.SetActive(self._emptyPrize, #prizeList <= 0)
	self._prizeTableList:reloadData(prizeList)

	local stageCfg = WorldCupConfig.instance:getStageCfgs(self._activityId)
	local filterList = {}

	table.insert(filterList, 0)

	for i, v in ipairs(stageCfg) do
		table.insert(filterList, v.stageId)
	end

	self._filerList:reloadData(filterList)
end

function WorldCupOddsPrizeView:_onSelectMatch(matchId)
	if self._curMatchId ~= matchId then
		self._curMatchId = matchId

		self:_refreshView()
	end
end

function WorldCupOddsPrizeView:_updateMatchCell(view, cell, data, tag)
	local go = cell.gameObject
	local txtRaceType = goutil.findChildTextComponent(go, "txtRaceType")
	local txtRaceTime = goutil.findChildTextComponent(go, "txtRaceTime")
	local raceStateChange = goutil.findChildComponent(go, "raceState", ComponentType.UIImageSpriteChange)
	local txtRaceState = goutil.findChildTextComponent(go, "raceState/txtRaceState")
	local mainTeamIcon = goutil.findChild(go, "mainTeam/icon")
	local txtMainTeamName = goutil.findChildTextComponent(go, "mainTeam/txtName")
	local txtMainTeamScore = goutil.findChildTextComponent(go, "mainTeam/txtScore")
	local awayTeamIcon = goutil.findChild(go, "visitingTeam/icon")
	local txtAwayTeamName = goutil.findChildTextComponent(go, "visitingTeam/txtName")
	local txtAwayTeamScore = goutil.findChildTextComponent(go, "visitingTeam/txtScore")
	local selectGo = goutil.findChild(go, "select")
	local btn = goutil.findChild(go, "btn")
	local stageCfg = WorldCupConfig.instance:getStageCfg(self._activityId, data.stageId)

	if data.stageId == GROUP_STAGE then
		local groupNameAttr = string.split(data.groupName, "_")

		txtRaceType.text = langPara("%s %s组", stageCfg.name, groupNameAttr[2])
	else
		txtRaceType.text = langPara("%s", stageCfg.name)
	end

	local startTime = checknumber(data.startTime) / 1000

	if startTime <= ServerTime.now() then
		if not RACE_STATE_PLAY then
			local raceState = RACE_STATE_WAIT
			local startDate = GameUtil.time2date(startTime)

			txtRaceTime.text = langPara("%02d-%02d %02d:%02d", startDate.month, startDate.day, startDate.hour, startDate.min)

			local mainTeamCfg = WorldCupConfig.instance:getTeamCfg(self._activityId, data.homeTeamId)

			if mainTeamCfg then
				uGuiUtil.setSpriteToImage(mainTeamIcon, nil, GameUrl.getShiJieBeiJingCaiIconUrl(mainTeamCfg.res))

				txtMainTeamName.text = langPara("(主)%s", WorldCupController.instance:getTeamName(mainTeamCfg))

				GameUtil.SetActive(mainTeamIcon, true)
			else
				uGuiUtil.clearImage(mainTeamIcon)
				GameUtil.SetActive(mainTeamIcon, false)

				txtMainTeamName.text = lang("待定")
			end

			local awayTeamCfg = WorldCupConfig.instance:getTeamCfg(self._activityId, data.awayTeamId)

			if awayTeamCfg then
				uGuiUtil.setSpriteToImage(awayTeamIcon, nil, GameUrl.getShiJieBeiJingCaiIconUrl(awayTeamCfg.res))

				txtAwayTeamName.text = langPara("(客)%s", WorldCupController.instance:getTeamName(awayTeamCfg))

				GameUtil.SetActive(awayTeamIcon, true)
			else
				GameUtil.SetActive(awayTeamIcon, false)
				uGuiUtil.clearImage(awayTeamIcon)

				txtAwayTeamName.text = lang("待定")
			end

			if data.result then
				raceState = RACE_STATE_END
				txtMainTeamScore.text = data.result.fullTimeHome
				txtAwayTeamScore.text = data.result.fullTimeAway
			else
				txtMainTeamScore.text = 0
				txtAwayTeamScore.text = 0
			end

			txtRaceState.text = raceState == RACE_STATE_PLAY and lang("赛中") or raceState == RACE_STATE_WAIT and lang("未赛") or lang("完赛")

			raceStateChange:SetState(raceState)
			GameUtil.SetActive(selectGo, data.matchId == self._curMatchId)
			GameUtil.addClickHandler(btn, function()
				self:_onSelectMatch(data.matchId)
			end, self)
		end
	end
end

function WorldCupOddsPrizeView:_clearMatchCell(cell)
	local go = cell.gameObject
	local btn = goutil.findChild(go, "btn")

	GameUtil.rmClickHandler(btn)
end

function WorldCupOddsPrizeView:_updatePrizeCell(view, cell, data, tag)
	local go = cell.gameObject

	MaterialMgr.setCellByCfg(data, go)
end

function WorldCupOddsPrizeView:_clearPrizeCell(cell)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
end

function WorldCupOddsPrizeView:_isOtherOddsComplete(matchInfo)
	local mainTeamGoal = matchInfo.result.fullTimeHome
	local awayTeamGoal = matchInfo.result.fullTimeAway

	for i, v in ipairs(matchInfo.odds) do
		local oddsCfg = WorldCupConfig.instance:getOddsCfg(self._activityId, v.stageId, v.defineId)

		if oddsCfg.type == ODDS_TYPE_SCORE then
			local oddScoreArr = string.split(oddsCfg.param, "-")

			if mainTeamGoal == checknumber(oddScoreArr[1]) and awayTeamGoal == checknumber(oddScoreArr[2]) then
				return false
			end
		end
	end

	return true
end

function WorldCupOddsPrizeView:_isOddsWin(matchInfo, defineId)
	local stageId = matchInfo.stageId
	local oddsCfg = WorldCupConfig.instance:getOddsCfg(self._activityId, stageId, defineId)

	if oddsCfg.type == ODDS_TYPE_SCORE then
		local oddScoreArr = string.split(oddsCfg.param, "-")

		if matchInfo.result and matchInfo.result.fullTimeHome == checknumber(oddScoreArr[1]) and matchInfo.result.fullTimeAway == checknumber(oddScoreArr[2]) then
			return true
		end
	elseif oddsCfg.type == ODDS_TYPE_MAIN_WIN then
		if matchInfo.result and matchInfo.result.fullTimeHome > matchInfo.result.fullTimeAway then
			return true
		end
	elseif oddsCfg.type == ODDS_TYPE_AWAY_WIN then
		if matchInfo.result and matchInfo.result.fullTimeHome < matchInfo.result.fullTimeAway then
			return true
		end
	elseif oddsCfg.type == ODDS_TYPE_DROW then
		if matchInfo.result and matchInfo.result.fullTimeHome == matchInfo.result.fullTimeAway then
			return true
		end
	elseif oddsCfg.type == ODDS_TYPE_OTHER_SCORE and matchInfo.result then
		return self:_isOtherOddsComplete(matchInfo)
	end
end

function WorldCupOddsPrizeView:_fillOddsOptionText(matchInfo, betInfo, txtType, txtResult)
	local stageId = matchInfo.stageId
	local oddsCfg = WorldCupConfig.instance:getOddsCfg(self._activityId, stageId, betInfo.defineId)

	if not oddsCfg then
		return
	end

	if oddsCfg.type == ODDS_TYPE_SCORE then
		txtType.text = lang("比分")

		local oddScoreArr = string.split(oddsCfg.param, "-")

		txtResult.text = string.format("%s:%s", oddScoreArr[1], oddScoreArr[2])
	elseif oddsCfg.type == ODDS_TYPE_MAIN_WIN then
		txtType.text = lang("胜负")
		txtResult.text = lang("主队<color=#FE5F5D>胜</color>")
	elseif oddsCfg.type == ODDS_TYPE_AWAY_WIN then
		txtType.text = lang("胜负")
		txtResult.text = lang("客队<color=#FE5F5D>胜</color>")
	elseif oddsCfg.type == ODDS_TYPE_DROW then
		txtType.text = lang("胜负")
		txtResult.text = lang("平局")
	elseif oddsCfg.type == ODDS_TYPE_OTHER_SCORE then
		txtType.text = lang("比分")
		txtResult.text = langPara("其他")
	end
end

function WorldCupOddsPrizeView:_updateOddsCell(view, cell, data, tag)
	local go = cell.gameObject
	local txtType = goutil.findChildTextComponent(go, "txtType")
	local txtMyScore = goutil.findChildTextComponent(go, "txtMyScore")
	local txtMyPrize = goutil.findChildTextComponent(go, "txtMyPrize")
	local txtMyFailPrize = goutil.findChildTextComponent(go, "txtMyFailPrize")
	local txtResult = goutil.findChildTextComponent(go, "result/txtResult")
	local txtOdds = goutil.findChildTextComponent(go, "result/txtOdds")
	local tagGain = goutil.findChild(go, "supportTag")
	local tagFail = goutil.findChild(go, "failTag")
	local matchInfo = WorldCupModel.instance:getMatchInfo(self._activityId, self._curMatchId)
	local myBetInfo = data.betInfo

	self:_fillOddsOptionText(matchInfo, myBetInfo, txtType, txtResult)

	local score = myBetInfo.score
	local realOdd = data.odds

	txtOdds.text = langPara("%0.2f倍", realOdd / 100)
	txtMyPrize.text = langPara("成功可得：%s", math.ceil(score * realOdd / 100))
	txtMyFailPrize.text = langPara("失败可得：%s", math.ceil(score * self._actCfg.betFailPercent / 100))
	txtMyScore.text = langPara("我的应援：%s", myBetInfo.score)

	GameUtil.SetActive(tagGain, self:_isOddsWin(matchInfo, myBetInfo.defineId) and matchInfo.result ~= nil)
	GameUtil.SetActive(tagFail, not self:_isOddsWin(matchInfo, myBetInfo.defineId) and matchInfo.result ~= nil)
end

function WorldCupOddsPrizeView:_clearOddsCell(cell)
	return
end

function WorldCupOddsPrizeView:_updateFilterCell(view, cell, data, tag)
	local go = cell.gameObject
	local txtName = goutil.findChildTextComponent(go, "txt")
	local txtMarkName = goutil.findChildTextComponent(go, "Mark/txt")
	local markGo = goutil.findChild(go, "Mark")

	if data == 0 then
		GameUtil.SetActive(markGo, self._filterStageId == nil)

		txtName.text = lang("全部")
		txtMarkName.text = lang("全部")
	else
		local stageCfg = WorldCupConfig.instance:getStageCfg(self._activityId, data)

		GameUtil.SetActive(markGo, self._filterStageId == data)

		txtName.text = stageCfg.name
		txtMarkName.text = stageCfg.name
	end

	GameUtil.addClickHandler(go, function()
		self:_onClickFilterType(data)
	end)
end

function WorldCupOddsPrizeView:_clearFilterCell(cell)
	local go = cell.gameObject

	GameUtil.rmClickHandler(go)
end

function WorldCupOddsPrizeView:_onClickFilter()
	GameUtil.SetActive(self._btnFilterClose, true)
	GameUtil.SetActive(self._content, true)
end

function WorldCupOddsPrizeView:_onClickFilterClose()
	GameUtil.SetActive(self._btnFilterClose, false)
	GameUtil.SetActive(self._content, false)
end

function WorldCupOddsPrizeView:_onClickFilterType(stageId)
	if stageId == 0 then
		self._filterStageId = nil
	else
		self._filterStageId = stageId
	end

	self:_refreshView()
end

function WorldCupOddsPrizeView:_onClickSure()
	if WorldCupController.instance:hasOddsPrize(self._activityId) == true then
		WorldCupAgent.instance:sendPM_WorldCupOneKeyGainPrizeReq(self._activityId)
	else
		FloatWordMgr.instance:show(lang("无可领取奖励"))
	end
end

return WorldCupOddsPrizeView
