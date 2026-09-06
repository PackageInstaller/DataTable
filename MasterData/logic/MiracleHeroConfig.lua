-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miraclehero/config/MiracleHeroConfig.lua

module("logic.extensions.miraclehero.config.MiracleHeroConfig", package.seeall)

local MiracleHeroConfig = class("MiracleHeroConfig", BaseConfig)

function MiracleHeroConfig:onInit()
	MiracleHeroConfig.super.onInit(self)

	self._cofignameCfg = nil
end

function MiracleHeroConfig:getNames()
	return {
		"miracle_hero_activity",
		"miracle_hero_assist_pet",
		"miracle_hero_challenge",
		"miracle_hero_creeps",
		"miracle_hero_pet_property_strategy",
		"miracle_hero_pet_race_type",
		"miracle_hero_pet",
		"miracle_hero_position_upgrade",
		"miracle_hero_rank_prize",
		"miracle_hero_stage",
		"miracle_hero_team",
		"miracle_hero_pet_skill",
		"miracle_hero_pet_skill_affix",
		"miracle_hero_damage_rate",
		"miracle_hero_block_layout_plan",
		"miracle_hero_block_layout",
		"miracle_hero_rule_desc"
	}
end

function MiracleHeroConfig:handleConfig(name, content)
	if name == "miracle_hero_activity" then
		self._actCfg = content
	elseif name == "miracle_hero_assist_pet" then
		self._assistPetCfgs = content
	elseif name == "miracle_hero_challenge" then
		self._challengeCfgs = content
	elseif name == "miracle_hero_creeps" then
		self._miracle_hero_creeps = content
	elseif name == "miracle_hero_pet_property_strategy" then
		self._propertyCfgs = content
	elseif name == "miracle_hero_pet_skill" then
		self._skillCfgs = content
	elseif name == "miracle_hero_pet_race_type" then
		self._miracle_hero_pet_race_type = content
	elseif name == "miracle_hero_pet" then
		self._petCfgs = content
	elseif name == "miracle_hero_position_upgrade" then
		self._positUpgradeCfgs = content
	elseif name == "miracle_hero_rank_prize" then
		self._rankCfgs = content
	elseif name == "miracle_hero_stage" then
		self._stageCfgs = content
	elseif name == "miracle_hero_team" then
		self._miracle_hero_team = content
	elseif name == "miracle_hero_pet_skill_affix" then
		self._miracle_hero_pet_skill_affix = content

		self:handlerSkillAffix(content)
	elseif name == "miracle_hero_damage_rate" then
		self._miracle_hero_damage_rate = content
	elseif name == "miracle_hero_block_layout_plan" then
		self._miracle_hero_block_layout_plan = content
	elseif name == "miracle_hero_block_layout" then
		self._miracle_hero_block_layout = content
	elseif name == "miracle_hero_rule_desc" then
		self._ruleDescCfgs = content
	end
end

function MiracleHeroConfig:getActCfg(actId)
	return self._actCfg[actId]
end

function MiracleHeroConfig:getRankPrizeStrByRank(actId, rank)
	local temRank = checknumber(rank)

	if not self._rankCfgs[actId] then
		for range, cfg in pairs(self._rankCfgs[actId]) do
			if range and temRank >= range[1] and temRank <= range[2] then
				return cfg.prize
			end
		end

		return ""
	end
end

function MiracleHeroConfig:getChallengeCfgs(actId)
	return self._challengeCfgs[actId]
end

function MiracleHeroConfig:getStageCfgs(actId, challengeId)
	return (self._stageCfgs[actId] or nil) and (self._stageCfgs[actId][challengeId] or {})
end

function MiracleHeroConfig:getStageCfg(actId, challengeId, stageId)
	return self._stageCfgs[actId] and self._stageCfgs[actId][challengeId] and self._stageCfgs[actId][challengeId][stageId]
end

function MiracleHeroConfig:getPetCfgs(actId)
	return self._petCfgs[actId] or {}
end

function MiracleHeroConfig:getPetCfg(actId, raceId)
	return self._petCfgs[actId] and self._petCfgs[actId][raceId]
end

function MiracleHeroConfig:getAssistCfgs(actId)
	return self._assistPetCfgs[actId] or {}
end

function MiracleHeroConfig:getAssistCfg(actId, assistId)
	return self._assistPetCfgs[actId] and self._assistPetCfgs[actId][assistId]
end

function MiracleHeroConfig:getSkillCfg(skillId)
	return self._skillCfgs[skillId]
end

function MiracleHeroConfig:getPositUpgradeCfgs(actId)
	return self._positUpgradeCfgs[actId]
end

function MiracleHeroConfig:getShowLevel(actId, trueLv)
	if self._positUpgradeCfgs[actId] then
		return (self._positUpgradeCfgs[actId] or nil) and (self._positUpgradeCfgs[actId].showLevel or 1)
	end
end

function MiracleHeroConfig:getPropertyCfgs(planId)
	return self._propertyCfgs[planId]
end

function MiracleHeroConfig:getRaceFaceId(actId, raceId)
	local cfg = self:getPetCfg(actId, raceId)

	return checknumber(cfg and cfg.faceIds)
end

function MiracleHeroConfig:getAssistFaceId(actId, assistId)
	local cfg = self:getAssistCfg(actId, assistId)

	return checknumber(cfg and cfg.faceIds)
end

function MiracleHeroConfig:getSkillAffixCfg(id)
	return self._miracle_hero_pet_skill_affix[id]
end

function MiracleHeroConfig:getDamageRateCfg(num)
	return self._miracle_hero_damage_rate[num] or 1
end

function MiracleHeroConfig:handlerSkillAffix(content)
	local list = content.dataList

	self._skillAffixMap = {}

	for i, v in ipairs(list) do
		self._skillAffixMap[v.skillId] = self._skillAffixMap[v.skillId] or {}

		table.insert(self._skillAffixMap[v.skillId], v.id)
	end
end

function MiracleHeroConfig:getAffixBySkillId(skillId)
	return self._skillAffixMap[skillId] or {}
end

function MiracleHeroConfig:getRaceType(id)
	return self._miracle_hero_pet_race_type[id]
end

function MiracleHeroConfig:getLayoutPlan(planId)
	return self._miracle_hero_block_layout_plan[planId]
end

function MiracleHeroConfig:getLayout(layoutId)
	return self._miracle_hero_block_layout[layoutId]
end

function MiracleHeroConfig:getTeamCfg(actId, creepsMasterId)
	return self._miracle_hero_team[actId][creepsMasterId]
end

function MiracleHeroConfig:getCreepsCfg(actId, creepsMasterId)
	return self._miracle_hero_creeps[actId][creepsMasterId]
end

function MiracleHeroConfig:getRuleDescCfgs(actId)
	return self._ruleDescCfgs[actId]
end

MiracleHeroConfig.instance = MiracleHeroConfig.New()

return MiracleHeroConfig
