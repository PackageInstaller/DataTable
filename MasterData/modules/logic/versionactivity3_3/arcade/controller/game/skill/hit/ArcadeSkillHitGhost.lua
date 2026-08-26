-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/skill/hit/ArcadeSkillHitGhost.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.skill.hit.ArcadeSkillHitGhost", package.seeall)

local ArcadeSkillHitGhost = class("ArcadeSkillHitGhost", ArcadeSkillHitBase)

function ArcadeSkillHitGhost:onCtor()
	local params = self._params

	self._changeName = params[1]
	self._round = tonumber(params[2])
	self._killId = tonumber(params[3])
	self._curRound = 0
end

function ArcadeSkillHitGhost:onHit()
	if self._context and self._context.target then
		local target = self._context.target

		self._entyType = target:getEntityType()
		self._curRound = self._curRound + 1

		if self._curRound > self._round then
			self._curLimit = self._curLimit + 1

			self:addHiter(target)

			self._curRound = 0

			local entity = self:_getEntity(target)

			if entity and entity.playStateShow then
				xpcall(entity.playStateShow, __G__TRACKBACK__, entity)
			end

			ArcadeGameSkillController.instance:useSkill(target, self._killId, self._context)
		end

		if self._curRound == 1 and not target:getIsDead() and target:getHp() > 0 then
			local entity = self:_getEntity(target)

			if entity and entity.animatorPlayer then
				entity.animatorPlayer:Play("buff_blue_loop", nil, nil, nil)
			end
		end
	end
end

function ArcadeSkillHitGhost:_getEntity(target)
	local gameScent = ArcadeGameController.instance:getGameScene()

	if gameScent then
		return gameScent.entityMgr:getEntityWithType(target:getEntityType(), target:getUid())
	end
end

function ArcadeSkillHitGhost:onHitLimitCount()
	return
end

function ArcadeSkillHitGhost:onHitPrintLog()
	if self._context and self._context.target then
		local target = self._context.target

		logNormal(string.format("%s ==> 每X回合出现:%s/%s  type:%s id:%s uid:%s", self:getLogPrefixStr(), self._curRound, self._round, target:getEntityType(), target:getUid(), target:getId()))
	end
end

return ArcadeSkillHitGhost
