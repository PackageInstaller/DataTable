-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/worldcup/view/WorldCupMainView.lua

module("logic.extensions.worldcup.view.WorldCupMainView", package.seeall)

local WorldCupMainView = class("WorldCupMainView", ViewComponent)
local RACE_STATE_WAIT = 0
local RACE_STATE_PLAY = 1
local RACE_STATE_END = 2
local GROUP_STAGE = 1
local ODDS_TYPE_MAIN_WIN = "WIN"
local ODDS_TYPE_AWAY_WIN = "LOSE"
local ODDS_TYPE_DROW = "TIE"
local ODDS_TYPE_SCORE = "SCORE"
local ODDS_TYPE_OTHER_SCORE = "OTHER_SCORE"
local SHOW_TYPE_NEXT_RACE = 1
local SHOW_TYPE_END_RACE = 2

function WorldCupMainView:ctor()
	WorldCupMainView.super.ctor(self)
end

function WorldCupMainView:unbindEvents()
	WorldCupMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnMainWin)
	GameUtil.rmClickHandler(self._btnDraw)
	GameUtil.rmClickHandler(self._btnAwayWin)
	GameUtil.rmClickHandler(self._btnSchedule)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnShop)
	GameUtil.rmClickHandler(self._btnCoinGain)
	GameUtil.rmClickHandler(self._btnRecord)
	GameUtil.rmClickHandler(self._btnGroupInfo)
	GameUtil.rmClickHandler(self._btnShowRealName)
	GameUtil.rmClickHandler(self._btnTopThree)
end

function WorldCupMainView:bindEvents()
	WorldCupMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnMainWin, self._onClickMainWin, self)
	GameUtil.addClickHandler(self._btnDraw, self._onClickDraw, self)
	GameUtil.addClickHandler(self._btnAwayWin, self._onClickAwayWin, self)
	GameUtil.addClickHandler(self._btnSchedule, self._onClickSchedule, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickRank, self)
	GameUtil.addClickHandler(self._btnShop, self._onClickShop, self)
	GameUtil.addClickHandler(self._btnCoinGain, self._onClickCoinGain, self)
	GameUtil.addClickHandler(self._btnRecord, self._onClickRecord, self)
	GameUtil.addClickHandler(self._btnGroupInfo, self._onClickGroupInfo, self)
	GameUtil.addClickHandler(self._btnShowRealName, self._onClickShowRealName, self)
	GameUtil.addClickHandler(self._btnTopThree, self._onClickTopThree, self)
	GameUtil.addClickHandler(self._btnRecent, self._onClickRecent, self)
	GameUtil.addClickHandler(self._btnEnd, self._onClickEnd, self)
end

function WorldCupMainView:buildUI()
	WorldCupMainView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._raceTableview = self:getGo("raceTableview")
	self._raceTablecell = self:getGo("raceTableview/raceTablecell")
	self._raceTableList = ScrollerList.create(self._raceTableview, self._raceTablecell, GameUtil.handler(self._updateRaceCell, self), GameUtil.handler(self._clearRaceCell, self))
	self._guessTableview = self:getGo("raceInfo/guessInfo/viewport/content/guessScore")
	self._guessTablecell = self:getGo("raceInfo/guessTablecell")
	self._goldBar = self:getGo("goldBar")
	self._btnSchedule = self:getGo("btnSchedule")
	self._btnRank = self:getGo("btnRank")
	self._btnShop = self:getGo("btnShop")
	self._btnCoinGain = self:getGo("btnCoinGain")
	self._btnRecord = self:getGo("btnRecord")
	self._btnTopThree = self:getGo("btnTopThree")

	local guessWinLoseGo = self:getGo("raceInfo/guessInfo/viewport/content/guessWinLose")

	self._txtMainWinOdds = goutil.findChildTextComponent(guessWinLoseGo, "mainTeamWin/btnMainWin/txtOdds")
	self._txtMainWinSupportCount = goutil.findChildTextComponent(guessWinLoseGo, "mainTeamWin/txtSupportCount")
	self._txtMainWin = goutil.findChildTextComponent(guessWinLoseGo, "mainTeamWin/btnMainWin/txtMainWin")
	self._txtMainWinMySupport = goutil.findChildTextComponent(guessWinLoseGo, "mainTeamWin/txtMySupport")
	self._mainWinSupporttTag = goutil.findChild(guessWinLoseGo, "mainTeamWin/supportTag")
	self._btnMainWin = goutil.findChild(guessWinLoseGo, "mainTeamWin/btnMainWin")
	self._txtDrawOdds = goutil.findChildTextComponent(guessWinLoseGo, "draw/btnDraw/txtOdds")
	self._txtDrawSupportCount = goutil.findChildTextComponent(guessWinLoseGo, "draw/txtSupportCount")
	self._txtDrawMySupport = goutil.findChildTextComponent(guessWinLoseGo, "draw/txtMySupport")
	self._drawSupporttTag = goutil.findChild(guessWinLoseGo, "draw/supportTag")
	self._btnDraw = goutil.findChild(guessWinLoseGo, "draw/btnDraw")
	self._txtAwayWin = goutil.findChildTextComponent(guessWinLoseGo, "visitingTeamWin/btnVisitingWin/txtVisitingWin")
	self._txtAwayWinSupportCount = goutil.findChildTextComponent(guessWinLoseGo, "visitingTeamWin/txtSupportCount")
	self._txtAwayWinMySupport = goutil.findChildTextComponent(guessWinLoseGo, "visitingTeamWin/txtMySupport")
	self._txtAwayWinOdds = goutil.findChildTextComponent(guessWinLoseGo, "visitingTeamWin/btnVisitingWin/txtOdds")
	self._awayWinSupporttTag = goutil.findChild(guessWinLoseGo, "visitingTeamWin/supportTag")
	self._btnAwayWin = goutil.findChild(guessWinLoseGo, "visitingTeamWin/btnVisitingWin")
	self._txtCurMainScore = self:getTxt("raceInfo/txtMainScore")
	self._txtCurRaceType = self:getTxt("raceInfo/txtRaceType")
	self._txtCurRaceTime = self:getTxt("raceInfo/txtRaceTime")
	self._txtCurAwayScore = self:getTxt("raceInfo/txtVisitingScore")
	self._curRaceState = self:getGo("raceInfo/raceState")
	self._curRaceStateChange = self._curRaceState:GetComponent(ComponentType.UIImageSpriteChange)
	self._txtCurRaceState = self:getTxt("raceInfo/raceState/txtRaceState")
	self._mainTeamIcon = self:getGo("raceInfo/mainTeam/icon")
	self._txtMainTeamName = self:getTxt("raceInfo/mainTeam/nameLayout/txtName")
	self._txtMainTeamRank = self:getTxt("raceInfo/mainTeam/txtRank")
	self._awayTeamIcon = self:getGo("raceInfo/visitingTeam/icon")
	self._txtAwayTeamRank = self:getTxt("raceInfo/visitingTeam/txtRank")
	self._txtAwayTeamName = self:getTxt("raceInfo/visitingTeam/nameLayout/txtName")
	self._redPointGainGoin = self:getGo("btnCoinGain/redPoint")
	self._redPointGainPrize = self:getGo("btnRecord/redPoint")
	self._redPointTopThree = self:getGo("btnTopThree/redPoint")
	self._btnGroupInfo = self:getGo("btnGroupInfo")
	self._btnShowRealName = self:getGo("btnShowRealName")
	self._tagShow = self:getGo("btnShowRealName/tagShow")
	self._txtTime = self:getTxt("txtOpenTime/txt")
	self._btnRecent = self:getGo("btnRecent")
	self._uiChangeGroupRecent = self._btnRecent:GetComponent(ComponentType.UIChangeGroup)
	self._btnEnd = self:getGo("btnEnd")
	self._uiChangeGroupEnd = self._btnEnd:GetComponent(ComponentType.UIChangeGroup)
end

function WorldCupMainView:onExit()
	WorldCupMainView.super.onExit(self)
	self._raceTableList:dispose()
	GameUtil.clearCells(self._guessTableview, self._clearGuessCell, self, true)
end

function WorldCupMainView:onEnter()
	WorldCupMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_WorldCupBetRes, self._refreshView, self)
	self.addGEvent(self, GlobalNotify.PM_WorldCupGetInfoRes, self._refreshView, self)
	self.addGEvent(self, GlobalNotify.PM_WorldCupGainDailyPrizeRes, self._refreshView, self)
	self.addGEvent(self, GlobalNotify.PM_WorldCupGuessTopThreeReq, self._refreshView, self)
	self.addGEvent(self, GlobalNotify.PM_WorldCupOneKeyGainPrizeRes, self._refreshView, self)
	self.addGEvent(self, GlobalNotify.WorldCup_Close_Bet_View, self._setTopGoldBar, self)
	self.addGEvent(self, GlobalNotify.PM_WorldCupGainTopThreePrizeReq, self._setTopGoldBar, self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = 602001
	end

	self._curMatchId = 0
	self._txtTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId)
	self._showType = SHOW_TYPE_END_RACE

	self:_setTopGoldBar()
	WorldCupAgent.instance:sendPM_WorldCupGetInfoReq(self._activityId)
end

function WorldCupMainView:_refreshView()
	local raceInfos = WorldCupModel.instance:getMatchList(self._activityId)
	local recentRaceList = {}

	if self._showType == SHOW_TYPE_NEXT_RACE then
		local maxCount = 10

		for i, v in ipairs(raceInfos) do
			local startTime = checknumber(v.startTime) / 1000

			if not v.result and checknumber(v.homeTeamId) > 0 and checknumber(v.awayTeamId) > 0 then
				table.insert(recentRaceList, v)
			end
		end

		table.sort(recentRaceList, function(a, b)
			return checknumber(a.startTime) < checknumber(b.startTime)
		end)

		if maxCount < #recentRaceList then
			for i = 1, #recentRaceList - maxCount do
				table.remove(recentRaceList)
			end
		end
	else
		for i, v in ipairs(raceInfos) do
			if v.result then
				table.insert(recentRaceList, v)
			end
		end

		table.sort(recentRaceList, function(a, b)
			return checknumber(a.startTime) < checknumber(b.startTime)
		end)
	end

	if self._curMatchId == 0 and #recentRaceList > 0 then
		self._curMatchId = recentRaceList[1].matchId
	end

	self._raceTableList:reloadData(recentRaceList)

	local actCfg = WorldCupConfig.instance:getActivityCfg(self._activityId)
	local startGainPrizeTime = GameUtil.string2time(actCfg.guessTopEndTime)
	local guessInfo = WorldCupModel.instance:getTopGuessInfo(self._activityId)
	local dailyPrizeCfg = WorldCupController.instance:getSignInPrize(self._activityId)
	local hasDailyPrize = not WorldCupModel.instance:isGainDailyPrize(self._activityId) and dailyPrizeCfg ~= nil

	GameUtil.SetActive(self._redPointGainGoin, hasDailyPrize)
	GameUtil.SetActive(self._redPointGainPrize, WorldCupController.instance:hasOddsPrize(self._activityId))
	GameUtil.SetActive(self._redPointTopThree, WorldCupController.instance:isCanGetGuessTopThree(self._activityId) or not ((startGainPrizeTime > ServerTime.now() and (guessInfo == nil or checknumber(guessInfo.championTeamId) <= 0 or checknumber(guessInfo.runnerUpTeamId) <= 0 or checknumber(guessInfo.thirdPlaceTeamId) <= 0) or nil) and false))
	GameUtil.SetActive(self._tagShow, WorldCupController.instance:isShowRealTeamName())
	self:_refreshCurTeamInfo()
	self:_refreshWinLoseInfo()
	self:_refreshGuessScoreInfo()
	self._uiChangeGroupRecent:SetState(self._showType == SHOW_TYPE_NEXT_RACE and 1 or 0)
	self._uiChangeGroupEnd:SetState(self._showType == SHOW_TYPE_END_RACE and 1 or 0)
end

function WorldCupMainView:_refreshCurTeamInfo()
	self._txtMainTeamRank.text = lang("")
	self._txtAwayTeamRank.text = lang("")

	if self._curMatchId == 0 then
		GameUtil.SetActive(self._mainTeamIcon, false)
		GameUtil.SetActive(self._awayTeamIcon, false)

		self._txtMainTeamName.text = lang("待定")
		self._txtAwayTeamName.text = lang("待定")
		self._txtCurMainScore.text = 0
		self._txtCurAwayScore.text = 0
		self._txtCurRaceType.text = lang("")
		self._txtCurRaceTime.text = lang("")

		GameUtil.SetActive(self._curRaceState, false)
		uGuiUtil.clearImage(self._awayTeamIcon)
		uGuiUtil.clearImage(self._mainTeamIcon)
	else
		GameUtil.SetActive(self._curRaceState, true)

		local matchInfo = WorldCupModel.instance:getMatchInfo(self._activityId, self._curMatchId)

		self._txtMainTeamName.text = lang("待定")
		self._txtAwayTeamName.text = lang("待定")

		local mainTeamCfg = WorldCupConfig.instance:getTeamCfg(self._activityId, matchInfo.homeTeamId)

		if mainTeamCfg then
			self._txtMainTeamName.text = WorldCupController.instance:getTeamName(mainTeamCfg)

			uGuiUtil.setSpriteToImage(self._mainTeamIcon, nil, GameUrl.getShiJieBeiJingCaiIconUrl(mainTeamCfg.res))
			GameUtil.SetActive(self._mainTeamIcon, true)
		else
			GameUtil.SetActive(self._mainTeamIcon, false)
			uGuiUtil.clearImage(self._mainTeamIcon)
		end

		local awayTeamCfg = WorldCupConfig.instance:getTeamCfg(self._activityId, matchInfo.awayTeamId)

		if awayTeamCfg then
			self._txtAwayTeamName.text = WorldCupController.instance:getTeamName(awayTeamCfg)

			uGuiUtil.setSpriteToImage(self._awayTeamIcon, nil, GameUrl.getShiJieBeiJingCaiIconUrl(awayTeamCfg.res))
			GameUtil.SetActive(self._awayTeamIcon, true)
		else
			GameUtil.SetActive(self._awayTeamIcon, false)
			uGuiUtil.clearImage(self._awayTeamIcon)
		end

		local stageCfg = WorldCupConfig.instance:getStageCfg(self._activityId, matchInfo.stageId)

		if matchInfo.stageId == GROUP_STAGE then
			local groupNameAttr = string.split(matchInfo.groupName, "_")

			self._txtCurRaceType.text = langPara("%s %s组", stageCfg.name, groupNameAttr[2])
		else
			self._txtCurRaceType.text = langPara("%s", stageCfg.name)
		end

		local startTime = checknumber(matchInfo.startTime) / 1000
		local startDate = GameUtil.time2date(startTime)

		self._txtCurRaceTime.text = langPara("%02d-%02d %02d:%02d", startDate.month, startDate.day, startDate.hour, startDate.min)

		if startTime <= ServerTime.now() then
			if not RACE_STATE_PLAY then
				local raceState = RACE_STATE_WAIT

				if matchInfo.result then
					raceState = RACE_STATE_END
					self._txtCurMainScore.text = matchInfo.result.fullTimeHome
					self._txtCurAwayScore.text = matchInfo.result.fullTimeAway
				else
					self._txtCurMainScore.text = 0
					self._txtCurAwayScore.text = 0
				end

				self._txtCurRaceState.text = raceState == RACE_STATE_PLAY and lang("赛中") or raceState == RACE_STATE_WAIT and lang("未赛") or lang("完赛")

				self._curRaceStateChange:SetState(raceState)
			end
		end
	end
end

function WorldCupMainView:_refreshWinLoseInfo()
	self._txtMainWin.text = lang("主场<color=#FE5F5D>胜</color>")
	self._txtMainWinOdds.text = ""
	self._txtMainWinSupportCount.text = ""
	self._txtMainWinMySupport.text = ""

	GameUtil.SetActive(self._mainWinSupporttTag, false)

	self._txtDrawOdds.text = ""
	self._txtDrawSupportCount.text = ""
	self._txtDrawMySupport.text = ""

	GameUtil.SetActive(self._drawSupporttTag, false)

	self._txtAwayWin.text = lang("客场<color=#FE5F5D>胜</color>")
	self._txtAwayWinOdds.text = ""
	self._txtAwayWinSupportCount.text = ""
	self._txtAwayWinMySupport.text = ""

	GameUtil.SetActive(self._awayWinSupporttTag, false)

	if self._curMatchId ~= 0 then
		local matchInfo = WorldCupModel.instance:getMatchInfo(self._activityId, self._curMatchId)

		for i, v in ipairs(matchInfo.odds or {}) do
			local oddsCfg = WorldCupConfig.instance:getOddsCfg(self._activityId, v.stageId, v.defineId)
			local myBetInfo = WorldCupModel.instance:getBetInfo(self._activityId, self._curMatchId, v.defineId)

			if oddsCfg.type == ODDS_TYPE_MAIN_WIN then
				self._txtMainWinOdds.text = langPara("%0.2f倍", checknumber(v.odds) / 100)
				self._txtMainWinSupportCount.text = langPara("当前应援人数：%s", checknumber(v.hot))

				if myBetInfo then
					self._txtMainWinMySupport.text = langPara("我的应援：%s", myBetInfo.score)

					GameUtil.SetActive(self._mainWinSupporttTag, true)
				end
			elseif oddsCfg.type == ODDS_TYPE_AWAY_WIN then
				self._txtAwayWinOdds.text = langPara("%0.2f倍", checknumber(v.odds) / 100)
				self._txtDrawSupportCount.text = langPara("当前应援人数：%s", checknumber(v.hot))

				if myBetInfo then
					self._txtAwayWinMySupport.text = langPara("我的应援：%s", myBetInfo.score)

					GameUtil.SetActive(self._awayWinSupporttTag, true)
				end
			elseif oddsCfg.type == ODDS_TYPE_DROW then
				self._txtDrawOdds.text = langPara("%0.2f倍", checknumber(v.odds) / 100)
				self._txtAwayWinSupportCount.text = langPara("当前应援人数：%s", checknumber(v.hot))

				if myBetInfo then
					self._txtDrawMySupport.text = langPara("我的应援：%s", myBetInfo.score)

					GameUtil.SetActive(self._drawSupporttTag, true)
				end
			end
		end

		local startTime = checknumber(matchInfo.startTime) / 1000
		local isMatchStart = startTime <= ServerTime.now() or matchInfo.result ~= nil

		GameUtil.SetGray(self._btnMainWin, isMatchStart)
		GameUtil.SetGray(self._btnDraw, isMatchStart)
		GameUtil.SetGray(self._btnAwayWin, isMatchStart)
	else
		GameUtil.SetGray(self._btnMainWin, true)
		GameUtil.SetGray(self._btnDraw, true)
		GameUtil.SetGray(self._btnAwayWin, true)
	end
end

function WorldCupMainView:_refreshGuessScoreInfo()
	if self._curMatchId ~= 0 then
		local list2 = {}
		local matchInfo = WorldCupModel.instance:getMatchInfo(self._activityId, self._curMatchId)

		for i, v in ipairs(matchInfo.odds or {}) do
			local oddsCfg = WorldCupConfig.instance:getOddsCfg(self._activityId, v.stageId, v.defineId)

			if oddsCfg.type == ODDS_TYPE_SCORE or oddsCfg.type == ODDS_TYPE_OTHER_SCORE then
				table.insert(list2, v)
			end
		end

		GameUtil.updateCellsList(self._guessTableview, self._guessTablecell, list2, self._updateGuessCell, self)
	else
		local list2 = {}

		GameUtil.updateCellsList(self._guessTableview, self._guessTablecell, list2, self._updateGuessCell, self)
	end
end

function WorldCupMainView:_isCurMatChInfoDone()
	if self._curMatchId == 0 then
		return false
	end

	local matchInfo = WorldCupModel.instance:getMatchInfo(self._activityId, self._curMatchId)
	local mainTeamCfg = WorldCupConfig.instance:getTeamCfg(self._activityId, matchInfo.homeTeamId)

	if not mainTeamCfg then
		return false
	end

	local awayTeamCfg = WorldCupConfig.instance:getTeamCfg(self._activityId, matchInfo.awayTeamId)

	if not awayTeamCfg then
		return false
	end

	return true
end

function WorldCupMainView:_updateRaceCell(view, cell, data, tag)
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

				local teamName = WorldCupController.instance:getTeamName(mainTeamCfg)

				txtMainTeamName.text = langPara("%s", teamName)

				GameUtil.SetActive(mainTeamIcon, true)
			else
				uGuiUtil.clearImage(mainTeamIcon)
				GameUtil.SetActive(mainTeamIcon, false)

				txtMainTeamName.text = lang("待定")
			end

			local awayTeamCfg = WorldCupConfig.instance:getTeamCfg(self._activityId, data.awayTeamId)

			if awayTeamCfg then
				uGuiUtil.setSpriteToImage(awayTeamIcon, nil, GameUrl.getShiJieBeiJingCaiIconUrl(awayTeamCfg.res))

				local teamName = WorldCupController.instance:getTeamName(awayTeamCfg)

				txtAwayTeamName.text = langPara("%s", teamName)

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
				self:_onClickMatch(data.matchId)
			end, self)
		end
	end
end

function WorldCupMainView:_clearRaceCell(cell)
	local go = cell.gameObject
	local btn = goutil.findChild(go, "btn")

	GameUtil.rmClickHandler(btn)
end

function WorldCupMainView:_updateGuessCell(cell, data, index)
	local go = cell.gameObject
	local btn = goutil.findChild(go, "btnSupport")
	local txtScore = goutil.findChildTextComponent(btn, "txtScore")
	local txtOdds = goutil.findChildTextComponent(btn, "txtOdds")
	local txtSupportCount = goutil.findChildTextComponent(go, "txtSupportCount")
	local txtMySupport = goutil.findChildTextComponent(go, "txtMySupport")
	local supportTag = goutil.findChild(go, "supportTag")
	local oddsCfg = WorldCupConfig.instance:getOddsCfg(self._activityId, data.stageId, data.defineId)
	local myBetInfo = WorldCupModel.instance:getBetInfo(self._activityId, self._curMatchId, data.defineId)
	local oddScoreArr = string.split(oddsCfg.param, "-")

	txtScore.text = oddsCfg.type == ODDS_TYPE_OTHER_SCORE and lang("其他") or string.format("%s:%s", oddScoreArr[1], oddScoreArr[2])
	txtOdds.text = langPara("%0.2f倍", checknumber(data.odds) / 100)
	txtSupportCount.text = langPara("当前应援人数：%s", checknumber(data.hot))

	if myBetInfo then
		txtMySupport.text = langPara("我的应援：%s", myBetInfo.score)

		GameUtil.SetActive(supportTag, true)
	else
		txtMySupport.text = ""

		GameUtil.SetActive(supportTag, false)
	end

	GameUtil.addClickHandler(btn, function()
		self:_onClickOdds(data)
	end)

	local matchInfo = WorldCupModel.instance:getMatchInfo(self._activityId, self._curMatchId)
	local startTime = checknumber(matchInfo.startTime) / 1000

	GameUtil.SetGray(btn, startTime <= ServerTime.now() or matchInfo.result ~= nil)
end

function WorldCupMainView:_clearGuessCell(cell)
	local go = cell.gameObject
	local btn = goutil.findChild(go, "btnSupport")

	GameUtil.rmClickHandler(btn)
end

function WorldCupMainView:_setTopGoldBar()
	local btn_list = {}
	local actCfg = WorldCupConfig.instance:getActivityCfg(self._activityId)
	local itemArry = string.split(actCfg.betItemKey, "#")

	for i, v in ipairs(itemArry) do
		table.insert(btn_list, {
			showAdd = false,
			id = v
		})
	end

	MainUIController.instance:showGlodBar(self._goldBar, self._viewPresentor, btn_list, false)
end

function WorldCupMainView:_onClickTip()
	TipsFacade.instance:openRulesView("world_cap_ruld")
end

function WorldCupMainView:_onClickMainWin()
	if checknumber(self._curMatchId) == 0 then
		FloatWordMgr.instance:show(lang("未选中比赛"))

		return
	end

	local matchInfo = WorldCupModel.instance:getMatchInfo(self._activityId, self._curMatchId)
	local startTime = checknumber(matchInfo.startTime) / 1000

	if self:_isCurMatChInfoDone() == true and startTime > ServerTime.now() and matchInfo.result == nil then
		for i, v in ipairs(matchInfo.odds or {}) do
			local oddsCfg = WorldCupConfig.instance:getOddsCfg(self._activityId, v.stageId, v.defineId)

			if oddsCfg.type == ODDS_TYPE_MAIN_WIN then
				self:_onClickOdds(v)

				break
			end
		end
	else
		FloatWordMgr.instance:show(lang("已完赛和进行中的赛事不可应援"))
	end
end

function WorldCupMainView:_onClickDraw()
	if checknumber(self._curMatchId) == 0 then
		FloatWordMgr.instance:show(lang("未选中比赛"))

		return
	end

	local matchInfo = WorldCupModel.instance:getMatchInfo(self._activityId, self._curMatchId)
	local startTime = checknumber(matchInfo.startTime) / 1000

	if self:_isCurMatChInfoDone() == true and startTime > ServerTime.now() and matchInfo.result == nil then
		for i, v in ipairs(matchInfo.odds or {}) do
			local oddsCfg = WorldCupConfig.instance:getOddsCfg(self._activityId, v.stageId, v.defineId)

			if oddsCfg.type == ODDS_TYPE_DROW then
				self:_onClickOdds(v)

				break
			end
		end
	else
		FloatWordMgr.instance:show(lang("已完赛和进行中的赛事不可应援"))
	end
end

function WorldCupMainView:_onClickAwayWin()
	if checknumber(self._curMatchId) == 0 then
		FloatWordMgr.instance:show(lang("未选中比赛"))

		return
	end

	local matchInfo = WorldCupModel.instance:getMatchInfo(self._activityId, self._curMatchId)
	local startTime = checknumber(matchInfo.startTime) / 1000

	if self:_isCurMatChInfoDone() == true and startTime > ServerTime.now() and matchInfo.result == nil then
		for i, v in ipairs(matchInfo.odds or {}) do
			local oddsCfg = WorldCupConfig.instance:getOddsCfg(self._activityId, v.stageId, v.defineId)

			if oddsCfg.type == ODDS_TYPE_AWAY_WIN then
				self:_onClickOdds(v)

				break
			end
		end
	else
		FloatWordMgr.instance:show(lang("已完赛和进行中的赛事不可应援"))
	end
end

function WorldCupMainView:_onClickSchedule()
	UIStateManager.instance:push(ViewName.WorldCupAllMatchView, self._activityId)
end

function WorldCupMainView:_onClickRank()
	UIStateManager.instance:push(ViewName.WorldCupRankView, self._activityId)
end

function WorldCupMainView:_onClickShop()
	local actCfg = WorldCupConfig.instance:getActivityCfg(self._activityId)

	GotoMgr.gotoByString(actCfg.jumpToShop)
end

function WorldCupMainView:_onClickGroupInfo()
	UIStateManager.instance:push(ViewName.WorldCupGroupInfoView, self._activityId)
end

function WorldCupMainView:_onClickCoinGain()
	local prizeCfg = WorldCupController.instance:getSignInPrize(self._activityId)

	if not prizeCfg then
		FloatWordMgr.instance:show(lang("已无可领取应援币"))
	elseif WorldCupModel.instance:isGainDailyPrize(self._activityId) then
		FloatWordMgr.instance:show(lang("今日已领取"))
	else
		UIStateManager.instance:push(ViewName.WorldCupDailyPrizeView, self._activityId)
	end
end

function WorldCupMainView:_onClickRecord()
	UIStateManager.instance:push(ViewName.WorldCupOddsPrizeView, self._activityId)
end

function WorldCupMainView:_onClickMatch(matchId)
	if self._curMatchId ~= matchId then
		self._curMatchId = matchId

		self:_refreshView()
	end
end

function WorldCupMainView:_onClickOdds(oddsData)
	if checknumber(self._curMatchId) == 0 then
		FloatWordMgr.instance:show(lang("未选中比赛"))

		return
	end

	local matchInfo = WorldCupModel.instance:getMatchInfo(self._activityId, self._curMatchId)
	local stageCfg = WorldCupConfig.instance:getStageCfg(self._activityId, matchInfo.stageId)
	local stageBetStartTime = GameUtil.string2time(stageCfg.betTime)

	if stageBetStartTime > ServerTime.now() then
		local betDate = GameUtil.string2date(stageCfg.betTime)
		local content = langPara("%02d.%02d %02d:%02d 开启应援", betDate.month, betDate.day, betDate.hour, betDate.min)

		FloatWordMgr.instance:show(content)

		return
	end

	local startTime = checknumber(matchInfo.startTime) / 1000

	if self:_isCurMatChInfoDone() == true and startTime > ServerTime.now() and matchInfo.result == nil then
		UIStateManager.instance:push(ViewName.WorldCupBetView, self._activityId, self._curMatchId, oddsData)
	else
		FloatWordMgr.instance:show(lang("已完赛和进行中的赛事不可应援"))
	end
end

function WorldCupMainView:_onClickShowRealName()
	local isShow = WorldCupController.instance:isShowRealTeamName()

	WorldCupController.instance:setShowRealTeamName(not isShow)
	self:_refreshView()
end

function WorldCupMainView:_onClickTopThree()
	UIStateManager.instance:push(ViewName.WorldCupTopThreeView, self._activityId)
end

function WorldCupMainView:_onClickRecent()
	if self._showType ~= SHOW_TYPE_NEXT_RACE then
		self._showType = SHOW_TYPE_NEXT_RACE
		self._curMatchId = 0

		self:_refreshView()
	end
end

function WorldCupMainView:_onClickEnd()
	if self._showType ~= SHOW_TYPE_END_RACE then
		self._showType = SHOW_TYPE_END_RACE
		self._curMatchId = 0

		self:_refreshView()
	end
end

return WorldCupMainView
