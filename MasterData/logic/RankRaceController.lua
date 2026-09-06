-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rankrace/controller/RankRaceController.lua

module("logic.extensions.rankrace.controller.RankRaceController", package.seeall)

local RankRaceController = class("RankRaceController", BaseController)

RankRaceController.MatchTypeClassics = 0
RankRaceController.MatchTypeLimit = 1
RankRaceController.TaskTypeDaily = 1
RankRaceController.TaskTypeWeek = 2
RankRaceController.TaskTypeSeason = 3
RankRaceController.RankingWard = 4
RankRaceController.WinTab = 1
RankRaceController.LoseTab = 2
RankRaceController.CanGet = 1
RankRaceController.Doing = 2
RankRaceController.Done = 3
RankRaceController.BeginStart = 13
RankRaceController.rankModelReqGapTime = 600

function RankRaceController:ctor()
	RankRaceController.super.ctor(self)
end

function RankRaceController:onInit()
	RankRaceController.super.onInit(self)
	self:_handleLevelConfig()
	self:_handleTaskRewardConfig()
	self:_initDeclareConfig()
	self:_bindEvent()

	self._banPetInfoResMsgs = {}
	self._recordPreRank = {}
	self._recordRank = {}
	self._avoidFormZdlDetailFlag = nil
end

function RankRaceController:_bindEvent()
	GlobalDispatcher:addListener(GlobalNotify.BattleEnd, self._OnBattleEnd, self)
	GlobalDispatcher:addListener(GlobalNotify.ApplicationResume, self._OnApplicationResume, self)
end

function RankRaceController:_OnBattleEnd()
	local _videoBack = self:getClickVideo()

	if _videoBack ~= nil then
		RankRaceResultController.instance:checkResult()

		return
	end

	local _videoBackForDetail = self:getClickVideoForDetail()

	if _videoBackForDetail ~= nil then
		self:setClickVideoForDetail(nil)
		self:openClassicsView("detail", _videoBackForDetail)
	end

	RankRaceController.instance:setAvoidFormZdlDetailFlag(false)
end

function RankRaceController:onReset()
	RankRaceController.super.onReset(self)

	self._levelConfig = nil
	self._allInfos = nil
	self._openRankingMatchData = nil
	self._clickMatchType = nil
	self._checkLastSeasonDone = false
	self.battlerecords = nil
	self.showVideo = nil
	self.showVideoForDetail = nil
	self._detailData = nil
	self._closeForReset = nil
	self._avoidFormZdlDetailFlag = nil
	self.rankModelReqTimeStamp = {}
	self._rankMos = {}
	self._recordPreRank = {}
	self._recordRank = {}
	self._banPetInfoResMsgs = {}

	GlobalDispatcher:removeListener(GlobalNotify.BattleEnd, self._OnBattleEnd, self)
	removetimer(self.updateFindEnemyView, self)
end

function RankRaceController:setCurViewType(_viewType)
	self._curViewType = _viewType
end

function RankRaceController:getCurViewType()
	return self._curViewType
end

function RankRaceController:_handleLevelConfig()
	if self._configRankRaceLevel then
		return self._configRankRaceLevel
	end

	self._configRankRaceLevel = {}

	local config = RankRaceConfig.instance:getRankLevelConfig()

	if config then
		for i = 1, #config do
			local _indexStart = config[i].star
			local _levelName = config[i].levelName
			local _bigLevel = config[i].bigLevel
			local _subLevel = config[i].subLevel
			local _level = config[i].level

			self._configRankRaceLevel[_indexStart] = {
				_levelStart = 1,
				_levelName = _levelName,
				_levelAllStart = (i < #config or nil) and config[i + 1].star - config[i].star,
				_bigLevel = _bigLevel,
				_subLevel = _subLevel,
				_level = _level
			}
		end
	end

	local _firstStart = -1
	local _levelName = ""
	local _bigLevel = 1
	local _subLevel = 4
	local _levelAllStart = 0
	local _level = 1

	for i = 1, config[#config].star do
		if self._configRankRaceLevel[i] then
			_firstStart = 1
			_levelName = self._configRankRaceLevel[i]._levelName
			_bigLevel = self._configRankRaceLevel[i]._bigLevel
			_subLevel = self._configRankRaceLevel[i]._subLevel
			_level = self._configRankRaceLevel[i]._level
			_levelAllStart = self._configRankRaceLevel[i]._levelAllStart
		else
			_firstStart = _firstStart + 1
			self._configRankRaceLevel[i] = {
				_levelName = _levelName,
				_levelAllStart = _levelAllStart,
				_levelStart = _firstStart,
				_bigLevel = _bigLevel,
				_subLevel = _subLevel,
				_level = _level
			}
		end
	end

	return self._configRankRaceLevel
end

function RankRaceController:getLevelInfoByCurStart(_allStart)
	if not _allStart then
		return
	end

	return self._configRankRaceLevel[tonumber(_allStart)]
end

function RankRaceController:setOpenRankingMatchData(msg)
	if not msg then
		return
	end

	local _seasonWord, _type

	if msg.matchSeasonId then
		_seasonWord, _type = RankRaceController.instance:_deCodeMatchSeasonId(msg.matchSeasonId)
	else
		error("RM_OpenRankingMatchRes 没有下发 matchSeasonId")

		return
	end

	self._openRankingMatchData = self._openRankingMatchData or {}
	self._openRankingMatchData[_type + 1] = {
		wins = msg.wins,
		total = msg.total,
		star = msg.star,
		winStreak = msg.winStreak,
		hasSetDefenseForm = msg.hasSetDefenseForm,
		dailyGainedScore = msg.dailyGainedScore,
		matchSeasonId = msg.matchSeasonId,
		legendRankScore = checknumber(msg.legendRankScore),
		myRank = msg.myRank,
		banRaceIds = msg.banRaceIds
	}

	self:_updateAllInfoData(self._openRankingMatchData[_type + 1])
	self:operView(ViewName.RankRaceClassicsView, function(_view)
		_view:_updateView()
	end)
end

function RankRaceController:_updateAllInfoData(_newOpenRankingMatchData)
	if not _newOpenRankingMatchData or not self._allInfos then
		return
	end

	local _findData = false

	for i = 1, #self._allInfos do
		if tostring(self._allInfos[i].matchSeasonId) == tostring(_newOpenRankingMatchData.matchSeasonId) then
			self._allInfos[i].star = _newOpenRankingMatchData.star
			self._allInfos[i].rank = _newOpenRankingMatchData.myRank
			self._allInfos[i].total = _newOpenRankingMatchData.total
			self._allInfos[i].wins = _newOpenRankingMatchData.wins
			_findData = true

			break
		end
	end

	if not _findData and self._allInfos then
		local len = #self._allInfos + 1

		self._allInfos[len] = {}
		self._allInfos[len].matchSeasonId = _newOpenRankingMatchData.matchSeasonId
		self._allInfos[len].star = _newOpenRankingMatchData.star
		self._allInfos[len].rank = _newOpenRankingMatchData.myRank
		self._allInfos[len].total = _newOpenRankingMatchData.total
		self._allInfos[len].wins = _newOpenRankingMatchData.wins
	end

	self:_arrangeDataBySeason()
end

function RankRaceController:getOpenRankingMatchData(_viewType)
	return self._openRankingMatchData and self._openRankingMatchData[_viewType + 1]
end

function RankRaceController:isEnoughVoteOfBanPet()
	local isEnough = false
	local needLevel = RankRaceConfig.instance:getRankCommonValue("CAN_BAN_VOTE_LEVEL", true)

	if self._openRankingMatchData then
		for _, v in pairs(self._openRankingMatchData) do
			local configRankRaceLevel = self:getLevelInfoByCurStart(v.star)
			local curLevel = configRankRaceLevel._level

			if needLevel <= curLevel then
				isEnough = true

				break
			end
		end
	end

	return isEnough
end

function RankRaceController:updateDeclareView()
	self:operView(ViewName.RankRaceDeclareView, function(_view)
		_view:_updateTabView()
	end)
end

function RankRaceController:updateMyInfoView(infos)
	self._allInfos = GameUtil.pbToTable(infos)

	if self._openRankingMatchData then
		for i = 1, 2 do
			if self._openRankingMatchData[i] then
				self:_updateAllInfoData(self._openRankingMatchData[i])
			end
		end
	end

	self:operView(ViewName.RankRaceMyInfoView, function(_view)
		_view:_updateView()
	end)
	self:operView(ViewName.RankRaceRewardSeasonView, function(_view)
		_view:updateViewWithouParams()
	end)
end

function RankRaceController:getAllInfos()
	return self._allInfos
end

function RankRaceController:sendRM_BanPetReq(seasonId, raceIds)
	RankingMatchAgent.instance:sendRM_BanPetReq(seasonId, raceIds)
end

function RankRaceController:handleRM_BanPetRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandleRM_BanPetRes)
end

function RankRaceController:sendRM_GetBanPetInfoReq(seasonId)
	RankingMatchAgent.instance:sendRM_GetBanPetInfoReq(seasonId)
end

function RankRaceController:handleRM_GetBanPetInfoRes(msg)
	self._banPetInfoResMsgs[msg.seasonId] = msg

	GlobalDispatcher:dispatch(GlobalNotify.HandleRM_GetBanPetInfoRes)
end

function RankRaceController:getBanPetInfoResMsg(seasonId)
	return self._banPetInfoResMsgs[seasonId]
end

function RankRaceController:getBanPetTimeStamp(seasonId)
	local startStamp, endStamp = 0, 0
	local curData = RankRaceConfig.instance:getSeasonCfg(seasonId)
	local nextData = RankRaceConfig.instance:getSeasonCfg(seasonId + 1)

	if curData and not string.nilorempty(nextData.startTime) then
		startStamp = GameUtil.string2time(curData.startTime)
	end

	if nextData and not string.nilorempty(nextData.openTime) then
		endStamp = GameUtil.string2time(nextData.openTime)
	end

	local hour = RankRaceConfig.instance:getRankCommonValue("ADVANCE_VOTE_END_HOURS", true)

	endStamp = Mathf.Max(endStamp - hour * 3600, 0)

	return startStamp, endStamp
end

function RankRaceController:iscurBanPet(_viewType, raceId)
	local info = self:getOpenRankingMatchData(_viewType)

	return info and table.indexof(info.banRaceIds, raceId) ~= false or false
end

function RankRaceController:_arrangeDataBySeason()
	self._allInfoArrange = {}

	if #self._allInfos == 0 then
		return
	elseif #self._allInfos == 1 then
		local _type = tonumber(string.sub(self._allInfos[1].matchSeasonId, 7, 8))
		local var_28_0 = {
			_id = 1
		}

		if _type == 0 then
			var_28_0._classData = self._allInfos[1] or nil
		end

		if _type == 1 then
			var_28_0._limitData = self._allInfos[1] or nil
		end

		self._allInfoArrange[1] = var_28_0
	else
		table.sort(self._allInfos, function(a, b)
			return tonumber(a.matchSeasonId) < tonumber(b.matchSeasonId)
		end)

		local seasonCount, prevWord = 0

		for i = 1, #self._allInfos do
			local _seasonWord, _type = self:_deCodeMatchSeasonId(self._allInfos[i].matchSeasonId)

			if _seasonWord ~= prevWord then
				prevWord = _seasonWord
				seasonCount = seasonCount + 1
			end

			self._allInfoArrange[seasonCount] = self._allInfoArrange[seasonCount] or {
				_id = seasonCount
			}

			if _type == RankRaceController.MatchTypeClassics then
				self._allInfoArrange[seasonCount]._classData = self._allInfos[i]
			elseif _type == RankRaceController.MatchTypeLimit then
				self._allInfoArrange[seasonCount]._limitData = self._allInfos[i]
			end
		end
	end
end

function RankRaceController:getArrangeSeasonData()
	return self._allInfoArrange
end

function RankRaceController:updateCurSeasonInfo(_type, newInfo)
	if not _type or not newInfo or not self._allInfos then
		return
	end

	local _curSeasonId, _ = self:getCurSeasonId(_type)

	for i, v in ipairs(self._allInfos) do
		if tostring(v.matchSeasonId) == tostring(_curSeasonId) then
			v.matchSeasonId = newInfo.matchSeasonId or v.matchSeasonId

			if newInfo.wins and newInfo.wins == 1 then
				v.wins = v.wins + newInfo.wins or v.wins
			end

			v.total = v.total + 1
			v.star = newInfo.star or v.star
			v.rank = newInfo.rank or v.rank
		end
	end

	self:_arrangeDataBySeason()
end

function RankRaceController:getCurSeasonId(_type)
	if not _type then
		return
	end

	local _curSeasonIdOtherType
	local curDate = GameUtil.time2date(ServerTime.now())
	local _curSeasonId = curDate.year

	_curSeasonId = curDate.month < 10 and _curSeasonId .. "0" .. curDate.month or _curSeasonId .. curDate.month

	if _type == RankRaceController.MatchTypeClassics then
		_curSeasonIdOtherType = _curSeasonId .. "01"
		_curSeasonId = _curSeasonId .. "00"
	elseif _type == RankRaceController.MatchTypeLimit then
		_curSeasonIdOtherType = _curSeasonId .. "00"
		_curSeasonId = _curSeasonId .. "01"
	end

	return _curSeasonId, _curSeasonIdOtherType
end

function RankRaceController:_getCurSeasonData()
	local _classSeasonId, _limitSeasonId = self:getCurSeasonId(RankRaceController.MatchTypeClassics)
	local _curClassInfo, _curLimitInfo
	local _getDataDone = 0

	for i, v in ipairs(self._allInfos) do
		if v and v.matchSeasonId then
			if tostring(v.matchSeasonId) == _classSeasonId then
				_curClassInfo = v
				_getDataDone = _getDataDone + 1
			end

			if tostring(v.matchSeasonId) == _limitSeasonId then
				_curLimitInfo = v
				_getDataDone = _getDataDone + 1
			end

			if _getDataDone >= 2 then
				break
			end
		end
	end

	return _curClassInfo, _curLimitInfo
end

function RankRaceController:getCurSeasonNum()
	local curDate = GameUtil.time2date(ServerTime.now())
	local _seasonNum = RankRaceConfig.instance:getCurSeasonNum()

	return _seasonNum, curDate.year, curDate.month
end

function RankRaceController:getPreSeasonNum()
	local _curSeasonNum, _curYear, _curMonth = self:getCurSeasonNum()
	local _preSeasonNum = _curSeasonNum - 1
	local _perMonth = _curMonth - 1
	local _preYear = _curYear

	if _perMonth == 0 then
		_perMonth = 12
		_preYear = _curYear - 1
	end

	return _preSeasonNum, _preYear, _perMonth
end

function RankRaceController:getSeasonNumBySeasonId(_seasonId)
	if not _seasonId then
		return
	end

	local _seasonYear = string.sub(_seasonId, 1, 4)
	local _seasonMonth = string.sub(_seasonId, 5, 6)
	local _firstSeasonTime = RankRaceConfig.instance:getFirstSeasonTime()
	local _firstSeasonTimeArray = string.split(_firstSeasonTime, "-")
	local _seasonNum = RankRaceConfig.instance:getSeasonNumBySeasonId(checknumber(string.sub(_seasonId, 1, 6)))

	return _seasonNum, _seasonYear, _seasonMonth
end

function RankRaceController:matchComplete()
	settimer(1, self.updateFindEnemyView, self, false)
end

function RankRaceController:updateFindEnemyView()
	self:operView(ViewName.RankRaceFindEnemyView, function(_view)
		_view:endMatchEnemy()
	end)
	removetimer(self.updateFindEnemyView, self)
end

function RankRaceController:closeFindEnemyView()
	self:operView(ViewName.RankRaceFindEnemyView, function(_view)
		_view:close()
	end)
end

function RankRaceController:setNotifyBeginGameResData(msg)
	self._notifyBeginGameResData = msg
end

function RankRaceController:getNotifyBeginGameResData()
	return self._notifyBeginGameResData
end

function RankRaceController:setMatchType(_viewType)
	self._clickMatchType = _viewType
end

function RankRaceController:getMatchType()
	return self._clickMatchType
end

function RankRaceController:notifyGameResult(msg)
	if not msg or not msg.state or msg.state ~= 1 then
		return
	end

	if self._openRankingMatchData and self._openRankingMatchData[self._clickMatchType + 1] then
		if msg.dailyGainedScore then
			self._openRankingMatchData[self._clickMatchType + 1].dailyGainedScore = msg.dailyGainedScore
		end

		if msg.curLegendRankScore then
			self._openRankingMatchData[self._clickMatchType + 1].legendRankScore = msg.curLegendRankScore
		end

		if msg.winStreak then
			self._openRankingMatchData[self._clickMatchType + 1].winStreak = msg.winStreak
		end

		if msg.addStar then
			self._openRankingMatchData[self._clickMatchType + 1].star = self._openRankingMatchData[self._clickMatchType + 1].star + msg.addStar
		end

		if msg.curRank then
			self._openRankingMatchData[self._clickMatchType + 1].myRank = msg.curRank
		end

		self._openRankingMatchData[self._clickMatchType + 1].total = self._openRankingMatchData[self._clickMatchType + 1].total + 1

		if msg.result and msg.result == 1 then
			self._openRankingMatchData[self._clickMatchType + 1].wins = self._openRankingMatchData[self._clickMatchType + 1].wins + 1
		end
	end

	local newInfo = {}

	if msg.addStar then
		newInfo.star = self._openRankingMatchData[self._clickMatchType + 1].star
	end

	if msg.result then
		newInfo.wins = msg.result
	end

	self:updateCurSeasonInfo(self._clickMatchType, newInfo)
	self:setResultDeclear(msg)
end

function RankRaceController:setResultDeclear(msg)
	if not msg then
		return
	end

	self.myDeclearWord = ""
	self.opDeclearWord = ""

	if msg.result == 1 then
		if msg.myWinDeclaration and msg.myWinDeclaration > 0 then
			self.myDeclearWord = self._declareConfig[RankRaceController.WinTab][msg.myWinDeclaration]
		end

		if msg.opLoseDeclaration and msg.opLoseDeclaration > 0 then
			self.opDeclearWord = self._declareConfig[RankRaceController.LoseTab][msg.opLoseDeclaration]
		end
	elseif msg.result == 0 then
		-- block empty
	elseif msg.result == -1 then
		if msg.myLoseDeclaration and msg.myLoseDeclaration > 0 then
			self.myDeclearWord = self._declareConfig[RankRaceController.LoseTab][msg.myLoseDeclaration]
		end

		if msg.opWinDeclaration and msg.opWinDeclaration > 0 then
			self.opDeclearWord = self._declareConfig[RankRaceController.WinTab][msg.opWinDeclaration]
		end
	end
end

function RankRaceController:getResultDeclear()
	return self.myDeclearWord, self.opDeclearWord
end

function RankRaceController:_initDeclareConfig()
	local config = RankRaceConfig.instance:getDeclareConfig()

	self._declareConfig = {}
	self._declareConfig[RankRaceController.WinTab] = self._declareConfig[RankRaceController.WinTab] or {}
	self._declareConfig[RankRaceController.LoseTab] = self._declareConfig[RankRaceController.LoseTab] or {}

	for i = 1, #config do
		for j = 1, 2 do
			table.insert(self._declareConfig[j], config[i][j].desc)
		end
	end
end

function RankRaceController:getDeclareConfig()
	return self._declareConfig
end

function RankRaceController:matchFail()
	self:operView(ViewName.RankRaceFindEnemyView, function(_view)
		_view:_onNoEnemy(true)
	end)
end

function RankRaceController:updateRewardView(msg)
	if not msg then
		return
	end

	local taskinfos = msg.taskInfos

	if not self._configTaskResardType then
		return
	end

	for i = 1, 2 do
		for k, v in pairs(self._configTaskResardType[i]) do
			local finded = false

			for j = 1, #taskinfos do
				if v.id == taskinfos[j].taskId then
					v.progressValue = taskinfos[j].progress
					v.prizeGained = taskinfos[j].prizeGained
					finded = true

					break
				end
			end

			v._rewardTag = RankRaceController.Doing

			if finded then
				v._rewardTag = v.progressValue < v.progress and RankRaceController.Doing or v.prizeGained and RankRaceController.Done or RankRaceController.CanGet
			end
		end

		table.sort(self._configTaskResardType[i], function(a, b)
			return a._rewardTag < b._rewardTag
		end)
	end

	self:operView(ViewName.RankRaceRewardView, function(_view)
		_view:updateView()
	end)
end

function RankRaceController:gainTaskPrizeSucc(msg)
	if not msg.taskId then
		if not self._configTaskResardType then
			return
		end

		for i = 1, 2 do
			for k, v in pairs(self._configTaskResardType[i]) do
				if table.indexof(msg.taskId, v.id) then
					v.prizeGained = true
					v._rewardTag = RankRaceController.Done
				end
			end

			table.sort(self._configTaskResardType[i], function(a, b)
				return a._rewardTag < b._rewardTag
			end)
		end

		self:operView(ViewName.RankRaceRewardView, function(_view)
			_view:updateView()
		end)
	end
end

function RankRaceController:_handleTaskRewardConfig()
	self._configTaskResard = self._configTaskResard or RankRaceConfig.instance:getRankRaceTask()
	self._configTaskLevelResard = self._configTaskLevelResard or RankRaceConfig.instance:getRankMatchLevelPrize()
	self._configTaskResardType = {}
	self._configTaskResardType[RankRaceController.TaskTypeDaily] = {}
	self._configTaskResardType[RankRaceController.TaskTypeWeek] = {}
	self._configTaskResardType[RankRaceController.TaskTypeSeason] = {}

	for k, v in pairs(self._configTaskResard) do
		if v.type == RankRaceController.TaskTypeDaily then
			table.insert(self._configTaskResardType[RankRaceController.TaskTypeDaily], v)
		elseif v.type == RankRaceController.TaskTypeWeek then
			table.insert(self._configTaskResardType[RankRaceController.TaskTypeWeek], v)
		end
	end

	for i = 1, 2 do
		table.sort(self._configTaskResardType[i], function(a, b)
			return a.id < b.id
		end)
	end

	for k, v in pairs(self._configTaskLevelResard) do
		if k == 0 or k == 1 then
			self._configTaskResardType[RankRaceController.TaskTypeSeason][tostring(k)] = v
		end
	end
end

function RankRaceController:getTaskRewardConfig(index, _type)
	if not index then
		return
	end

	if _type then
		if index == RankRaceController.TaskTypeSeason then
			return self._configTaskResardType[index][tostring(_type)]
		end
	else
		return self._configTaskResardType[index]
	end
end

function RankRaceController:getRankingReward(planId, _type)
	if _type ~= 0 and _type ~= 1 then
		return
	end

	return RankRaceConfig.instance:getRankingReward(planId, _type)
end

function RankRaceController:getBattleRecordRes(msg)
	if not msg then
		return
	end

	self.battlerecords = msg.battleRecords

	table.sort(self.battlerecords, function(a, b)
		return a.recordTime > b.recordTime
	end)
	self:operView(ViewName.RankRaceBattleReportView, function(_view)
		_view:updateView()
	end)
end

function RankRaceController:getBattleRecords()
	return self.battlerecords
end

function RankRaceController:openClassicsView(_reason, _videoBackForDetail)
	if not self._curViewType then
		return
	end

	if _reason == "detail" then
		RankRaceResultModel.instance:setReason(true)
	end

	UIJumper.instance:pushOneStack(ViewName.RankRaceClassicsView, true, self._curViewType, _reason, _videoBackForDetail)
end

function RankRaceController:setClickVideo(_isShowingSelf)
	self.showVideo = _isShowingSelf
end

function RankRaceController:getClickVideo()
	return self.showVideo
end

function RankRaceController:setClickVideoForDetail(_isShowingSelf)
	self.showVideoForDetail = _isShowingSelf
end

function RankRaceController:getClickVideoForDetail()
	return self.showVideoForDetail
end

function RankRaceController:setDataForDetail(_detailData)
	self._detailData = _detailData
end

function RankRaceController:getDataForDetail()
	return self._detailData
end

function RankRaceController:_deCodeMatchSeasonId(_matchSeasonId)
	if not _matchSeasonId then
		return
	end

	local _seasonWord = tonumber(string.sub(_matchSeasonId, 5, 6))
	local _type = tonumber(string.sub(_matchSeasonId, 7, 8))

	return _seasonWord, _type
end

function RankRaceController:getView(_viewName)
	local presentor = ViewMgr.instance:getViewPresentor(_viewName)
	local view = self:_getViewByViewName(presentor, _viewName)

	return view, presentor
end

function RankRaceController:_getViewByViewName(presentor, viewName)
	if not presentor or not presentor._views or not viewName then
		return
	end

	for i = 1, #presentor._views do
		if presentor._views[i]._viewPresentor.viewName == viewName then
			return presentor._views[i]
		end
	end
end

function RankRaceController:operView(viewName, _callBack)
	if not viewName then
		return
	end

	local _view, _ = self:getView(viewName)

	if _view and ViewMgr.instance:isOpen(viewName) and _callBack then
		_callBack(_view)
	end
end

function RankRaceController:checkLastSeasonPrizeReq()
	if not self._checkLastSeasonDone then
		self._checkLastSeasonDone = true

		RankingMatchAgent.instance:sendRM_CheckLastSeasonPrizeReq()
	else
		UIStateManager.instance:push(ViewName.RankRaceChooseView)
	end
end

function RankRaceController:checkLastSeasonPrize(msg)
	local lastMatchSeasonId = msg.lastMatchSeasonId

	if lastMatchSeasonId == -1 then
		UIStateManager.instance:push(ViewName.RankRaceChooseView)
	else
		local lastClassicStar = msg.lastClassicStar and msg.lastClassicStar > 0 and msg.lastClassicStar or -1
		local lastExtremeStar = msg.lastExtremeStar and msg.lastExtremeStar > 0 and msg.lastExtremeStar or -1

		if lastClassicStar == -1 and lastExtremeStar == -1 then
			UIStateManager.instance:push(ViewName.RankRaceChooseView)
		else
			UIStateManager.instance:push(ViewName.RankRaceSeasonEndView, lastClassicStar, lastExtremeStar)
		end
	end
end

function RankRaceController:getFirstOpenRemindView()
	local _keyStr = RoleModel.instance:getUserName() .. "firstOpenRemindView"
	local str = GameUtil.getLocalString(_keyStr)

	if not str or str == "" then
		return false, _keyStr
	else
		return true, ""
	end
end

function RankRaceController:IsRankRaceOpenTime(_type)
	local curWeekNum = self:getCurWeekNum()
	local config = RankRaceConfig.instance:getRankCommonConfig()

	if not config then
		return
	end

	local _openTime = config[_type][2]

	if _openTime ~= "" then
		local _openTimeArray = string.split(_openTime, ":")

		for i = 1, #_openTimeArray do
			if curWeekNum == tonumber(_openTimeArray[i]) then
				return true
			end
		end
	end

	return false
end

function RankRaceController:getCurWeekNum()
	local curDate = GameUtil.time2date(ServerTime.now())
	local curWeekNum = (curDate.wday - 1) % 7

	curWeekNum = curWeekNum == 0 and 7 or curWeekNum

	if self:_isRealToday() then
		return curWeekNum
	else
		curWeekNum = curWeekNum - 1
		curWeekNum = curWeekNum == 0 and 7 or curWeekNum

		return curWeekNum
	end
end

function RankRaceController:_isRealToday()
	local today_date = ServerTime.formatNow("%Y/%m/%d/%H/%M")
	local today_date_array = string.split(today_date, "/")

	if tonumber(today_date_array[4]) >= 0 and tonumber(today_date_array[4]) < 5 then
		return false
	else
		return true
	end
end

function RankRaceController:getDoubleRewardTime()
	local _cfg = RankRaceConfig.instance:getRankCommonConfig()
	local _doubleTimeStr = _cfg.DOUBLE_TIME.value
	local _doubleTimeStrArray = string.split(_doubleTimeStr, "#")
	local _beginHour = {}
	local _endHour = {}

	for i = 1, #_doubleTimeStrArray do
		local _signalTimeArray = string.split(_doubleTimeStrArray[i], ":")

		table.insert(_beginHour, _signalTimeArray[1])
		table.insert(_endHour, _signalTimeArray[2])
	end

	return _beginHour, _endHour
end

function RankRaceController:isInDoubleRewardTime()
	local _cfg = RankRaceConfig.instance:getRankCommonConfig()
	local _doubleTimeStr = _cfg.DOUBLE_TIME.value
	local _doubleTimeStrArray = string.split(_doubleTimeStr, "#")
	local _beginHour = {}
	local _endHour = {}

	for i = 1, #_doubleTimeStrArray do
		local _signalTimeArray = string.split(_doubleTimeStrArray[i], ":")

		table.insert(_beginHour, _signalTimeArray[1])
		table.insert(_endHour, _signalTimeArray[2])
	end

	local _nowTimeStamp = ServerTime.now()
	local _curDate = GameUtil.time2date(_nowTimeStamp)
	local _beginTimeStamp = {}
	local _endTimeStamp = {}

	for i = 1, #_doubleTimeStrArray do
		table.insert(_beginTimeStamp, os.time({
			second = 0,
			minute = 0,
			year = _curDate.year,
			month = _curDate.month,
			day = _curDate.day,
			hour = _beginHour[i]
		}))
		table.insert(_endTimeStamp, os.time({
			second = 0,
			minute = 0,
			year = _curDate.year,
			month = _curDate.month,
			day = _curDate.day,
			hour = _endHour[i]
		}))
	end

	for i = 1, #_doubleTimeStrArray do
		if _nowTimeStamp >= _beginTimeStamp[i] and _nowTimeStamp <= _endTimeStamp[i] then
			return true
		end
	end

	return false
end

function RankRaceController:setCloseForReset(tag)
	self._closeForReset = tag
end

function RankRaceController:getCloseForReset()
	return self._closeForReset
end

function RankRaceController:refreshMyLocalRankRes(msg)
	if self._openRankingMatchData then
		self._recordPreRank[msg.matchType + 1] = self._recordPreRank[msg.matchType + 1] or {}

		if self._recordRank then
			self._recordPreRank[msg.matchType + 1] = self._recordRank[msg.matchType + 1] or msg.myRank
		end

		self._recordRank[msg.matchType + 1] = self._recordRank[msg.matchType + 1] or {}
		self._recordRank[msg.matchType + 1] = msg.myRank
		self._openRankingMatchData[msg.matchType + 1].myRank = msg.myRank
	end

	self:_updateAllInfoData(self._openRankingMatchData[msg.matchType + 1])
	self:operView(ViewName.RankRaceClassicsView, function(_view)
		_view:_updateMyRank()
	end)
end

function RankRaceController:getRecordPreRank(_matchType)
	return (self._recordPreRank or nil) and (self._recordPreRank[_matchType] or -1)
end

function RankRaceController:rankModelReq(root, leaf)
	if not root or not leaf then
		return
	end

	self.rankModelReqTimeStamp = self.rankModelReqTimeStamp or {}

	if root == GameEnum.RankType.RankMatchClass then
		leaf = leaf == 0 and 1 or leaf

		local _nowTimeStamp = ServerTime.now()

		if self.rankModelReqTimeStamp and self.rankModelReqTimeStamp[1] and self.rankModelReqTimeStamp[1][leaf] then
			if _nowTimeStamp - self.rankModelReqTimeStamp[1][leaf] > RankRaceController.rankModelReqGapTime then
				self.rankModelReqTimeStamp[1][leaf] = _nowTimeStamp
			else
				local _rankMo = self:getRankMo(root, leaf)

				if _rankMo then
					RankModel.instance:setRankData(_rankMo, root, leaf)
					GlobalDispatcher:dispatch(GlobalNotify.RankDataGet)
				end

				return -1
			end
		else
			self.rankModelReqTimeStamp[1] = self.rankModelReqTimeStamp[1] or {}
			self.rankModelReqTimeStamp[1][leaf] = _nowTimeStamp
		end

		if leaf == 1 then
			RankingMatchAgent.instance:sendPM_GetRMLegendRankReq(0, 1, 1000, true)
		elseif leaf == 2 then
			RankingMatchAgent.instance:sendPM_GetRMLegendRankReq(0, 1, 1000)
		elseif leaf == 3 then
			RankingMatchAgent.instance:sendPM_GetRMPetRaceRankReq(0, true, 1, 1000)
		elseif leaf == 4 then
			RankingMatchAgent.instance:sendPM_GetRMPetRaceRankReq(0, false, 1, 1000)
		end
	elseif root == GameEnum.RankType.RankMatchLimit then
		leaf = leaf == 0 and 1 or leaf

		local _nowTimeStamp = ServerTime.now()

		if self.rankModelReqTimeStamp and self.rankModelReqTimeStamp[2] and self.rankModelReqTimeStamp[2][leaf] then
			if _nowTimeStamp - self.rankModelReqTimeStamp[2][leaf] > RankRaceController.rankModelReqGapTime then
				self.rankModelReqTimeStamp[2][leaf] = _nowTimeStamp
			else
				local _rankMo = self:getRankMo(root, leaf)

				if _rankMo then
					RankModel.instance:setRankData(_rankMo, root, leaf)
					GlobalDispatcher:dispatch(GlobalNotify.RankDataGet)
				end

				return -1
			end
		else
			self.rankModelReqTimeStamp[2] = self.rankModelReqTimeStamp[2] or {}
			self.rankModelReqTimeStamp[2][leaf] = _nowTimeStamp
		end

		if leaf == 1 then
			RankingMatchAgent.instance:sendPM_GetRMLegendRankReq(1, 1, 1000, true)
		elseif leaf == 2 then
			RankingMatchAgent.instance:sendPM_GetRMLegendRankReq(1, 1, 1000)
		elseif leaf == 3 then
			RankingMatchAgent.instance:sendPM_GetRMPetRaceRankReq(1, true, 1, 1000)
		elseif leaf == 4 then
			RankingMatchAgent.instance:sendPM_GetRMPetRaceRankReq(1, false, 1, 1000)
		end
	end
end

function RankRaceController:setRankMo(msg, root, leaf)
	self._rankMos = self._rankMos or {}
	self._rankMos[root] = self._rankMos[root] or {}
	self._rankMos[root][leaf] = msg or {}
end

function RankRaceController:getRankMo(root, leaf)
	if self._rankMos and self._rankMos[root] then
		return self._rankMos[root][leaf]
	else
		return nil
	end
end

function RankRaceController:calMaxFightPowerAnfSpeed(formationMo, heroSkillId, fid, flvl)
	local power, speed = 0, 0
	local team = {}
	local fff = {}

	for idx, v in ipairs(formationMo:GetPositions()) do
		if v > 0 then
			local pet = BagPetsController.instance:getPet(v)

			if pet then
				local maxMo = FightingPowerPetMo.getMaxPetMoByData(pet)

				if pet.petId ~= checknumber(formationMo.summonedPetId) then
					speed = speed + maxMo._speed
				end

				table.insert(team, maxMo)

				fff[idx] = maxMo
			end
		end
	end

	local eleMap = formationMo:getCurElementRelationMap()
	local masterId = formationMo:GetSummonMasterPetId()
	local summonId = formationMo:GetSummonPetId()
	local cutePetRaceId, cutePetQuality = 0, 0
	local var_94_0, var_94_1 = formationMo:getCutePetInfo()

	return FightingPowerFormula.instance:getTeamFightingPower(team, heroSkillId, fid, flvl, eleMap, var_94_0, var_94_1, masterId, summonId), speed
end

function RankRaceController:_OnApplicationResume()
	self:operView(ViewName.RankRaceFindEnemyView, function(_view)
		if self:getNotifyBeginGameResData() then
			self:matchComplete()
		end
	end)
end

function RankRaceController:getMyAreaIdAndAreaName()
	return (RoleModel.instance:getAreaName())
end

function RankRaceController:parseOpAreaInfo(_opHeadInfo)
	if not _opHeadInfo then
		return
	end

	if _opHeadInfo and _opHeadInfo.areaName then
		self:_setOpAreaInfo(_opHeadInfo.areaName)

		return _opHeadInfo.areaName
	end
end

function RankRaceController:_setOpAreaInfo(_areaName)
	self._opUserAreaName = _areaName
end

function RankRaceController:getOpAreaInfo()
	return self._opUserAreaName
end

function RankRaceController:setAvoidFormZdlDetailFlag(_flag)
	self._avoidFormZdlDetailFlag = _flag
end

function RankRaceController:getAvoidFormZdlDetailFlag()
	return self._avoidFormZdlDetailFlag
end

function RankRaceController:getCurSeasonTimeStr()
	local timeStr, seasonId = RankRaceConfig.instance:getCurSeasonTime()

	if not string.nilorempty(timeStr) then
		local times = string.split(timeStr, "#")
		local startDate = GameUtil.string2date(times[1])
		local endDate = GameUtil.string2date(times[2])

		return string.format("%04d/%02d/%02d~%04d/%02d/%02d", startDate.year, startDate.month, startDate.day, endDate.year, endDate.month, endDate.day), seasonId
	else
		return ""
	end
end

function RankRaceController:getNextSeasonTimeStr()
	local timeStr, seasonId = RankRaceConfig.instance:getNextSeasonTime()

	if not string.nilorempty(timeStr) then
		local times = string.split(timeStr, "#")
		local startDate = GameUtil.string2date(times[1])
		local endDate = GameUtil.string2date(times[2])

		return string.format("%04d.%02d.%02d-%04d.%02d.%02d", startDate.year, startDate.month, startDate.day, endDate.year, endDate.month, endDate.day), seasonId
	else
		return ""
	end
end

function RankRaceController:isSeasonLock()
	local list = RankRaceConfig.instance:getSeasonTimeCfgList()
	local curTimestamp = ServerTime.now()

	for i, v in ipairs(list) do
		local openTimestamp = GameUtil.string2time(v.openTime)
		local startTimestamp = GameUtil.string2time(v.startTime)

		if startTimestamp <= curTimestamp and curTimestamp <= openTimestamp then
			return true
		end

		if i ~= 1 then
			local preOpenTimestamp = GameUtil.string2time(list[i - 1].openTime)

			if preOpenTimestamp <= curTimestamp and curTimestamp <= startTimestamp then
				return false
			end
		end
	end

	return true
end

function RankRaceController:getClientSeasonId()
	local list = RankRaceConfig.instance:getSeasonTimeCfgList()

	for i = #list, 2, -1 do
		local last = list[i]
		local pre = list[i - 1]
		local isIn = GameUtil.checkIsInTimePeriod(pre.startTime, last.startTime)

		if isIn then
			return pre.seasonId
		end
	end

	return 0
end

RankRaceController.instance = RankRaceController.New()

return RankRaceController
