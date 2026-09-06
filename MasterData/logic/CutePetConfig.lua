-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cutepet/config/CutePetConfig.lua

module("logic.extensions.cutepet.config.CutePetConfig", package.seeall)

local CutePetConfig = class("CutePetConfig", BaseConfig)

function CutePetConfig:onInit()
	CutePetConfig.super.onInit(self)
end

function CutePetConfig:getNames()
	return {
		"cute_pet_other_config",
		"cute_pet_adventure_building_lvl",
		"cute_pet_guest_house_speed_up_cost",
		"cute_pet_garden_lvl",
		"cute_pet_garden_interact_cost",
		"cute_pet",
		"cute_pet_type",
		"cute_pet_init_property_grading",
		"cute_pet_lvlup_plan",
		"cute_pet_starup_plan",
		"cute_pet_star_skill",
		"cute_pet_qualityup_plan",
		"cute_pet_assistance_plan",
		"cute_pet_talent",
		"cute_pet_privilege",
		"cute_pet_privilege_time_plan",
		"cute_pet_introduce",
		"cute_pet_view_model",
		"cute_pet_init_property_plan"
	}
end

function CutePetConfig:handleConfig(name, content)
	if name == "cute_pet_other_config" then
		self._cute_pet_other_config = content
	elseif name == "cute_pet_adventure_building_lvl" then
		self._cute_pet_adventure_building_lvl = content
	elseif name == "cute_pet_guest_house_speed_up_cost" then
		self._cute_pet_guest_house_speed_up_cost = content
	elseif name == "cute_pet_garden_lvl" then
		self._cute_pet_garden_lvl = content
	elseif name == "cute_pet_garden_interact_cost" then
		self._cute_pet_garden_interact_cost = content
	elseif name == "cute_pet" then
		self._cute_pet = content
	elseif name == "cute_pet_type" then
		self._cute_pet_type = content
	elseif name == "cute_pet_init_property_grading" then
		self._cute_pet_init_property_grading = content
	elseif name == "cute_pet_lvlup_plan" then
		self._cute_pet_lvlup_plan = content
	elseif name == "cute_pet_starup_plan" then
		self._cute_pet_starup_plan = content
	elseif name == "cute_pet_star_skill" then
		self._cute_pet_star_skill = content
	elseif name == "cute_pet_qualityup_plan" then
		self._cute_pet_qualityup_plan = content
	elseif name == "cute_pet_assistance_plan" then
		self._cute_pet_assistance_plan = content
	elseif name == "cute_pet_talent" then
		self._cute_pet_talent = content
	elseif name == "cute_pet_privilege" then
		self._cute_pet_privilege = content
	elseif name == "cute_pet_privilege_time_plan" then
		self._cute_pet_privilege_time_plan = content
	elseif name == "cute_pet_introduce" then
		self._cute_pet_introduce = content
	elseif name == "cute_pet_view_model" then
		self._cute_pet_view_model = content
	elseif name == "cute_pet_init_property_plan" then
		self._cute_pet_init_property_plan = content
	end
end

function CutePetConfig:getCutePetById(raceId)
	return self._cute_pet[raceId]
end

function CutePetConfig:getCutePetList()
	return self._cute_pet.dataList
end

function CutePetConfig:getGardenCfg(lv)
	return self._cute_pet_garden_lvl[lv]
end

function CutePetConfig:getAllPetTypeCfg()
	return self._cute_pet_type
end

function CutePetConfig:getPetTypeCfg(typeId)
	return self._cute_pet_type[typeId]
end

function CutePetConfig:getCommonValue(key, isToNumber)
	local val

	if self._cute_pet_other_config and self._cute_pet_other_config[key] then
		val = self._cute_pet_other_config[key].value
	end

	if isToNumber then
		val = checknumber(val)
	end

	return val
end

function CutePetConfig:getGuestSpeedUpCfg(planId)
	return self._cute_pet_guest_house_speed_up_cost[planId]
end

function CutePetConfig:getAssistanceCfgByRaceId(raceId, quality)
	local cfg = self:getCutePetById(raceId)

	if cfg then
		return self:getAssistanceCfg(cfg.type, quality)
	end

	return nil
end

function CutePetConfig:getAssistanceCfg(petType, quality)
	if self._cute_pet_assistance_plan[petType] then
		return self._cute_pet_assistance_plan[petType][quality]
	end

	return nil
end

function CutePetConfig:getStarUpCfgs(planId)
	return self._cute_pet_starup_plan[planId]
end

function CutePetConfig:getStarUpCfg(planId, star)
	return self._cute_pet_starup_plan[planId][star]
end

function CutePetConfig:getMaxStar(planId, quality)
	if not self._cute_pet_starup_plan[planId] then
		return 0
	end

	local maxStar = 0

	for i, v in ipairs(self._cute_pet_starup_plan[planId]) do
		if quality >= v.minQuality then
			maxStar = v.star
		end
	end

	return maxStar
end

function CutePetConfig:getStarSkillCfgs(raceId)
	return self._cute_pet_star_skill[raceId]
end

function CutePetConfig:getStarSkillCfg(raceId, star)
	return self._cute_pet_star_skill[raceId][star]
end

function CutePetConfig:getQualityUpPlan(planId)
	return self._cute_pet_qualityup_plan[planId]
end

function CutePetConfig:getAttrSortByQualityPlan(planId)
	self._attrSortByQualityPlan = self._attrSortByQualityPlan or {}

	if not self._attrSortByQualityPlan[planId] then
		self._attrSortByQualityPlan[planId] = {}

		local plan = self:getQualityUpPlan(planId) or {}

		for i, v in ipairs(plan) do
			for j, attrType in ipairs(v.newActivePropTypes) do
				local typeIndex = FightingPowerFormula.instance:getAttrTypeByName(attrType)

				table.insert(self._attrSortByQualityPlan[planId], typeIndex)
			end
		end
	end

	return self._attrSortByQualityPlan[planId]
end

function CutePetConfig:getQualityUpCfg(planId, quality)
	return self._cute_pet_qualityup_plan[planId][quality]
end

function CutePetConfig:getLevelUpCfgs(planId)
	return self._cute_pet_lvlup_plan[planId]
end

function CutePetConfig:getLevelUpCfg(planId, level)
	return self._cute_pet_lvlup_plan[planId][level]
end

function CutePetConfig:getInteractCfgs()
	return self._cute_pet_garden_interact_cost.dataList
end

function CutePetConfig:getPropertyGradingCfg(typeName)
	return self._cute_pet_init_property_grading[typeName]
end

function CutePetConfig:getAllAdventureBuilding()
	return self._cute_pet_adventure_building_lvl
end

function CutePetConfig:getAdventureBuildingCfg(buildingId, buildingLv)
	return self._cute_pet_adventure_building_lvl[buildingId][buildingLv]
end

function CutePetConfig:getTalentCfg(talentId)
	return self._cute_pet_talent[talentId]
end

function CutePetConfig:getPrivilegeCommonValue(key, isToNumber)
	local val

	if self._cute_pet_privilege and self._cute_pet_privilege[key] then
		val = self._cute_pet_privilege[key].value
	end

	if isToNumber then
		val = checknumber(val)
	end

	return val
end

function CutePetConfig:getPrivilegeTimePlanCfgs()
	return self._cute_pet_privilege_time_plan.dataList
end

function CutePetConfig:getPetIntroduceCfgs()
	return self._cute_pet_introduce.dataList
end

function CutePetConfig:getPetOffsetInView(raceId)
	return self._cute_pet_view_model[raceId]
end

function CutePetConfig:getPetOffsetInDefaultView(raceId)
	if self._cute_pet_view_model[raceId] and self._cute_pet_view_model[raceId].default then
		local offset = self._cute_pet_view_model[raceId].default

		return {
			z = 0,
			x = offset[1],
			y = offset[2],
			scale = offset[3]
		}
	else
		return {
			scale = 1,
			z = 0,
			x = 0,
			y = 0
		}
	end
end

function CutePetConfig:getTagByTalentId(talentId)
	self._talentTagMap = self._talentTagMap or {}

	if not self._talentTagMap[typeId] then
		local tagStr = self._cute_pet_talent[talentId].petValidator
		local str = string.split(tagStr, "$") or {}

		self._talentTagMap[typeId] = str[2]
	end

	return self._talentTagMap[typeId]
end

function CutePetConfig:getInitPropCfgs(planId)
	return self._cute_pet_init_property_plan[planId]
end

function CutePetConfig:isIllusionCard(matId)
	if not self._illusionCardMap then
		self._illusionCardMap = {}

		for i, v in ipairs(self._cute_pet.dataList) do
			local matType, cfgId, matNum = MaterialMgr.getMatParams(v.cost4UnlockIllusion)

			self._illusionCardMap[cfgId] = v.raceId
		end
	end

	if checknumber(self._illusionCardMap[matId]) ~= 0 then
		return true
	else
		return false
	end
end

function CutePetConfig:getIllusionCardCutePet(matId)
	return self._illusionCardMap[matId]
end

CutePetConfig.instance = CutePetConfig.New()

return CutePetConfig
