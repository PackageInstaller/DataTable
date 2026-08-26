-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/skill/hit/ArcadeSkillHitDieandSummon.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.skill.hit.ArcadeSkillHitDieandSummon", package.seeall)

local ArcadeSkillHitDieandSummon = class("ArcadeSkillHitDieandSummon", ArcadeSkillHitBase)

function ArcadeSkillHitDieandSummon:onCtor()
	local params = self._params

	self._changeName = params[1]
	self._monsterId = tonumber(params[2])
end

function ArcadeSkillHitDieandSummon:onHit()
	if self._context and self._context.target then
		local target = self._context.target

		self:addHiter(target)

		local gridX, gridY = target:getGridPos()
		local sizeX, sizeY = target:getSize()
		local curHp = target:getHp()

		ArcadeGameController.instance:changeEntityHp(target, -curHp)
		target:setHp(0)
		ArcadeGameController.instance:dispatchEvent(ArcadeEvent.OnSkillKillDeathSettle, target, self._context.atker)

		local curRoom = ArcadeGameController.instance:getCurRoom()

		if curRoom then
			curRoom:removeEntityOccupyGrids(target)
		end

		local mSx, mSy = ArcadeConfig.instance:getMonsterSize(self._monsterId)

		if sizeX < mSx or sizeY < mSy then
			logError(string.format("%s ==> 召唤怪物[id:%s size:(%s,%s) 比原怪物[id:%s size:(%s,%s)]体积大]", self:getLogPrefixStr(), self._mosterId, mSx, mSy, target.id, sizeX, sizeY))
		end

		self._isSuccess = ArcadeGameSummonController.instance:summonMonsterByXY(self._monsterId, gridX, gridY)
	end
end

function ArcadeSkillHitDieandSummon:onHitPrintLog()
	if self._context and self._context.target then
		local target = self._context.target

		logNormal(string.format("%s ==> 自身死亡并召唤怪物[%s-%s】 %s 尸体:%s 存在回合：%s", self:getLogPrefixStr(), target.id, self._monsterId, self._isSuccess and "成功" or "失败", target:getHasCorpse(), target:getCorpseTime()))
	end
end

return ArcadeSkillHitDieandSummon
