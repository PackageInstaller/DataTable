-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/youtharenathird/view/YouthArenaThirdChildRankView.lua

module("logic.extensions.youtharenathird.view.YouthArenaThirdChildRankView", package.seeall)

local YouthArenaThirdChildRankView = class("YouthArenaThirdChildRankView", ViewComponent)
local CHAMPION_SCORE_VIEW_GROUP_ID = 1

function YouthArenaThirdChildRankView:buildUI()
	YouthArenaThirdChildRankView.super.buildUI(self)

	self._rankScrollList = ScrollerList.create(self:getGo("rankCol/scrView"), self:getGo("rankCol/scrCell"), GameUtil.handler(self._updateRankCell, self), GameUtil.handler(self._clearRankCell, self))
	self._emptyGo = self:getGo("rankCol/emptyGo")
	self._itemScrollercell = self:getGo("rankCol/itemScrCell")
	self._txtRankValueTitle = self:getTxt("rankCol/titleCol/txtField3")
	self._itemScrollListDic = {}

	GameUtil.SetActive(self._itemScrollercell, false)

	self._txtMyRank = self:getTxt("tipsCol/txtMyRank")
	self._txtMyScore = self:getTxt("tipsCol/values/myScore/txt")
	self._myWinCountRoot = self:getGo("tipsCol/values/myWinCount")
	self._txtMyWinCount = self:getTxt("tipsCol/values/myWinCount/txt")
	self._myPrizeCol = self:getGo("tipsCol/myPrizeCol")

	local myPrizeScrollView = self:getGo("tipsCol/myPrizeCol/itemScrollerview")
	local myPrizeScrollCell = self:getGo("tipsCol/myPrizeCol/itemScrollercell")

	if self._myPrizeCol and myPrizeScrollView and myPrizeScrollCell then
		self._myPrizeScrollList = ScrollerList.create(myPrizeScrollView, myPrizeScrollCell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))
	end
end

function YouthArenaThirdChildRankView:onEnter()
	YouthArenaThirdChildRankView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._rankStage = checknumber(params[2])
	self._rankType = checknumber(params[3])
	self._roundId = checknumber(params[4])
	self._subMo = YouthArenaThirdController.instance:getSubMo(self._activityId)
	self._rankList = {}
	self._myRank = 0
	self._myScore = 0
	self._myWinCount = 0

	self.addGEvent(self, GlobalNotify.HandlePM_YoungArenaKingS3QualifierRankInfoRes, self._handlePlayerRankRes, self)
	self.addGEvent(self, GlobalNotify.HandlePM_YoungArenaKingS3GetKnockoutScheduleRes, self._handleChampionScoreRankRes, self)
	self:_refreshStaticInfo()
	self:_sendRankReq()
end

function YouthArenaThirdChildRankView:onExit()
	YouthArenaThirdChildRankView.super.onExit(self)

	if self._rankScrollList then
		self._rankScrollList:dispose()
	end

	if self._myPrizeScrollList then
		self._myPrizeScrollList:dispose()
	end

	for _, itemScrollList in pairs(self._itemScrollListDic) do
		itemScrollList:dispose()
	end

	table.clear(self._itemScrollListDic)
end

function YouthArenaThirdChildRankView:_sendRankReq()
	if self._activityId <= 0 or self._rankType ~= YouthArenaThirdEnum.RankType.PlayerScore then
		self:_refreshRankView({}, 0, 0, 0)

		return
	end

	if not YouthArenaThirdController.instance:isRankStageOpen(self._activityId, self._rankStage) then
		self:_refreshRankView({}, 0, 0, 0)

		return
	end

	if self:_isChampionScorePlayerRank() then
		if self._roundId > 0 then
			self._roundId = self._roundId or YouthArenaThirdController.instance:getRankChampionScoreRoundId(self._activityId)
		end

		if self._roundId > 0 then
			YouthArenaThirdController.instance:sendPM_YoungArenaKingS3GetKnockoutScheduleReq(self._activityId, CHAMPION_SCORE_VIEW_GROUP_ID, self._roundId)
		else
			self:_refreshRankView({}, 0, 0, 0)
		end

		return
	end

	local stepId = self:_getMatchStepId()

	if stepId <= 0 then
		self:_refreshRankView({}, 0, 0, 0)

		return
	end

	local zoneId = YouthArenaThirdController.instance:getCurZoneId(self._activityId)

	YouthArenaThirdController.instance:sendPM_YoungArenaKingS3QualifierRankInfoReq(self._activityId, zoneId, stepId)
end

function YouthArenaThirdChildRankView:_handlePlayerRankRes()
	if self._rankType ~= YouthArenaThirdEnum.RankType.PlayerScore or self:_isChampionScorePlayerRank() then
		return
	end

	local stepId = self:_getMatchStepId()
	local zoneId = YouthArenaThirdController.instance:getCurZoneId(self._activityId)

	if self._subMo then
		local info = self._subMo:getQualifierRankInfo(stepId, zoneId)

		if not self._subMo then
			return
		end

		local rankList = {}

		for _, rankInfo in ipairs(self._subMo.rankList or {}) do
			table.insert(rankList, self:_buildPlayerRankData(rankInfo))
		end

		self:_refreshRankView(rankList, self._subMo.myRank, self._subMo.myScore, self._subMo.myWinCount)
	end
end

function YouthArenaThirdChildRankView:_handleChampionScoreRankRes()
	if not self:_isChampionScorePlayerRank() then
		return
	end

	if self._subMo then
		local scheduleInfo = self._subMo:getKnockoutScheduleInfo(CHAMPION_SCORE_VIEW_GROUP_ID, self._roundId)

		if not scheduleInfo then
			return
		end

		local rankList = {}
		local myRank = 0
		local myScore = 0
		local myUserId = checknumber(RoleModel.instance:getUserId())

		for rank, playerInfo in ipairs(scheduleInfo.top8ScoreMatchPlayers or {}) do
			local data = self:_buildChampionScoreRankData(rank, playerInfo)

			table.insert(rankList, data)

			if myUserId > 0 then
				if myUserId == checknumber(playerInfo.headInfo and playerInfo.headInfo.userId) then
					myRank = rank
					myScore = checknumber(playerInfo.score)
				end
			end
		end

		self:_refreshRankView(rankList, myRank, myScore, 0)
	end
end

function YouthArenaThirdChildRankView:_refreshStaticInfo()
	if self._txtRankValueTitle then
		self._txtRankValueTitle.text = "积分"
	end

	if self._myWinCountRoot then
		GameUtil.SetActive(self._myWinCountRoot, not self:_isChampionScorePlayerRank())
	end
end

function YouthArenaThirdChildRankView:_refreshRankView(rankList, myRank, myScore, myWinCount)
	self._rankList = rankList or {}
	self._myRank = checknumber(myRank)
	self._myScore = checknumber(myScore)
	self._myWinCount = checknumber(myWinCount)

	if self._txtMyRank then
		self._txtMyRank.text = self:_formatRank(self._myRank)
	end

	if self._txtMyScore then
		self._txtMyScore.text = tostring(self._myScore)
	end

	if self._txtMyWinCount then
		self._txtMyWinCount.text = tostring(self._myWinCount)
	end

	self:_refreshMyPrize()
	GameUtil.SetActive(self._emptyGo, #self._rankList <= 0)
	self._rankScrollList:reloadData(self._rankList)
	self._rankScrollList:MoveCellInView(0, true)
end

function YouthArenaThirdChildRankView:_refreshMyPrize()
	if not self._myPrizeScrollList or not self._myPrizeCol then
		return
	end

	local prizes = self:_getPrizesByRank(self._myRank)

	if not string.nilorempty(prizes) then
		self._myPrizeScrollList:reloadData(string.split(prizes, "#"))
		self._myPrizeScrollList:dragNotifyParent()
		GameUtil.SetActive(self._myPrizeCol, true)
	else
		self._myPrizeScrollList:reloadData({})
		GameUtil.SetActive(self._myPrizeCol, false)
	end
end

function YouthArenaThirdChildRankView:_buildPlayerRankData(info)
	local value = checknumber(info and info.value)
	local var_10_0 = {
		source = "player",
		rank = checknumber(info and info.rank),
		headInfo = info and info.headInfo
	}

	if info and info.headInfo then
		var_10_0.name = info.headInfo.userName or ""
	end

	var_10_0.value = value
	var_10_0.winTimes = checknumber(info and info.winCount)

	return var_10_0
end

function YouthArenaThirdChildRankView:_buildChampionScoreRankData(rank, info)
	local var_11_0 = {
		source = "player",
		rank = checknumber(rank),
		headInfo = info and info.headInfo
	}

	if info and info.headInfo then
		var_11_0.name = info.headInfo.userName or ""
	end

	var_11_0.value = checknumber(info and info.score)
	var_11_0.winTimes = checknumber(info and info.winCount)

	return var_11_0
end

function YouthArenaThirdChildRankView:_updateRankCell(view, cell, data, tag)
	if not cell.gameObject then
		local go = cell
		local imgRank = goutil.findChildComponent(go, "imgRank", ComponentType.UIImageSpriteChange)
		local txtRank = goutil.findChildTextComponent(go, "txtRank")
		local headRoot = goutil.findChild(go, "headRoot")
		local txtName = goutil.findChildTextComponent(go, "txtName")
		local txtValue = goutil.findChildTextComponent(go, "txtValue")
		local txtWinTimes = goutil.findChildTextComponent(go, "txtWinTimes")
		local itemScrollerview = goutil.findChild(go, "itemScrollerview")
		local rank = checknumber(data and data.rank)
		local isTop3 = rank >= 1 and rank <= 3

		self:_clearHeadRoot(headRoot)

		if imgRank then
			imgRank.gameObject:SetActive(isTop3)

			if isTop3 then
				imgRank:SetState(rank - 1)
			end
		end

		if txtRank then
			txtRank.gameObject:SetActive(not isTop3)

			txtRank.text = tostring(rank)
		end

		if data and data.headInfo then
			HeadItemController.instance:setHeadCellByInfo(headRoot, data.headInfo, true)
		end

		if data then
			txtName.text = data.name or ""
		end

		txtValue.text = tostring((data or nil) and (data.value or ""))
		txtWinTimes.text = tostring((data or nil) and (data.winTimes or ""))

		self:_refreshCellPrize(go, itemScrollerview, self:_getPrizesByRank(rank))
	end
end

function YouthArenaThirdChildRankView:_clearRankCell(cell)
	if not cell.gameObject then
		local go = cell
		local headRoot = goutil.findChild(go, "headRoot")

		self:_clearHeadRoot(headRoot)

		local itemScrollList = self._itemScrollListDic[go]

		if itemScrollList then
			itemScrollList:dispose()

			self._itemScrollListDic[go] = nil
		end
	end
end

function YouthArenaThirdChildRankView:_refreshCellPrize(go, itemScrollerview, prizes)
	if itemScrollerview and self._itemScrollercell and not string.nilorempty(prizes) then
		if not self._itemScrollListDic[go] then
			local itemScrollList = ScrollerList.create(itemScrollerview, self._itemScrollercell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

			self._itemScrollListDic[go] = self._itemScrollListDic[go]

			self._itemScrollListDic[go]:reloadData(string.split(prizes, "#"))
			self._itemScrollListDic[go]:dragNotifyParent()
		end
	elseif self._itemScrollListDic[go] then
		self._itemScrollListDic[go]:dispose()

		self._itemScrollListDic[go] = nil
	end
end

function YouthArenaThirdChildRankView:_updateItemCell(view, cell, prizeStr, tag)
	MaterialMgr.setCellByCfg(prizeStr, cell.gameObject or cell)
end

function YouthArenaThirdChildRankView:_clearItemCell(cell)
	MaterialMgr.resetAll(cell.gameObject or cell)
end

function YouthArenaThirdChildRankView:_getMatchStepId()
	if self._rankStage == YouthArenaThirdEnum.RankStage.Qualifier then
		return YouthArenaThirdEnum.MatchStepId.Qualifier
	end

	if self._rankStage == YouthArenaThirdEnum.RankStage.ScoreMatch then
		return YouthArenaThirdEnum.MatchStepId.ScoreMatch
	end

	return 0
end

function YouthArenaThirdChildRankView:_isChampionScorePlayerRank()
	return self._rankStage == YouthArenaThirdEnum.RankStage.ChampionScore and self._rankType == YouthArenaThirdEnum.RankType.PlayerScore
end

function YouthArenaThirdChildRankView:_getPrizesByRank(rank)
	rank = checknumber(rank)

	if rank <= 0 then
		return nil
	end

	if self._rankStage == YouthArenaThirdEnum.RankStage.ChampionScore then
		local cfg = YouthArenaThirdConfig.instance:getKnockoutRankPrizeDataByRank(self._activityId, rank)

		if cfg and not string.nilorempty(cfg.showPrize) then
			return cfg.showPrize
		end

		return cfg and cfg.prize
	end

	local cfg = YouthArenaThirdConfig.instance:getScoreMatchRankPrizeDataByRank(self._activityId, rank)

	return cfg and cfg.prize
end

function YouthArenaThirdChildRankView:_formatRank(rank)
	rank = checknumber(rank)

	return rank > 0 and tostring(rank) or "未上榜"
end

function YouthArenaThirdChildRankView:_clearHeadRoot(headRoot)
	if not headRoot then
		return
	end

	HeadItemController.instance:resetHeadCell(headRoot)
	MaterialMgr.resetAll(headRoot)
end

return YouthArenaThirdChildRankView
