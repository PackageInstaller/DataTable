-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/youtharenathird/view/YouthArenaThirdMainView.lua

module("logic.extensions.youtharenathird.view.YouthArenaThirdMainView", package.seeall)

local YouthArenaThirdMainView = class("YouthArenaThirdMainView", ViewComponent)

function YouthArenaThirdMainView:ctor()
	YouthArenaThirdMainView.super.ctor(self)
end

function YouthArenaThirdMainView:buildUI()
	YouthArenaThirdMainView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/txtTitle/btnTip")
	self._txtTitle = self:getTxt("leftTop/txtTitle")
	self._contentRoot = self:getGo("contentRoot")
	self._btnRank = self:getGo("btns/btnRank")
	self._btnRankPrize = self:getGo("btns/btnRankPrize")
	self._btnShop = self:getGo("btns/btnShop")
	self._tabScrollerList = ScrollerList.create(self:getGo("tabCol/scrView"), self:getGo("tabCol/scrCell"), GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))
end

function YouthArenaThirdMainView:bindEvents()
	YouthArenaThirdMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickBtnRank, self)
	GameUtil.addClickHandler(self._btnRankPrize, self._onClickBtnRankPrize, self)
	GameUtil.addClickHandler(self._btnShop, self._onClickBtnShop, self)
end

function YouthArenaThirdMainView:unbindEvents()
	YouthArenaThirdMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnRankPrize)
	GameUtil.rmClickHandler(self._btnShop)
end

function YouthArenaThirdMainView:onEnter()
	YouthArenaThirdMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.HandlePM_YoungArenaKingS3GetInfoRes, self._handleGetInfoRefresh, self)
	self.addGEvent(self, GlobalNotify.HandlePM_YoungArenaKingS3NotifyStepChangeRes, self._handleStepChange, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = YouthArenaThirdController.instance:getActivityId()
	end

	self._pendingOpenTabKey = params[2]

	if self._pendingOpenTabKey == YouthArenaThirdEnum.TabKey.Fun then
		self._pendingOpenTabKey = YouthArenaThirdEnum.TabKey.Qualifier
	end

	self._shouldRecommendTabOnGetInfo = string.nilorempty(self._pendingOpenTabKey)
	self._lastSelectedTabKey = self._pendingOpenTabKey or self._lastSelectedTabKey or self._curTabKey
	self._curTabKey = self._lastSelectedTabKey
	self._actData = YouthArenaThirdConfig.instance:getActivityData(self._activityId)

	if YouthArenaThirdController.instance:trySwitchToDisplayViewFromMain(self._activityId) then
		return
	end

	self:_refreshView()
	self:_startTimeStateTimer()
	self:_sendGetInfoReq()
end

function YouthArenaThirdMainView:onExit()
	YouthArenaThirdMainView.super.onExit(self)
	self:_clearPendingTabSelection()
	self:_stopTimeStateTimer()

	if self._tabScrollerList then
		self._tabScrollerList:dispose()
	end
end

function YouthArenaThirdMainView:_handleGetInfoRefresh()
	self:_refreshView(true)
end

function YouthArenaThirdMainView:_refreshView(isGetInfoRefresh)
	self._tabDataList = self:_buildTabDataList()

	local hasPendingSelection = self:_hasPendingTabSelection()
	local shouldCommitSelection = false
	local targetTabKey = self._curTabKey

	if isGetInfoRefresh and hasPendingSelection then
		targetTabKey = self:_isTabSelectable(self._pendingOpenTabKey) and self._pendingOpenTabKey or self:_getBestAutoTabKey()
		shouldCommitSelection = true

		self:_clearPendingTabSelection()
	elseif not self:_isTabSelectable(targetTabKey) then
		targetTabKey = self:_isTabSelectable(self._pendingOpenTabKey) and self._pendingOpenTabKey or self:_getBestAutoTabKey()
		shouldCommitSelection = not hasPendingSelection
	end

	local targetTabData = self:_getTabDataByKey(targetTabKey)

	if shouldCommitSelection then
		self:_applyTabData(targetTabData)
	else
		self._curTabKey = targetTabKey
	end

	self:_refreshTabList()
	self:_showTabAt(targetTabData)
end

function YouthArenaThirdMainView:_handleStepChange(activityId, stepId)
	if checknumber(activityId) ~= checknumber(self._activityId) then
		return
	end

	if YouthArenaThirdController.instance:trySwitchToDisplayViewFromMain(self._activityId) then
		return
	end

	YouthArenaThirdController.instance:requestGetInfoForStepChange(activityId, stepId)
end

function YouthArenaThirdMainView:_sendGetInfoReq()
	if checknumber(self._activityId) <= 0 then
		return
	end

	YouthArenaThirdController.instance:sendPM_YoungArenaKingS3GetInfoReq(self._activityId)
end

function YouthArenaThirdMainView:_buildTabDataList()
	local list = {}
	local championScoreStartStepId = YouthArenaThirdController.instance:getChampionScoreMatchStartStepId(self._activityId)
	local displayStartStepId = YouthArenaThirdController.instance:getDisplayStartStepId(self._activityId)

	if championScoreStartStepId > 0 then
		if not YouthArenaThirdEnum.TimeStepId.KnockoutStart then
			local championKnockoutStartStepId = 0
			local championScoreTabStartStepId = displayStartStepId > 0 and championScoreStartStepId or 0

			table.insert(list, self:_buildMatchTabData(YouthArenaThirdEnum.TabKey.Qualifier, YouthArenaThirdEnum.MatchStepId.Qualifier, YouthArenaThirdEnum.TimeStepId.QualifierStart, nil, ViewName.YouthArenaThirdMatchTabView))
			table.insert(list, self:_buildMatchTabData(YouthArenaThirdEnum.TabKey.ScoreMatch, YouthArenaThirdEnum.MatchStepId.ScoreMatch, YouthArenaThirdEnum.TimeStepId.ScoreMatchStart, YouthArenaThirdEnum.TimeStepId.KnockoutStart, ViewName.YouthArenaThirdMatchTabView))
			table.insert(list, self:_buildChampionRaceTabData(YouthArenaThirdEnum.TabKey.ChampionKnockout, "冠军淘汰赛", championKnockoutStartStepId, championScoreStartStepId))
			table.insert(list, self:_buildChampionRaceTabData(YouthArenaThirdEnum.TabKey.ChampionScoreMatch, "冠军积分赛", championScoreTabStartStepId, displayStartStepId))
			self:_decorateTabDataList(list)

			return list
		end
	end
end

function YouthArenaThirdMainView:_buildMatchTabData(key, matchStepId, startStepId, endStepId, viewName)
	local cfg = YouthArenaThirdConfig.instance:getMatchData(self._activityId, matchStepId)
	local stepCfg = YouthArenaThirdConfig.instance:getStepData(self._activityId, startStepId)
	local startStamp = self:_getTimeStamp(stepCfg and stepCfg.startTime)

	return {
		key = key,
		name = cfg.stepName,
		matchStepId = matchStepId,
		startStepId = startStepId,
		endStepId = endStepId,
		viewName = viewName,
		startStamp = startStamp,
		state = self:_getTimeTabState(startStepId, endStepId)
	}
end

function YouthArenaThirdMainView:_buildChampionRaceTabData(key, name, startStepId, endStepId)
	local stepCfg = YouthArenaThirdConfig.instance:getStepData(self._activityId, startStepId)
	local startStamp = self:_getTimeStamp(stepCfg and stepCfg.startTime)

	return {
		key = key,
		name = name,
		startStepId = startStepId,
		endStepId = endStepId,
		viewName = ViewName.YouthArenaThirdChampionRaceTabView,
		startStamp = startStamp,
		state = self:_getTimeTabState(startStepId, endStepId)
	}
end

function YouthArenaThirdMainView:_getTimeTabState(startStepId, endStepId)
	if checknumber(startStepId) <= 0 then
		return YouthArenaThirdEnum.TabState.Lock
	end

	if self:_isTimeStepLocked(startStepId) then
		return YouthArenaThirdEnum.TabState.Lock
	end

	if checknumber(endStepId) > 0 and self:_isTimeStepEnd(endStepId) then
		return YouthArenaThirdEnum.TabState.End
	end

	return YouthArenaThirdEnum.TabState.Open
end

function YouthArenaThirdMainView:_isTimeStepLocked(timeStepId)
	if checknumber(timeStepId) <= 0 then
		return true
	end

	local stepCfg = YouthArenaThirdConfig.instance:getStepData(self._activityId, timeStepId)
	local startStamp = self:_getTimeStamp(stepCfg and stepCfg.startTime)

	return startStamp > 0 and startStamp > ServerTime.now()
end

function YouthArenaThirdMainView:_isTimeStepEnd(timeStepId)
	local nextStepCfg = YouthArenaThirdConfig.instance:getStepData(self._activityId, timeStepId)
	local nextStartStamp = self:_getTimeStamp(nextStepCfg and nextStepCfg.startTime)

	return nextStartStamp > 0 and nextStartStamp <= ServerTime.now()
end

function YouthArenaThirdMainView:_updateTabCell(view, cell, data, tag)
	if not cell.gameObject then
		local go = cell
		local txtName = goutil.findChildTextComponent(go, "txtName")
		local redPoint = goutil.findChild(go, "redpoint")
		local tagSelect = goutil.findChild(go, "tagSelect")
		local tagLock = goutil.findChild(go, "tagLock")
		local tagEnd = goutil.findChild(go, "tagEnd")
		local tagIn = goutil.findChild(go, "tagIn")
		local tagOut = goutil.findChild(go, "tagOut")
		local tagOpen = goutil.findChild(go, "tagOpen")
		local txtIn = goutil.findChildTextComponent(go, "tagIn/txt")
		local txtTime = goutil.findChildTextComponent(go, "tagLock/txtTime")
		local icon = goutil.findChild(go, "icon")

		GameUtil.rmClickHandler(go)

		txtName.text = data.name
		txtIn.text = data.key == YouthArenaThirdEnum.TabKey.ChampionScoreMatch and "已完赛" or "晋级"
		txtTime.text = self:_formatOpenTime(data.startStamp)

		GameUtil.SetActive(redPoint, false)
		GameUtil.SetActive(tagSelect, data.key == self._curTabKey)
		GameUtil.SetActive(tagLock, data.state == YouthArenaThirdEnum.TabState.Lock)
		GameUtil.SetActive(tagEnd, data.state == YouthArenaThirdEnum.TabState.End)
		GameUtil.SetActive(tagOpen, data.state == YouthArenaThirdEnum.TabState.Open)
		GameUtil.SetActive(tagIn, data.promotionState == YouthArenaThirdEnum.TabPromotionState.In)
		GameUtil.SetActive(tagOut, data.promotionState == YouthArenaThirdEnum.TabPromotionState.Out)
		GameUtil.setUIGroupIdx(icon, (data.key == YouthArenaThirdEnum.TabKey.ChampionKnockout or data.key == YouthArenaThirdEnum.TabKey.ChampionScoreMatch or nil) and 1)
		GameUtil.addClickHandler(go, GameUtil.handler(self._onClickTab, self, data))
	end
end

function YouthArenaThirdMainView:_clearTabCell(cell)
	if not cell.gameObject then
		GameUtil.rmClickHandler(cell.gameObject)
	end
end

function YouthArenaThirdMainView:_onClickTab(data)
	if data.state == YouthArenaThirdEnum.TabState.Lock then
		self:_showTabDenyTips(data)

		return
	end

	if not self:_canEnterTab(data) then
		self:_showTabDenyTips(data)

		return
	end

	self:_clearPendingTabSelection()
	self:_selectTab(data)
end

function YouthArenaThirdMainView:_showTabDenyTips(data)
	if data and data.state == YouthArenaThirdEnum.TabState.Lock then
		FloatWordMgr.instance:show(langPara("赛事将于%s开启", self:_formatDenyTime(data.startStamp)))

		return
	end

	if data and data.state == YouthArenaThirdEnum.TabState.End then
		FloatWordMgr.instance:show(lang("赛事已结束"))

		return
	end

	FloatWordMgr.instance:show(self:_getTabDenyTips(data))
end

function YouthArenaThirdMainView:_selectTab(data)
	if not self:_canEnterTab(data) then
		return
	end

	self:_applyTabData(data)
	self:_refreshTabList()
	self:_showTabAt(data)
end

function YouthArenaThirdMainView:_applyTabData(data)
	self._curTabKey = data and data.key
	self._lastSelectedTabKey = self._curTabKey

	self:_syncSelectedTabParam()
end

function YouthArenaThirdMainView:_refreshTabList()
	self._tabScrollerList:reloadData(self._tabDataList)
end

function YouthArenaThirdMainView:_showTabAt(data)
	if self._curStageData then
		if self._curStageData then
			local lastViewName = self._curStageData.viewName

			self._curStageData = data

			if data then
				if not data.viewName then
					local viewName = ""

					if not string.nilorempty(viewName) and lastViewName == viewName and self._curStageData ~= data.key then
						self:showTabAt(self._contentRoot, "")
					end

					self:showTabAt(self._contentRoot, viewName, self._activityId, data)
				end
			end
		end
	end
end

function YouthArenaThirdMainView:_isTabSelectable(key)
	if string.nilorempty(key) then
		return false
	end

	local data = self:_getTabDataByKey(key)

	return self:_canEnterTab(data)
end

function YouthArenaThirdMainView:_getBestAutoTabKey()
	local tabKey = YouthArenaThirdEnum.TabKey
	local preferList = {
		tabKey.ChampionScoreMatch,
		tabKey.ChampionKnockout,
		tabKey.ScoreMatch,
		tabKey.Qualifier
	}

	for _, key in ipairs(preferList) do
		if self:_isTabSelectable(key) then
			return key
		end
	end

	return self:_getFirstEnterableTabKey()
end

function YouthArenaThirdMainView:_getFirstEnterableTabKey()
	for _, data in ipairs(self._tabDataList or {}) do
		if self:_canEnterTab(data) then
			return data.key
		end
	end
end

function YouthArenaThirdMainView:_hasPendingTabSelection()
	return self._shouldRecommendTabOnGetInfo == true or not string.nilorempty(self._pendingOpenTabKey)
end

function YouthArenaThirdMainView:_clearPendingTabSelection()
	self._pendingOpenTabKey = nil
	self._shouldRecommendTabOnGetInfo = false
end

function YouthArenaThirdMainView:_getTabDataByKey(key)
	for _, data in ipairs(self._tabDataList or {}) do
		if data.key == key then
			return data
		end
	end
end

function YouthArenaThirdMainView:_decorateTabDataList(list)
	for _, data in ipairs(list or {}) do
		data.promotionState = self:_getTabPromotionState(data.key)
		data.canEnter = self:_getTabCanEnter(data)
	end
end

function YouthArenaThirdMainView:_canEnterTab(data)
	return data and data.canEnter == true
end

function YouthArenaThirdMainView:_getTabCanEnter(data)
	if not data or data.state == YouthArenaThirdEnum.TabState.Lock then
		return false
	end

	if not self:_isPlayerQualifiedTab(data.key) then
		return false
	end

	if data.state == YouthArenaThirdEnum.TabState.Open then
		return true
	end

	if data.state == YouthArenaThirdEnum.TabState.End then
		return data.key == YouthArenaThirdEnum.TabKey.ChampionKnockout or data.key == YouthArenaThirdEnum.TabKey.ChampionScoreMatch
	end

	return false
end

function YouthArenaThirdMainView:_isPlayerQualifiedTab(key)
	if key ~= YouthArenaThirdEnum.TabKey.ScoreMatch then
		return true
	end

	local roundTypeMap = self:_getTabRoundTypeMap(key)

	if roundTypeMap then
		return self:_isPlayerQualifiedStage(roundTypeMap)
	end

	return true
end

function YouthArenaThirdMainView:_getTabPromotionState(key)
	local promotionState = YouthArenaThirdEnum.TabPromotionState

	if self:_isPlayerRoundUnknown() then
		return promotionState.None
	end

	if key == YouthArenaThirdEnum.TabKey.Qualifier and not self:_isTimeStepEnd(YouthArenaThirdEnum.TimeStepId.ScoreMatchStart) then
		return promotionState.None
	end

	local roundTypeMap = self:_getTabRoundTypeMap(key)

	if not roundTypeMap then
		return promotionState.None
	end

	local minRoundId, maxRoundId = self:_getRoundIdRangeByTypes(roundTypeMap)
	local playerRoundId = self:_getPlayerRoundId()
	local curRoundId = self:_getCurRoundId()

	if minRoundId <= 0 or maxRoundId <= 0 or playerRoundId <= 0 or curRoundId <= 0 then
		return promotionState.None
	end

	if maxRoundId < playerRoundId then
		return promotionState.In
	end

	if key == YouthArenaThirdEnum.TabKey.ChampionScoreMatch and playerRoundId == maxRoundId and maxRoundId < curRoundId then
		return promotionState.In
	end

	if minRoundId <= playerRoundId and playerRoundId <= maxRoundId and playerRoundId < curRoundId then
		return promotionState.Out
	end

	return promotionState.None
end

function YouthArenaThirdMainView:_getTabRoundTypeMap(key)
	local tabKey = YouthArenaThirdEnum.TabKey
	local roundType = YouthArenaThirdEnum.RoundType

	if key == tabKey.Qualifier then
		return {
			[roundType.Qualify] = true
		}
	end

	if key == tabKey.ScoreMatch then
		return {
			[roundType.ScoreMatch] = true
		}
	end

	if key == tabKey.ChampionKnockout then
		return {
			[roundType.CommonKnockout] = true,
			[roundType.Top16Knockout] = true
		}
	end

	if key == tabKey.ChampionScoreMatch then
		return YouthArenaThirdEnum.ChampionScoreRoundTypeMap
	end
end

function YouthArenaThirdMainView:_isPlayerQualifiedStage(roundTypeMap)
	if self:_isPlayerRoundUnknown() then
		return false
	end

	local minRoundId = self:_getRoundIdRangeByTypes(roundTypeMap)

	if checknumber(minRoundId) <= 0 then
		return false
	end

	return minRoundId <= self:_getPlayerRoundId()
end

function YouthArenaThirdMainView:_isPlayerRoundUnknown()
	local subMo = self:_getSubMo()

	return checknumber(subMo and subMo:getCurStepId()) <= 0
end

function YouthArenaThirdMainView:_getPlayerRoundId()
	local subMo = self:_getSubMo()

	return checknumber(subMo and subMo:getPlayerRoundId())
end

function YouthArenaThirdMainView:_getCurRoundId()
	local subMo = self:_getSubMo()
	local curStepId = checknumber(subMo and subMo:getCurStepId())
	local stepData = YouthArenaThirdConfig.instance:getStepData(self._activityId, curStepId)

	return checknumber(stepData and stepData.roundId)
end

function YouthArenaThirdMainView:_getSubMo()
	if checknumber(self._activityId) <= 0 then
		return nil
	end

	return YouthArenaThirdController.instance:getSubMo(self._activityId)
end

function YouthArenaThirdMainView:_getRoundIdRangeByTypes(roundTypeMap)
	local minRoundId = 0
	local maxRoundId = 0
	local validTypeMap = roundTypeMap or {}

	for _, roundData in pairs(YouthArenaThirdConfig.instance:getRoundDatas(self._activityId) or {}) do
		if validTypeMap[roundData.roundType] == true then
			local roundId = checknumber(roundData.roundId)

			if roundId > 0 then
				minRoundId = minRoundId <= 0 and roundId or math.min(minRoundId, roundId)
				maxRoundId = math.max(maxRoundId, roundId)
			end
		end
	end

	return minRoundId, maxRoundId
end

function YouthArenaThirdMainView:_getTabDenyTips(data)
	if not data then
		return "当前赛事暂不可进入"
	end

	if self:_isPlayerRoundUnknown() then
		return "赛事信息同步中，请稍后再试"
	end

	if data.key == YouthArenaThirdEnum.TabKey.ScoreMatch then
		return "很遗憾，你未晋级战区积分赛"
	end

	return "当前赛事暂不可进入"
end

function YouthArenaThirdMainView:_syncSelectedTabParam()
	if string.nilorempty(self._curTabKey) or checknumber(self._activityId) <= 0 then
		return
	end

	UIStateManager.instance:updateParms(ViewName.YouthArenaThirdMainView, {
		self._activityId,
		self._curTabKey
	})
end

function YouthArenaThirdMainView:_onClickTip()
	if self._actData then
		if string.nilorempty(self._actData) then
			return
		end

		TipsFacade.instance:openRulesView(self._actData)
	end
end

function YouthArenaThirdMainView:_onClickBtnRank()
	local rankStage = YouthArenaThirdController.instance:getRankStageByTabKey(self._curTabKey)

	YouthArenaThirdController.instance:openRankView(self._activityId, rankStage, YouthArenaThirdEnum.RankType.PlayerScore)
end

function YouthArenaThirdMainView:_onClickClose()
	self._lastSelectedTabKey = nil
	self._curTabKey = nil

	self:_clearPendingTabSelection()
	self:close()
end

function YouthArenaThirdMainView:_onClickBtnRankPrize()
	UIStateManager.instance:push(ViewName.YouthArenaThirdRankPrizeView, self._activityId)
end

function YouthArenaThirdMainView:_onClickBtnShop()
	if self._actData then
		if not string.nilorempty(self._actData) then
			GotoMgr.gotoByString(self._actData)
		end
	end
end

function YouthArenaThirdMainView:_startTimeStateTimer()
	self:_stopTimeStateTimer()
	settimer(1, self._onTimeStateTimer, self)
end

function YouthArenaThirdMainView:_stopTimeStateTimer()
	removetimer(self._onTimeStateTimer, self)
end

function YouthArenaThirdMainView:_onTimeStateTimer()
	if YouthArenaThirdController.instance:trySwitchToDisplayViewFromMain(self._activityId) then
		self:_stopTimeStateTimer()

		return
	end

	for _, data in ipairs(self._tabDataList or {}) do
		local latestState = self:_getTimeTabState(data.startStepId, data.endStepId)

		if data.state ~= latestState then
			self:_refreshView()

			return
		end
	end
end

function YouthArenaThirdMainView:_getTimeStamp(timeStr)
	if string.nilorempty(timeStr) then
		return 0
	end

	return GameUtil.string2time(timeStr)
end

function YouthArenaThirdMainView:_formatOpenTime(stamp)
	local date = GameUtil.time2date(checknumber(stamp))

	return langPara("%s.%02d %02d:%02d 开启", date.month, date.day, date.hour, date.min)
end

function YouthArenaThirdMainView:_formatDenyTime(stamp)
	local date = GameUtil.time2date(checknumber(stamp))

	return langPara("%s月%s日%s:%02d", date.month, date.day, date.hour, date.min)
end

return YouthArenaThirdMainView
