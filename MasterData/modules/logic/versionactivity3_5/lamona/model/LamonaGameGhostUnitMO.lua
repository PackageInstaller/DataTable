-- chunkname: @modules/logic/versionactivity3_5/lamona/model/LamonaGameGhostUnitMO.lua

module("modules.logic.versionactivity3_5.lamona.model.LamonaGameGhostUnitMO", package.seeall)

local LamonaGameGhostUnitMO = class("LamonaGameGhostUnitMO", LamonaGameUnitMO)

function LamonaGameGhostUnitMO:setUnitInfo(info)
	LamonaGameGhostUnitMO.super.setUnitInfo(self, info)
	self:setIsMoving()
	self:setIsCaught()

	local impactedPropDict, tempImpactedPropUid, tempImpactedPropId, tempAttrChangeDict

	if info then
		impactedPropDict = info.impactedPropDict
		tempImpactedPropUid = info.tempImpactedPropUid
		tempImpactedPropId = info.tempImpactedPropId
		tempAttrChangeDict = info.tempAttrChangeDict
	end

	self._impactedPropDict = {}

	if impactedPropDict then
		for propUid, propId in pairs(impactedPropDict) do
			self._impactedPropDict[propUid] = propId
		end
	end

	self:setPropTempImpacted(tempImpactedPropUid, tempImpactedPropId, tempAttrChangeDict)
end

function LamonaGameGhostUnitMO:setIsMoving(isMoving)
	self._isMoving = isMoving
	self._haveMovedSteps = 0
end

function LamonaGameGhostUnitMO:addHaveMovedStep()
	self._haveMovedSteps = self._haveMovedSteps + 1
end

function LamonaGameGhostUnitMO:addPropImpacted(propUid, propId)
	self._impactedPropDict[propUid] = propId
end

function LamonaGameGhostUnitMO:setPropTempImpacted(tempPropUid, tempPropId, tempChangeAttrDict)
	self._tempImpactedPropUid = tempPropUid
	self._tempImpactedPropId = tempPropId
	self._tempAttrChangeDict = tempChangeAttrDict
end

function LamonaGameGhostUnitMO:setIsCaught(isCaught)
	self._isCaught = isCaught
end

function LamonaGameGhostUnitMO:getIsMoving()
	return self._isMoving
end

function LamonaGameGhostUnitMO:getHaveMovedSteps()
	return self._haveMovedSteps
end

function LamonaGameGhostUnitMO:getPropHasAlreadyImpacted(propUid)
	return self._impactedPropDict and self._impactedPropDict[propUid]
end

function LamonaGameGhostUnitMO:getTempImpactedProp()
	return self._tempImpactedPropUid, self._tempImpactedPropId
end

function LamonaGameGhostUnitMO:getAttrValue(attrKey)
	local attrVal = LamonaGameGhostUnitMO.super.getAttrValue(self, attrKey)

	if self._tempAttrChangeDict then
		if not self._tempAttrChangeDict[attrKey] then
			local tempChangeValue = 0

			return attrVal + tempChangeValue
		end
	end
end

function LamonaGameGhostUnitMO:getUnitInfo()
	local info = LamonaGameGhostUnitMO.super.getUnitInfo(self)
	local impactedPropDict = {}

	for uid, id in pairs(self._impactedPropDict) do
		impactedPropDict[uid] = id
	end

	info.impactedPropDict = impactedPropDict

	local tempImpactedPropUid, tempImpactedPropId = self:getTempImpactedProp()
	local tempAttrChangeDict = {}

	if self._tempAttrChangeDict then
		for attrKey, changeValue in pairs(self._tempAttrChangeDict) do
			tempAttrChangeDict[attrKey] = changeValue
		end
	end

	info.tempImpactedPropUid = tempImpactedPropUid
	info.tempImpactedPropId = tempImpactedPropId
	info.tempAttrChangeDict = tempAttrChangeDict

	return info
end

function LamonaGameGhostUnitMO:getIsCaught()
	return self._isCaught
end

function LamonaGameGhostUnitMO:getHasFog()
	local _, tempImpactedPropId = self:getTempImpactedProp()

	return tempImpactedPropId == LamonaEnum.Const.FogPropId
end

function LamonaGameGhostUnitMO:getHasTrap()
	local result

	if self._impactedPropDict then
		for _, propId in pairs(self._impactedPropDict) do
			if propId == LamonaEnum.Const.TrapPropId then
				result = true

				break
			end
		end
	end

	return result
end

return LamonaGameGhostUnitMO
