-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/config/SeasonMainCampConfig.lua

module("logic.extensions.season.config.SeasonMainCampConfig", package.seeall)

local SeasonMainCampConfig = class("SeasonMainCampConfig", BaseConfig)

function SeasonMainCampConfig:onInit()
	SeasonMainCampConfig.super.onInit(self)
end

function SeasonMainCampConfig:getNames()
	return {
		"season_mode_pve_energy",
		"season_mode_pve_camp",
		"season_mode_pve_camp_upgrade",
		"season_mode_pve_camp_pet_guard",
		"season_mode_pve_camp_pet_addition",
		"season_mode_pve_camp_pet_guard_grid",
		"season_mode_pve_training_ground",
		"season_mode_pve_team",
		"season_mode_pve_team_max_level",
		"season_mode_pve_team_upgrade",
		"season_mode_pve_totem_pole",
		"season_mode_pve_totem_pole_race_type",
		"season_mode_pve_totem_item",
		"season_mode_pve_main_totem",
		"season_mode_pve_pet_palace",
		"season_mode_pve_hire_pet_times",
		"season_mode_pve_hire_pet",
		"season_mode_pve_badge",
		"season_mode_pve_badge_suit",
		"season_mode_pve_camp_entrance",
		"season_mode_pve_cute_pet",
		"season_mode_pve_cute_pet_level",
		"season_mode_pve_cute_pet_talent"
	}
end

function SeasonMainCampConfig:handleConfig(name, content)
	if name == "season_mode_pve_energy" then
		self._season_mode_pve_energy = content
	elseif name == "season_mode_pve_camp" then
		self._season_mode_pve_camp = content
	elseif name == "season_mode_pve_camp_upgrade" then
		self._season_mode_pve_camp_upgrade = content
	elseif name == "season_mode_pve_camp_pet_guard" then
		self._season_mode_pve_camp_pet_guard = content
	elseif name == "season_mode_pve_camp_pet_addition" then
		self._season_mode_pve_camp_pet_addition = content
	elseif name == "season_mode_pve_camp_pet_guard_grid" then
		self._season_mode_pve_camp_pet_guard_grid = content
	elseif name == "season_mode_pve_training_ground" then
		self._season_mode_pve_training_ground = content
	elseif name == "season_mode_pve_team" then
		self._season_mode_pve_team = content
	elseif name == "season_mode_pve_team_max_level" then
		self._season_mode_pve_team_max_level = content

		self:onTeamMaxLvlSort(content)
	elseif name == "season_mode_pve_team_upgrade" then
		self._season_mode_pve_team_upgrade = content
	elseif name == "season_mode_pve_totem_pole" then
		self._season_mode_pve_totem_pole = content
	elseif name == "season_mode_pve_totem_pole_race_type" then
		self._season_mode_pve_totem_pole_race_type = content
	elseif name == "season_mode_pve_totem_item" then
		self._season_mode_pve_totem_item = content
	elseif name == "season_mode_pve_main_totem" then
		self._season_mode_pve_main_totem = content
	elseif name == "season_mode_pve_pet_palace" then
		self._season_mode_pve_pet_palace = content
	elseif name == "season_mode_pve_hire_pet_times" then
		self._season_mode_pve_hire_pet_times = content
	elseif name == "season_mode_pve_hire_pet" then
		self._season_mode_pve_hire_pet = content
	elseif name == "season_mode_pve_badge" then
		self._season_mode_pve_badge = content
	elseif name == "season_mode_pve_badge_suit" then
		self._season_mode_pve_badge_suit = content
	elseif name == "season_mode_pve_camp_entrance" then
		self._season_mode_pve_camp_entrance = content
	elseif name == "season_mode_pve_cute_pet" then
		self._season_mode_pve_cute_pet = content
	elseif name == "season_mode_pve_cute_pet_level" then
		self._season_mode_pve_cute_pet_level = content
	elseif name == "season_mode_pve_cute_pet_talent" then
		self._season_mode_pve_cute_pet_talent = content
	end
end

function SeasonMainCampConfig:getMainCampConfig(seasonId)
	return self._season_mode_pve_camp[seasonId]
end

function SeasonMainCampConfig:getMainCampUpgradeConfig(upgradePlanId)
	return self._season_mode_pve_camp_upgrade[upgradePlanId]
end

function SeasonMainCampConfig:getPetGuardRecommendConfig(petGuardPlanId)
	return self._season_mode_pve_camp_pet_guard[petGuardPlanId]
end

function SeasonMainCampConfig:getPetGuardAddition(additionPlanId, awakenLv)
	local configs = self._season_mode_pve_camp_pet_addition[additionPlanId]

	if configs then
		return configs[awakenLv]
	end
end

function SeasonMainCampConfig:getPetGuardUnlockLevel(gridPlanId, posId)
	local configs = self._season_mode_pve_camp_pet_guard_grid[gridPlanId]

	if configs then
		local config = configs[posId]

		if config then
			return config.campLv
		end
	end
end

function SeasonMainCampConfig:getPetGuardRecommendRaceIds(petGuardPlanId)
	self._petGuardRaceIds = self._petGuardRaceIds or {}
	self._petGuardRaceIds[petGuardPlanId] = self._petGuardRaceIds[petGuardPlanId] or {}

	if not self._petGuardRaceIds[petGuardPlanId].recommendPets then
		local define = self:getPetGuardRecommendConfig(petGuardPlanId)
		local raceIds = string.splitToNumber(define.recommendPets or "", ",")

		self._petGuardRaceIds[petGuardPlanId].recommendPets = raceIds
		self._petGuardRaceIds[petGuardPlanId].recommendPetMap = {}

		local map = {}

		self._petGuardRaceIds[petGuardPlanId].recommendPetMap = map

		for i, v in ipairs(raceIds) do
			map[v] = true
		end
	end

	return self._petGuardRaceIds[petGuardPlanId].recommendPets, self._petGuardRaceIds[petGuardPlanId].recommendPetMap
end

function SeasonMainCampConfig:getPetGuardNormalRaceIds(petGuardPlanId)
	self._petGuardRaceIds = self._petGuardRaceIds or {}
	self._petGuardRaceIds[petGuardPlanId] = self._petGuardRaceIds[petGuardPlanId] or {}

	if not self._petGuardRaceIds[petGuardPlanId].normalPets then
		local define = self:getPetGuardRecommendConfig(petGuardPlanId)
		local raceIds = string.splitToNumber(define.normalPets or "", ",")

		self._petGuardRaceIds[petGuardPlanId].normalPets = raceIds

		local map = {}

		self._petGuardRaceIds[petGuardPlanId].normalPetsMap = map

		for i, v in ipairs(raceIds) do
			map[v] = true
		end
	end

	return self._petGuardRaceIds[petGuardPlanId].normalPets, self._petGuardRaceIds[petGuardPlanId].normalPetsMap
end

function SeasonMainCampConfig:getTotemPoleConfig(seasonId)
	return self._season_mode_pve_totem_pole[seasonId]
end

function SeasonMainCampConfig:getTotemPoleRaceTypeConfigs(totemPoleRaceTypePlanId)
	return self._season_mode_pve_totem_pole_race_type[totemPoleRaceTypePlanId]
end

function SeasonMainCampConfig:getTotemPoleRaceTypeConfig(totemPoleRaceTypePlanId, index)
	local configs = self._season_mode_pve_totem_pole_race_type[totemPoleRaceTypePlanId]

	if configs then
		return configs[index]
	end
end

function SeasonMainCampConfig:getTotemPoleItemConfig(totemItemPlanId, itemId, level)
	local configs = self._season_mode_pve_totem_item[totemItemPlanId]

	if configs then
		configs = configs[itemId]

		if configs then
			return configs[level]
		end
	end
end

function SeasonMainCampConfig:getTotemPoleItemList(totemItemPlanId)
	return self._season_mode_pve_totem_item[totemItemPlanId]
end

function SeasonMainCampConfig:getMainTotemConfigs(mainTotemPlanId)
	return self._season_mode_pve_main_totem[mainTotemPlanId]
end

function SeasonMainCampConfig:getMainTotemConfig(mainTotemPlanId, level)
	local configs = self._season_mode_pve_main_totem[mainTotemPlanId]

	if configs then
		return configs[level]
	end
end

function SeasonMainCampConfig:getBadgeConfigs(seasonId)
	return self._season_mode_pve_badge[seasonId]
end

function SeasonMainCampConfig:getBadgeConfig(seasonId, badgeId)
	if self._season_mode_pve_badge[seasonId] then
		return self._season_mode_pve_badge[seasonId][badgeId]
	end
end

function SeasonMainCampConfig:getTeamConfigList(planId)
	return self._season_mode_pve_team[planId]
end

function SeasonMainCampConfig:getTeamConfig(planId, teamId)
	if self._season_mode_pve_team[planId] then
		return self._season_mode_pve_team[planId][teamId]
	end
end

function SeasonMainCampConfig:getUpgradeConfig(planId, lvl)
	if self._season_mode_pve_team_upgrade[planId] then
		return self._season_mode_pve_team_upgrade[planId][lvl]
	end
end

function SeasonMainCampConfig:getUpgradeConfigList(planId)
	return table.nums(self._season_mode_pve_team_upgrade[planId] or {})
end

function SeasonMainCampConfig:onTeamMaxLvlSort(content)
	self._teamMaxLvlListMap = {}

	for i, v in ipairs(content.dataList) do
		local key = v.maxLvPlanId

		self._teamMaxLvlListMap[key] = self._teamMaxLvlListMap[key] or {}

		table.insert(self._teamMaxLvlListMap[key], v)
	end

	for key, v in pairs(self._teamMaxLvlListMap) do
		ArraySort.sortOn(self._teamMaxLvlListMap[key], "campLv")
	end
end

function SeasonMainCampConfig:getTeamMaxLvlCfgList(planId)
	return self._teamMaxLvlListMap[planId] or {}
end

function SeasonMainCampConfig:getSeasonPveHireTimes(planId, day)
	if self._season_mode_pve_hire_pet_times[planId] then
		return self._season_mode_pve_hire_pet_times[planId][day]
	end
end

function SeasonMainCampConfig:getNearTeamLvlConfig(planId, campLv)
	if not self._teamMaxLvlListMap[planId] then
		local list = {}
		local len = #list

		for i = len, 1, -1 do
			local cfg = list[i]

			if campLv >= cfg.campLv then
				return cfg
			end
		end

		return nil
	end
end

function SeasonMainCampConfig:getBadgeAttributes(seasonId, badgeId)
	local config = self:getBadgeConfig(seasonId, badgeId)

	return (config or nil) and config.propertyApp
end

function SeasonMainCampConfig:getBadgeAllAttributes(seasonId, badgeId)
	local res = {}
	local config = self:getBadgeConfig(seasonId, badgeId)

	if config then
		local attrs = FightingPowerFormula.instance:parseAttrValues(config.propertyApp) or {}

		res = AttrMo.addSameAttrs(attrs, res)
		attrs = FightingPowerFormula.instance:parseAttrValues(config.FormPropertyAppRate) or {}
		res = AttrMo.addSameAttrs(attrs, res)
		res[AttrMo.KEY_DIRECT_ZDL] = checknumber(res[AttrMo.KEY_DIRECT_ZDL]) + checknumber(config.numZdl)
	end

	return res
end

function SeasonMainCampConfig:getTotemPoleConfig(seasonId)
	return self._season_mode_pve_totem_pole[seasonId]
end

function SeasonMainCampConfig:getElvenHallConfig(seasonId)
	return self._season_mode_pve_pet_palace[seasonId]
end

function SeasonMainCampConfig:getTrainingGroundConfig(seasonId)
	return self._season_mode_pve_training_ground[seasonId]
end

function SeasonMainCampConfig:getBadgeSuitConfig(seasonId)
	local badgeCfg = self:getBadgeConfig(seasonId, 1)
	local result = {}

	if badgeCfg then
		local suitType = badgeCfg.suitType
		local cfg = self._season_mode_pve_badge_suit[suitType]

		for k, v in pairs(cfg) do
			if checknumber(k) > 0 then
				table.insert(result, v)
			end
		end

		ArraySort.sortOn(result, "num")
	end

	return result
end

function SeasonMainCampConfig:getCampEntranceConfig(seasonId)
	return self._season_mode_pve_camp_entrance[seasonId]
end

function SeasonMainCampConfig:getTotemSkillCfgsById(id)
	local seasonId = SeasonModel.instance:getSeasonId()
	local totemPoleRaceTypePlanId = self:getTotemPoleConfig(seasonId).totemPoleRaceTypePlanId
	local mainTotemPlanId = self:getTotemPoleRaceTypeConfig(totemPoleRaceTypePlanId, id).mainTotemPlanId
	local result = {}
	local index = 1
	local map = {}
	local config = self:getMainTotemConfigs(mainTotemPlanId)

	for i, v in ipairs(config) do
		if v.isNextUpgrade == "0" then
			map[v] = index
			v.id = index

			table.insert(result, v)

			index = index + 1
		end
	end

	return result, map
end

function SeasonMainCampConfig:getUnlockInfo(level)
	local seasonId = SeasonModel.instance:getSeasonId()
	local upgradePlanId = self:getMainCampConfig(seasonId).upgradePlanId
	local upgradeList = self:getMainCampUpgradeConfig(upgradePlanId)

	return upgradeList[level]
end

function SeasonMainCampConfig:getAllCutePetInfo()
	return self._season_mode_pve_cute_pet.dataList
end

function SeasonMainCampConfig:getCutePetInfo(cutePetId)
	return self._season_mode_pve_cute_pet[cutePetId]
end

function SeasonMainCampConfig:getCutePetLevelInfo(cutePetId)
	return self._season_mode_pve_cute_pet_level[cutePetId]
end

function SeasonMainCampConfig:getCutePetLevelInfoList(cutePetId)
	if not self._cutePetLevelList then
		self:_handleCutePetLevelCfg()
	end

	return self._cutePetLevelList[cutePetId]
end

function SeasonMainCampConfig:_handleCutePetLevelCfg()
	self._cutePetLevelList = {}

	for i, v in ipairs(self._season_mode_pve_cute_pet_level.dataList) do
		self._cutePetLevelList[v.cutePetType] = self._cutePetLevelList[v.cutePetType] or {}

		table.insert(self._cutePetLevelList[v.cutePetType], v)
	end

	for i, v in pairs(self._cutePetLevelList) do
		table.sort(v, function(a, b)
			return a.campLv < b.campLv
		end)
	end
end

function SeasonMainCampConfig:getCutePetTalentInfo(cutePetId)
	return self._season_mode_pve_cute_pet_talent[cutePetId]
end

function SeasonMainCampConfig:getMiniCutePetUnLockCampLv()
	local miniCutePetUnLockCampLv = math.huge

	for i, v in ipairs(self._season_mode_pve_cute_pet.dataList) do
		if miniCutePetUnLockCampLv > v.openCampLv then
			miniCutePetUnLockCampLv = v.openCampLv
		end
	end

	return miniCutePetUnLockCampLv
end

SeasonMainCampConfig.instance = SeasonMainCampConfig.New()

return SeasonMainCampConfig
