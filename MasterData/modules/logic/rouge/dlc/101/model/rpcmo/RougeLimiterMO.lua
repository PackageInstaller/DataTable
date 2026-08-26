-- chunkname: @modules/logic/rouge/dlc/101/model/rpcmo/RougeLimiterMO.lua

module("modules.logic.rouge.dlc.101.model.rpcmo.RougeLimiterMO", package.seeall)

local RougeLimiterMO = pureTable("RougeLimiterMO")

function RougeLimiterMO:init(info)
	self:_buildLimitBuffInfoMap(info.unlockLimitBuffs)
	self:_buildLimitGroupInfoMap(info.unlockLimitGroupIds)
	self:updateLimiterClientInfo(info.clientNO)

	self._totalEmblemCount = info.emblem
end

function RougeLimiterMO:_buildLimitBuffInfoMap(unlockLimitBuffs)
	self._unlockLimitBuff = {}

	for _, buff in ipairs(unlockLimitBuffs) do
		local buffId = buff.id

		self._unlockLimitBuff[buffId] = buff.cd
	end
end

function RougeLimiterMO:_buildLimitGroupInfoMap(unlockLimitGroupIds)
	self._unlockLimitGroupIds = {}
	self._unlockLimitGroupIdMap = {}

	for _, limiterGroupId in ipairs(unlockLimitGroupIds) do
		self._unlockLimitGroupIdMap[limiterGroupId] = true

		table.insert(self._unlockLimitGroupIds, limiterGroupId)
	end
end

function RougeLimiterMO:isBuffUnlocked(buffId)
	local buffCo = RougeDLCConfig101.instance:getLimiterBuffCo(buffId)

	if buffCo and buffCo.needEmblem <= 0 then
		return true
	end

	if self._unlockLimitBuff then
		local cd = self._unlockLimitBuff[buffId]

		return cd ~= nil
	end
end

function RougeLimiterMO:isBuffCD(buffId)
	if self._unlockLimitBuff then
		return self._unlockLimitBuff and self._unlockLimitBuff > 0
	end
end

function RougeLimiterMO:getBuffCDRound(buffId)
	if self._unlockLimitBuff then
		return self._unlockLimitBuff or 0
	end
end

function RougeLimiterMO:isLimiterGroupUnlocked(limiterGroupId)
	return self._unlockLimitGroupIdMap and self._unlockLimitGroupIdMap[limiterGroupId] ~= nil
end

function RougeLimiterMO:getAllUnlockLimiterGroupIds()
	return self._unlockLimitGroupIds
end

function RougeLimiterMO:getTotalEmblemCount()
	return self._totalEmblemCount
end

function RougeLimiterMO:updateTotalEmblemCount(updateCount)
	self._totalEmblemCount = self._totalEmblemCount + updateCount
end

function RougeLimiterMO:getLimiterGroupState(groupId)
	local isUnlocked = self:isLimiterGroupUnlocked(groupId)

	if isUnlocked then
		if not RougeDLCEnum101.LimitState.Unlocked then
			return RougeDLCEnum101.LimitState.Locked
		end
	end
end

function RougeLimiterMO:getLimiterClientMo()
	return self._clientMo
end

function RougeLimiterMO:updateLimiterClientInfo(limiterClientInfo)
	self._clientMo = self._clientMo or RougeLimiterClientMO.New()

	self._clientMo:init(limiterClientInfo)
	self:_checkCDAndRemoveLimitBuff()
end

function RougeLimiterMO:getLimiterBuffCD(buffId)
	if self._unlockLimitBuff then
		return self._unlockLimitBuff or 0
	end
end

function RougeLimiterMO:unlockLimiterBuff(buffId)
	self._unlockLimitBuff[buffId] = self._unlockLimitBuff[buffId] or 0
end

function RougeLimiterMO:speedupLimiterBuff(buffId)
	if self._unlockLimitBuff[buffId] then
		self._unlockLimitBuff[buffId] = 0
	end
end

function RougeLimiterMO:_checkCDAndRemoveLimitBuff()
	if not self._clientMo then
		return
	end

	local buffIds = self._clientMo:getLimitBuffIds()

	if not buffIds then
		return
	end

	for i = #buffIds, 1, -1 do
		local buffId = buffIds[i]

		if self:isBuffCD(buffId) then
			self._clientMo:selectLimitBuff(buffId, false)
		end
	end
end

return RougeLimiterMO
