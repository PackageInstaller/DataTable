-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/domainadventure/config/DomainAdventureConfig.lua

module("logic.extensions.domainadventure.config.DomainAdventureConfig", package.seeall)

local DomainAdventureConfig = class("DomainAdventureConfig", BaseConfig)

function DomainAdventureConfig:onInit()
	DomainAdventureConfig.super.onInit(self)
end

function DomainAdventureConfig:getNames()
	return {
		"domain_adventure_activity",
		"domain_adventure_map",
		"domain_adventure_challenge_event",
		"domain_adventure_solve_form_event",
		"domain_adventure_dispatch_event",
		"domain_adventure_dispatch_progress_plan",
		"domain_adventure_game_event",
		"domain_adventure_boss_event",
		"domain_adventure_creeps",
		"domain_adventure_creeps_master",
		"domain_adventure_value_prize",
		"domain_adventure_sys_pet",
		"domain_adventure_buff",
		"domain_adventure_global_prize",
		"domain_adventure_boss_rank_prize",
		"domain_adventure_fight_rank_prize",
		"domain_adventure_state_show",
		"domain_adventure_resource"
	}
end

function DomainAdventureConfig:handleConfig(name, content)
	if name == "domain_adventure_activity" then
		self._domain_adventure_activity = content
	elseif name == "domain_adventure_map" then
		self._domain_adventure_map = content
	elseif name == "domain_adventure_challenge_event" then
		self._domain_adventure_challenge_event = content
	elseif name == "domain_adventure_solve_form_event" then
		self._domain_adventure_solve_form_event = content
	elseif name == "domain_adventure_dispatch_event" then
		self._domain_adventure_dispatch_event = content
	elseif name == "domain_adventure_dispatch_progress_plan" then
		self._domain_adventure_dispatch_progress_plan = content
	elseif name == "domain_adventure_game_event" then
		self._domain_adventure_game_event = content
	elseif name == "domain_adventure_boss_event" then
		self._domain_adventure_boss_event = content
	elseif name == "domain_adventure_creeps" then
		self._domain_adventure_creeps = content
	elseif name == "domain_adventure_creeps_master" then
		self._domain_adventure_creeps_master = content
	elseif name == "domain_adventure_value_prize" then
		self._domain_adventure_value_prize = content
	elseif name == "domain_adventure_sys_pet" then
		self._domain_adventure_sys_pet = content
	elseif name == "domain_adventure_buff" then
		self._domain_adventure_buff = content
	elseif name == "domain_adventure_global_prize" then
		self._domain_adventure_global_prize = content
	elseif name == "domain_adventure_boss_rank_prize" then
		self._domain_adventure_boss_rank_prize = content
	elseif name == "domain_adventure_fight_rank_prize" then
		self._domain_adventure_fight_rank_prize = content
	elseif name == "domain_adventure_state_show" then
		self._domain_adventure_state_show = content
	elseif name == "domain_adventure_resource" then
		self._domain_adventure_resource = content
	end
end

function DomainAdventureConfig:getActCfg()
	return self._domain_adventure_activity.dataList
end

function DomainAdventureConfig:getActData(activityId)
	return self._domain_adventure_activity[activityId]
end

function DomainAdventureConfig:getGlobalDispatchLimit(activityId)
	local data = self:getActData(activityId)

	return (data or nil) and data.globalDispatchLimit
end

function DomainAdventureConfig:getDispatchPetLimit(activityId)
	local data = self:getActData(activityId)

	return (data or nil) and data.dispatchPetLimit
end

function DomainAdventureConfig:getMapJson(activityId)
	local data = self:getActData(activityId)

	if data then
		return data.mapJson
	end
end

function DomainAdventureConfig:getMapDataName(activityId)
	local data = self:getActData(activityId)

	if data then
		return data.mapDataName
	end
end

function DomainAdventureConfig:getViewName(activityId)
	local data = self:getActData(activityId)

	if data then
		return data.viewname
	end
end

function DomainAdventureConfig:getInitBlockId(activityId)
	local data = self:getActData(activityId)

	if data then
		return data.initBlockId
	end
end

function DomainAdventureConfig:getDailyGameTimes(activityId)
	local data = self:getActData(activityId)

	return (data or nil) and data.dailyGameTimes
end

function DomainAdventureConfig:getUnlockGlobalPrizeCostStrength(activityId)
	local data = self:getActData(activityId)

	return (data or nil) and data.unlockGlobalPrizeCostStrength
end

function DomainAdventureConfig:getGuideDailyStrengthCost(activityId)
	local data = self:getActData(activityId)

	return (data or nil) and (data.guideDailyStrengthCost or 0)
end

function DomainAdventureConfig:getCostItem(activityId)
	local data = self:getActData(activityId)

	return data and data.costItem
end

function DomainAdventureConfig:getMapCfg(activityId)
	return self._domain_adventure_map[activityId]
end

function DomainAdventureConfig:getMapData(activityId, blockId)
	if self._domain_adventure_map[activityId] then
		return self._domain_adventure_map[activityId][blockId]
	end
end

function DomainAdventureConfig:getEventType(activityId, blockId)
	local data = self:getMapData(activityId, blockId)

	return (data or nil) and (data.eventType or DomAdvEnum.EventType_Empty)
end

function DomainAdventureConfig:getEventId(activityId, blockId)
	local data = self:getMapData(activityId, blockId)

	return (data or nil) and (data.eventId or 0)
end

function DomainAdventureConfig:getNeedProgress(activityId, blockId)
	local data = self:getMapData(activityId, blockId)

	return data and data.needProgress
end

function DomainAdventureConfig:getCostStrength(activityId, blockId)
	local data = self:getMapData(activityId, blockId)

	return data and data.costStrength
end

function DomainAdventureConfig:getBuffIdInGrid(activityId, blockId)
	local data = self:getMapData(activityId, blockId)

	return (data or nil) and (data.occupiedEffectBuffId or 0)
end

function DomainAdventureConfig:getClgEventCfg(activityId)
	return self._domain_adventure_challenge_event[activityId]
end

function DomainAdventureConfig:getClgEventData(activityId, challengeId)
	if self._domain_adventure_challenge_event[activityId] then
		return self._domain_adventure_challenge_event[activityId][challengeId]
	end
end

function DomainAdventureConfig:getSolveFormCfg(activityId)
	return self._domain_adventure_solve_form_event[activityId]
end

function DomainAdventureConfig:getSolveFormData(activityId, challengeId)
	if self._domain_adventure_solve_form_event[activityId] then
		return self._domain_adventure_solve_form_event[activityId][challengeId]
	end
end

function DomainAdventureConfig:getDispatchCfg(activityId)
	return self._domain_adventure_dispatch_event[activityId]
end

function DomainAdventureConfig:getDispatchData(activityId, dispatchId)
	if self._domain_adventure_dispatch_event[activityId] then
		return self._domain_adventure_dispatch_event[activityId][dispatchId]
	end
end

function DomainAdventureConfig:getDispatchProgressPlanCfg(progressPlanId)
	return self._domain_adventure_dispatch_progress_plan[progressPlanId]
end

function DomainAdventureConfig:getDispatchProgressPlanData(progressPlanId, progressId)
	if self._domain_adventure_dispatch_progress_plan[progressPlanId] then
		return self._domain_adventure_dispatch_progress_plan[progressPlanId][progressId]
	end
end

function DomainAdventureConfig:getDisProgressDataByValue(progressPlanId, value)
	local result
	local cfg = self:getDispatchProgressPlanCfg(progressPlanId)

	if cfg then
		for _, data in ipairs(cfg) do
			if value >= data.value then
				result = data
			end
		end
	end

	return result
end

function DomainAdventureConfig:getGameEventCfg(activityId)
	return self._domain_adventure_game_event[activityId]
end

function DomainAdventureConfig:getGameEventData(activityId, gameId)
	if self._domain_adventure_game_event[activityId] then
		return self._domain_adventure_game_event[activityId][gameId]
	end
end

function DomainAdventureConfig:getBossEventCfg(activityId)
	return self._domain_adventure_boss_event[activityId]
end

function DomainAdventureConfig:getBossEventData(activityId, bossId)
	if self._domain_adventure_boss_event[activityId] then
		return self._domain_adventure_boss_event[activityId][bossId]
	end
end

function DomainAdventureConfig:getUnlockBlockCount(activityId, gridId)
	local eventId = self:getEventId(activityId, gridId)
	local data = self:getBossEventData(activityId, eventId)

	return (data or nil) and (data.unlockBlockCount or 0)
end

function DomainAdventureConfig:getCreepsCfg(creepsMasterId)
	return self._domain_adventure_creeps[creepsMasterId]
end

function DomainAdventureConfig:getCreepsData(creepsMasterId, creepsId)
	if self._domain_adventure_creeps[creepsMasterId] then
		return self._domain_adventure_creeps[creepsMasterId][creepsId]
	end
end

function DomainAdventureConfig:getCreepsMasterCfg(creepsMasterId)
	return self._domain_adventure_creeps_master[creepsMasterId]
end

function DomainAdventureConfig:getValuePrizeCfg(prizePlanId)
	return self._domain_adventure_value_prize[prizePlanId]
end

function DomainAdventureConfig:getValuePrizeData(prizePlanId, prizeId)
	if self._domain_adventure_value_prize[prizePlanId] then
		return self._domain_adventure_value_prize[prizePlanId][prizeId]
	end
end

function DomainAdventureConfig:getPrizeDataByValue(prizePlanId, value)
	local result
	local cfg = self:getValuePrizeCfg(prizePlanId)

	if cfg and value > 0 then
		for _, data in ipairs(cfg) do
			result = data

			if value < data.value then
				break
			end
		end
	end

	return result
end

function DomainAdventureConfig:getMaxValuePrizeData(prizePlanId)
	local cfg = self:getValuePrizeCfg(prizePlanId)

	if cfg then
		return cfg[#cfg]
	end
end

function DomainAdventureConfig:getSysPetData(systemPoolId)
	return self._domain_adventure_sys_pet[systemPoolId]
end

function DomainAdventureConfig:getBuffCfg(activityId)
	return self._domain_adventure_buff[activityId]
end

function DomainAdventureConfig:getBuffData(activityId, buffId)
	if self._domain_adventure_buff[activityId] then
		return self._domain_adventure_buff[activityId][buffId]
	end
end

function DomainAdventureConfig:getGlobalPrizeCfg(activityId)
	return self._domain_adventure_global_prize[activityId]
end

function DomainAdventureConfig:getGlobalPrizeData(activityId, prizeId)
	if self._domain_adventure_global_prize[activityId] then
		return self._domain_adventure_global_prize[activityId][prizeId]
	end
end

function DomainAdventureConfig:getBossRankPrizeCfg(activityId)
	return self._domain_adventure_boss_rank_prize[activityId]
end

function DomainAdventureConfig:getBossRankPrizeDataByRank(activityId, rank)
	local result
	local cfg = self:getBossRankPrizeCfg(activityId)

	if cfg then
		for _, data in pairs(cfg) do
			if rank >= data.rankRange[1] and rank <= data.rankRange[2] then
				result = data

				break
			end
		end
	end

	return result
end

function DomainAdventureConfig:getEliteRankPrizeCfg(activityId)
	return self._domain_adventure_fight_rank_prize[activityId]
end

function DomainAdventureConfig:getEliteRankPrizeDataByRank(activityId, rank)
	local result
	local cfg = self:getEliteRankPrizeCfg(activityId)

	if cfg then
		for _, data in pairs(cfg) do
			if rank >= data.rankRange[1] and rank <= data.rankRange[2] then
				result = data

				break
			end
		end
	end

	return result
end

function DomainAdventureConfig:getStateShowData(eventType, showType, sortGroups)
	if self._domain_adventure_state_show[eventType] and self._domain_adventure_state_show[eventType][showType] then
		return self._domain_adventure_state_show[eventType][showType][sortGroups]
	end
end

function DomainAdventureConfig:getResourceDataList()
	return self._domain_adventure_resource.dataList
end

function DomainAdventureConfig:getResourcePath(resourceKey)
	if self._domain_adventure_resource[resourceKey] then
		return self._domain_adventure_resource[resourceKey].path
	end
end

DomainAdventureConfig.instance = DomainAdventureConfig.New()

return DomainAdventureConfig
