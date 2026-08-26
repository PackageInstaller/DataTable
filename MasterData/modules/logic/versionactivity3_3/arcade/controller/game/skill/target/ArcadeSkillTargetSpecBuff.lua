-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/skill/target/ArcadeSkillTargetSpecBuff.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.skill.target.ArcadeSkillTargetSpecBuff", package.seeall)

local ArcadeSkillTargetSpecBuff = class("ArcadeSkillTargetSpecBuff", ArcadeSkillTargetLinkColor)

function ArcadeSkillTargetSpecBuff:onCtor()
	self._specBuffId = nil
	self._checkMonsterLinked = false
end

function ArcadeSkillTargetSpecBuff:onConfigParams()
	if not self._effectParams then
		return
	end

	self._specBuffId = tonumber(self._effectParams[1])

	local isLinked = tonumber(self._effectParams[2])

	if isLinked and isLinked > 0 then
		self._checkMonsterLinked = true
	end
end

function ArcadeSkillTargetSpecBuff:onFindTarget()
	if not self._cfgNeedTargetTypeDict or not self._specBuffId then
		return
	end

	for entityType, _ in pairs(self._cfgNeedTargetTypeDict) do
		self:_onFindTargetWithType(entityType)
	end
end

function ArcadeSkillTargetSpecBuff:_onFindTargetWithType(entityType)
	if not entityType then
		return
	end

	local moList = ArcadeGameModel.instance:getEntityMOList(entityType)

	if not moList then
		return
	end

	local findLinked = entityType == ArcadeGameEnum.EntityType.Monster and self._checkMonsterLinked

	for _, mo in pairs(moList) do
		local buffSetMO = mo:getBuffSetMO()
		local buff = buffSetMO:getBuffById(self._specBuffId)

		if buff then
			if findLinked then
				local gridX, gridY = mo:getGridPos()

				self:_beginFindLinkedMonster(gridX, gridY)
			else
				self:addTarget(mo)
			end
		end
	end
end

return ArcadeSkillTargetSpecBuff
