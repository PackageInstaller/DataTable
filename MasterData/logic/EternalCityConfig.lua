-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eternalcity/config/EternalCityConfig.lua

module("logic.extensions.eternalcity.config.EternalCityConfig", package.seeall)

local EternalCityConfig = class("EternalCityConfig", BaseConfig)

function EternalCityConfig:getNames()
	return {
		"eternal_city_activity",
		"eternal_city_boss",
		"eternal_city_building",
		"eternal_city_building_effect",
		"eternal_city_common",
		"eternal_city_creeps",
		"eternal_city_master",
		"eternal_city_pet_pool",
		"eternal_city_pet_prosperity_convert_plan",
		"eternal_city_progress",
		"eternal_city_prosperity",
		"eternal_city_rank_prize",
		"eternal_city_stage",
		"eternal_city_support_pet"
	}
end

function EternalCityConfig:handleConfig(name, content)
	if name == "eternal_city_activity" then
		self._eternal_city_activity = content
	elseif name == "eternal_city_boss" then
		self._eternal_city_boss = content
	elseif name == "eternal_city_building" then
		self._eternal_city_building = content
	elseif name == "eternal_city_building_effect" then
		self._eternal_city_building_effect = content
	elseif name == "eternal_city_common" then
		self._eternal_city_common = content
	elseif name == "eternal_city_creeps" then
		self._eternal_city_creeps = content
	elseif name == "eternal_city_master" then
		self._eternal_city_master = content
	elseif name == "eternal_city_pet_pool" then
		self._eternal_city_pet_pool = content
	elseif name == "eternal_city_pet_prosperity_convert_plan" then
		self._eternal_city_pet_prosperity_convert_plan = content
	elseif name == "eternal_city_progress" then
		self._eternal_city_progress = content
	elseif name == "eternal_city_prosperity" then
		self._eternal_city_prosperity = content
	elseif name == "eternal_city_rank_prize" then
		self._eternal_city_rank_prize = content
	elseif name == "eternal_city_stage" then
		self._eternal_city_stage = content
	elseif name == "eternal_city_support_pet" then
		self._eternal_city_support_pet = content
	end
end

function EternalCityConfig:_safeGet(data, ...)
	local keys = {
		...
	}
	local current = data

	for i = 1, #keys do
		if current and type(current) == "table" then
			current = current[keys[i]]
		else
			current = nil

			break
		end
	end

	return current
end

function EternalCityConfig:getActivityData(activityId)
	return self:_safeGet(self._eternal_city_activity, activityId)
end

function EternalCityConfig:getBossDatas(activityId)
	return self:_safeGet(self._eternal_city_boss, activityId)
end

function EternalCityConfig:getBossData(activityId, bossId)
	return self:_safeGet(self._eternal_city_boss, activityId, bossId)
end

function EternalCityConfig:getBuildingDatass(activityId)
	return self:_safeGet(self._eternal_city_building, activityId)
end

function EternalCityConfig:getBuildingDatas(activityId, buildingId)
	return self:_safeGet(self._eternal_city_building, activityId, buildingId)
end

function EternalCityConfig:getBuildingData(activityId, buildingId, level)
	return self:_safeGet(self._eternal_city_building, activityId, buildingId, level)
end

function EternalCityConfig:getBuildingEffectDatass(activityId)
	return self:_safeGet(self._eternal_city_building_effect, activityId)
end

function EternalCityConfig:getBuildingEffectDatas(activityId, buildingId)
	return self:_safeGet(self._eternal_city_building_effect, activityId, buildingId)
end

function EternalCityConfig:getBuildingEffectData(activityId, buildingId, rate)
	local result
	local datas = self:getBuildingEffectDatas(activityId, buildingId)

	if datas then
		for _, data in pairs(datas) do
			if rate >= data.rate and (result == nil or data.rate > result.rate) then
				result = data
			end
		end
	end

	return result
end

function EternalCityConfig:getCommonValue(key, isToNumber)
	local data = self:_safeGet(self._eternal_city_common, key)
	local value = data.value

	if isToNumber then
		return checknumber(value)
	end

	return value
end

function EternalCityConfig:getCreepsDatas(creepsMasterId)
	return self:_safeGet(self._eternal_city_creeps, creepsMasterId)
end

function EternalCityConfig:getCreepsData(creepsMasterId, creepsId)
	return self:_safeGet(self._eternal_city_creeps, creepsMasterId, creepsId)
end

function EternalCityConfig:getMasterData(creepsMasterId)
	return self:_safeGet(self._eternal_city_master, creepsMasterId)
end

function EternalCityConfig:getPetPoolDatass(activityId)
	return self:_safeGet(self._eternal_city_pet_pool, activityId)
end

function EternalCityConfig:getPetPoolDatas(activityId, poolId)
	return self:_safeGet(self._eternal_city_pet_pool, activityId, poolId)
end

function EternalCityConfig:getPetPoolData(activityId, poolId, creepsId)
	return self:_safeGet(self._eternal_city_pet_pool, activityId, poolId, creepsId)
end

function EternalCityConfig:getPetProsperityConvertDatas(activityId)
	return self:_safeGet(self._eternal_city_pet_prosperity_convert_plan, activityId)
end

function EternalCityConfig:getPetProsperityConvertData(activityId, num)
	return self:_safeGet(self._eternal_city_pet_prosperity_convert_plan, activityId, num)
end

function EternalCityConfig:getProgressDatas(progressPlan)
	return self:_safeGet(self._eternal_city_progress, progressPlan)
end

function EternalCityConfig:getProgressData(progressPlan, progress)
	return self:_safeGet(self._eternal_city_progress, progressPlan, progress)
end

function EternalCityConfig:getProsperityDatas(activityId)
	return self:_safeGet(self._eternal_city_prosperity, activityId)
end

function EternalCityConfig:getProsperityData(activityId, prosperity)
	return self:_safeGet(self._eternal_city_prosperity, activityId, prosperity)
end

function EternalCityConfig:getProsperityDataByProsperity(activityId, prosperity)
	local result
	local datas = self:getProsperityDatas(activityId)

	if datas then
		for _, data in pairs(datas) do
			if prosperity >= data.prosperity and (result == nil or data.prosperity > result.prosperity) then
				result = data
			end
		end
	end

	return result
end

function EternalCityConfig:getRankPrizeDatas(activityId)
	return self:_safeGet(self._eternal_city_rank_prize, activityId)
end

function EternalCityConfig:getRankPrizeData(activityId, rank)
	local result
	local datas = self:getRankPrizeDatas(activityId)

	if datas then
		for k, data in pairs(datas) do
			if rank >= data.rankRange[1] and rank <= data.rankRange[2] then
				result = data

				break
			end
		end
	end

	return result
end

function EternalCityConfig:getStageDatas(activityId)
	return self:_safeGet(self._eternal_city_stage, activityId)
end

function EternalCityConfig:getStageData(activityId, stageId)
	return self:_safeGet(self._eternal_city_stage, activityId, stageId)
end

function EternalCityConfig:getSupportPetDatas(activityId)
	return self:_safeGet(self._eternal_city_support_pet, activityId)
end

function EternalCityConfig:getSupportPetData(activityId, creepsId)
	return self:_safeGet(self._eternal_city_support_pet, activityId, creepsId)
end

EternalCityConfig.instance = EternalCityConfig.New()

return EternalCityConfig
