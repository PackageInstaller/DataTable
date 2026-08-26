-- chunkname: @modules/logic/autochess/act182/model/Act182MO.lua

module("modules.logic.autochess.act182.model.Act182MO", package.seeall)

local Act182MO = pureTable("Act182MO")

function Act182MO:init(info)
	self.activityId = info.activityId
	self.passEpisodeIds = info.passEpisodeIds
	self.rank = info.rank
	self.score = info.score
	self.gameMos = {}

	for _, v in ipairs(info.gameInfos) do
		local gameMo = AutoChessGameMO.New()

		gameMo:init(v)
		table.insert(self.gameMos, gameMo)
	end

	self.historyInfo = info.historyInfo
	self.doubleScoreTimes = info.doubleScoreTimes
	self.gainRewardRank = info.gainRewardRank

	self:updateSnapshot(info.snapshot)

	self.warnLevel = info.warnLevel
	self.warnExp = info.warnExp
end

function Act182MO:update(info)
	if info.rank > self.rank then
		self.rankUp = true

		if info.rank > self.historyInfo.maxRank then
			self.newRankUp = true
		end
	end

	self.passEpisodeIds = info.passEpisodeIds
	self.rank = info.rank
	self.score = info.score

	for _, v in ipairs(info.gameInfos) do
		local gameMo = self:getGameMo(v.activityId, v.module, true)

		if not gameMo then
			gameMo = AutoChessGameMO.New()

			table.insert(self.gameMos, gameMo)
		end

		gameMo:init(v)
	end

	self.historyInfo = info.historyInfo
	self.doubleScoreTimes = info.doubleScoreTimes
	self.gainRewardRank = info.gainRewardRank
	self.snapshot = info.snapshot

	if info.warnLevel > self.warnLevel then
		self.warnLevelUp = true
	end

	self.warnLevel = info.warnLevel
	self.warnExp = info.warnExp
end

function Act182MO:updateSnapshot(snapshot, refresh)
	self.snapshot = snapshot
end

function Act182MO:updateFriendSnapshot(friendSnapshots, refresh)
	self._friendSnapshots = self._friendSnapshots or {}

	local friendUserId = friendSnapshots.playerInfo.userId

	if friendUserId ~= 0 then
		self._friendSnapshots[friendUserId] = friendSnapshots
		self._curFriendSnapshot = friendSnapshots
	end
end

function Act182MO:updateFriendInfoList(friendPlayerInfos, refresh)
	self._friendPlayerInfos = friendPlayerInfos
end

function Act182MO:updateFriendFightRecords(fightRecords, refresh)
	self._friendFightRecords = fightRecords
end

function Act182MO:getCurFriendSnapshot()
	return self._curFriendSnapshot
end

function Act182MO:getFriendInfoList()
	return self._friendPlayerInfos
end

function Act182MO:getFriendFightRecords()
	return self._friendFightRecords
end

function Act182MO:isEpisodePass(episodeId)
	if tabletool.indexOf(self.passEpisodeIds, episodeId) then
		return true
	else
		return false
	end
end

function Act182MO:isEpisodeUnlock(episodeId)
	local episodeCo = AutoChessConfig.instance:getEpisodeCO(episodeId)
	local preEpisodeId = episodeCo.preEpisode

	if preEpisodeId == 0 then
		return true
	elseif self:isEpisodePass(preEpisodeId) then
		return true
	end

	return false
end

function Act182MO:clearRankUpMark()
	self.rankUp = false
	self.newRankUp = false
end

function Act182MO:clearWarnLevelUpMark()
	self.warnLevelUp = false
end

function Act182MO:getGameMo(actId, moduleId, ignore)
	for _, v in ipairs(self.gameMos) do
		if v.activityId == actId and v.module == moduleId then
			return v
		end
	end

	if not ignore then
		logError(string.format("活动: %s 模块: %s 不存在Act182AutoChessGameInfo", actId, moduleId))
	end
end

function Act182MO:getMaxRound(episodeId)
	local episodeRound = 999

	if episodeId then
		local episodeCo = AutoChessConfig.instance:getEpisodeCO(episodeId)

		episodeRound = episodeCo.maxRound
	end

	local rankCfg = lua_auto_chess_rank.configDict[self.activityId][self.rank]

	if rankCfg.maxRound ~= 0 then
		if not rankCfg.maxRound then
			local rankRound = 999

			return math.min(episodeRound, rankRound)
		end
	end
end

function Act182MO:checkCollectionReddot()
	local collectionCfgs = AutoChessConfig.instance:getSpecialCollectionCfgs()
	local key = AutoChessStrEnum.ClientReddotKey.SpecialCollection

	for _, config in ipairs(collectionCfgs) do
		local unlockLvl = AutoChessConfig.instance:getCollectionUnlockLevel(config.id)

		if unlockLvl <= self.warnLevel and AutoChessHelper.getUnlockReddot(key, config.id) then
			return true
		end
	end

	local leaderCfgs = AutoChessConfig.instance:getSpecialLeaderCfgs()

	key = AutoChessStrEnum.ClientReddotKey.SpecialLeader

	for _, config in ipairs(leaderCfgs) do
		local unlockLvl = AutoChessConfig.instance:getLeaderUnlockLevel(config.id)

		if unlockLvl <= self.warnLevel and AutoChessHelper.getUnlockReddot(key, config.id) then
			return true
		end
	end

	return false
end

function Act182MO:checkBossReddot()
	local key = AutoChessStrEnum.ClientReddotKey.Boss

	for _, config in ipairs(lua_auto_chess_boss.configList) do
		local unlockLvl = AutoChessConfig.instance:getBossUnlockLevel(config.id)

		if unlockLvl <= self.warnLevel and AutoChessHelper.getUnlockReddot(key, config.id) then
			return true
		end
	end

	return false
end

function Act182MO:checkCardpackReddot()
	local key = AutoChessStrEnum.ClientReddotKey.Cardpack

	for _, config in pairs(lua_auto_chess_cardpack.configDict[self.activityId]) do
		local unlockLvl = AutoChessConfig.instance:getCardpackUnlockLevel(config.id)

		if unlockLvl <= self.warnLevel and AutoChessHelper.getUnlockReddot(key, config.id) then
			return true
		end
	end

	return false
end

return Act182MO
