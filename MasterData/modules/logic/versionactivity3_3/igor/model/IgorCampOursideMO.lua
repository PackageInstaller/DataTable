-- chunkname: @modules/logic/versionactivity3_3/igor/model/IgorCampOursideMO.lua

module("modules.logic.versionactivity3_3.igor.model.IgorCampOursideMO", package.seeall)

local IgorCampOursideMO = class("IgorCampOursideMO", IgorCampBasedMO)

function IgorCampOursideMO:onInit()
	self.skillDataDict = {}

	for k, skillId in pairs(IgorEnum.SkillType) do
		local mo = IgorSkillMO.New()

		mo:init(skillId, self)

		self.skillDataDict[skillId] = mo
	end
end

function IgorCampOursideMO:getSkillMO(skillId)
	return self.skillDataDict[skillId]
end

function IgorCampOursideMO:levelup()
	if self:isDead() then
		return
	end

	if self:isMaxLevel() then
		return
	end

	local nextLev = self.level + 1
	local config = IgorConfig.instance:getBaseConfig(self.entityId, nextLev)

	if not self.gameMo:tryCost(config.cost) then
		return
	end

	self.level = nextLev

	local lastConfig = self.config

	self.config = config

	self:setAttackSpeed(config.attackSpeed)

	local addHealth = config.health - lastConfig.health

	self:addHealthAndMaxHealth(addHealth, addHealth)
	self:onLevelup()
	IgorController.instance:dispatchEvent(IgorEvent.OnEntityLevChange, self)
	IgorController.instance:dispatchEvent(IgorEvent.OnCampAttrChange, self, IgorEnum.SkillType.Levup)

	return true
end

function IgorCampOursideMO:defenseup()
	if self:isDead() then
		return
	end

	local skillData = self:getSkillMO(IgorEnum.SkillType.Defense)

	if not skillData:isHasRemainTimes() then
		return
	end

	local cost = skillData:getSkillCost()

	if not self.gameMo:tryCost(cost) then
		return
	end

	skillData:onUseSkill()

	local val = IgorConfig.instance:getConstValue(IgorEnum.ConstId.SkillValue2)
	local param = string.splitToNumber(val, "#")

	self:addHealthAndMaxHealth(param[1], param[2])
	IgorController.instance:dispatchEvent(IgorEvent.OnCampAttrChange, self, skillData.id)

	return true
end

function IgorCampOursideMO:attackup()
	if self:isDead() then
		return
	end

	local skillData = self:getSkillMO(IgorEnum.SkillType.Attack)

	if not skillData:isHasRemainTimes() then
		return
	end

	local cost = skillData:getSkillCost()

	if not self.gameMo:tryCost(cost) then
		return
	end

	skillData:onUseSkill()

	local val = IgorConfig.instance:getConstValue(IgorEnum.ConstId.SkillValue1)

	self:addExDamage(tonumber(val))
	IgorController.instance:dispatchEvent(IgorEvent.OnCampAttrChange, self, skillData.id)

	return true
end

function IgorCampOursideMO:transfer()
	if self:isDead() then
		return
	end

	local skillData = self:getSkillMO(IgorEnum.SkillType.Transfer)

	if not skillData:isHasRemainTimes() then
		return
	end

	local cost = skillData:getSkillCost()

	if not self.gameMo:tryCost(cost) then
		return
	end

	skillData:onUseSkill()
	IgorController.instance:dispatchEvent(IgorEvent.OnCampAttrChange, self, skillData.id)

	return true
end

function IgorCampOursideMO:onLevelup()
	for _, skillMo in pairs(self.skillDataDict) do
		skillMo:onLevelup()
	end
end

return IgorCampOursideMO
