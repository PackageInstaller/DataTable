-- chunkname: @modules/logic/versionactivity2_7/lengzhou6/model/skill/SkillBase.lua

module("modules.logic.versionactivity2_7.lengzhou6.model.skill.SkillBase", package.seeall)

local SkillBase = class("SkillBase")

function SkillBase:ctor()
	self._id = 0
	self._configId = 0
	self._cd = 0
	self._entity = nil
	self._skillType = LengZhou6Enum.SkillType.passive
end

function SkillBase:init(id, configId)
	self._id = id
	self._configId = configId
	self._config = LengZhou6Config.instance:getEliminateBattleSkill(configId)
	self._cd = self._config.cd

	self:_initEffect()
end

function SkillBase:getConfig()
	return self._config
end

function SkillBase:getConfigId()
	return self._configId
end

function SkillBase:_initEffect()
	local effect = self._config.effect

	self._triggerPoint = self._config.triggerPoint

	if not string.nilorempty(effect) then
		self._effect = string.split(effect, "#")
	end
end

function SkillBase:getEffect()
	return self._effect
end

function SkillBase:initEntity(entity)
	self._entity = entity
end

function SkillBase:getEntityCamp()
	if self._entity then
		return self._entity:getCamp()
	end

	return -1
end

function SkillBase:getSkillType()
	return self._skillType
end

function SkillBase:getCd()
	return self._cd
end

function SkillBase:setCd(cd)
	self._cd = cd

	if self._cd < 0 then
		self._cd = 0
	end
end

function SkillBase:updateCD()
	self._cd = self._cd - 1

	if self._cd < 0 then
		self._cd = 0
	end
end

function SkillBase:execute()
	if self._cd == 0 then
		self._cd = self._config.cd

		return true
	end
end

return SkillBase
