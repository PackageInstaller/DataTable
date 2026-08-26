-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/skill/hit/ArcadeSkillHitUnaffectedFloor.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.skill.hit.ArcadeSkillHitUnaffectedFloor", package.seeall)

local ArcadeSkillHitUnaffectedFloor = class("ArcadeSkillHitUnaffectedFloor", ArcadeSkillHitBase)

function ArcadeSkillHitUnaffectedFloor:onCtor()
	local params = self._params

	self._changeName = params[1]
	self._floorId = tonumber(params[2])
end

function ArcadeSkillHitUnaffectedFloor:onHit()
	self._success = false

	if self._context and self._context.hiterList and self._context.target and self._context.atker then
		local atker = self._context.atker

		if atker:getId() == self._floorId and atker:getEntityType() == ArcadeGameEnum.EntityType.Floor and tabletool.removeValue(self._context.hiterList, self._context.target) then
			self._success = true
		end
	end
end

function ArcadeSkillHitUnaffectedFloor:onHitPrintLog()
	if self._success and self._context and self._context.target then
		local target = self._context.target

		logNormal(string.format("%s 不会受到xx地板的影响 == > [type:%s id:%s]", self:getLogPrefixStr(), target:getEntityType(), target:getId()))
	end
end

return ArcadeSkillHitUnaffectedFloor
