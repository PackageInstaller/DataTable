-- chunkname: @modules/logic/versionactivity3_0/maLiAnNaAct201/model/skill/MaLiAnNaPassiveSkill.lua

module("modules.logic.versionactivity3_0.maLiAnNaAct201.model.skill.MaLiAnNaPassiveSkill", package.seeall)

local MaLiAnNaPassiveSkill = class("MaLiAnNaPassiveSkill", MaLiAnNaSkillBase)

function MaLiAnNaPassiveSkill:init(id, configId)
	self._config = Activity201MaLiAnNaConfig.instance:getPassiveSkillConfig(configId)

	MaLiAnNaPassiveSkill.super.init(self, id, configId)

	self._skillType = Activity201MaLiAnNaEnum.SkillType.passive

	self:_initCdTime()
end

function MaLiAnNaPassiveSkill:_initCdTime()
	self._cdTime = 0

	if self:getSkillActionType() == Activity201MaLiAnNaEnum.SkillAction.releaseBullet then
		self._cdTime = self:getEffect()[2] or 0
	end
end

function MaLiAnNaPassiveSkill:update(time)
	local state = MaLiAnNaPassiveSkill.super.update(self, time)

	if state then
		self:execute()
		self:_initCdTime()
	end
end

function MaLiAnNaPassiveSkill:setUseSoliderId(soliderId)
	if self._params == nil then
		self._params = {}
	end

	table.insert(self._params, soliderId)
end

function MaLiAnNaPassiveSkill:execute()
	if self:getSkillActionType() == Activity201MaLiAnNaEnum.SkillAction.releaseBullet then
		if self._params == nil or #self._params == 0 then
			return
		end

		Activity201MaLiAnNaGameController.instance:addAction(self:getEffect(), self._params)
	end
end

function MaLiAnNaPassiveSkill:destroy()
	self._soliderId = nil
	self._config = nil
end

return MaLiAnNaPassiveSkill
