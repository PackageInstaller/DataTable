-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/skill/hit/ArcadeSkillHitAlertAttack.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.skill.hit.ArcadeSkillHitAlertAttack", package.seeall)

local ArcadeSkillHitAlertAttack = class("ArcadeSkillHitAlertAttack", ArcadeSkillHitAlertBase)

function ArcadeSkillHitAlertAttack:onCtor()
	local params = self._params

	self._changeName = params[1]

	local round = tonumber(params[2])

	self._skillTargetId = tonumber(params[3])
	self._useSkillId = tonumber(params[4])
	self._alertEffId = tonumber(params[5])
	self._alertAtkEffId = tonumber(params[6])

	self:setAlertRound(round)

	self._skillTargetBase = ArcadeSkillFactory.instance:createSkillTargetById(self._skillTargetId)
end

function ArcadeSkillHitAlertAttack:onHitAction()
	local target = self._context.target

	if not target:getIsDead() and target:getHp() > 0 then
		self:_playGridEffect(self._alertAtkEffId, false)
		ArcadeGameSkillController.instance:useActiveSkill(self._context.target, self._useSkillId, self._context)
	end
end

function ArcadeSkillHitAlertAttack:onAlertAction()
	local target = self._context.target

	if not target:getIsDead() and target:getHp() > 0 then
		self:_playGridEffect(self._alertEffId, true)
	end
end

function ArcadeSkillHitAlertAttack:_playGridEffect(effectId, isAlert)
	if not effectId or effectId == 0 then
		return
	end

	local gameScent = ArcadeGameController.instance:getGameScene()

	if gameScent then
		self._skillTargetBase:findByContext(self._context)

		local targetMOList = self._skillTargetBase:getTargetList()

		for _, unitMO in ipairs(targetMOList) do
			local gridX, gridY = unitMO:getGridPos()
			local direction = unitMO:getDirection()

			if isAlert then
				gameScent.effectMgr:playAlertEffect(effectId, gridX, gridY, direction)
			else
				local playInNearestGrid = ArcadeConfig.instance:getIsNearestGrid(effectId)

				if playInNearestGrid then
					gridX, gridY = ArcadeGameHelper.getEntityNearCharacterGrid(unitMO)
				end

				gameScent.effectMgr:playEffect2Grid(effectId, gridX, gridY, direction)
			end
		end
	end
end

return ArcadeSkillHitAlertAttack
