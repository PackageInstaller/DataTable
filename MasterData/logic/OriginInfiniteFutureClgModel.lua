-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origininfinitefutureclg/model/OriginInfiniteFutureClgModel.lua

module("logic.extensions.origininfinitefutureclg.model.OriginInfiniteFutureClgModel", package.seeall)

local OriginInfiniteFutureClgModel = class("OriginInfiniteFutureClgModel", BaseModel)

function OriginInfiniteFutureClgModel:onInit()
	self:onReset()
end

function OriginInfiniteFutureClgModel:onReset()
	self._infos = {}
	self._stageInfoMaps = {}
	self._customFmtMoPool = {}
	self._changeSetIdMap = {}
	self._selectStageMap = {}
end

function OriginInfiniteFutureClgModel:getInfo(activityId)
	return self._infos[activityId]
end

function OriginInfiniteFutureClgModel:getFmtMo(activityId)
	if self._customFmtMoPool[activityId] == nil then
		self._customFmtMoPool[activityId] = OriginInfiniteFutureClgFmtMo.New()
	end

	return self._customFmtMoPool[activityId]
end

function OriginInfiniteFutureClgModel:getStageInfoMap(activityId)
	return self._stageInfoMaps[activityId]
end

function OriginInfiniteFutureClgModel:getStageInfo(activityId, stageId)
	local stageInfoMap = self:getStageInfoMap(activityId)

	return stageInfoMap and stageInfoMap[stageId]
end

function OriginInfiniteFutureClgModel:getStageValueMap(activityId, stageId)
	local stageInfo = self:getStageInfo(activityId, stageId)

	return (stageInfo or nil) and (stageInfo.valueMap or {})
end

function OriginInfiniteFutureClgModel:getStageValue(activityId, stageId, valueType)
	local valueMap = self:getStageValueMap(activityId, stageId)

	return checknumber(valueMap[valueType])
end

function OriginInfiniteFutureClgModel:getSelectStage(activityId)
	return checknumber(self._selectStageMap[activityId])
end

function OriginInfiniteFutureClgModel:setSelectStage(activityId, stageId)
	self._selectStageMap[activityId] = checknumber(stageId)
end

function OriginInfiniteFutureClgModel:getLockRaceIdMap(activityId)
	local lockRaceIdMap = {}
	local stageInfoMap = self:getStageInfoMap(activityId) or {}

	for _, stageInfo in pairs(stageInfoMap) do
		for _, raceId in ipairs(checktable(stageInfo.lockRaceIds)) do
			lockRaceIdMap[raceId] = true
		end
	end

	return lockRaceIdMap
end

function OriginInfiniteFutureClgModel:stageHasPass(activityId, stageId)
	local stageInfo = self:getStageInfo(activityId, stageId)

	if not stageInfo then
		return false
	end

	if stageInfo.isPass ~= nil then
		return stageInfo.isPass == true
	end

	return #checktable(stageInfo.lockRaceIds) > 0
end

function OriginInfiniteFutureClgModel:pushChangeSetId(activityId, changeSetId)
	self._changeSetIdMap[activityId] = self._changeSetIdMap[activityId] or {}

	table.insert(self._changeSetIdMap[activityId], changeSetId)
end

function OriginInfiniteFutureClgModel:popChangeSetId(activityId)
	local changeSetIds = self._changeSetIdMap[activityId]

	if changeSetIds and #changeSetIds > 0 then
		return table.remove(changeSetIds, 1)
	end
end

function OriginInfiniteFutureClgModel:handlePM_OriginInfiniteFutureClgGetInfoRes(msg)
	self._infos[msg.activityId] = GameUtil.pbToTable(msg)

	local info = self._infos[msg.activityId]

	info.stageList = info.stageList or {}
	self._stageInfoMaps[msg.activityId] = {}

	for _, stageInfo in ipairs(info.stageList) do
		self:_normalizeStageInfo(stageInfo)

		self._stageInfoMaps[msg.activityId][stageInfo.stageId] = stageInfo
	end
end

function OriginInfiniteFutureClgModel:handlePM_OriginInfiniteFutureClgResetRes(msg)
	local stageInfo = self:_getOrCreateStageInfo(msg.activityId, msg.stageId)

	stageInfo.valueList = {}
	stageInfo.lockRaceIds = {}
	stageInfo.valueMap = {}
	stageInfo.isPass = false
end

function OriginInfiniteFutureClgModel:handlePM_OriginInfiniteFutureClgNotifyFightRes(msg)
	local stageInfo = self:_getOrCreateStageInfo(msg.activityId, msg.stageId)

	stageInfo.isWin = msg.isWin == true
	stageInfo.isPass = msg.isPass == true

	local var_17_0 = GameUtil.pbToTable(msg.valueList or {})

	var_17_0 = var_17_0 or {}
	stageInfo.valueList = var_17_0
	stageInfo.valueMap = self:_buildValueMap(stageInfo.valueList)

	if msg.isWin then
		local var_17_2 = GameUtil.pbToTable(msg.raceIds or {})

		var_17_2 = var_17_2 or {}
		stageInfo.lockRaceIds = var_17_2
	end
end

function OriginInfiniteFutureClgModel:_getOrCreateStageInfo(activityId, stageId)
	self._infos[activityId] = self._infos[activityId] or {
		activityId = activityId,
		stageList = {}
	}
	self._stageInfoMaps[activityId] = self._stageInfoMaps[activityId] or {}

	local stageInfo = self._stageInfoMaps[activityId][stageId]

	if stageInfo == nil then
		stageInfo = {
			stageId = stageId,
			valueList = {},
			lockRaceIds = {}
		}

		table.insert(self._infos[activityId].stageList, stageInfo)

		self._stageInfoMaps[activityId][stageId] = stageInfo
	end

	return stageInfo
end

function OriginInfiniteFutureClgModel:_normalizeStageInfo(stageInfo)
	stageInfo.valueList = stageInfo.valueList or {}
	stageInfo.lockRaceIds = stageInfo.lockRaceIds or {}
	stageInfo.valueMap = self:_buildValueMap(stageInfo.valueList)
	stageInfo.isPass = #checktable(stageInfo.lockRaceIds) > 0
end

function OriginInfiniteFutureClgModel:_buildValueMap(valueList)
	local valueMap = {}

	for _, valueInfo in ipairs(checktable(valueList)) do
		valueMap[valueInfo.left] = valueInfo.right
	end

	return valueMap
end

OriginInfiniteFutureClgModel.instance = OriginInfiniteFutureClgModel.New()

return OriginInfiniteFutureClgModel
