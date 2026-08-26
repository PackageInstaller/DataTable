-- chunkname: @modules/logic/versionactivity3_9/racingcar/model/V3a9RacingTalentMO.lua

module("modules.logic.versionactivity3_9.racingcar.model.V3a9RacingTalentMO", package.seeall)

local V3a9RacingTalentMO = pureTable("V3a9RacingTalentMO")

function V3a9RacingTalentMO:init(id, coList)
	self._id = id
	self._curLevel = 0
	self._coList = coList or {}
	self._isCanUnlock = false
	self._maxLevel = 0

	if coList then
		for _, co in pairs(coList) do
			if self._order and self._order ~= co.order then
				logError(string.format("同个天赋id 不同排序？？ id:%s,order :%s  %s", id, self._order, co.order))
			end

			if self._group and self._group ~= co.group then
				logError(string.format("同个天赋id 不同天赋组？？ id:%s,group :%s  %s", id, self._group, co.group))
			end

			self._order = co.order
			self._group = co.group

			if self._maxLevel < co.level then
				self._maxLevel = co.level
			end
		end
	end
end

function V3a9RacingTalentMO:refreshCurLevel(level)
	self._curLevel = level or 0
end

function V3a9RacingTalentMO:getCurLevel()
	return self._curLevel
end

function V3a9RacingTalentMO:getCurLevelCo()
	local level = self:getCurLevel()

	return self:getCoByLevel(level)
end

function V3a9RacingTalentMO:getCoByLevel(level)
	return self._coList[level]
end

function V3a9RacingTalentMO:getNextLevelCo()
	local level = self:getCurLevel()

	return self._coList[level + 1]
end

function V3a9RacingTalentMO:getLevelCos()
	return self._coList
end

function V3a9RacingTalentMO:getId()
	return self._id
end

function V3a9RacingTalentMO:getOrder()
	return self._order
end

function V3a9RacingTalentMO:getGroup()
	return self._group
end

function V3a9RacingTalentMO:isLock()
	return self._curLevel == 0
end

function V3a9RacingTalentMO:getLevelUpCost()
	local nextCo = self:getNextLevelCo()

	if nextCo then
		return nextCo.cost
	end

	return 0
end

function V3a9RacingTalentMO:isWaitActive()
	return self._isCanUnlock
end

function V3a9RacingTalentMO:setCanUnlock(isCan)
	self._isCanUnlock = isCan and self._curLevel == 0
end

function V3a9RacingTalentMO:getMaxLevel()
	return self._maxLevel
end

function V3a9RacingTalentMO:isSpecial()
	return self._coList and #self._coList > 1
end

function V3a9RacingTalentMO:isMaxLevel()
	return self._maxLevel == self._curLevel
end

function V3a9RacingTalentMO:isCanLevelUp()
	return (not self:isLock() or self:isWaitActive()) and not self:isMaxLevel()
end

return V3a9RacingTalentMO
