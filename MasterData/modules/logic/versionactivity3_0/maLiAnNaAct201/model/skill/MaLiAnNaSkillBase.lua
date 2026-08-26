-- chunkname: @modules/logic/versionactivity3_0/maLiAnNaAct201/model/skill/MaLiAnNaSkillBase.lua

module("modules.logic.versionactivity3_0.maLiAnNaAct201.model.skill.MaLiAnNaSkillBase", package.seeall)

local MaLiAnNaSkillBase = class("MaLiAnNaSkillBase")

function MaLiAnNaSkillBase:ctor()
	self._id = 0
	self._configId = 0
	self._cdTime = 0
end

function MaLiAnNaSkillBase:init(id, configId)
	self._id = id
	self._configId = configId

	self:_initEffect()
end

function MaLiAnNaSkillBase:getConfig()
	return self._config
end

function MaLiAnNaSkillBase:getConfigId()
	return self._configId
end

function MaLiAnNaSkillBase:_initEffect()
	if self._config == nil then
		return
	end

	local effect = self._config.effect

	if not string.nilorempty(effect) then
		self._effect = string.splitToNumber(effect, "#")
	end
end

function MaLiAnNaSkillBase:getSkillActionType()
	if self._effect == nil then
		return nil
	end

	return self._effect[1]
end

function MaLiAnNaSkillBase:getEffect()
	return self._effect
end

function MaLiAnNaSkillBase:getSkillType()
	return self._skillType
end

function MaLiAnNaSkillBase:getCdTime()
	return self._cdTime
end

function MaLiAnNaSkillBase:update(time)
	if self._cdTime <= 0 then
		return true
	end

	self._cdTime = math.max(self._cdTime - time * 1000, 0)

	return false
end

function MaLiAnNaSkillBase:execute()
	return
end

return MaLiAnNaSkillBase
