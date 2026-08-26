-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/skill/hit/ArcadeSkillHitSkillAttack.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.skill.hit.ArcadeSkillHitSkillAttack", package.seeall)

local ArcadeSkillHitSkillAttack = class("ArcadeSkillHitSkillAttack", ArcadeSkillHitBase)

function ArcadeSkillHitSkillAttack:onCtor()
	local params = self._params

	self._changeName = params[1]
	self._useSkillId = tonumber(params[2])
end

function ArcadeSkillHitSkillAttack:onHit()
	if self._context and self._context.target then
		local target = self._context.target

		self:addHiter(target)
		ArcadeGameSkillController.instance:useActiveSkill(target, self._useSkillId, self._context)
	end
end

function ArcadeSkillHitSkillAttack:onHitPrintLog()
	logNormal(string.format("%s ==> 释放一次主动技能攻击:[%s]", self:getLogPrefixStr(), self._useSkillId))
end

return ArcadeSkillHitSkillAttack
