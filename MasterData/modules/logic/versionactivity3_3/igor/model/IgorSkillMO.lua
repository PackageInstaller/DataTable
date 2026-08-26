-- chunkname: @modules/logic/versionactivity3_3/igor/model/IgorSkillMO.lua

module("modules.logic.versionactivity3_3.igor.model.IgorSkillMO", package.seeall)

local IgorSkillMO = class("IgorSkillMO")

function IgorSkillMO:init(id, campMo)
	self.id = id
	self.campMo = campMo
	self.skillUseTimes = 0
	self.skillCD = 0
	self.skillCost = 0

	if self.id == IgorEnum.SkillType.Attack then
		local cd = IgorConfig.instance:getConstValue(IgorEnum.ConstId.SkillCD1)

		self.skillCD = tonumber(cd)

		local cost = IgorConfig.instance:getConstValue(IgorEnum.ConstId.SkillCost1)

		self.skillCost = tonumber(cost)

		local config = self.campMo:getConfig()

		self.skillTimes = config.skill1Times
	elseif self.id == IgorEnum.SkillType.Defense then
		local cd = IgorConfig.instance:getConstValue(IgorEnum.ConstId.SkillCD2)

		self.skillCD = tonumber(cd)

		local cost = IgorConfig.instance:getConstValue(IgorEnum.ConstId.SkillCost2)

		self.skillCost = tonumber(cost)

		local config = self.campMo:getConfig()

		self.skillTimes = config.skill2Times
	elseif self.id == IgorEnum.SkillType.Transfer then
		local cd = IgorConfig.instance:getConstValue(IgorEnum.ConstId.SkillCD3)

		self.skillCD = tonumber(cd)

		local cost = IgorConfig.instance:getConstValue(IgorEnum.ConstId.SkillCost3)

		self.skillCost = tonumber(cost)
		self.skillTimes = 1
	elseif self.id == IgorEnum.SkillType.Levup then
		local level = self.campMo:getLevel()
		local config = IgorConfig.instance:getBaseConfig(self.campMo.entityId, level + 1)

		if config then
			self.skillCost = config.cost or 0
		end

		self.skillTimes = 99999
	end
end

function IgorSkillMO:onLevelup()
	if self.id == IgorEnum.SkillType.Attack then
		local config = self.campMo:getConfig()

		self.skillTimes = config.skill1Times
	elseif self.id == IgorEnum.SkillType.Defense then
		local config = self.campMo:getConfig()

		self.skillTimes = config.skill2Times
	elseif self.id == IgorEnum.SkillType.Levup then
		local level = self.campMo:getLevel()
		local config = IgorConfig.instance:getBaseConfig(self.campMo.entityId, level + 1)

		if config then
			self.skillCost = config.cost or 0
		end
	end
end

function IgorSkillMO:onUseSkill()
	if not self:isHasRemainTimes() then
		return
	end

	self.skillUseTimes = self.skillUseTimes + 1
end

function IgorSkillMO:onTransfer()
	self.skillUseTimes = self.skillUseTimes - 1
end

function IgorSkillMO:getSkillUseTimes()
	return self.skillUseTimes
end

function IgorSkillMO:getSkillRemainTimes()
	return self.skillTimes - self.skillUseTimes
end

function IgorSkillMO:isHasRemainTimes()
	return self:getSkillRemainTimes() > 0
end

function IgorSkillMO:getSkillCD()
	return self.skillCD
end

function IgorSkillMO:getSkillCost()
	return self.skillCost
end

return IgorSkillMO
