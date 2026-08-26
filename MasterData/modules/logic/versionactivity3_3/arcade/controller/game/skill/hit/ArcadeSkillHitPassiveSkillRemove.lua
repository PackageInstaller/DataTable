-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/skill/hit/ArcadeSkillHitPassiveSkillRemove.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.skill.hit.ArcadeSkillHitPassiveSkillRemove", package.seeall)

local ArcadeSkillHitPassiveSkillRemove = class("ArcadeSkillHitPassiveSkillRemove", ArcadeSkillHitBase)

function ArcadeSkillHitPassiveSkillRemove:onCtor()
	local params = self._params

	self._changeName = params[1]
	self._removeSkillId = tonumber(params[2])
end

function ArcadeSkillHitPassiveSkillRemove:onHit()
	if self._context and self._context.target then
		local target = self._context.target

		self:addHiter(target)
		target:removeSkillById(self._removeSkillId)
	end
end

function ArcadeSkillHitPassiveSkillRemove:onHitPrintLog()
	logNormal(string.format("%s ==> 自身移除特定id的被动技能:[%s]", self:getLogPrefixStr(), self._removeSkillId))
end

return ArcadeSkillHitPassiveSkillRemove
