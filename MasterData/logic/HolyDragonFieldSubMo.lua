-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holydragonfield/data/HolyDragonFieldSubMo.lua

module("logic.extensions.holydragonfield.data.HolyDragonFieldSubMo", package.seeall)

local HolyDragonFieldSubMo = class("HolyDragonFieldSubMo")

function HolyDragonFieldSubMo:ctor(activityId)
	self._activityId = activityId

	self:_resetData()
end

function HolyDragonFieldSubMo:dispose()
	self:_resetData()
end

function HolyDragonFieldSubMo:_resetData()
	self._selectedStageIds = {}

	self:_resetFieldData()
	self:_resetChallengeData()
	self:_resetRankData()
end

function HolyDragonFieldSubMo:_resetFieldData()
	self._fieldIds = {}
	self._fieldIdSet = {}
	self._fieldBuffLevels = {}
	self._stageKeys = {}
	self._stageKeySet = {}
	self._stageKeyToFieldId = {}
	self._stageKeyToStageId = {}
	self._stageScores = {}
	self._stagePassedStates = {}
	self._stageSettleTypeNums = {}
	self._bossSettleIds = {}
	self._bossSettleUseStates = {}
end

function HolyDragonFieldSubMo:_resetChallengeData()
	self._lastChallengeMsg = nil
	self._changeSetId = nil
end

function HolyDragonFieldSubMo:_resetRankData()
	self._rankMsg = nil
end

function HolyDragonFieldSubMo:handlePM_HolyDragonFieldInfoRes(msg)
	self:_resetFieldData()

	for _, fieldInfo in ipairs(msg.fieldInfoList) do
		local fieldId = fieldInfo.fieldId

		self:_appendFieldId(fieldId)

		self._fieldBuffLevels[fieldId] = fieldInfo.buffLevel

		for _, stageInfo in ipairs(fieldInfo.stageInfo) do
			local stageId = stageInfo.stageId

			self:_setStageScore(fieldId, stageId, stageInfo.score)
			self:_setStagePassed(fieldId, stageId, true)
			self:_setStageSettleTypeNums(fieldId, stageId, stageInfo.settleTypeToNum)
			self:_setBossSettleIds(fieldId, stageId, stageInfo.hasUseBossSettle)
		end
	end
end

function HolyDragonFieldSubMo:handlePM_HolyDragonFieldChallengeRes(msg)
	return
end

function HolyDragonFieldSubMo:handlePM_HolyDragonFieldNotifyChallengeRes(msg)
	self._lastChallengeMsg = msg
	self._changeSetId = nil

	if msg:HasField("changeSetId") then
		self._changeSetId = msg.changeSetId
	end
end

function HolyDragonFieldSubMo:handlePM_HolyDragonFieldUpgradeBuffRes(msg)
	self:_appendFieldId(msg.fieldId)

	self._fieldBuffLevels[msg.fieldId] = msg.buffLevel
end

function HolyDragonFieldSubMo:handlePM_HolyDragonFieldRankViewRes(msg)
	self._rankMsg = msg
end

function HolyDragonFieldSubMo:_appendFieldId(fieldId)
	if self._fieldIdSet[fieldId] then
		return
	end

	self._fieldIdSet[fieldId] = true

	table.insert(self._fieldIds, fieldId)
end

function HolyDragonFieldSubMo:_getStageKey(fieldId, stageId)
	return string.format("%s_%s", fieldId, stageId)
end

function HolyDragonFieldSubMo:_appendStageKey(fieldId, stageId)
	local stageKey = self:_getStageKey(fieldId, stageId)

	if self._stageKeySet[stageKey] then
		return stageKey
	end

	self._stageKeySet[stageKey] = true
	self._stageKeyToFieldId[stageKey] = fieldId
	self._stageKeyToStageId[stageKey] = stageId

	table.insert(self._stageKeys, stageKey)

	return stageKey
end

function HolyDragonFieldSubMo:_setStageScore(fieldId, stageId, score)
	local stageKey = self:_appendStageKey(fieldId, stageId)

	self:_appendFieldId(fieldId)

	self._stageScores[stageKey] = score
end

function HolyDragonFieldSubMo:_setStagePassed(fieldId, stageId, isPassed)
	local stageKey = self:_appendStageKey(fieldId, stageId)

	self:_appendFieldId(fieldId)

	self._stagePassedStates[stageKey] = isPassed == true
end

function HolyDragonFieldSubMo:_setStageSettleTypeNums(fieldId, stageId, settleTypeToNum)
	local stageKey = self:_appendStageKey(fieldId, stageId)

	self:_appendFieldId(fieldId)

	self._stageSettleTypeNums[stageKey] = {}

	for _, pair in ipairs(settleTypeToNum or {}) do
		self._stageSettleTypeNums[stageKey][checknumber(pair.left)] = checknumber(pair.right)
	end
end

function HolyDragonFieldSubMo:_setBossSettleIds(fieldId, stageId, settleIds)
	local stageKey = self:_appendStageKey(fieldId, stageId)

	self:_appendFieldId(fieldId)

	self._bossSettleIds[stageKey] = {}

	for _, settleId in ipairs(settleIds) do
		table.insert(self._bossSettleIds[stageKey], settleId)

		if checknumber(settleId) > 0 then
			self._bossSettleUseStates[self:_getBossSettleKey(fieldId, stageId, settleId)] = true
		end
	end
end

function HolyDragonFieldSubMo:_getBossSettleKey(fieldId, stageId, settleId)
	return string.format("%s_%s_%s", fieldId, stageId, settleId)
end

function HolyDragonFieldSubMo:getActivityId()
	return self._activityId
end

function HolyDragonFieldSubMo:getFieldIds()
	return self._fieldIds
end

function HolyDragonFieldSubMo:setSelectedStageId(fieldId, stageId)
	fieldId = checknumber(fieldId)
	stageId = checknumber(stageId)

	if fieldId <= 0 then
		return
	end

	self._selectedStageIds[fieldId] = stageId > 0 and stageId or nil
end

function HolyDragonFieldSubMo:getSelectedStageId(fieldId)
	return self._selectedStageIds[checknumber(fieldId)] or 0
end

function HolyDragonFieldSubMo:getBuffLevel(fieldId)
	return self._fieldBuffLevels[fieldId] or 0
end

function HolyDragonFieldSubMo:isBuffUnlocked(fieldId)
	return self:getBuffLevel(fieldId) > 0
end

function HolyDragonFieldSubMo:getStageKeys()
	return self._stageKeys
end

function HolyDragonFieldSubMo:getFieldIdByStageKey(stageKey)
	return self._stageKeyToFieldId[stageKey] or 0
end

function HolyDragonFieldSubMo:getStageIdByStageKey(stageKey)
	return self._stageKeyToStageId[stageKey] or 0
end

function HolyDragonFieldSubMo:getStageScore(fieldId, stageId)
	local stageKey = self:_getStageKey(fieldId, stageId)

	return self._stageScores[stageKey] or 0
end

function HolyDragonFieldSubMo:isStagePassed(fieldId, stageId)
	local stageKey = self:_getStageKey(fieldId, stageId)

	return self._stagePassedStates[stageKey] == true
end

function HolyDragonFieldSubMo:getStageSettleTypeNum(fieldId, stageId, settleType)
	local stageKey = self:_getStageKey(fieldId, stageId)
	local settleTypeNums = self._stageSettleTypeNums[stageKey]

	return settleTypeNums and settleTypeNums[checknumber(settleType)] or 0
end

function HolyDragonFieldSubMo:hasStageSettleTypeNum(fieldId, stageId, settleType)
	local stageKey = self:_getStageKey(fieldId, stageId)
	local settleTypeNums = self._stageSettleTypeNums[stageKey]

	return settleTypeNums and settleTypeNums[checknumber(settleType)] ~= nil or false
end

function HolyDragonFieldSubMo:getBossSettleIds(fieldId, stageId)
	local stageKey = self:_getStageKey(fieldId, stageId)

	return self._bossSettleIds[stageKey] or {}
end

function HolyDragonFieldSubMo:isBossSettleUsed(fieldId, stageId, settleId)
	return self._bossSettleUseStates[self:_getBossSettleKey(fieldId, stageId, settleId)] == true
end

function HolyDragonFieldSubMo:getLastChallengeMsg()
	return self._lastChallengeMsg
end

function HolyDragonFieldSubMo:popChangeSetId()
	self._changeSetId = nil

	return self._changeSetId
end

function HolyDragonFieldSubMo:getRankMsg()
	return self._rankMsg
end

return HolyDragonFieldSubMo
