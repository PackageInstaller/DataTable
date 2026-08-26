-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/skill/hit/ArcadeSkillHitDropBomb.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.skill.hit.ArcadeSkillHitDropBomb", package.seeall)

local ArcadeSkillHitDropBomb = class("ArcadeSkillHitDropBomb", ArcadeSkillHitBase)

function ArcadeSkillHitDropBomb:onCtor()
	local params = self._params

	self._changeName = params[1]
	self._bombId = tonumber(params[2])
end

function ArcadeSkillHitDropBomb:onHit()
	local scene = ArcadeGameController.instance:getGameScene()

	if self._context then
		local target = self._context.target

		if not target or not scene then
			return
		end

		local gridX, gridY = target:getGridPos()
		local direction = target:getDirection()

		if not self._context.extraParam then
			local extraParam = {}

			extraParam.direction = direction

			ArcadeGameController.instance:directPlaceBomb(self._bombId, gridX, gridY, extraParam)

			local _, gridMOList = ArcadeGameHelper.getBombExplodeTargetList(self._bombId, gridX, gridY, extraParam and extraParam.isCharacterBomb)

			if gridMOList then
				local warnEffectIdList = ArcadeGameHelper.getActionShowEffect(ArcadeGameEnum.ActionShowId.BombWarn, self._bombId)
				local warnEffId = warnEffectIdList and warnEffectIdList[1]

				for _, gridMO in ipairs(gridMOList) do
					local x, y = gridMO:getGridPos()

					scene.effectMgr:playEffect2Grid(warnEffId, x, y)
				end
			end
		end
	end
end

function ArcadeSkillHitDropBomb:onHitPrintLog()
	logNormal(string.format("%s ==> 生成炸弹:[%s]", self:getLogPrefixStr(), self._bombId))
end

return ArcadeSkillHitDropBomb
