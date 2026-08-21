-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/think/model/ThinkingMO.lua

module("logic.extensions.think.model.ThinkingMO", package.seeall)

local ThinkingMO = class("ThinkingMO")

function ThinkingMO:ctor(cfg)
	self._id = cfg.id
	self._cfgId = cfg.id
	self._name = cfg.name
	self._online = cfg.online > 0
	self._icon = cfg.icon
	self._skills = {}
end

function ThinkingMO:updateByAgent(ThinkingNO)
	table.clear(self._skills)

	for _, SkillNO in ipairs(ThinkingNO.skills or {}) do
		table.insert(self._skills, {
			id = SkillNO.id,
			level = SkillNO.level
		})
	end
end

function ThinkingMO:getId()
	return self._id
end

function ThinkingMO:getCfgId()
	return self._cfgId
end

function ThinkingMO:getIsOnline()
	return self._online
end

function ThinkingMO:getName()
	return self._name
end

function ThinkingMO:getCareerName(career)
	return self._careerNames[career] or "未定义思维职业名"
end

function ThinkingMO:getIcon()
	return self._icon
end

function ThinkingMO:getDescription()
	return self._description
end

function ThinkingMO:setSkillLevel(id, lv)
	local find = false

	for _, v in ipairs(self._skills) do
		if v.id == id then
			v.level = lv
			find = true

			break
		end
	end

	if not find then
		table.insert(self._skills, {
			id = id,
			level = lv
		})
	end
end

function ThinkingMO:getSkills()
	return self._skills
end

function ThinkingMO:getSkillLevel(skillId)
	for _, skillMo in ipairs(self._skills) do
		if skillMo.id == skillId then
			return skillMo.level
		end
	end

	return 0
end

function ThinkingMO:isMaxLevelSkill(skillId)
	local curLevel = self:getSkillLevel(skillId)
	local maxLevel = ThinkingConfig.instance:getMaxThinkingSkillLevel(skillId)

	return maxLevel <= curLevel
end

function ThinkingMO:getSkillData(skillId, skillLevel)
	local skillName = ""
	local skillDesc = ""
	local skillIcon = ""

	skillLevel = skillLevel or self:getSkillLevel(skillId)

	local skillEnhanceMO = self:getSkillEnhanceMO(skillId, skillLevel)

	if skillEnhanceMO then
		local skillCO = skillEnhanceMO:getSkillCO()

		skillName = skillCO.name
		skillDesc = skillEnhanceMO:getDescription()
		skillIcon = ActiveSkillCOUtil.getSkillIcon(skillCO)
	end

	SkillEnhanceMO.releaseSharedMO(skillEnhanceMO)

	return skillName, skillDesc, skillIcon
end

function ThinkingMO:getSkillEnhanceMO(skillId, skillLevel)
	skillLevel = skillLevel or self:getSkillLevel(skillId)

	local skillEnhanceMO = SkillEnhanceMO.New(skillId)

	if skillEnhanceMO then
		local cfgUpgrade = ThinkingConfig.instance:getThinkingSkillCfg(skillId) or {}

		for i = 1, skillLevel do
			if cfgUpgrade[i] and cfgUpgrade[i].skillEnhance > 0 then
				skillEnhanceMO:addSkillEnhanceCode(cfgUpgrade[i].skillEnhance)
			end
		end

		skillEnhanceMO:rebuild()
	else
		printWarn("无法获取skillEnhanceMo:", skillId)
	end

	return skillEnhanceMO
end

return ThinkingMO
