-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origingoddragonclg/data/OriginGodDragonClgSubMo.lua

module("logic.extensions.origingoddragonclg.data.OriginGodDragonClgSubMo", package.seeall)

local OriginGodDragonClgSubMo = class("OriginGodDragonClgSubMo")

function OriginGodDragonClgSubMo:ctor(activityId)
	self._activityId = activityId

	local actData = OriginGodDragonClgConfig.instance:getActivityData(activityId)
	local costItem = actData and actData.costItem
	local matType, matId, matNum = MaterialMgr.getMatParams(costItem)
	local matName = MaterialMgr.getMaterialsNameByCfg(costItem)

	self._costItemMat = {
		matStr = costItem,
		matType = matType,
		matId = matId,
		matName = matName
	}

	self:_resetData()
end

function OriginGodDragonClgSubMo:_resetData()
	self._stageMap = {}
	self._gainedStageIdSet = {}
	self._fightResultMsg = nil
	self._changeSetIds = {}
end

function OriginGodDragonClgSubMo:dispose()
	self:_resetData()
end

function OriginGodDragonClgSubMo:handlePM_OriginGodDragonClgInfoRes(msg)
	table.clear(self._stageMap)

	for _, v in ipairs(msg.stages) do
		self._stageMap[v.stageId] = v
	end

	table.clear(self._gainedStageIdSet)

	for _, stageId in ipairs(msg.gainedStageId) do
		self._gainedStageIdSet[stageId] = true
	end
end

function OriginGodDragonClgSubMo:handlePM_OriginGodDragonClgConfirmRes(msg)
	if msg:HasField("changeSetId") then
		table.insert(self._changeSetIds, msg.changeSetId)
		MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
	end
end

function OriginGodDragonClgSubMo:handlePM_OriginGodDragonEffectBuffRes(msg)
	local stage = self._stageMap[msg.stageId]

	if stage then
		stage.effectBuff = true
	end
end

function OriginGodDragonClgSubMo:handlePM_OriginGodDragonBacktrackRes(msg)
	return
end

function OriginGodDragonClgSubMo:handlePM_OriginGodDragonResetRes(msg)
	self:_resetData()
end

function OriginGodDragonClgSubMo:handlePM_NotifyOriginGodDragonChallengeFinishRes(msg)
	self._fightResultMsg = msg

	if msg:HasField("changeSetId") then
		self._gainedStageIdSet[msg.stageId] = true

		table.insert(self._changeSetIds, msg.changeSetId)
		MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
	end
end

function OriginGodDragonClgSubMo:getZoneCount()
	local cfg = OriginGodDragonClgConfig.instance:getZoneDatas(self._activityId)

	return (cfg or nil) and (#cfg or 0)
end

function OriginGodDragonClgSubMo:isUnlockZone(zoneId)
	local preZoneId = zoneId - 1

	if preZoneId > 0 then
		return self:isPassZone(preZoneId)
	end

	return true
end

function OriginGodDragonClgSubMo:isPassZone(zoneId)
	local stageDataList = OriginGodDragonClgConfig.instance:getStageDataListByZone(self._activityId, zoneId)

	if stageDataList then
		for _, data in ipairs(stageDataList) do
			local info = self:getStageInfo(data.stageId)

			if info == nil then
				return false
			end
		end
	end

	return true
end

function OriginGodDragonClgSubMo:isUnlockStage(stageId)
	local result = false
	local stageType = self:getStageType(stageId)

	if stageType == OriginGodDragonClgEnum.StageType.Nor then
		local preStageId = stageId - 1

		result = preStageId > 0 and self:isPassStage(preStageId) or true
	elseif stageType == OriginGodDragonClgEnum.StageType.Ext then
		result = true

		local zoneId = self:getZoneId(stageId)

		if result then
			local maxCircleNum = self:getMaxCircleNum(zoneId)
			local circleNum = self:getCurCircleNumInZone(zoneId)

			result = circleNum <= maxCircleNum
		end

		if result then
			local stageDataList = OriginGodDragonClgConfig.instance:getStageDataListByZone(self._activityId, zoneId)

			if stageDataList then
				for _, data in ipairs(stageDataList) do
					local sType = self:getStageType(data.stageId)

					if sType == OriginGodDragonClgEnum.StageType.Nor and not self:isPassStage(data.stageId) then
						result = false

						break
					end
				end
			end
		end
	end

	return result
end

function OriginGodDragonClgSubMo:isPassStage(stageId)
	local info = self:getStageInfo(stageId)

	return info ~= nil
end

function OriginGodDragonClgSubMo:getStageType(stageId)
	local data = OriginGodDragonClgConfig.instance:getStageData(self._activityId, stageId)

	return (data and data.parallelStage or nil) and (OriginGodDragonClgEnum.StageType.Ext or OriginGodDragonClgEnum.StageType.Nor)
end

function OriginGodDragonClgSubMo:getZoneId(stageId)
	local data = OriginGodDragonClgConfig.instance:getStageData(self._activityId, stageId)

	return (data or nil) and (data.zoneId or 0)
end

function OriginGodDragonClgSubMo:getStageInfo(stageId)
	return self._stageMap[stageId]
end

function OriginGodDragonClgSubMo:getAllLockRaceIds()
	local result = {}

	for _, info in pairs(self._stageMap) do
		for _, raceId in ipairs(info.lockRaceIds) do
			result[raceId] = true
		end
	end

	return result
end

function OriginGodDragonClgSubMo:getLockRaceIds(stageId)
	local info = self:getStageInfo(stageId)

	return (info or nil) and (info.lockRaceIds or {})
end

function OriginGodDragonClgSubMo:isEffectBuff(stageId)
	local info = self:getStageInfo(stageId)

	return (info or nil) and (info.effectBuff or false)
end

function OriginGodDragonClgSubMo:getLeftCircleNum(zoneId)
	local maxCircleNum = self:getMaxCircleNum(zoneId)
	local circleNum = self:getCurCircleNumInZone(zoneId)

	return Mathf.Max(0, maxCircleNum - circleNum)
end

function OriginGodDragonClgSubMo:getCurCircleNumInZone(zoneId)
	local result = 0
	local stageDataList = OriginGodDragonClgConfig.instance:getStageDataListByZone(self._activityId, zoneId)

	if stageDataList then
		for _, data in ipairs(stageDataList) do
			result = result + self:getStageCircleNum(data.stageId)
		end
	end

	return result
end

function OriginGodDragonClgSubMo:getStageCircleNum(stageId)
	local info = self:getStageInfo(stageId)

	return (info or nil) and (info.circleNum or 0)
end

function OriginGodDragonClgSubMo:getMaxCircleNum(zoneId)
	local data = OriginGodDragonClgConfig.instance:getZoneData(self._activityId, zoneId)

	return (data or nil) and (data.circleLimit or 0)
end

function OriginGodDragonClgSubMo:getCostItemMat()
	return self._costItemMat
end

function OriginGodDragonClgSubMo:getCurCostItemNum()
	local result = 0

	for stageId, v in pairs(self._stageMap) do
		if self:isPassStage(stageId) then
			result = result + self:getPassGainCostItemNum(stageId)
		end

		if self:isEffectBuff(stageId) then
			result = result - self:getUnlockCostItemNum(stageId)
		end
	end

	return result
end

function OriginGodDragonClgSubMo:getUnlockCostItemNum(stageId)
	local data = OriginGodDragonClgConfig.instance:getStageData(self._activityId, stageId)

	return (data or nil) and (data.buffCost or 0)
end

function OriginGodDragonClgSubMo:getPassGainCostItemNum(stageId)
	local data = OriginGodDragonClgConfig.instance:getStageData(self._activityId, stageId)

	return (data or nil) and (data.buffScore or 0)
end

function OriginGodDragonClgSubMo:isStageGained(stageId)
	return self._gainedStageIdSet[stageId] == true
end

function OriginGodDragonClgSubMo:getGainedStageIdList()
	local ids = {}

	for stageId, _ in pairs(self._gainedStageIdSet) do
		table.insert(ids, stageId)
	end

	return ids
end

function OriginGodDragonClgSubMo:popChangeSetId()
	return (table.remove(self._changeSetIds, #self._changeSetIds))
end

function OriginGodDragonClgSubMo:getFightResultMsg()
	return self._fightResultMsg
end

return OriginGodDragonClgSubMo
