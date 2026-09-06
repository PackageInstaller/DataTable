-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rankrace/view/RankRaceClassicsView.lua

module("logic.extensions.rankrace.view.RankRaceClassicsView", package.seeall)

local RankRaceClassicsView = class("RankRaceClassicsView", ViewComponent)

RankRaceClassicsView.MaxStartCount = 5

function RankRaceClassicsView:buildUI()
	RankRaceClassicsView.super.buildUI(self)

	self._txtTitle = self:getGo("topleft/txtTitle"):GetComponent("Text")
	self._btnHome = self:getBtn("topleft/btnHome")
	self._btnClose = self:getBtn("topleft/btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._btnMatch = self:getBtn("btnMatch")

	self._btnMatch:SetClickInterval(0.5)

	self._imgStartBk = self:getGo("imgStartBk")
	self._imgLevel = self:getGo("imgLevel"):GetComponent("UIImageSpriteChange")
	self._startWid = self:getGo("startWid")
	self._start = {}

	for i = 1, RankRaceClassicsView.MaxStartCount do
		self._start[i] = self:getGo("startWid/start_" .. i)
	end

	self._txtGrade = self:getGo("imgGradebg/txtGrade"):GetComponent("Text")
	self._imgRank = self:getGo("imgGradebg/imgRank")
	self._txtRank = self:getGo("imgGradebg/imgRank/txtRank"):GetComponent("Text")
	self._btnRank = self:getBtn("oneBtns/btnRank")
	self._btnReward = self:getBtn("oneBtns/btnReward")
	self._btnRewardRedPoint = self:getGo("oneBtns/btnReward/redPoint")
	self._btnExchange = self:getBtn("oneBtns/btnExchange")
	self._btnFameHall = self:getBtn("oneBtns/btnFameHall")
	self._btnFightReport = self:getBtn("oneBtns/btnFightReport")
	self._btnBanInfo = self:getBtn("twoBtns/btnBanInfo")
	self._btnVoteBan = self:getBtn("twoBtns/btnVoteBan/btn")
	self._btnJingLing = self:getBtn("twoBtns/btnJingLing")
	self._btnShouZhen = self:getBtn("twoBtns/btnShouZhen")
	self._btnInfo = self:getBtn("twoBtns/btnInfo")
	self._imgDouble = self:getGo("imgInfoBk/imgDouble")

	self._imgDouble.gameObject:SetActive(RankRaceController.instance:isInDoubleRewardTime())

	self._btnInfoTip = self:getBtn("imgInfoBk/btnInfoTip")
	self._imgInfoTipBk = self:getBtn("imgInfoTipBk")
	self._txtInfoTip = self:getGo("imgInfoTipBk/txtInfoTip"):GetComponent("Text")
	self._txtTodayGetCount = self:getGo("imgInfoBk/txtTodayGetCount"):GetComponent("Text")
	self._txtInfoTipWord = self:getGo("imgInfoBk/txtInfoTipWord"):GetComponent("Text")
	self._txtInfoLeft = self:getGo("txtInfoLeft"):GetComponent("Text")
	self._txtInfoSeasonTime = self:getGo("txtInfoLeft/txtInfoSeasonTime"):GetComponent("Text")
	self._txtInfoSeasonId = self:getGo("txtInfoLeft/txtInfoSeasonId"):GetComponent("Text")
	self._imgWinbg = self:getGo("imgWinbg"):GetComponent("UIChangeGroup")
	self._txtInfoStreakWin = self:getGo("txtInfoStreakWin"):GetComponent("Text")
	self._txtGradeScore = self:getTxt("imgGradebg/txtGradeScore")
end

function RankRaceClassicsView:bindEvents()
	RankRaceClassicsView.super.bindEvents(self)
	self._btnHome:AddClickListener(self._onClickBtnHome, self)
	self._btnClose:AddClickListener(self._onClickBtnClose, self)
	self._btnTip:AddClickListener(self._onClickBtnTip, self)
	self._btnMatch:AddClickListener(self._onClickBtnMatch, self)
	self._btnRank:AddClickListener(self._onClickBtnRank, self)
	self._btnReward:AddClickListener(self._onClickBtnReward, self)
	self._btnExchange:AddClickListener(self._onClickBtnExchange, self)
	self._btnJingLing:AddClickListener(self._onClickBtnJingLing, self)
	self._btnShouZhen:AddClickListener(self._onClickBtnShouZhen, self)
	self._btnFightReport:AddClickListener(self._onClickBtnFightReport, self)
	self._btnInfo:AddClickListener(self._onClickBtnInfo, self)
	self._btnInfoTip:AddClickListener(self._onClickBtnInfoTip, self)
	self._imgInfoTipBk:AddClickListener(self._onClickImgInfoTipBk, self)
	self._btnFameHall:AddClickListener(self._onClickFameHall, self)
	self._btnBanInfo:AddClickListener(self._onClickBanInfo, self)
	self._btnVoteBan:AddClickListener(self._onClickVoteBan, self)
end

function RankRaceClassicsView:unbindEvents()
	RankRaceClassicsView.super.unbindEvents(self)
	self._btnHome:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnMatch:RemoveClickListener()
	self._btnRank:RemoveClickListener()
	self._btnReward:RemoveClickListener()
	self._btnExchange:RemoveClickListener()
	self._btnJingLing:RemoveClickListener()
	self._btnShouZhen:RemoveClickListener()
	self._btnFightReport:RemoveClickListener()
	self._btnInfo:RemoveClickListener()
	self._btnInfoTip:RemoveClickListener()
	self._imgInfoTipBk:RemoveClickListener()
	self._btnFameHall:RemoveClickListener()
end

function RankRaceClassicsView:destroyUI()
	RankRaceClassicsView.super.destroyUI(self)
end

function RankRaceClassicsView:onEnter()
	RankRaceClassicsView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.RedPointUpdate, self._updateRedPoint, self)
	RankRaceResultController.instance:checkResult()

	local param = self._viewPresentor:getOpenParam()

	self._viewType = param and param[1]
	self._reason = param and param[2]
	self._videoBackForDetail = param and param[3]

	if RankRaceResultModel.instance:getReason() then
		RankRaceResultModel.instance:setReason(false)

		local _detailData = RankRaceController.instance:getDataForDetail()

		UIStateManager.instance:push(ViewName.RankRaceBattleReportView, self._viewType, _detailData, self._videoBackForDetail)
	end

	if self._viewType == RankRaceController.MatchTypeClassics then
		self._txtInfoLeft.text = RankRaceConfig.instance:getWord(1) or RankRaceConfig.instance:getWord(2)
	end

	if self._viewType == RankRaceController.MatchTypeClassics then
		self._txtTitle.text = RankRaceConfig.instance:getWord(6) or RankRaceConfig.instance:getWord(7)
	end

	self._openRankingMatchData = RankRaceController.instance:getOpenRankingMatchData(self._viewType)

	RankingMatchAgent.instance:sendRM_OpenRankingMatchReq(self._viewType)

	local opened, keyStr = RankRaceController.instance:getFirstOpenRemindView()

	if not opened then
		GameUtil.setLocalString(keyStr, "true")
		UIStateManager.instance:push(ViewName.RankRaceRemindView)
	end

	self:_updateRedPoint()
	self:_updateTxtInfoTip()
end

function RankRaceClassicsView:_updateRedPoint()
	if self._btnRewardRedPoint then
		local taskRewardRedPoint
		local _matchType = RankRaceController.instance:getCurViewType()

		self._btnRewardRedPoint.gameObject:SetActive(_matchType == RankRaceController.MatchTypeClassics and RedPointModel.instance:isActive(RedPointModel.ID_RANKRACE) or RedPointModel.instance:isActive(RedPointModel.ID_RANKRACELIMIT))
	end
end

function RankRaceClassicsView:onExit()
	RankRaceClassicsView.super.onExit(self)
	self:_clearStartEffect()
	removetimer(self._onStartWin, self)
	self:_clearBigbg()
	GlobalDispatcher:removeListener(GlobalNotify.RedPointUpdate, self._updateRedPoint, self)
end

function RankRaceClassicsView:_onClickBtnHome()
	UIStateManager.instance:clear(true)
end

function RankRaceClassicsView:_onClickBtnClose()
	self:close()
end

function RankRaceClassicsView:_onClickBtnTip()
	UIStateManager.instance:push(ViewName.RankRaceRemindView)
end

function RankRaceClassicsView:_onClickBtnMatch()
	RankRaceController.instance:setMatchType(self._viewType)
	RankRaceFmtController.instance:checkDefenseForm(self._viewType, function()
		RankingMatchAgent.instance:sendRM_BeginMatchingReq(self._viewType)
	end)
end

function RankRaceClassicsView:_onClickBtnRank()
	if self._viewType == RankRaceController.MatchTypeClassics then
		UIStateManager.instance:push(ViewName.Rank, GameEnum.RankType.RankMatchClass, 1)
	else
		UIStateManager.instance:push(ViewName.Rank, GameEnum.RankType.RankMatchLimit, 1)
	end
end

function RankRaceClassicsView:_onClickBtnReward()
	ViewMgr.instance:open(ViewName.RankRaceRewardView)
end

function RankRaceClassicsView:_onClickBtnExchange()
	if not FuncOpenModel.instance:getFuncIsOpen(46) then
		FloatWordMgr.instance:show(FuncOpenConfig.instance:getFunctionOpenById(46).lockedTips)
	else
		GotoMgr.gotoByString("func#470#ExchangeArena")
	end
end

function RankRaceClassicsView:_onClickBtnJingLing()
	UIStateManager.instance:push(ViewName.PetView)
end

function RankRaceClassicsView:_onClickBtnShouZhen()
	RankRaceFmtController.instance:enterDefenseForm(self._viewType, true)
end

function RankRaceClassicsView:_onClickBtnFightReport()
	UIStateManager.instance:push(ViewName.RankRaceBattleReportView, self._viewType)
end

function RankRaceClassicsView:_onClickBtnInfo()
	UIStateManager.instance:push(ViewName.RankRaceMyInfoView)
end

function RankRaceClassicsView:_onClickBtnInfoTip()
	self._imgInfoTipBk.gameObject:SetActive(true)
end

function RankRaceClassicsView:_onClickImgInfoTipBk()
	self._imgInfoTipBk.gameObject:SetActive(false)
end

function RankRaceClassicsView:_onClickFameHall()
	if self._viewType == RankRaceController.MatchTypeClassics then
		GotoMgr.gotoByString("func#1137#4")
	else
		GotoMgr.gotoByString("func#1137#5")
	end
end

function RankRaceClassicsView:_onClickBanInfo()
	local matchSeasonId = RankRaceController.instance:getClientSeasonId()

	UIStateManager.instance:push(ViewName.RankRaceBanPetTipsView, matchSeasonId, self._viewType)
end

function RankRaceClassicsView:_onClickVoteBan()
	local matchSeasonId = RankRaceController.instance:getClientSeasonId()

	UIStateManager.instance:push(ViewName.RankRaceBanPetView, matchSeasonId, self._viewType)
end

function RankRaceClassicsView:_updateStartShow(_curLightStartCount, _allStartCount)
	if not _curLightStartCount or not _allStartCount then
		return
	end

	if _curLightStartCount < 0 or _allStartCount < _curLightStartCount then
		return
	end

	for i = 1, _curLightStartCount do
		if not self._start[i].activeSelf then
			self._start[i].gameObject:SetActive(true)
		end

		uGuiUtil.setImageGrayStateRecursive(self._start[i], false)
	end

	for i = _curLightStartCount + 1, _allStartCount do
		if not self._start[i].activeSelf then
			self._start[i].gameObject:SetActive(true)
		end

		uGuiUtil.setImageGrayStateRecursive(self._start[i], true)
	end

	for i = _allStartCount + 1, RankRaceClassicsView.MaxStartCount do
		if self._start[i].activeSelf then
			self._start[i].gameObject:SetActive(false)
		end
	end

	if _allStartCount == 3 then
		GameUtil.setLocalPos(self._startWid, 38, 0, 0)
	elseif _allStartCount == 4 then
		GameUtil.setLocalPos(self._startWid, 17, 0, 0)
	elseif _allStartCount == 5 then
		GameUtil.setLocalPos(self._startWid, 0, 0, 0)
	end
end

function RankRaceClassicsView:_onStartWin()
	self:_updateStartShow()
	self:_clearStartEffect()
	removetimer(self._onStartWin, self)
end

function RankRaceClassicsView:_clearStartEffect()
	if self._qualityEffect then
		UIEffectManager.instance:stopEffect(self._qualityEffect)

		self._qualityEffect = nil
	end
end

function RankRaceClassicsView:_updateView()
	self._openRankingMatchData = RankRaceController.instance:getOpenRankingMatchData(self._viewType)

	if not self._openRankingMatchData then
		return
	end

	self._txtInfoSeasonTime.text = RankRaceController.instance:getCurSeasonTimeStr()

	if self._openRankingMatchData.winStreak > 0 then
		self._txtInfoStreakWin.text = self._openRankingMatchData.winStreak or 0
	end

	self:_updateWinbg(self._openRankingMatchData.winStreak)

	local _dailyLimit = RankRaceConfig.instance:getChallengeRewardCeiling()

	self._txtTodayGetCount.text = self._openRankingMatchData.dailyGainedScore .. "/" .. _dailyLimit

	local _configRankRaceLevel = RankRaceController.instance:getLevelInfoByCurStart(self._openRankingMatchData.star)

	if _configRankRaceLevel then
		self._txtGrade.text = _configRankRaceLevel._levelName

		uGuiUtil.setSpriteToImage(self._imgStartBk.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getRankRaceIconUrl("paiweisai_icon_lv0" .. _configRankRaceLevel._bigLevel))
		self._imgStartBk.gameObject:SetActive(true)

		if _configRankRaceLevel._bigLevel >= 8 then
			self._imgLevel.gameObject:SetActive(false)
			self._startWid.gameObject:SetActive(false)
			self._imgRank.gameObject:SetActive(true)

			local _rank = self._openRankingMatchData.myRank and ((self._openRankingMatchData.myRank > 1000 or self._openRankingMatchData.myRank < 0) and "1000+" or self._openRankingMatchData.myRank) or "1000+"

			self._txtRank.text = string.format(RankRaceConfig.instance:getWord(24), _rank)
			self._txtGradeScore.text = string.format("%s积分", self._openRankingMatchData.legendRankScore)
		else
			self._imgLevel.gameObject:SetActive(true)
			self._imgLevel:SetState(_configRankRaceLevel._subLevel - 1)
			self._startWid.gameObject:SetActive(true)
			self:_updateStartShow(_configRankRaceLevel._levelStart, _configRankRaceLevel._levelAllStart)
			self._imgRank.gameObject:SetActive(false)

			self._txtGradeScore.text = ""
		end
	end

	self:_updateSeasonNum()
	RankingMatchAgent.instance:sendRM_RefreshMyLocalRankReq(self._viewType)
end

function RankRaceClassicsView:_updateMyRank()
	self._openRankingMatchData = RankRaceController.instance:getOpenRankingMatchData(self._viewType)

	local _rank = self._openRankingMatchData.myRank and ((self._openRankingMatchData.myRank > 1000 or self._openRankingMatchData.myRank < 0) and "1000+" or self._openRankingMatchData.myRank) or "1000+"

	self._txtRank.text = string.format(RankRaceConfig.instance:getWord(24), _rank)
end

function RankRaceClassicsView:_updateWinbg(_winStreak)
	if not _winStreak then
		return
	end

	self._txtInfoStreakWin.gameObject:SetActive(true)

	if _winStreak < 2 then
		self._imgWinbg:SetState(0)
	elseif _winStreak < 5 then
		self._imgWinbg:SetState(1)
	elseif _winStreak < 8 then
		self._imgWinbg:SetState(2)
	elseif _winStreak < 11 then
		self._imgWinbg:SetState(3)
	else
		self._imgWinbg:SetState(4)
		self._txtInfoStreakWin.gameObject:SetActive(false)
	end
end

function RankRaceClassicsView:_updateSeasonNum()
	local _seasonNum, _, _ = RankRaceController.instance:getCurSeasonNum()

	self._txtInfoSeasonId.text = "S" .. _seasonNum
end

function RankRaceClassicsView:_updateTxtInfoTip()
	local _beginHour, _endHour = RankRaceController.instance:getDoubleRewardTime()

	if self._viewType == RankRaceController.MatchTypeClassics then
		local var_32_0 = RankRaceConfig.instance:getWord(28)

		if not var_32_0 then
			var_32_0 = RankRaceConfig.instance:getWord(30)

			local _tipWord = var_32_0

			self._txtInfoTipWord.text = string.format(_tipWord, _beginHour[1], _endHour[1])
		end
	end
end

function RankRaceClassicsView:_clearBigbg()
	if not self._imgStartBk then
		return
	end

	local bigImg = Framework.ImageBigBG.Get(self._imgStartBk)

	if bigImg then
		bigImg:ClearImage()
	end
end

return RankRaceClassicsView
