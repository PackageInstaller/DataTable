-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guardcity/config/GuardCityConfig.lua

module("logic.extensions.guardcity.config.GuardCityConfig", package.seeall)

local GuardCityConfig = class("GuardCityConfig", BaseConfig)

function GuardCityConfig:onInit()
	GuardCityConfig.super.onInit(self)
end

function GuardCityConfig:getNames()
	return {
		"gaurd_city",
		"guard_city_buff",
		"guard_city_path",
		"guard_city_master",
		"guard_city_creeps",
		"guard_city_damage_prize",
		"guard_city_star",
		"guard_city_ability",
		"guard_city_prize",
		"guard_city_params",
		"guard_city_strength_purchase"
	}
end

function GuardCityConfig:handleConfig(name, content)
	if name == "gaurd_city" then
		self._gaurd_city = content
	elseif name == "guard_city_buff" then
		self._guard_city_buff = content
	elseif name == "guard_city_path" then
		self._guard_city_path = content
	elseif name == "guard_city_master" then
		self._guard_city_master = content
	elseif name == "guard_city_creeps" then
		self._guard_city_creeps = content
	elseif name == "guard_city_damage_prize" then
		self._guard_city_damage_prize = content
	elseif name == "guard_city_star" then
		self._guard_city_star = content
	elseif name == "guard_city_ability" then
		self._guard_city_ability = content
	elseif name == "guard_city_prize" then
		self._guard_city_prize = content
	elseif name == "guard_city_params" then
		self._guard_city_params = content
	elseif name == "guard_city_strength_purchase" then
		self._guard_city_strength_purchase = content
	end
end

function GuardCityConfig:getCommonValue(key, isToNumber)
	local str = ""

	if self._guard_city_params and self._guard_city_params[key] then
		str = self._guard_city_params[key].value
	end

	if isToNumber then
		str = checknumber(str)
	end

	return str
end

function GuardCityConfig:getFirstActivityId()
	return self._gaurd_city.dataList[1].activityId
end

function GuardCityConfig:getActivityCfg(activityId)
	return self._gaurd_city[activityId]
end

function GuardCityConfig:getBuffCfgs(buffPlanId)
	return self._guard_city_buff[buffPlanId]
end

function GuardCityConfig:getBuffCfg(buffPlanId, day)
	if self._guard_city_buff[buffPlanId] then
		return self._guard_city_buff[buffPlanId][day]
	end

	return nil
end

function GuardCityConfig:getMonsterCfg(masterPlanId, creepsMasterId)
	return self._guard_city_master[masterPlanId][creepsMasterId]
end

function GuardCityConfig:getAbilityCfg(abilityPlanId, abilityLv)
	return self._guard_city_ability[abilityPlanId][abilityLv]
end

function GuardCityConfig:getAbilityCfgs(abilityPlanId)
	return self._guard_city_ability[abilityPlanId]
end

function GuardCityConfig:getCreepsCfg(creepsMasterId)
	return self._guard_city_creeps[creepsMasterId]
end

function GuardCityConfig:getMapCfgs(mapPlanId)
	return self._guard_city_map[mapPlanId]
end

function GuardCityConfig:getMapCfgsByActId(activityId)
	local actCfg = self:getActivityCfg(activityId)

	if actCfg then
		return self:getMapCfgs(actCfg.mapPlan)
	end
end

function GuardCityConfig:getMapPlanId(activityId)
	local actCfg = self:getActivityCfg(activityId)

	if actCfg then
		return actCfg.mapPlan
	end
end

function GuardCityConfig:getPathCfgs(pathPlanId)
	return self._guard_city_path[pathPlanId]
end

function GuardCityConfig:getPathPosByGrid(pathPlanId, gridId)
	return self._gridByPathPos[pathPlanId][gridId]
end

function GuardCityConfig:getGridByPathPos(pathPlanId, pathId, posId)
	return self._guard_city_path[pathPlanId][pathId].pathPos[posId]
end

function GuardCityConfig:getDamagePrizeCfgs(damagePrizePlanId)
	return self._guard_city_damage_prize[damagePrizePlanId]
end

function GuardCityConfig:getStarCfg(starPlanId, star)
	return self._guard_city_star[starPlanId][star]
end

function GuardCityConfig:getBuyStrengthPlans(strengthPurchasePlanId)
	return self._guard_city_strength_purchase[strengthPurchasePlanId]
end

GuardCityConfig.instance = GuardCityConfig.New()

return GuardCityConfig
