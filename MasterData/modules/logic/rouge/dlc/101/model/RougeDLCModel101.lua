-- chunkname: @modules/logic/rouge/dlc/101/model/RougeDLCModel101.lua

module("modules.logic.rouge.dlc.101.model.RougeDLCModel101", package.seeall)

local RougeDLCModel101 = class("RougeDLCModel101", BaseModel)

function RougeDLCModel101:clear()
	self._tmpClientMo = nil
	self._preFogPosX = 0
	self._preFogPosY = 0
end

function RougeDLCModel101:initLimiterInfo(rougeServerInfo)
	self:clear()

	if not rougeServerInfo then
		return
	end

	local limiterMo = rougeServerInfo.limiterInfo
	local newLimiterMo = RougeLimiterMO.New()

	newLimiterMo:init(limiterMo)

	self._tmpClientMo = LuaUtil.deepCopy(newLimiterMo:getLimiterClientMo())

	self:_buildNewUnlockedLimiterGroupMap(self._limiterMo, newLimiterMo)

	self._limiterMo = newLimiterMo
end

function RougeDLCModel101:getLimiterMo()
	return self._limiterMo
end

function RougeDLCModel101:getLimiterClientMo()
	return self._tmpClientMo
end

function RougeDLCModel101:getCurLimiterGroupLv(groupId)
	local clientMo = self:getLimiterClientMo()
	local limitId = clientMo and clientMo:getLimitIdInGroup(groupId)
	local level = 0

	if limitId then
		local limitCo = RougeDLCConfig101.instance:getLimiterCo(limitId)

		level = limitCo and limitCo.level or 0
	end

	return level
end

function RougeDLCModel101:addLimiterGroupLv(groupId)
	self:_changeLimiterGroupLv(groupId, true)
end

function RougeDLCModel101:removeLimiterGroupLv(groupId)
	self:_changeLimiterGroupLv(groupId, false)
end

function RougeDLCModel101:_changeLimiterGroupLv(groupId, isAdd)
	local originLv = self:getCurLimiterGroupLv(groupId)
	local maxLv = RougeDLCConfig101.instance:getLimiterGroupMaxLevel(groupId)

	if isAdd then
		if not (originLv + 1) then
			local targetLv = originLv - 1

			targetLv = GameUtil.clamp(targetLv, 0, maxLv)

			if originLv == targetLv then
				return
			end

			local limiterCo = RougeDLCConfig101.instance:getLimiterCoByGroupIdAndLv(groupId, originLv)
			local limiterId = limiterCo and limiterCo.id

			self._tmpClientMo:selectLimit(limiterId, false)

			limiterCo = RougeDLCConfig101.instance:getLimiterCoByGroupIdAndLv(groupId, targetLv)
			limiterId = limiterCo and limiterCo.id

			self._tmpClientMo:selectLimit(limiterId, true)

			if not isAdd then
				self:_tryRemoveBuff2MatchRisk()
			end

			RougeDLCController101.instance:dispatchEvent(RougeDLCEvent101.UpdateLimitGroup, groupId)
		end
	end
end

function RougeDLCModel101:_tryRemoveBuff2MatchRisk()
	local selectBuffIds = self._tmpClientMo:getLimitBuffIdsAndSortByType()

	for i = #selectBuffIds, 1, -1 do
		local isEnough = self:_checkIsLimiterRiskEnough()

		if isEnough then
			break
		end

		local limiterBuffId = selectBuffIds[i]

		self._tmpClientMo:selectLimitBuff(limiterBuffId, false)
	end
end

function RougeDLCModel101:_checkIsLimiterRiskEnough()
	local totalRiskValue = self:getTotalRiskValue()
	local riskCo = RougeDLCConfig101.instance:getRougeRiskCoByRiskValue(totalRiskValue)
	local selectBuffIds = self._tmpClientMo:getLimitBuffIds()

	if selectBuffIds then
		if not #selectBuffIds then
			local curSelectBuffCount = 0

			if riskCo then
				if not riskCo.buffNum then
					local canSelectBuffCount = 0

					return curSelectBuffCount <= canSelectBuffCount
				end
			end
		end
	end
end

function RougeDLCModel101:getTotalRiskValue()
	return (self:_calcTotalRiskValue())
end

function RougeDLCModel101:_calcTotalRiskValue()
	local clientMo = self:getLimiterClientMo()
	local limitIds = clientMo and clientMo:getLimitIds()
	local totalRiskValue = 0

	for _, limitId in ipairs(limitIds or {}) do
		local limitCo = RougeDLCConfig101.instance:getLimiterCo(limitId)

		if limitCo then
			if not limitCo.riskValue then
				local riskValue = 0

				totalRiskValue = totalRiskValue + riskValue
			end
		end
	end

	return totalRiskValue
end

function RougeDLCModel101:getCurLimiterGroupState(groupId)
	local limiterMo = self:getLimiterMo()

	return limiterMo and limiterMo:getLimiterGroupState(groupId)
end

function RougeDLCModel101:getSelectLimiterGroupIds()
	local selectLimitGroups = {}
	local selectLimitGroupMap = {}
	local limiterClientInfo = self:getLimiterClientMo()
	local limitIds = limiterClientInfo and limiterClientInfo:getLimitIds()

	for _, limitId in ipairs(limitIds) do
		local limitCo = RougeDLCConfig101.instance:getLimiterCo(limitId)
		local group = limitCo and limitCo.group

		if group and not selectLimitGroupMap[group] then
			selectLimitGroupMap[group] = true

			table.insert(selectLimitGroups, group)
		end
	end

	return selectLimitGroups
end

function RougeDLCModel101:isLimiterGroupSelected(groupId)
	local limiterMo = self:getLimiterMo()
	local groupState = limiterMo and limiterMo:getLimiterGroupState()
	local curGroupLv = self:getCurLimiterGroupLv(groupId)

	return groupState == RougeDLCEnum101.LimitState.Unlocked and curGroupLv >= 1
end

function RougeDLCModel101:getAllLimiterBuffIds()
	local selectBuffIds = {}
	local limiterClientInfo = self:getLimiterClientMo()
	local limiterBuffIds = limiterClientInfo and limiterClientInfo:getLimitBuffIds()

	tabletool.addValues(selectBuffIds, limiterBuffIds)

	return selectBuffIds
end

function RougeDLCModel101:getLimiterStateBuffIds(buffState)
	local buffIds = {}
	local allBuffCos = RougeDLCConfig101.instance:getAllLimiterBuffCos()

	for _, buffCo in ipairs(allBuffCos or {}) do
		local buffId = buffCo.id
		local state = self:getLimiterBuffState(buffId)

		if state == buffState then
			table.insert(buffIds, buffId)
		end
	end

	return buffIds
end

function RougeDLCModel101:getLimiterBuffState(buffId)
	local limiterMo = self:getLimiterMo()
	local state = RougeDLCEnum101.BuffState.Locked
	local isUnlocked = limiterMo and limiterMo:isBuffUnlocked(buffId)

	if isUnlocked then
		state = RougeDLCEnum101.BuffState.Unlocked

		local limiterClientInfo = self:getLimiterClientMo()
		local isCD = limiterMo and limiterMo:isBuffCD(buffId)
		local isEquiped = limiterClientInfo and limiterClientInfo:isSelectBuff(buffId)

		if isCD then
			state = RougeDLCEnum101.BuffState.CD
		elseif isEquiped then
			state = RougeDLCEnum101.BuffState.Equiped
		end
	end

	return state
end

function RougeDLCModel101:try2EquipBuff(buffId)
	local limiterClientInfo = self:getLimiterClientMo()

	limiterClientInfo:selectLimitBuff(buffId, true)
	RougeDLCController101.instance:dispatchEvent(RougeDLCEvent101.UpdateBuffState, buffId)
end

function RougeDLCModel101:try2UnEquipBuff(buffId)
	local limiterClientInfo = self:getLimiterClientMo()

	limiterClientInfo:selectLimitBuff(buffId, false)
	RougeDLCController101.instance:dispatchEvent(RougeDLCEvent101.UpdateBuffState, buffId)
end

function RougeDLCModel101:getTotalEmblemCount()
	local limiterMo = self:getLimiterMo()

	return limiterMo and limiterMo:getTotalEmblemCount()
end

function RougeDLCModel101:getLimiterBuffCD(buffId)
	local limiterMo = self:getLimiterMo()

	return limiterMo and limiterMo:getLimiterBuffCD(buffId) or 0
end

function RougeDLCModel101:isModifySelectLimiterGroup()
	local limiterMo = self:getLimiterMo()
	local originClientInfo = limiterMo and limiterMo:getLimiterClientMo()
	local curClientInfo = self:getLimiterClientMo()
	local originBuffIdMap = originClientInfo:getLimitBuffIdMap()
	local curBuffIdMap = curClientInfo:getLimitBuffIdMap()
	local originDebuffIdMap = originClientInfo:getLimitIdMap()
	local curDebuffIdMap = curClientInfo:getLimitIdMap()
	local isBuffSame = self:_is2MapSame(originBuffIdMap, curBuffIdMap)
	local isDebuffSame = self:_is2MapSame(originDebuffIdMap, curDebuffIdMap)

	return not isBuffSame or not isDebuffSame
end

function RougeDLCModel101:_is2MapSame(map1, map2)
	local mapCount1 = tabletool.len(map1)
	local mapCount2 = tabletool.len(map2)

	if mapCount1 ~= mapCount2 then
		return false
	end

	for key, value in pairs(map1) do
		if map2[key] ~= value then
			return false
		end
	end

	return true
end

function RougeDLCModel101:onGetLimiterClientMo(limiterClientInfo)
	local limiterMo = self:getLimiterMo()

	limiterMo:updateLimiterClientInfo(limiterClientInfo)

	self._tmpClientMo = LuaUtil.deepCopy(self._limiterMo:getLimiterClientMo())
end

function RougeDLCModel101:getFogPrePos()
	return self._preFogPosX or 0, self._preFogPosY or 0
end

function RougeDLCModel101:setFogPrePos(posX, posY)
	self._preFogPosX = posX
	self._preFogPosY = posY
end

function RougeDLCModel101:_buildNewUnlockedLimiterGroupMap(sourceLimiterMo, newLimiterMo)
	self._newUnlockedGroupMap = self._newUnlockedGroupMap or {}

	if sourceLimiterMo and newLimiterMo then
		local newUnlockGroupIds = newLimiterMo:getAllUnlockLimiterGroupIds()

		if newUnlockGroupIds then
			for _, limiterGroupId in ipairs(newUnlockGroupIds) do
				local isPreLocked = not sourceLimiterMo:isLimiterGroupUnlocked(limiterGroupId)

				if isPreLocked then
					self._newUnlockedGroupMap[limiterGroupId] = true
				end
			end
		end
	end
end

function RougeDLCModel101:isLimiterGroupNewUnlocked(limiterGroupId)
	return self._newUnlockedGroupMap and self._newUnlockedGroupMap[limiterGroupId]
end

function RougeDLCModel101:resetLimiterGroupNewUnlockInfo()
	self._newUnlockedGroupMap = {}
end

function RougeDLCModel101:resetAllSelectLimitIds()
	local limiterClinetMo = self:getLimiterClientMo()

	if not limiterClinetMo then
		return
	end

	limiterClinetMo:clearAllLimitIds()
	limiterClinetMo:clearAllLimitBuffIds()
	RougeDLCController101.instance:dispatchEvent(RougeDLCEvent101.UpdateLimitGroup)
	RougeDLCController101.instance:dispatchEvent(RougeDLCEvent101.RefreshLimiterDebuffTips)
end

RougeDLCModel101.instance = RougeDLCModel101.New()

return RougeDLCModel101
