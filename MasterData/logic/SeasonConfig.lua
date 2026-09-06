-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/config/SeasonConfig.lua

module("logic.extensions.season.config.SeasonConfig", package.seeall)

local SeasonConfig = class("SeasonConfig", BaseConfig)

function SeasonConfig:onInit()
	SeasonConfig.super.onInit(self)

	self._eventType2Configs = {}
end

function SeasonConfig:getNames()
	return {
		"season_mode",
		"season_mode_pve_common",
		"season_mode_pve",
		"season_mode_pve_map",
		"season_mode_pve_event_challenge",
		"season_mode_pve_event_prize",
		"season_mode_pve_event_medal",
		"season_mode_pve_event_convey",
		"season_mode_pve_event_lock",
		"season_mode_pve_event_game",
		"season_mode_pve_event_wooden",
		"season_mode_pve_event_wooden_damage",
		"season_mode_pve_creeps_team",
		"season_mode_pve_creeps",
		"season_mode_pve_team_times_cost",
		"season_mode_pve_holy_stripes",
		"season_mode_pve_energy",
		"season_mode_pve_hire_pet",
		"season_mode_pve_boss_phase",
		"season_mode_pve_doppelganger",
		"season_mode_pve_boss",
		"season_mode_pve_boss_speak",
		"season_mode_pve_boss_panel_step",
		"season_mode_pve_boss_story_step",
		"season_mode_war_order",
		"season_mode_war_order_level",
		"season_mode_war_order_buy",
		"season_mode_war_order_prize",
		"season_mode_war_order_task",
		"season_mode_war_order_recover",
		"season_mode_rank",
		"season_mode_rank_prize",
		"season_mode_rank_score",
		"season_mode_zone",
		"season_mode_pve_emaki",
		"season_mode_pve_emaki_fragment",
		"season_mode_pve_key_prize",
		"season_mode_pve_map_buff",
		"season_mode_pve_hire_pet_event",
		"season_mode_pve_find_key_event",
		"season_mode_pve_task_introduce_page",
		"season_mode_pve_task_introduce",
		"season_mode_pve_offset_level",
		"season_mode_pve_boss_plus",
		"season_mode_minimap_regions"
	}
end

function SeasonConfig:handleConfig(name, content)
	if name == "season_mode" then
		self._season_mode = content
	elseif name == "season_mode_pve_common" then
		self._season_mode_pve_common = content

		self:_handleOffseLevel()
	elseif name == "season_mode_pve" then
		self._season_mode_pve = content
	elseif name == "season_mode_pve_map" then
		self._season_mode_pve_map = content

		self:_collectFogElemets(content)
		self:_collectSearch(content)
		self:_handleOffseLevel()
	elseif name == "season_mode_pve_event_challenge" then
		self._eventType2Configs[SeasonGridEvtTypes.EVT_CHALLENGE] = content
	elseif name == "season_mode_pve_event_prize" then
		self._eventType2Configs[SeasonGridEvtTypes.EVT_MATERIAL] = content
		self._eventType2Configs[SeasonGridEvtTypes.EVT_PLOT] = content
	elseif name == "season_mode_pve_event_medal" then
		self._eventType2Configs[SeasonGridEvtTypes.EVT_MEDAL] = content
	elseif name == "season_mode_pve_event_convey" then
		self._eventType2Configs[SeasonGridEvtTypes.EVT_CONVEY] = content
		self._eventType2Configs[SeasonGridEvtTypes.EVT_RAINBOW] = content
	elseif name == "season_mode_pve_event_lock" then
		self._eventType2Configs[SeasonGridEvtTypes.EVT_MAP_LOCK] = content
	elseif name == "season_mode_pve_event_game" then
		self._eventType2Configs[SeasonGridEvtTypes.EVT_GAME] = content
	elseif name == "season_mode_pve_event_wooden" then
		self._eventType2Configs[SeasonGridEvtTypes.EVT_WOODEN_STAKE] = content
	elseif name == "season_mode_pve_event_wooden_damage" then
		self._season_mode_pve_event_wooden_damage = content
	elseif name == "season_mode_pve_creeps_team" then
		self._season_mode_pve_creeps_team = content
	elseif name == "season_mode_pve_creeps" then
		self._season_mode_pve_creeps = content
	elseif name == "season_mode_pve_team_times_cost" then
		self._season_mode_pve_team_times_cost = content
	elseif name == "season_mode_pve_holy_stripes" then
		self._season_mode_pve_holy_stripes = content
	elseif name == "season_mode_pve_energy" then
		self._season_mode_pve_energy = content
	elseif name == "season_mode_pve_hire_pet" then
		self._season_mode_pve_hire_pet = content
	elseif name == "season_mode_pve_boss_speak" then
		self._season_mode_pve_boss_speak = content
	elseif name == "season_mode_pve_boss_panel_step" then
		self._season_mode_pve_boss_panel_step = content
	elseif name == "season_mode_pve_boss_story_step" then
		self._season_mode_pve_boss_story_step = content
	elseif name == "season_mode_war_order" then
		self._season_mode_war_order = content
	elseif name == "season_mode_war_order_level" then
		self._season_mode_war_order_level = content
	elseif name == "season_mode_war_order_buy" then
		self._season_mode_war_order_buy = content
	elseif name == "season_mode_war_order_prize" then
		self._season_mode_war_order_prize = content
	elseif name == "season_mode_war_order_task" then
		self._season_mode_war_order_task = content
	elseif name == "season_mode_war_order_recover" then
		self._season_mode_war_order_recover = content
	elseif name == "season_mode_pve_boss_phase" then
		self._season_mode_pve_boss_phase = content
	elseif name == "season_mode_pve_doppelganger" then
		self._eventType2Configs[SeasonGridEvtTypes.EVT_BOSS_DOPPELGANGER] = content
	elseif name == "season_mode_pve_boss" then
		self._eventType2Configs[SeasonGridEvtTypes.EVT_BOSS] = content
	elseif name == "season_mode_rank" then
		self._season_mode_rank = content
	elseif name == "season_mode_rank_prize" then
		self._season_mode_rank_prize = content
	elseif name == "season_mode_rank_score" then
		self._season_mode_rank_score = content
	elseif name == "season_mode_zone" then
		self._season_mode_zone = content
	elseif name == "season_mode_pve_emaki" then
		self._season_mode_pve_emaki = content
	elseif name == "season_mode_pve_emaki_fragment" then
		self._season_mode_pve_emaki_fragment = content
	elseif name == "season_mode_pve_key_prize" then
		self._season_mode_pve_key_prize = content
	elseif name == "season_mode_pve_find_key_event" then
		self._eventType2Configs[SeasonGridEvtTypes.EVT_FIND_KEY] = content
	elseif name == "season_mode_pve_hire_pet_event" then
		self._eventType2Configs[SeasonGridEvtTypes.EVT_HIRE_PET] = content
	elseif name == "season_mode_pve_task_introduce_page" then
		self._season_mode_pve_task_introduce_page = content
	elseif name == "season_mode_pve_task_introduce" then
		self._season_mode_pve_task_introduce = content
	elseif name == "season_mode_pve_map_buff" then
		self._season_mode_pve_map_buff = content
	elseif name == "season_mode_pve_offset_level" then
		self._season_mode_pve_offset_level = content

		self:_handleOffseLevel()
	elseif name == "season_mode_pve_boss_plus" then
		self._season_mode_pve_boss_plus = content
	elseif name == "season_mode_minimap_regions" then
		self._season_mode_minimap_regions = content
	end
end

function SeasonConfig:getCommonValue(key, isToNumber)
	local str = ""

	if self._season_mode_pve_common and self._season_mode_pve_common[key] then
		str = self._season_mode_pve_common[key].value
	end

	if isToNumber then
		str = checknumber(str)
	end

	return str
end

function SeasonConfig:isInActTime()
	return self:getInTimeSeasonConfig() ~= nil
end

function SeasonConfig:getInTimeSeasonConfig()
	for _, conf in ipairs(self._season_mode) do
		if conf and GameUtil.checkIsInTimePeriod(conf.startTime, conf.endTime) then
			return conf
		end
	end
end

function SeasonConfig:getSeasonConfig()
	return self:getSeasonConfigBySeasonId(self:getSeasonId())
end

function SeasonConfig:getSeasonConfigList()
	return self._season_mode.dataList
end

function SeasonConfig:getSeasonConfigBySeasonId(seasonId)
	return self._season_mode[seasonId]
end

function SeasonConfig:getSeasonId()
	return checknumber(self:getCommonValue("CUR_SEASONID"))
end

function SeasonConfig:getAllEvts(seasonId)
	return self._season_mode_pve_map[seasonId] or {}
end

function SeasonConfig:getMapEvtTypeAndId(seasonId, id)
	if not self._season_mode_pve_map[seasonId] then
		return self._season_mode_pve_map[seasonId][id]
	end
end

function SeasonConfig:getMapEvtDetail(seasonId, eventType, eventId)
	if not self._eventType2Configs[eventType] then
		local configs = {}

		configs = self._eventType2Configs[eventType][seasonId] or {}

		return self._eventType2Configs[eventType][eventId]
	end
end

function SeasonConfig:getCreepTeam(creepsMasterId)
	return self._season_mode_pve_creeps_team[creepsMasterId]
end

function SeasonConfig:getCreeps(creepsMasterId)
	return self._season_mode_pve_creeps[creepsMasterId]
end

function SeasonConfig:getModePveTimeCostList()
	return self._season_mode_pve_team_times_cost.dataList
end

function SeasonConfig:getModePveTimeCost(time)
	return self._season_mode_pve_team_times_cost[time]
end

function SeasonConfig:getWoodenDamageConfigs(seasonId, damagePlanId)
	if not self._season_mode_pve_event_wooden_damage[seasonId] then
		local configs = {}

		configs = self._season_mode_pve_event_wooden_damage[seasonId][damagePlanId] or {}

		local result = {}

		for i, v in pairs(self._season_mode_pve_event_wooden_damage[seasonId]) do
			if checknumber(i) > 0 then
				table.insert(result, v)
			end
		end

		ArraySort.sortOn(result, "damage")

		return result
	end
end

function SeasonConfig:getHolyStripeCfg(id)
	if not self._season_mode_pve_holy_stripes[id] then
		return self._season_mode_pve_holy_stripes[id]
	end
end

function SeasonConfig:getHolyStripeCfgList()
	return self._season_mode_pve_holy_stripes.dataList
end

function SeasonConfig:getSeasonEnergyCfg(seasonId, level)
	if self._season_mode_pve_energy[seasonId] then
		return self._season_mode_pve_energy[seasonId][level] or {}
	end

	return {}
end

function SeasonConfig:getHirePetCfgById(defineId)
	return self._season_mode_pve_hire_pet[defineId]
end

function SeasonConfig:getBossPhaseConfigs(seasonId)
	return self._season_mode_pve_boss_phase[seasonId]
end

function SeasonConfig:getSeasonPassBaseConfig(seasonId)
	return self._season_mode_war_order[seasonId] or {}
end

function SeasonConfig:getSeasonPassLevelConfig(levelPlanId)
	return self._season_mode_war_order_level[levelPlanId] or {}
end

function SeasonConfig:getSeasonPassBuyLevelConfig(buyLevelPlanId)
	return self._season_mode_war_order_buy[buyLevelPlanId] or {}
end

function SeasonConfig:getSeasonPassRewardConfig(prizePlanId)
	return self._season_mode_war_order_prize[prizePlanId] or {}
end

function SeasonConfig:getSeasonPassTaskConfig(taskPlanId)
	return self._season_mode_war_order_task[taskPlanId] or {}
end

function SeasonConfig:getSeasonPassRecoverConfig(recoverPlanId)
	return self._season_mode_war_order_recover[recoverPlanId] or {}
end

function SeasonConfig:getRankConfig(seasonId, rankType)
	if self._season_mode_rank[seasonId] then
		return self._season_mode_rank[seasonId][rankType]
	end

	return nil
end

function SeasonConfig:getRankTabData(seasonId)
	local data = {
		rankType = {},
		areaType = {}
	}

	if self._season_mode_rank[seasonId] then
		for _, v in pairs(self._season_mode_rank[seasonId]) do
			local param = {
				name = v.desc,
				type = v.rankType,
				viewName = SeasonRankModel.RankTypeToViewName[v.rankType],
				prizePlanId = v.prizePlanId
			}

			table.insert(data.rankType, param)
		end
	end

	if not self._season_mode_zone[seasonId] then
		local list = {}
		local addZoneIdList = {}

		for _, v in pairs(list) do
			if v.zoneId and not addZoneIdList[v.zoneId] and (v.zoneId ~= 0 or enableDebug) then
				local param = {
					name = v.name,
					areaIds = v.areaIds,
					zoneId = v.zoneId
				}

				table.insert(data.areaType, param)

				addZoneIdList[v.zoneId] = true
			end
		end

		local function idSort(a, b)
			return a.zoneId < b.zoneId
		end

		table.sort(data.areaType, idSort)

		return data
	end
end

function SeasonConfig:getRankRewardByRank(planId, rank)
	local rewardCfg

	if self._season_mode_rank_prize[planId] and rank > 0 then
		local rankCfg = self._season_mode_rank_prize[planId]

		for _, v in pairs(rankCfg) do
			if rank >= v.rankStart and rank <= v.rankEnd then
				rewardCfg = v.prize

				break
			end
		end
	end

	if not string.nilorempty(rewardCfg) then
		local reward = {}
		local rewardArray = string.split(rewardCfg, "#")

		for _, v in pairs(rewardArray) do
			if not string.nilorempty(v) then
				table.insert(reward, v)
			end
		end

		return reward
	end

	return nil
end

function SeasonConfig:getRankScoreByRank(planId, rank)
	if self._season_mode_rank_score[planId] and rank > 0 then
		local scoreCfg = self._season_mode_rank_score[planId]

		for _, v in pairs(scoreCfg) do
			if rank >= v.rankStart and rank <= v.rankEnd then
				return v.score
			end
		end
	end

	return 0
end

function SeasonConfig:getBossSpeak(phaseId)
	return self._season_mode_pve_boss_speak[phaseId] or {}
end

function SeasonConfig:getBossRandSpeak(phaseId)
	local list = self:getBossSpeak(phaseId)
	local weight = 0
	local resultKey = -1
	local res

	for k, v in pairs(list) do
		weight = checknumber(v.weight)

		if weight > 0 then
			local key = math.pow(math.random(), 1 / weight)

			if resultKey < key then
				resultKey = key
				res = v
			end
		end
	end

	return res
end

function SeasonConfig:getBossPanenStep(phaseId)
	return self._season_mode_pve_boss_panel_step[phaseId] or {}
end

function SeasonConfig:getBossPhaseStoryConfig(seasonId, storyId)
	local configs = self._season_mode_pve_boss_story_step[seasonId]

	if configs then
		return configs[storyId]
	end
end

function SeasonConfig:getSeasonModeMainRewardBySeasonId(seasonId)
	return self._season_mode_pve_key_prize[seasonId]
end

function SeasonConfig:getSeasonFragmentBaseDataConfigBySeasonId(seasonId)
	return self._season_mode_pve_emaki[seasonId]
end

function SeasonConfig:getSeasonFragmentConfigBySeasonId(seasonId)
	return self._season_mode_pve_emaki_fragment[seasonId]
end

function SeasonConfig:getSeasonFragmentConfig(seasonId, fragmentId)
	if self._season_mode_pve_emaki_fragment[seasonId] then
		return self._season_mode_pve_emaki_fragment[seasonId][fragmentId]
	end
end

function SeasonConfig:_collectSearch(content)
	self._gridTypeMap = {}
	self._gridEventTypeMap = {}

	for i = 1, #content.dataList do
		local evtCfg = content.dataList[i]

		self._gridTypeMap[evtCfg.seasonId] = self._gridTypeMap[evtCfg.seasonId] or {}

		local seasonMap = self._gridTypeMap[evtCfg.seasonId]

		seasonMap[evtCfg.eventType] = seasonMap[evtCfg.eventType] or {}

		local evtTypeMap = seasonMap[evtCfg.eventType]

		evtTypeMap[evtCfg.showLevel] = evtTypeMap[evtCfg.showLevel] or {}

		local array = evtTypeMap[evtCfg.showLevel]

		table.insert(array, evtCfg)

		self._gridEventTypeMap[evtCfg.seasonId] = self._gridEventTypeMap[evtCfg.seasonId] or {}

		local seasonEventMap = self._gridEventTypeMap[evtCfg.seasonId]

		seasonEventMap[evtCfg.eventType] = seasonEventMap[evtCfg.eventType] or {}

		local evtTypeList = seasonEventMap[evtCfg.eventType]

		table.insert(evtTypeList, evtCfg)
	end
end

function SeasonConfig:getGridSearchMap(seasonId)
	return self._gridTypeMap[seasonId]
end

function SeasonConfig:getGridEventMap(seasonId, type)
	local map = self._gridEventTypeMap[seasonId]

	if map then
		return map[type]
	end
end

function SeasonConfig:isFogElement(seasonId, elemId)
	return self._elementFogsMap and self._elementFogsMap[seasonId] and self._elementFogsMap[seasonId][elemId]
end

function SeasonConfig:getFogRelateToGridElementId(seasonId, fogId)
	if not self._elementFogsMap then
		return
	end

	if not self._elementFogsMap[seasonId] then
		return
	end

	return self._elementFogsMap[seasonId][fogId]
end

function SeasonConfig:_collectFogElemets(content)
	self._elementFogsMap = {}

	for i = 1, #content.dataList do
		local evtCfg = content.dataList[i]

		if not string.nilorempty(evtCfg.fogObjIds) then
			local fogObjIds = string.split(evtCfg.fogObjIds, ",")

			for i = 1, #fogObjIds do
				local fogId = checknumber(fogObjIds[i])

				if fogId ~= 0 then
					local seasons = self._elementFogsMap[evtCfg.seasonId]

					if not seasons then
						seasons = {}
						self._elementFogsMap[evtCfg.seasonId] = seasons
					end

					seasons[fogId] = evtCfg.id
				end
			end
		end
	end
end

function SeasonConfig:getMapJson(seasonId)
	if not self._season_mode_pve[seasonId] then
		return self._season_mode_pve[seasonId].mapJson
	end
end

function SeasonConfig:getSeasonPVEConfig(seasonId)
	return self._season_mode_pve[seasonId]
end

function SeasonConfig:getTaskIntroducePageInfo(seasonId)
	return self._season_mode_pve_task_introduce_page[seasonId]
end

function SeasonConfig:getTaskIntroduce(taskId)
	return self._season_mode_pve_task_introduce[taskId]
end

function SeasonConfig:getKeysCfg(seasonId)
	if self._eventType2Configs[SeasonGridEvtTypes.EVT_FIND_KEY][seasonId] then
		self._findKeyConfigs = self._findKeyConfigs or {}

		if not self._findKeyConfigs[seasonId] then
			self._findKeyConfigs[seasonId] = {}

			for i, cfg in pairs(self._eventType2Configs[SeasonGridEvtTypes.EVT_FIND_KEY][seasonId]) do
				if cfg.isKey == true then
					table.insert(self._findKeyConfigs[seasonId], cfg)
				end
			end
		end

		return self._findKeyConfigs[seasonId]
	else
		return {}
	end
end

function SeasonConfig:getMapBuffCfg(seasonId, buffId)
	return self._season_mode_pve_map_buff[seasonId][buffId]
end

function SeasonConfig:_handleOffseLevel()
	if self._season_mode_pve_offset_level and self._season_mode_pve_map and self._season_mode_pve_common and not self._mapOffsetLevel then
		self._mapOffsetLevel = {}

		for i = 1, #self._season_mode_pve_map.dataList do
			local evtCfg = self._season_mode_pve_map.dataList[i]
			local level = 0

			if self._season_mode_pve_offset_level[self:getSeasonId()] then
				for i, cfg in ipairs(self._season_mode_pve_offset_level[self:getSeasonId()]) do
					if cfg.upperLimit > checknumber(evtCfg.offsetY) and cfg.lowerLimit <= checknumber(evtCfg.offsetY) then
						level = cfg.level

						break
					end
				end
			end

			self._mapOffsetLevel[self._season_mode_pve_map.dataList[i].id] = level
		end
	end
end

function SeasonConfig:getOffsetLevel(id)
	return checknumber(self._mapOffsetLevel[id])
end

function SeasonConfig:getBossPlusCfg(seasonId, id)
	if self._season_mode_pve_boss_plus[seasonId] then
		return self._season_mode_pve_boss_plus[seasonId][id]
	end
end

function SeasonConfig:getMiniMapRegionParams(seasonId)
	if self._season_mode_minimap_regions then
		return self._season_mode_minimap_regions[seasonId]
	end
end

SeasonConfig.instance = SeasonConfig.New()

return SeasonConfig
