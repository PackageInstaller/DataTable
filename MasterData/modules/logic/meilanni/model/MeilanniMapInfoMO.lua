-- chunkname: @modules/logic/meilanni/model/MeilanniMapInfoMO.lua

module("modules.logic.meilanni.model.MeilanniMapInfoMO", package.seeall)

local MeilanniMapInfoMO = pureTable("MeilanniMapInfoMO")

function MeilanniMapInfoMO:init(info)
	self.mapId = info.mapId
	self.mapConfig = lua_activity108_map.configDict[self.mapId]

	self:_initEpisodeInfos(info)

	self.score = info.score
	self.highestScore = info.highestScore
	self.getRewardIds = info.getRewardIds
	self.isFinish = info.isFinish
	self.totalCount = info.totalCount

	self:updateExcludeRules(info)
end

function MeilanniMapInfoMO:getExcludeRules()
	return self.excludeRules
end

function MeilanniMapInfoMO:updateExcludeRules(info)
	self.excludeRules = {}
	self.excludeRulesMap = {}
	self._excludeThreat = 0

	for i, v in ipairs(info.excludeRules) do
		local config = lua_activity108_rule.configDict[v]

		if config then
			local ruleId = tonumber(config.rules)

			table.insert(self.excludeRules, ruleId)

			self.excludeRulesMap[ruleId] = config
			self._excludeThreat = self._excludeThreat + config.threat
		end
	end
end

function MeilanniMapInfoMO:isExcludeRule(id)
	return self.excludeRulesMap[id]
end

function MeilanniMapInfoMO:getThreat()
	local threat = self.mapConfig.threat

	return math.max(threat - self._excludeThreat, 0)
end

function MeilanniMapInfoMO:getMaxScore()
	return self.highestScore
end

function MeilanniMapInfoMO:_initEpisodeInfos(info)
	self.episodeInfos = {}
	self._episodeInfoMap = {}

	for i, v in ipairs(info.episodeInfos) do
		local e = EpisodeInfoMO.New()

		e:init(v)
		table.insert(self.episodeInfos, e)

		self._episodeInfoMap[e.episodeId] = e
	end
end

function MeilanniMapInfoMO:updateEpisodeInfo(info)
	local episodeInfo = self._episodeInfoMap[info.episodeId]

	if not episodeInfo then
		episodeInfo = EpisodeInfoMO.New()

		episodeInfo:init(info)
		table.insert(self.episodeInfos, episodeInfo)

		self._episodeInfoMap[episodeInfo.episodeId] = episodeInfo
	else
		episodeInfo:init(info)
	end
end

function MeilanniMapInfoMO:getEpisodeInfo(episodeId)
	return self._episodeInfoMap[episodeId]
end

function MeilanniMapInfoMO:getCurEpisodeInfo()
	return self.episodeInfos[#self.episodeInfos]
end

function MeilanniMapInfoMO:checkFinish()
	return self.isFinish and self:getCurEpisodeInfo().confirm
end

function MeilanniMapInfoMO:getEventInfo(id)
	local curEpisodeInfo = self:getCurEpisodeInfo()

	return curEpisodeInfo:getEventInfo(id)
end

function MeilanniMapInfoMO:getEpisodeByBattleId(id)
	for i, v in ipairs(self.episodeInfos) do
		if v:getEventByBattleId(id) then
			return v
		end
	end
end

function MeilanniMapInfoMO:isGetReward(id)
	return tabletool.indexOf(self.getRewardIds, id)
end

function MeilanniMapInfoMO:getTotalCostAP()
	if not self._episodeInfoMap then
		return 0
	end

	local totalCostAP = 0

	for episodeId, episodeInfo in pairs(self._episodeInfoMap) do
		local episodeConfig = MeilanniConfig.instance:getEpisodeConfig(episodeId)

		totalCostAP = totalCostAP + episodeConfig.actpoint - episodeInfo.leftActPoint
	end

	return totalCostAP
end

return MeilanniMapInfoMO
