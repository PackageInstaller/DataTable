-- chunkname: @modules/logic/bossrush/model/v3a2/V3a2_BossRush_HandBookMO.lua

module("modules.logic.bossrush.model.v3a2.V3a2_BossRush_HandBookMO", package.seeall)

local V3a2_BossRush_HandBookMO = pureTable("V3a2_BossRush_HandBookMO")

function V3a2_BossRush_HandBookMO:initMO(co)
	self.config = co
	self.haveFight = false
	self.heightScore = 0
	self.acceptExp = 0
	self.saveExp = 0

	self:_initPointBonus()
end

function V3a2_BossRush_HandBookMO:_initPointBonus()
	self.expBonus = {}

	local spiltPoint = string.splitToNumber(self.config.point, "|")
	local spiltBouns = string.splitToNumber(self.config.pointExp, "|")

	self.maxBonusExp = 0

	for i, point in ipairs(spiltPoint) do
		local info = {}

		info.exp = point
		info.bonus = spiltBouns[i]

		table.insert(self.expBonus, info)

		self.maxBonusExp = math.max(self.maxBonusExp, point)
	end
end

function V3a2_BossRush_HandBookMO:setInfo(info)
	self.heightScore = info.highestPoint or 0
	self.haveFight = info.haveFight

	local key = V3a2BossRushEnum.BossRankExp .. self:getBossType()

	self.saveExp = GameUtil.playerPrefsGetNumberByUserId(key, 0)
	self.saveExp = math.max(self.saveExp, info.acceptExpPoint)

	self:setAcceptExp(info.acceptExpPoint)
end

function V3a2_BossRush_HandBookMO:setAcceptExp(acceptExpPoint)
	self.acceptExp = acceptExpPoint or 0

	if not self.haveFight and self.heightScore > 0 then
		self.haveFight = true
	end

	self:_setCurPointBonus()
end

function V3a2_BossRush_HandBookMO:setSaveExp(exp)
	self.saveExp = exp

	local key = V3a2BossRushEnum.BossRankExp .. self:getBossType()

	GameUtil.playerPrefsSetNumberByUserId(key, exp)
	self:_setCurPointBonus()
end

function V3a2_BossRush_HandBookMO:_setCurPointBonus()
	if self.haveFight then
		for i, info in ipairs(self.expBonus) do
			if info.exp >= self.saveExp and info.exp > self.acceptExp then
				self._curPoint = i

				return
			end
		end
	else
		self._curPoint = 1

		return
	end

	self._curPoint = nil
end

function V3a2_BossRush_HandBookMO:getNextPointBonus()
	for i, info in ipairs(self.expBonus) do
		if info.exp > self.saveExp then
			return info
		end
	end
end

function V3a2_BossRush_HandBookMO:getCurPointBonus()
	return self.expBonus[self._curPoint]
end

function V3a2_BossRush_HandBookMO:getMaxPointBonus()
	return self.expBonus[#self.expBonus]
end

function V3a2_BossRush_HandBookMO:getCanClaimBonus(exp)
	local bonus = 0

	if self.haveFight then
		for i, info in ipairs(self.expBonus) do
			if exp >= info.exp and info.exp > self.acceptExp then
				bonus = bonus + info.bonus
			end
		end
	end

	return bonus
end

function V3a2_BossRush_HandBookMO:hasClaimBonus()
	local bouns = self:getCanClaimBonus(self.heightScore)

	return bouns > 0
end

function V3a2_BossRush_HandBookMO:getBossId()
	return self.config.id
end

function V3a2_BossRush_HandBookMO:getBossType()
	return self.config.type
end

function V3a2_BossRush_HandBookMO:getBossName()
	return self.config.typeName
end

return V3a2_BossRush_HandBookMO
