-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/skill/hit/ArcadeSkillHitDirShield.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.skill.hit.ArcadeSkillHitDirShield", package.seeall)

local ArcadeSkillHitDirShield = class("ArcadeSkillHitDirShield", ArcadeSkillHitBase)

function ArcadeSkillHitDirShield:onCtor()
	local params = self._params

	self._changeName = params[1]
	self._buffId = tonumber(params[2])
end

function ArcadeSkillHitDirShield:onHit()
	if self._context and self._context.target then
		local unitMO = self._context.target

		self:addHiter(unitMO)
		ArcadeGameController.instance:addBuff2Entity(self._buffId, unitMO:getEntityType(), unitMO:getUid())

		if self._context.hiterList then
			-- block empty
		end
	end
end

function ArcadeSkillHitDirShield:onHitPrintLog()
	if self._context and self._context.target then
		local target = self._context.target

		logNormal(string.format("%s ==> 方向生成护盾BUFF:%s  type:%s id:%s uid:%s", self:getLogPrefixStr(), self._buffId, target:getEntityType(), target:getUid(), target:getId()))
	end
end

return ArcadeSkillHitDirShield
