-- chunkname: @modules/logic/sp01/assassin2/outside/model/AssassinStealthGameEnemyMO.lua

module("modules.logic.sp01.assassin2.outside.model.AssassinStealthGameEnemyMO", package.seeall)

local AssassinStealthGameEnemyMO = class("AssassinStealthGameEnemyMO")

function AssassinStealthGameEnemyMO:updateData(enemyData)
	self.uid = enemyData.uid
	self.monsterId = enemyData.monsterId
	self.isDead = enemyData.isDead
	self.scan = enemyData.scan

	self:updateBuffList(enemyData.buffs)
	self:updatePos(enemyData.gridId, enemyData.pos)
end

function AssassinStealthGameEnemyMO:updateBuffList(buffDataList)
	self._buffDict = {}

	for _, buffData in ipairs(buffDataList) do
		self._buffDict[buffData.id] = buffData.duration
	end
end

function AssassinStealthGameEnemyMO:updatePos(gridId, pointIndex)
	self.gridId = gridId
	self.pos = pointIndex
end

function AssassinStealthGameEnemyMO:hasBuff(buffId)
	return (self._buffDict or nil) and not not self._buffDict[buffId]
end

function AssassinStealthGameEnemyMO:hasBuffType(targetBuffType)
	local result = false

	if self._buffDict then
		for buffId, _ in pairs(self._buffDict) do
			local buffType = AssassinConfig.instance:getAssassinBuffType(buffId)

			if buffType == targetBuffType then
				result = true

				break
			end
		end
	end

	return result
end

function AssassinStealthGameEnemyMO:getUid()
	return self.uid
end

function AssassinStealthGameEnemyMO:getMonsterId()
	return self.monsterId
end

function AssassinStealthGameEnemyMO:getIsDead()
	return self.isDead ~= 0
end

function AssassinStealthGameEnemyMO:getPos()
	return self.gridId, self.pos
end

function AssassinStealthGameEnemyMO:getExposeRate()
	local result = AssassinEnum.StealthConst.MinExposeRate
	local isDead = self:getIsDead()
	local isPetrified = self:hasBuffType(AssassinEnum.StealGameBuffType.Petrifaction)

	if not isDead and not isPetrified then
		local monsterId = self:getMonsterId()
		local curRate = 0

		curRate = self.scan == 1 and AssassinConfig.instance:getEnemyScanRate(monsterId) or curRate
		result = curRate / AssassinEnum.StealthConst.ConfigExposeRatePoint
	end

	return result
end

return AssassinStealthGameEnemyMO
