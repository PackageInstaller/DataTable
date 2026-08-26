-- chunkname: @modules/logic/rouge/dlc/101/model/rpcmo/RougeLimiterClientMO.lua

module("modules.logic.rouge.dlc.101.model.rpcmo.RougeLimiterClientMO", package.seeall)

local RougeLimiterClientMO = pureTable("RougeLimiterClientMO")

function RougeLimiterClientMO:init(info)
	self:_onGetLimitIds(info.limitIds)
	self:_onGetLimitBuffIds(info.limitBuffIds)
end

function RougeLimiterClientMO:_onGetLimitIds(limitIds)
	self._limitIds = {}
	self._limitIdMap = {}
	self._limitGroupMap = {}

	for _, limitId in ipairs(limitIds) do
		self:_onGetLimitId(limitId)
	end
end

function RougeLimiterClientMO:_onGetLimitId(limitId)
	if not self._limitIdMap[limitId] then
		local limitCo = RougeDLCConfig101.instance:getLimiterCo(limitId)
		local limitGroupId = limitCo and limitCo.group

		self._limitIdMap[limitId] = true
		self._limitGroupMap[limitGroupId] = limitId

		table.insert(self._limitIds, limitId)
	end
end

function RougeLimiterClientMO:_onRemoveLimitId(limitId)
	if self._limitIdMap[limitId] then
		local limitCo = RougeDLCConfig101.instance:getLimiterCo(limitId)
		local limitGroupId = limitCo and limitCo.group

		self._limitIdMap[limitId] = nil
		self._limitGroupMap[limitGroupId] = nil

		tabletool.removeValue(self._limitIds, limitId)
	end
end

function RougeLimiterClientMO:_onGetLimitBuffIds(limitBuffIds)
	self._limitBuffIds = {}
	self._limitBuffIdMap = {}
	self._limitBuffTypeMap = {}

	for _, buffId in ipairs(limitBuffIds) do
		self:_onGetLimitBuffId(buffId)
	end
end

function RougeLimiterClientMO:_onGetLimitBuffId(buffId)
	if not self._limitBuffIdMap[buffId] then
		local limiterCo = RougeDLCConfig101.instance:getLimiterBuffCo(buffId)
		local buffType = limiterCo.buffType

		self:removeLimitBuffByType(buffType)

		self._limitBuffIdMap[buffId] = true
		self._limitBuffTypeMap[buffType] = buffId

		table.insert(self._limitBuffIds, buffId)
	end
end

function RougeLimiterClientMO:_onRemoveLimitBuffId(buffId)
	if self._limitBuffIdMap[buffId] then
		local limiterCo = RougeDLCConfig101.instance:getLimiterBuffCo(buffId)
		local buffType = limiterCo.buffType

		self._limitBuffIdMap[buffId] = nil
		self._limitBuffTypeMap[buffType] = nil

		tabletool.removeValue(self._limitBuffIds, buffId)
	end
end

function RougeLimiterClientMO:removeLimitBuffByType(buffType)
	local buffId = self:getLimitBuffIdByType(buffType)

	self:_onRemoveLimitBuffId(buffId)
end

function RougeLimiterClientMO:getLimitBuffIdByType(buffType)
	return self._limitBuffTypeMap and self._limitBuffTypeMap[buffType]
end

function RougeLimiterClientMO:getLimitBuffIds()
	return self._limitBuffIds
end

function RougeLimiterClientMO:getLimitBuffIdsAndSortByType()
	local limitBuffIds = {}

	tabletool.addValues(limitBuffIds, self._limitBuffIds)
	table.sort(limitBuffIds, RougeLimiterClientMO._sortLimitBuffIdByType)

	return limitBuffIds
end

function RougeLimiterClientMO._sortLimitBuffIdByType(aBuffId, bBuffId)
	local aBuffCo = RougeDLCConfig101.instance:getLimiterBuffCo(aBuffId)
	local bBuffCo = RougeDLCConfig101.instance:getLimiterBuffCo(bBuffId)

	if aBuffCo and bBuffCo and aBuffCo.buffType ~= bBuffCo.buffType then
		return aBuffCo.buffType < bBuffCo.buffType
	end

	return aBuffCo.id < bBuffCo.id
end

function RougeLimiterClientMO:getLimitBuffIdMap()
	return self._limitBuffIdMap
end

function RougeLimiterClientMO:getLimitIds()
	return self._limitIds
end

function RougeLimiterClientMO:getLimitIdMap()
	return self._limitIdMap
end

function RougeLimiterClientMO:getLimitIdInGroup(groupId)
	return self._limitGroupMap and self._limitGroupMap[groupId]
end

function RougeLimiterClientMO:isSelectBuff(buffId)
	return self._limitBuffIdMap and self._limitBuffIdMap[buffId] ~= nil
end

function RougeLimiterClientMO:isSelectDebuff(debuffId)
	return self._limitIdMap and self._limitIdMap[debuffId] ~= nil
end

function RougeLimiterClientMO:selectLimit(limitId, isSelect)
	local limiterCo = RougeDLCConfig101.instance:getLimiterCo(limitId)

	if not limiterCo then
		return
	end

	if isSelect then
		self:_onGetLimitId(limitId)
	else
		self:_onRemoveLimitId(limitId)
	end
end

function RougeLimiterClientMO:selectLimitBuff(buffId, isSelect)
	local buffCo = RougeDLCConfig101.instance:getLimiterBuffCo(buffId)

	if not buffCo then
		return
	end

	if isSelect then
		self:_onGetLimitBuffId(buffId)
	else
		self:_onRemoveLimitBuffId(buffId)
	end
end

function RougeLimiterClientMO:clearAllLimitIds()
	self:_onGetLimitIds({})
end

function RougeLimiterClientMO:clearAllLimitBuffIds()
	self:_onGetLimitBuffIds({})
end

return RougeLimiterClientMO
