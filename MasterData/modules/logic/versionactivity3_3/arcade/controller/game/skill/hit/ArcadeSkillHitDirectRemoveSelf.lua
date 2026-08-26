-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/skill/hit/ArcadeSkillHitDirectRemoveSelf.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.skill.hit.ArcadeSkillHitDirectRemoveSelf", package.seeall)

local ArcadeSkillHitDirectRemoveSelf = class("ArcadeSkillHitDirectRemoveSelf", ArcadeSkillHitBase)

function ArcadeSkillHitDirectRemoveSelf:onCtor()
	local params = self._params

	self._changeName = params[1]
	self._actionShowId = tonumber(params[2])
end

function ArcadeSkillHitDirectRemoveSelf:onHit()
	if self._context then
		if not self._context then
			return
		end

		ArcadeGameController.instance:directRemoveEntity(self._context, self._actionShowId)
	end
end

function ArcadeSkillHitDirectRemoveSelf:onHitPrintLog()
	if self._context then
		if not self._context then
			return
		end

		logNormal(string.format("%s ==> 直接移除实体【%s-%s-%s】", self:getLogPrefixStr(), self._context:getEntityType(), self._context.id, self._context:getUid()))
	end
end

return ArcadeSkillHitDirectRemoveSelf
