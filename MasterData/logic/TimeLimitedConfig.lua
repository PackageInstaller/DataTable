-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/config/TimeLimitedConfig.lua

module("logic.extensions.timelimitedchallenge.config.TimeLimitedConfig", package.seeall)

local TimeLimitedConfig = class("TimeLimitedConfig", BaseConfig)

function TimeLimitedConfig:onInit()
	TimeLimitedConfig.super.onInit(self)

	self._cofignameCfg = nil
end

function TimeLimitedConfig:getNames()
	return {
		"timed_challenge",
		"timed_challenge_exchange",
		"timed_challenge_circle_fight",
		"timed_challenge_circle_monster",
		"timed_challenge_circle_creeps",
		"timed_challenge_circle_progress",
		"timed_challenge_accumulate_fight",
		"timed_challenge_accumulate_monster",
		"timed_challenge_accumulate_creeps",
		"timed_challenge_accumulate_progress",
		"timed_challenge_accumulate_buff",
		"timed_challenge_exchange_open",
		"timed_challenge_rank",
		"timed_challenge_longhuang_game",
		"timed_challenge_longhuang_common",
		"timed_challenge_longhuang_buff",
		"timed_challenge_strategy",
		"timed_challenge_pet_rank"
	}
end

function TimeLimitedConfig:handleConfig(name, content)
	if name == "timed_challenge" then
		self._cofignameCfg = content
		self._redDict = {}

		for k, v in pairs(content) do
			if checknumber(k) > 0 and checknumber(v.redPointId) > 0 then
				self._redDict[v.redPointId] = v
			end
		end

		self._returnConfig = {}

		for k, v in pairs(content.dataList) do
			if checkint(v.returnId) > 0 then
				table.insert(self._returnConfig, v)
			end
		end

		table.sort(self._returnConfig, function(a, b)
			return a.returnId < b.returnId
		end)
	elseif name == "timed_challenge_exchange" then
		self._exChangeCfgs = content
	elseif name == "timed_challenge_circle_fight" then
		self._circleFightCfgs = content
	elseif name == "timed_challenge_circle_monster" then
		self._circleMonsterCfgs = content
	elseif name == "timed_challenge_circle_creeps" then
		self._circleCreepsCfgs = content
	elseif name == "timed_challenge_circle_progress" then
		self._circleProgressCfgs = content
	elseif name == "timed_challenge_accumulate_fight" then
		self._accumulateFightCfgs = content
	elseif name == "timed_challenge_accumulate_monster" then
		self._accumulateMonsterCfgs = content
	elseif name == "timed_challenge_accumulate_creeps" then
		self._accumulateCreepsCfgs = content
	elseif name == "timed_challenge_accumulate_progress" then
		self._accumulateProgressCfgs = content
	elseif name == "timed_challenge_accumulate_buff" then
		self.timed_challenge_accumulate_buffCfg = content
	elseif name == "timed_challenge_exchange_open" then
		self._exchangeOpenCfgs = content
	elseif name == "timed_challenge_rank" then
		self._timed_challenge_rank = content
	elseif name == "timed_challenge_longhuang_game" then
		self._longhuang_game = content
	elseif name == "timed_challenge_longhuang_common" then
		self._longhuang_common = content
	elseif name == "timed_challenge_longhuang_buff" then
		self._longhuangGameBuffCfg = content
	elseif name == "timed_challenge_strategy" then
		self._timed_challenge_strategy = content
	elseif name == "timed_challenge_pet_rank" then
		self._timed_challenge_pet_rank = content
	end
end

function TimeLimitedConfig:getCfgByRedPointId(redPointId)
	if self._redDict then
		return self._redDict[redPointId]
	end
end

function TimeLimitedConfig:getChallengeRanks()
	local dic = {}

	for k, v in pairs(self._timed_challenge_rank) do
		if checknumber(k) > 0 then
			dic[k] = TableUtil.toList(v)
		end
	end

	return TableUtil.toList(dic)
end

function TimeLimitedConfig:getChallengeRankCfgByRootAndLeat(root, leaf)
	if self._timed_challenge_rank and self._timed_challenge_rank[root] then
		local t = self._timed_challenge_rank[root]

		return t[leaf]
	end
end

function TimeLimitedConfig:getChallengeIdByRankType(rankType)
	local list = self._cofignameCfg.dataList

	for _, v in ipairs(list) do
		if v.rankType == rankType then
			return v.challengeId
		end
	end

	return 0
end

function TimeLimitedConfig:getExchangeOpens()
	return self._exchangeOpenCfgs.dataList
end

function TimeLimitedConfig:getCfgById(id)
	return self._cofignameCfg[id]
end

function TimeLimitedConfig:getTimedChallengeCfgs()
	return self._cofignameCfg.dataList
end

function TimeLimitedConfig:getTimedChallengeCfgByRaceId(raceId)
	for i, v in ipairs(self._cofignameCfg.dataList) do
		if v.raceId == raceId then
			return v
		end
	end
end

function TimeLimitedConfig:getTimedChallengeCfgByViewName(viewName)
	for i, v in ipairs(self._cofignameCfg.dataList) do
		if v.viewName == viewName then
			return v
		end
	end
end

function TimeLimitedConfig:getExchangeCfgsById(id)
	local t = {}

	for _, v in ipairs(self._exChangeCfgs) do
		if v.challengeId == id then
			table.insert(t, v)
		end
	end

	return t
end

function TimeLimitedConfig:getExchangeOpenCfg(id)
	if self._exchangeOpenCfgs then
		return self._exchangeOpenCfgs[id]
	end
end

function TimeLimitedConfig:getExchangeCfgById(id)
	return self._exChangeCfgs[id]
end

function TimeLimitedConfig:getCircleFightCfg(id)
	return self._circleFightCfgs[id]
end

function TimeLimitedConfig:getCircleFightCfgList()
	return self._circleFightCfgs.dataList
end

function TimeLimitedConfig:isCircleChallenge(id)
	return self._circleFightCfgs[id] ~= nil
end

function TimeLimitedConfig:getCircleCreeps(id)
	return self._circleCreepsCfgs[id]
end

function TimeLimitedConfig:getCircleMonsterCfg(challengeId, round)
	local list = self._circleMonsterCfgs.dataList
	local monsterCfgs = {}

	for _, v in ipairs(list) do
		if v.challengeId == challengeId then
			table.insert(monsterCfgs, v)
		end
	end

	return monsterCfgs[round]
end

function TimeLimitedConfig:getCircleProgressCfgs(id)
	local dic = self._circleProgressCfgs[id]

	return self:_dicToList(dic)
end

function TimeLimitedConfig:_dicToList(dic)
	local list = {}

	if dic then
		for _, v in pairs(dic) do
			table.insert(list, v)
		end
	end

	table.sort(list, function(a, b)
		return a.progressPercent < b.progressPercent
	end)

	return list
end

function TimeLimitedConfig:getAccumulateFightCfg(id)
	return self._accumulateFightCfgs[id]
end

function TimeLimitedConfig:getAccumulateCreeps(id)
	return self._accumulateCreepsCfgs[id]
end

function TimeLimitedConfig:getAccumulateMonsterCfg(id)
	return self._accumulateMonsterCfgs[id]
end

function TimeLimitedConfig:getAccumulateProgressCfgs(id)
	local dic = self._accumulateProgressCfgs[id]

	return self:_dicToList(dic)
end

function TimeLimitedConfig:getAllBuffList()
	return self.timed_challenge_accumulate_buffCfg.dataList
end

function TimeLimitedConfig:getBuffCfgById(id)
	return self.timed_challenge_accumulate_buffCfg[id]
end

function TimeLimitedConfig:getMaxBuffLv()
	if self._maxBuffLv ~= nil then
		return self._maxBuffLv
	end

	local list = self.timed_challenge_accumulate_buffCfg.dataList

	for _, v in ipairs(list) do
		self._maxBuffLv = self._maxBuffLv == nil and v.grade or math.max(v.grade, self._maxBuffLv)
	end

	return self._maxBuffLv
end

function TimeLimitedConfig:getLongHuangGameTimeCfg(time)
	local dataList = self._longhuang_game.dataList
	local id

	for k, v in ipairs(dataList) do
		if time < v.time then
			id = k

			break
		end
	end

	if id == nil then
		return dataList[#dataList]
	else
		return dataList[id - 1]
	end
end

function TimeLimitedConfig:getLongHuangCommonValue(key)
	local cfg = self._longhuang_common[key]

	if cfg then
		return cfg.value
	end
end

function TimeLimitedConfig:getLongHuangGameBuffCfgs()
	return self._longhuangGameBuffCfg.dataList
end

function TimeLimitedConfig:getLongHuangGameBuffCfg(time)
	local dataList = self._longhuangGameBuffCfg.dataList
	local id

	for k, v in ipairs(dataList) do
		if time < v.timeThreshold then
			id = k

			break
		end
	end

	if id == nil then
		return dataList[#dataList], true
	else
		return dataList[id - 1]
	end
end

function TimeLimitedConfig:getStrategyCfg(challengeId)
	local cfg = self:getCfgById(challengeId)

	if cfg then
		return self._timed_challenge_strategy[cfg.strategyId]
	end
end

function TimeLimitedConfig:getMinDodgeTime()
	local dataList = self._longhuangGameBuffCfg.dataList

	if dataList and dataList[1] then
		return checknumber(dataList[1].timeThreshold)
	else
		return 0
	end
end

function TimeLimitedConfig:getRankTypes()
	local list = {}

	for k, _ in pairs(self._timed_challenge_rank) do
		if checknumber(k) > 0 then
			table.insert(list, k)
		end
	end
end

function TimeLimitedConfig:isTimedChallengeRank(rankType)
	for k, _ in pairs(self._timed_challenge_rank) do
		if checknumber(k) > 0 and k == rankType then
			return true
		end
	end

	return false
end

function TimeLimitedConfig:getRedPointIds(challengeId)
	local cfg = self:getCfgById(challengeId)

	if not cfg then
		return {}
	end

	local list = {}

	if checknumber(cfg.redPointId) > 0 then
		table.insert(list, cfg.redPointId)
	end

	local cp = cfg.clientRedPointId
	local arr = string.split(cp .. "", "#")

	table.insertto(list, arr)

	return list
end

function TimeLimitedConfig:getReturnConfigs()
	return self._returnConfig or {}
end

function TimeLimitedConfig:getCurReturnRedPointIds()
	self._returnRedPointIds = {}

	for k, v in pairs(self._returnConfig) do
		local redPoints = self:getRedPointIds(v.challengeId)

		table.insertto(self._returnRedPointIds, redPoints)
	end

	for k, v in pairs(self._returnRedPointIds) do
		self._returnRedPointIds[k] = checknumber(v)
	end

	return self._returnRedPointIds or {}
end

function TimeLimitedConfig:getPetRankSize(raceId)
	local cfg = self._timed_challenge_pet_rank[raceId]

	if cfg then
		return cfg.rankSize
	end

	return nil
end

TimeLimitedConfig.instance = TimeLimitedConfig.New()

return TimeLimitedConfig
