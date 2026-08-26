-- chunkname: @modules/logic/versionactivity1_6/dungeon/config/Activity149Config.lua

module("modules.logic.versionactivity1_6.dungeon.config.Activity149Config", package.seeall)

local Activity149Config = class("Activity149Config", BaseConfig)

function Activity149Config:ctor()
	self._bossEpisodeCfgList = {}
	self._bossEpisodeCfgDict = {}
	self._bossMapElementDict = {}
	self._rewardCfgDict = {}
	self._rewardCfgList = {}
	self._activityConstDict = {}
end

function Activity149Config:reqConfigNames()
	return {
		"activity149_episode",
		"activity149_rewards",
		"activity149_const",
		"activity149_map_element"
	}
end

function Activity149Config:onConfigLoaded(configName, configTable)
	if configName == "activity149_episode" then
		self._bossEpisodeCfgList = configTable.configList
		self._bossEpisodeCfgDict = configTable.configDict
	elseif configName == "activity149_rewards" then
		self:initRewardCfg(configTable)
	elseif configName == "activity149_const" then
		self._activityConstDict = configTable.configDict
	elseif configName == "activity149_map_element" then
		self._bossMapElementDict = configTable.configDict
	end
end

function Activity149Config:initRewardCfg(configTable)
	self._rewardCfgDict = configTable.configDict
	self._rewardCfgList = configTable.configList
	self._maxScore = 0

	for i, rewardCfg in ipairs(self._rewardCfgList) do
		self._maxScore = math.max(self._maxScore, rewardCfg.rewardPointNum)
	end
end

function Activity149Config:getAct149EpisodeCfg(id)
	return self._bossEpisodeCfgDict[id]
end

function Activity149Config:getDungeonEpisodeCfg(id)
	local bossCfg = self._bossEpisodeCfgDict[id]

	return lua_episode.configDict[bossCfg.episodeId]
end

function Activity149Config:getAct149EpisodeCfgByOrder(order, asList)
	if asList then
		local result = {}

		for _, cfg in pairs(self._bossEpisodeCfgDict) do
			if cfg.order == order then
				result[#result + 1] = cfg
			end
		end

		return result
	end

	for _, cfg in pairs(self._bossEpisodeCfgDict) do
		if cfg.order == order then
			return cfg
		end
	end
end

function Activity149Config:getAct149EpisodeCfgByEpisodeId(episodeId)
	for _, cfg in pairs(self._bossEpisodeCfgDict) do
		if cfg.episodeId == episodeId then
			return cfg
		end
	end
end

function Activity149Config:getNextBossEpisodeCfgById(id)
	local curBossCfg = self._bossEpisodeCfgDict[id]
	local nextBossCfg = self._bossEpisodeCfgDict[id + 1]
	local curBossOrder = curBossCfg.order

	if nextBossCfg then
		if nextBossCfg.order == curBossOrder then
			return nextBossCfg
		end
	else
		for _, cfg in ipairs(self._bossEpisodeCfgList) do
			if curBossOrder == cfg.order then
				return cfg
			end
		end
	end
end

function Activity149Config:getEpisodeMaxScore(id, activityId)
	local cfg = self._bossEpisodeCfgDict[id]

	if not cfg then
		return 0
	end

	local baseScore = tonumber(self._activityConstDict[1].value)

	return baseScore * cfg.multi
end

function Activity149Config:getAct149BossMapElement(Id)
	return self._bossMapElementDict[Id]
end

function Activity149Config:getAct149BossMapElementByMapId(mapId)
	for _, cfg in pairs(self._bossMapElementDict) do
		if cfg.mapId == mapId then
			return cfg
		end
	end
end

function Activity149Config:getAct149ConstValue(id)
	local cfg = self._activityConstDict[id]

	return cfg and cfg.value
end

function Activity149Config:getBossRewardCfgList()
	return self._rewardCfgList
end

function Activity149Config:getBossRewardMaxScore()
	return self._maxScore
end

function Activity149Config:calRewardProgressWidth(value, cellSpaceH, cellWidth, firstStep, normalStep, startPosX, endSpace)
	local rewardCfgList = self:getBossRewardCfgList()
	local rewardCount = #rewardCfgList

	if rewardCount == 0 then
		return 0, 0
	end

	startPosX = startPosX or 0
	endSpace = endSpace or 0
	firstStep = firstStep or cellWidth / 2
	normalStep = normalStep or cellWidth + cellSpaceH

	local maxWidth = firstStep + (rewardCount - 1) * normalStep + endSpace
	local curWidth = 0
	local last = 0

	for i, rewardCfg in ipairs(rewardCfgList) do
		local num = rewardCfg.rewardPointNum
		local step = i == 1 and firstStep or normalStep

		if num <= value then
			curWidth = curWidth + step
			last = num
		else
			local offset = GameUtil.remap(value, last, num, 0, step)

			curWidth = curWidth + offset

			break
		end
	end

	local width = math.max(0, curWidth - startPosX)

	return width, maxWidth
end

function Activity149Config:getAlternateDay()
	if not self._alternateDay then
		self._alternateDay = 1

		if self._bossEpisodeCfgDict then
			for _, cfg in pairs(self._bossEpisodeCfgDict) do
				if not string.nilorempty(cfg.effectCondition) then
					local day = string.splitToNumber(cfg.effectCondition, "_")

					if day and day[2] then
						self._alternateDay = math.max(self._alternateDay, day[2])
					end
				end
			end
		end
	end

	return self._alternateDay
end

Activity149Config.instance = Activity149Config.New()

return Activity149Config
