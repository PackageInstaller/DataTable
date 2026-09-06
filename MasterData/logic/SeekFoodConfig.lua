-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/seekfood/config/SeekFoodConfig.lua

module("logic.extensions.seekfood.config.SeekFoodConfig", package.seeall)

local SeekFoodConfig = class("SeekFoodConfig", BaseConfig)

function SeekFoodConfig:onInit()
	SeekFoodConfig.super.onInit(self)
end

function SeekFoodConfig:getNames()
	return {
		"seek_food_activity",
		"seek_food",
		"seek_food_site",
		"seek_food_material",
		"seek_food_prize",
		"seek_food_buff",
		"seek_food_master",
		"seek_food_creeps",
		"seek_food_common"
	}
end

function SeekFoodConfig:handleConfig(name, content)
	if name == "seek_food_activity" then
		self._sfBaseCfg = content
	elseif name == "seek_food" then
		self._sfFoodCfgs = content
	elseif name == "seek_food_site" then
		self._sfSiteCfgs = content
	elseif name == "seek_food_material" then
		self._sfMatCfgs = content
	elseif name == "seek_food_prize" then
		self._sfPrizeCfgs = content
	elseif name == "seek_food_buff" then
		self._sfBuffCfg = content
	elseif name == "seek_food_master" then
		self._sfMasterCfg = content
	elseif name == "seek_food_creeps" then
		self._sfCreepsCfgs = content
	elseif name == "seek_food_common" then
		self._sfCommonCfg = content
	end
end

function SeekFoodConfig:getSfBaseData(activityId)
	return self._sfBaseCfg[activityId]
end

function SeekFoodConfig:getSfFoodCfg(activityId)
	return self._sfFoodCfgs[activityId]
end

function SeekFoodConfig:getSfFoodData(activityId, foodId)
	return self._sfFoodCfgs[activityId][foodId]
end

function SeekFoodConfig:getSfSiteCfg(activityId)
	return self._sfSiteCfgs[activityId]
end

function SeekFoodConfig:getSfSiteData(activityId, siteId)
	return self._sfSiteCfgs[activityId][siteId]
end

function SeekFoodConfig:getOpenDateTimeOfFood(activityId, foodId)
	local foodData = self:getSfFoodData(activityId, foodId)
	local siteData = self:getSfSiteData(activityId, foodData.siteId)

	return siteData.openDateTime
end

function SeekFoodConfig:getSfMatCfgs(activityId)
	return self._sfMatCfgs[activityId]
end

function SeekFoodConfig:getSfMatCfg(activityId, foodId)
	return self._sfMatCfgs[activityId][foodId]
end

function SeekFoodConfig:getSfMatData(activityId, foodId, materialId)
	return self._sfMatCfgs[activityId][foodId][materialId]
end

function SeekFoodConfig:getLimitPetNumOfMat(activityId, foodId, materialId)
	local data = self:getSfMatData(activityId, foodId, materialId)

	return data.petNum
end

function SeekFoodConfig:getSfPrizeCfg(activityId)
	return self._sfPrizeCfgs[activityId]
end

function SeekFoodConfig:getSfPrizeData(activityId, prizeId)
	return self._sfPrizeCfgs[activityId][prizeId]
end

function SeekFoodConfig:getSfBuffCfg(activityId)
	return self._sfBuffCfg[activityId]
end

function SeekFoodConfig:getSfBuffData(activityId, day)
	return self._sfBuffCfg[activityId][day]
end

function SeekFoodConfig:getSfMasterData(creepsMasterId)
	return self._sfMasterCfg[creepsMasterId]
end

function SeekFoodConfig:getSfCreepsCfg(creepsMasterId)
	return self._sfCreepsCfgs[creepsMasterId]
end

function SeekFoodConfig:getSfCreepsData(creepsMasterId, creepsId)
	return self._sfCreepsCfgs[creepsMasterId][creepsId]
end

function SeekFoodConfig:getSfCommonValue(activityId, key, isToNumber)
	local comPlanId = self:getSfBaseData(activityId).comPlanId
	local data = self._sfCommonCfg[comPlanId][key]
	local value = data and data.value

	if isToNumber then
		value = checknumber(value)
	end

	return value
end

function SeekFoodConfig:getRedIdOfFood(activityId)
	return self:getSfCommonValue(activityId, "SF_REDID_FOOD_KEY", false)
end

function SeekFoodConfig:getRedIdOfCanPrize(activityId)
	return self:getSfCommonValue(activityId, "SF_REDID_PRIZE_KEY", false)
end

SeekFoodConfig.instance = SeekFoodConfig.New()

return SeekFoodConfig
