-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/rank/controller/RankSystem.lua

require("dm.gameplay.rank.model.Rank")

EVT_RANK_GOT_REWARD_SUCC = "EVT_RANK_GOT_REWARD_SUCC"
EVT_RANK_OPNE_SYNC = "EVT_RANK_OPNE_SYNC"
RankSystem = class("RankSystem", Facade, _M)

RankSystem:has("_rankService", {
	is = "r"
}):injectWith("RankService")
RankSystem:has("_gameServerAgent", {
	is = "r"
}):injectWith("GameServerAgent")
RankSystem:has("_rank", {
	is = "r"
})
RankSystem:has("_systemKeeper", {
	is = "r"
}):injectWith("SystemKeeper")
RankSystem:has("_rankGotRewards", {
	is = "rw"
})
RankSystem:has("_rankRewardList", {
	is = "rw"
})
RankSystem:has("_eventDispatcher", {
	is = "r"
}):injectWith("legs_sharedEventDispatcher")

RankType = {
	kCollection = 51,
	kBlockStar = 2,
	KWBVanguard = 47,
	KPetWorldScore = 25,
	kJump = 44,
	KPlane = 46,
	kPetRace = 11,
	kMazeTower = 49,
	kSupport = 40,
	kClubBoss = 41,
	KWorldPeaceHurt = 162,
	KRTPK = 26,
	kExp = 6,
	kClub = 9,
	KWorldPeaceScore = 164,
	KStageAreana = 43,
	kGold = 5,
	kMap = 14,
	kMaze = 15,
	kSubPetRace = 24,
	kCrystal = 7,
	kArena = 0,
	kCombat = 1,
	kCrusade = 30,
	kHeroCombat = 3,
	KWBBoss = 48,
	KNewAreana = 45,
	kDarts = 42
}
RankClass = {
	[RankType.kCombat] = CombatRankRecord,
	[RankType.kBlockStar] = BlockRankRecord,
	[RankType.kHeroCombat] = HeroRankRecord,
	[RankType.kPetRace] = PetRaceRankRecord,
	[RankType.kSubPetRace] = SubPetRaceRankRecord,
	[RankType.kGold] = SpGoldRankRecord,
	[RankType.kExp] = SpExpRankRecord,
	[RankType.kCrystal] = SpCrystalRankRecord,
	[RankType.kClub] = ClubRankRecord,
	[RankType.kMap] = MapRankRecord,
	[RankType.kMaze] = MazeRankRecord,
	[RankType.kArena] = ArenaRankRecord,
	[RankType.kCrusade] = CrusadeRankRecord,
	[RankType.kClubBoss] = ClubBossRankRecord,
	[RankType.kDarts] = MiniGameRankRecord,
	[RankType.KRTPK] = RTPKRankRecord,
	[RankType.KPetWorldScore] = PetWorldScoreRankRecord,
	[RankType.KStageAreana] = StageAreanaRankRecord,
	[RankType.kJump] = MiniGameJumpRankRecord,
	[RankType.KPlane] = MiniGamePlaneRankRecord,
	[RankType.KNewAreana] = ArenaNewRankRecord,
	[RankType.KWBVanguard] = WorldBossRankRecord,
	[RankType.KWBBoss] = WorldBossRankRecord,
	[RankType.kMazeTower] = MazeTowerRankRecord,
	[RankType.kCollection] = CollectionRankRecord,
	[RankType.KWorldPeaceHurt] = WorldPeaceHurtRecord,
	[RankType.KWorldPeaceScore] = WorldPeaceScoreRecord
}
RankSwitch = {
	[RankType.kClubBoss] = "fn_clubBoss",
	[RankType.kArena] = "fn_arena_normal"
}
RankTopImage = {
	"img_zlb_no1.png",
	"img_zlb_no2.png",
	"img_zlb_no3.png"
}

local kShowRankBest = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Rank_Weekly_List", "content")

function RankSystem:initialize()
	super.initialize(self)

	self._rank = Rank:new()
	self._rankGotRewards = {}
	self._rankRewardList = {}

	self:getRewardRankListData()
end

function RankSystem:userInject(injector)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_SYSTEM_LEVELUP, self, self.systemLevelUpListener)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_RANK_OPNE_SYNC, self, self.systemStageLevelUpListener)
end

function RankSystem:synchronize(data, rankType)
	self._rank:synchronize(data, rankType)
end

function RankSystem:synchronizeRankRewards(data)
	for key, value in pairs(data) do
		self._rankGotRewards[value] = true
	end

	self:requestGetRewardList()
end

function RankSystem:checkEnabled(data)
	local unlock, tips = self._systemKeeper:isUnlock("Rank_Main")

	return unlock, tips
end

function RankSystem:checkRewardEnabled(data)
	local unlock, tips = self._systemKeeper:isUnlock("RankList")

	return unlock, tips
end

function RankSystem:systemLevelUpListener(data)
	local unlock, tips = self:checkRewardEnabled()

	if unlock then
		self.unmapEventListener(self, self:getEventDispatcher(), EVT_SYSTEM_LEVELUP, self, self.systemLevelUpListener)
	end

	local unlock1, tips = self:checkEnabled()

	if unlock and unlock1 then
		self:requestGetRewardList()
	end
end

function RankSystem:systemStageLevelUpListener(data)
	local unlock, tips = self:checkEnabled()

	if unlock then
		self.unmapEventListener(self, self:getEventDispatcher(), EVT_RANK_OPNE_SYNC, self, self.systemStageLevelUpListener)
	end

	local unlock1, tips = self:checkRewardEnabled()

	if unlock and unlock1 then
		self:requestGetRewardList()
	end
end

function RankSystem:tryEnter(data)
	self:requestGetRewardList()

	local unlock, tips = self:checkEnabled(data)

	if not unlock then
		self:dispatch(ShowTipEvent({
			duration = 0.2,
			tip = tips
		}))

		return
	end

	local remoteTimestamp = self._gameServerAgent:remoteTimestamp()
	local date = TimeUtil:localDate("*t", remoteTimestamp)

	if not kShowRankBest[date.wday] then
		local rankId = RankType.kCombat

		remoteTimestamp = remoteTimestamp + 86400

		local date = TimeUtil:localDate("*t", remoteTimestamp)

		if not kShowRankBest[date.wday] then
			local nextRankId = RankType.kCombat

			local function callback()
				local view = self:getInjector():getInstance("RankBestView")

				self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
					transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
				}, {
					index = rankId,
					nextIndex = nextRankId
				}))
			end

			self._bestRankCount = 0

			local sendData = {
				rankStart = 1,
				type = rankId,
				rankEnd = self:getRequestRankCountPerTime()
			}

			self:requestRankData(sendData, function()
				self._bestRankCount = self._bestRankCount + 1

				if self._bestRankCount == 2 then
					self._bestRankCount = 0

					callback()
				end
			end)

			local sendData = {
				rankStart = 1,
				type = RankType.kClub,
				rankEnd = self:getRequestRankCountPerTime()
			}

			self:requestRankData(sendData, function()
				self._bestRankCount = self._bestRankCount + 1

				if self._bestRankCount == 2 then
					self._bestRankCount = 0

					callback()
				end
			end)
		end
	end
end

function RankSystem:tryEnterRank(data)
	local unlock, tips = self:checkEnabled(data)

	if not unlock then
		self:dispatch(ShowTipEvent({
			duration = 0.2,
			tip = tips
		}))

		return
	end

	if data then
		if not data.index then
			local rankId = RankType.kCombat

			local function callback()
				local view = self:getInjector():getInstance("RankView")

				self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
					transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
				}, {
					index = rankId,
					allRankData = data.allRankData
				}))
			end

			local sendData = {
				rankStart = 1,
				type = rankId,
				rankEnd = self:getRequestRankCountPerTime()
			}

			self:requestRankData(sendData, callback, data.blockUI)
		end
	end
end

function RankSystem:getAllRankData()
	local allRankData = ConfigReader:getDataTable("RankOrder")
	local rankData = {}

	for k, v in pairs(allRankData) do
		if not RankSwitch[v.AppID] or CommonUtils.GetSwitch(RankSwitch[v.AppID]) then
			table.insert(rankData, v)
		end
	end

	table.sort(rankData, function(a, b)
		return a.Order < b.Order
	end)

	return rankData
end

function RankSystem:requestRankData(data, callback, blockUI)
	local params = {
		type = data.type,
		start = data.rankStart,
		["end"] = data.rankEnd
	}

	self._rankService:requestRankData(params, blockUI, function(response)
		local syncTime = self:getCurrentTime()

		if data.rankStart == 1 then
			self._rank:cleanUpRankList(data.type)
		end

		self._rank:synchronize(response.data, data.type, syncTime)
		self:dispatch(Event:new(EVT_RANK_REQUEST_SUCC))

		if callback then
			callback(response)
		end
	end)
end

function RankSystem:requestRTPKAllServerRankData(data, callback, blockUI)
	local params = {
		type = data.type,
		start = data.rankStart,
		["end"] = data.rankEnd
	}

	self._rankService:requestRTPKAllServerRankData(params, blockUI, function(response)
		local syncTime = self:getCurrentTime()

		if data.rankStart == 1 then
			self._rank:cleanUpRankList(data.type)
		end

		self._rank:synchronize(response.data, data.type, syncTime)
		self:dispatch(Event:new(EVT_RANK_REQUEST_SUCC))

		if callback then
			callback(response)
		end
	end)
end

function RankSystem:requestStageAreanaAllServerRankData(data, callback, blockUI)
	local params = {
		rankType = data.type,
		start = data.rankStart,
		["end"] = data.rankEnd
	}

	self._rankService:requestStageAreanaAllServerRankData(params, blockUI, function(response)
		local syncTime = self:getCurrentTime()

		if data.rankStart == 1 then
			self._rank:cleanUpRankList(data.type)
		end

		self._rank:synchronize(response.data, data.type, syncTime)
		self:dispatch(Event:new(EVT_RANK_REQUEST_SUCC))

		if callback then
			callback(response)
		end
	end)
end

function RankSystem:requestSupportRankRewardData(data, callback)
	local params = {
		type = data.type,
		subIds = data.subIds,
		start = data.rankStart,
		["end"] = data.rankEnd
	}

	self._rankService:requestSupportRankData(params, true, function(response)
		local syncTime = self:getCurrentTime()

		if data.rankStart == 1 then
			self._rank:cleanUpRankList(data.type)
		end

		self._rank:synchronize(response.data, data.type, syncTime)
		self:dispatch(Event:new(EVT_RANK_REQUEST_SUCC))

		if callback then
			callback(response)
		end
	end)
end

function RankSystem:requestAloneRankData(data, callback, blockUI)
	local params = {
		type = data.type,
		subId = data.subId,
		start = data.rankStart,
		["end"] = data.rankEnd
	}

	self._rankService:requestAloneRankData(params, blockUI, function(response)
		if response.resCode == GS_SUCCESS then
			if data.type == RankType.kSupport then
				return
			end

			if data.rankStart == 1 then
				self._rank:cleanUpRankList(data.type)
			end

			local syncTime = self:getCurrentTime()

			self._rank:synchronize(response.data, data.type, syncTime)

			if callback then
				callback(response)
			end
		end
	end)
end

function RankSystem:getRankListByType(type)
	local rankInfo = self._rank:getRankInfo()
	local rankList = rankInfo[type]:getRankList()

	return rankList or {}
end

function RankSystem:getMyselfDataByType(type)
	local rankInfo = self._rank:getRankInfo()

	return (rankInfo[type]:getSelfRecord())
end

function RankSystem:getRankCountByType(type)
	local rankInfo = self._rank:getRankInfo()

	return (rankInfo[type]:getRecordCount())
end

function RankSystem:getRankRecordByTypeAndIndex(type, index)
	local rankInfo = self._rank:getRankInfo()
	local rankList = rankInfo[type]:getRankList()

	return rankList[index]
end

function RankSystem:getMyselfShowInfoByType(record)
	local data = {}

	if record then
		if record:getRankType() == RankType.kCombat then
			data[1] = record:getRank()
			data[2] = record:getName()
			data[3] = record:getClubName() == "" and Strings:get("ARENA_NO_RANK") or record:getClubName()
			data[4] = record:getMaxCombat()
		elseif record:getRankType() == RankType.kBlockStar then
			data[1] = record:getRank()
			data[2] = record:getName()
			data[3] = record:getClubName() == "" and Strings:get("ARENA_NO_RANK") or record:getClubName()
			data[4] = record:getStar()
		elseif record:getRankType() == RankType.kMap then
			data[1] = record:getRank()
			data[2] = record:getName()
			data[3] = record:getClubName() == "" and Strings:get("ARENA_NO_RANK") or record:getClubName()
			data[4] = record:getDp()
		elseif record:getRankType() == RankType.KPetWorldScore then
			data[1] = record:getRank()
			data[2] = record:getName()
			data[3] = record:getWinNum()
			data[4] = record:getScore()
		elseif record:getRankType() == RankType.kSubPetRace then
			data[1] = record:getRank()
			data[2] = record:getName()
			data[3] = record:getWinNum()
			data[4] = record:getScore()
		elseif record:getRankType() == RankType.kClub then
			data[1] = record:getRank()
			data[2] = record:getClubName()

			local clubSystem = self:getInjector():getInstance("ClubSystem")

			if not clubSystem:getHasJoinClub() then
				data[2] = Strings:get("RANK_UI15")
			end

			data[3] = record:getPresidentName()
			data[4] = record:getComatValue()
		elseif record:getRankType() == RankType.kClubBoss then
			data[1] = record:getRank()
			data[2] = record:getClubName()

			local clubSystem = self:getInjector():getInstance("ClubSystem")

			if not clubSystem:getHasJoinClub() then
				data[2] = Strings:get("RANK_UI15")
			end

			data[3] = record:getPresidentName()
			data[4] = record:getComatValue()
		elseif record:getRankType() == RankType.kMaze then
			data[1] = record:getRank()
			data[2] = record:getName()
			data[3] = record:getClubName() == "" and Strings:get("ARENA_NO_RANK") or record:getClubName()
			data[4] = record:getChapterCount()
		elseif record:getRankType() == RankType.kArena then
			data[1] = record:getRank()
			data[2] = record:getName()
			data[3] = record:getClubName() == "" and Strings:get("ARENA_NO_RANK") or record:getClubName()
			data[4] = record:getScore()
		elseif record:getRankType() == RankType.kCrusade then
			data[1] = record:getRank()
			data[2] = record:getName()
			data[3] = record:getClubName() == "" and Strings:get("ARENA_NO_RANK") or record:getClubName()
			data[4] = record:getPoint()
		elseif record:getRankType() == RankType.kCollection then
			data[1] = record:getRank()
			data[2] = record:getName()
			data[3] = record:getClubName() == "" and Strings:get("ARENA_NO_RANK") or record:getClubName()
			data[4] = record:getScore()
		end
	end

	return data
end

function RankSystem:resetSyncTime()
	self:getRank():resetAllRankListSyncTime()
end

function RankSystem:getCurrentTime()
	return self._gameServerAgent:remoteTimestamp()
end

function RankSystem:getMaxRank()
	return ConfigReader:getDataByNameIdAndKey("ConfigValue", "Rank_Show_Number", "content")
end

function RankSystem:getRTPKMaxRank()
	return ConfigReader:getDataByNameIdAndKey("ConfigValue", "RTPK_RankMax", "content")
end

function RankSystem:getLeadStageAreanaMaxRank()
	return ConfigReader:getDataByNameIdAndKey("ConfigValue", "StageArena_RankMax", "content")
end

function RankSystem:getNewAreanaMaxRank()
	return ConfigReader:getDataByNameIdAndKey("ConfigValue", "ChessArena_Rank_Num", "content")
end

function RankSystem:getRequestRankCountPerTime()
	return 20
end

function RankSystem:isServerDataEnough(type)
	local rankInfo = self._rank:getRankInfo()

	return (rankInfo[type]:getDataEnough())
end

function RankSystem:cleanUpRankList()
	for k, v in pairs(RankType) do
		self._rank:cleanUpRankList(v)
	end
end

function RankSystem:cleanUpRankListByType(type)
	self._rank:cleanUpRankList(type)
end

function RankSystem:requestGetRewardList(data, callback, blockUI)
	local unlock, tips = self:checkRewardEnabled()
	local unlock1, tips = self:checkEnabled()

	if not unlock or not unlock1 then
		return
	end

	local params = {}

	self._rankService:requestGetRewardList(params, blockUI, function(response)
		if response.resCode == GS_SUCCESS then
			self:syncRewardList(response.data)

			if callback then
				callback(response)
			end

			self:dispatch(Event:new(EVT_HOMEVIEW_REDPOINT_REF, {
				type = 5
			}))
		end
	end)
end

function RankSystem:requestObtainRewardList(data, callback, blockUI)
	local params = {
		id = data.id,
		obtainType = data.obtainType
	}

	self._rankService:requestObtainRewardList(params, blockUI, function(response)
		if response.resCode == GS_SUCCESS then
			if callback then
				callback(response)
			end

			if response.data.reward then
				local view = self:getInjector():getInstance("getRewardView")

				self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
					maskOpacity = 0
				}, {
					needClick = true,
					rewards = response.data.reward
				}))
			end

			self:dispatch(Event:new(EVT_RANK_GOT_REWARD_SUCC))
			self:dispatch(Event:new(EVT_HOMEVIEW_REDPOINT_REF, {
				type = 5
			}))
		end
	end)
end

function RankSystem:syncRewardList(data)
	for rankRewardId, players in pairs(data) do
		local list = {}

		for playerId, playerData in pairs(players) do
			list[#list + 1] = playerData
		end

		table.sort(list, function(a, b)
			return a.time < b.time
		end)

		self._rankRewardList[rankRewardId] = list
	end
end

function RankSystem:getRewardRankListData(rankType)
	if not self._rankRewardListData then
		self._rankRewardListData = {}

		local d = ConfigReader:getDataTable("RankList")

		for id, value in pairs(d) do
			self._rankRewardListData[value.Type] = self._rankRewardListData[value.Type] or {}
			self._rankRewardListData[value.Type][#self._rankRewardListData[value.Type] + 1] = value
		end

		for idx, value in pairs(self._rankRewardListData) do
			table.sort(self._rankRewardListData[idx], function(a, b)
				return a.ShowRank < b.ShowRank
			end)
		end
	end

	return (rankType or nil) and (self._rankRewardListData[rankType] or self._rankRewardListData)
end

function RankSystem:getRewardRedPointByRankType(rankType)
	local data = self:getRewardRankListData(rankType)

	if data then
		local rewardList = self:getRankRewardList()
		local gotRewards = self:getRankGotRewards()

		for key, value in pairs(data) do
			local firstNumLimit = 0
			local secondNumLimit = 0

			if not value.StageRank then
				return false
			end

			for k1, StageRank in pairs(value.StageRank) do
				if k1 == 1 then
					for k2, v in pairs(StageRank) do
						firstNumLimit = tonumber(k2)
					end
				elseif k1 == 2 then
					for k2, v in pairs(StageRank) do
						secondNumLimit = tonumber(k2)
					end
				end
			end

			if rewardList[value.Id] and not gotRewards[value.Id] and firstNumLimit <= #rewardList[value.Id] or rewardList[value.Id] and not gotRewards[value.Id .. "_1"] and secondNumLimit <= #rewardList[value.Id] then
				return true
			end
		end
	end

	return false
end

function RankSystem:getRewardRedPoint()
	for rankType, value in pairs(self._rankRewardListData) do
		if self:getRewardRedPointByRankType(rankType) then
			return true
		end
	end

	return false
end
