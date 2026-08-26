-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/skill/hit/ArcadeSkillHitNormal.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.skill.hit.ArcadeSkillHitNormal", package.seeall)

local ArcadeSkillHitNormal = class("ArcadeSkillHitNormal", ArcadeSkillHitBase)

function ArcadeSkillHitNormal:onHit()
	if self._context and self._context.target then
		self:addHiter(self._context.target)
	end
end

function ArcadeSkillHitNormal:onHitPrintLog()
	logNormal(string.format("%s ==> 默认都技能条件都能释放", self:getLogPrefixStr()))
end

return ArcadeSkillHitNormal
