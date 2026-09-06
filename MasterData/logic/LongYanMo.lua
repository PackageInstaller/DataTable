-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ashlesslongyan/data/LongYanMo.lua

module("logic.extensions.ashlesslongyan.data.LongYanMo", package.seeall)

local LongYanMo = class("LongYanMo")

function LongYanMo:ctor(activityId)
	self._activityId = activityId

	local phaseCfg = AshlessLongYanConfig.instance:getPhaseCfg(self._activityId)
	local maxPhaseData = phaseCfg[#phaseCfg]

	if maxPhaseData then
		self._maxPhaseId = maxPhaseData.phaseId or 0
	end

	local matStr = AshlessLongYanConfig.instance:getGoldMat(self._activityId)
	local matType, matId, matNum = MaterialMgr.getMatParams(matStr)

	self._goldMatArray = {
		matType,
		matId
	}
	self._phaseInfos = {}

	for phaseId = 1, self._maxPhaseId + 1 do
		self._phaseInfos[phaseId] = {}
		self._phaseInfos[phaseId].bonfireCounts = {}
		self._phaseInfos[phaseId].leftWoodIds = {}
		self._phaseInfos[phaseId].leftFires = {}
		self._phaseInfos[phaseId].stashStageIds = {}
		self._phaseInfos[phaseId].totalScore = 0
	end

	self._curPhaseId = 0
	self._stashStageIds = {}
	self._totalScore = 0
end

function LongYanMo:dispose()
	return
end

function LongYanMo:getActivityId()
	return self._activityId
end

function LongYanMo:handlePM_AshlessLongYanGetInfoRes(msg)
	self._curPhaseId = msg.passPhaseId + 1

	table.clear(self._phaseInfos[self._curPhaseId].leftWoodIds)
	table.insertto(self._phaseInfos[self._curPhaseId].leftWoodIds, msg.leftWoodIds)
	table.clear(self._phaseInfos[self._curPhaseId].bonfireCounts)

	for _, v in ipairs(msg.leftFire) do
		self._phaseInfos[self._curPhaseId].bonfireCounts[v.left] = v.right
	end

	table.clear(self._phaseInfos[self._curPhaseId].stashStageIds)
	table.insertto(self._phaseInfos[self._curPhaseId].stashStageIds, msg.stashStageIds)
	self:setTotalScore(msg.totalScore)
end

function LongYanMo:handlePM_AshlessLongYanChallengeRes(msg)
	return
end

function LongYanMo:handlePM_AshlessLongYanConfirmScoreRes(msg)
	return
end

function LongYanMo:handlePM_AshlessLongYanUseWoodRes(msg)
	local count = self._phaseInfos[msg.phaseId].bonfireCounts[msg.stageId]

	self._phaseInfos[msg.phaseId].bonfireCounts[msg.stageId] = count + msg.useCount

	self:setTotalScore(Mathf.Max(self._totalScore - msg.useCount, 0))
end

function LongYanMo:handlePM_AshlessLongYanStashOrTakeRes(msg)
	if msg.stashOrTake then
		table.insert(self._phaseInfos[msg.phaseId].stashStageIds, msg.stageId)
	else
		table.removebyvalue(self._phaseInfos[msg.phaseId].stashStageIds, msg.stageId)
	end
end

function LongYanMo:handlePM_AshlessLongYanResetPhaseRes(msg)
	return
end

function LongYanMo:handlePM_Notify_AshlessLongYanChallengeEndRes(msg)
	self._endResMsg = msg
end

function LongYanMo:getCurPhaseId()
	return self._curPhaseId
end

function LongYanMo:isPassAll()
	return self._curPhaseId > self._maxPhaseId
end

function LongYanMo:isPassPhaseId(phaseId)
	return phaseId < self._curPhaseId
end

function LongYanMo:getMaxPhaseId()
	return self._maxPhaseId
end

function LongYanMo:isInTopLayer(phaseId, group, layerId)
	local isInTop = true
	local layers = AshlessLongYanConfig.instance:getStageLayers(self._activityId, phaseId, group)

	for id = layerId + 1, #layers do
		local stages = layers[id]

		for _, data in pairs(stages) do
			if not self:isPassStage(phaseId, data.stageId) and not self:isStashStageId(phaseId, data.stageId) then
				isInTop = false

				break
			end
		end
	end

	return isInTop
end

function LongYanMo:isPassStageGroup(phaseId, group)
	local isPass = true
	local layers = AshlessLongYanConfig.instance:getStageLayers(self._activityId, phaseId, group)

	for layerId, stages in pairs(layers) do
		if not self:isPassStageLayer(phaseId, group, layerId) then
			isPass = false

			break
		end
	end

	return isPass
end

function LongYanMo:isPassStageLayer(phaseId, group, layerId)
	local isPass = true
	local layers = AshlessLongYanConfig.instance:getStageLayers(self._activityId, phaseId, group)
	local stages = layers[layerId]

	for _, data in pairs(stages) do
		if not self:isPassStage(phaseId, data.stageId) then
			isPass = false

			break
		end
	end

	return isPass
end

function LongYanMo:isPassStage(phaseId, stageId)
	local data = AshlessLongYanConfig.instance:getStageData(self._activityId, phaseId, stageId)
	local stageType = data.type

	if stageType == LongYanEnum.StageType_Wood then
		return self:_isPassWood(phaseId, stageId)
	elseif stageType == LongYanEnum.StageType_Bonfire then
		return self:_isPassBonfire(phaseId, stageId)
	end
end

function LongYanMo:_isPassWood(phaseId, stageId)
	return table.indexof(self._phaseInfos[phaseId].leftWoodIds, stageId) == false
end

function LongYanMo:_isPassBonfire(phaseId, stageId)
	if self._phaseInfos[phaseId].bonfireCounts[stageId] then
		local max = self:getMaxBonfireCount(phaseId, stageId)
		local cur = self:getBonfireCount(phaseId, stageId)

		return max <= cur
	else
		return true
	end
end

function LongYanMo:getPassStageCount(phaseId, stageType)
	local dataList = AshlessLongYanConfig.instance:getStageDataList(self._activityId, phaseId)
	local count = 0

	if dataList then
		for _, data in ipairs(dataList) do
			if stageType == data.type and self:isPassStage(phaseId, data.stageId) then
				count = count + 1
			end
		end
	end

	return count
end

function LongYanMo:getLeftBonfireCount(phaseId, stageId)
	local max = self:getMaxBonfireCount(phaseId, stageId)
	local cur = self:getBonfireCount(phaseId, stageId)

	return Mathf.Max(max - cur, 0)
end

function LongYanMo:getBonfireCount(phaseId, stageId)
	return checknumber(self._phaseInfos[phaseId].bonfireCounts[stageId])
end

function LongYanMo:getMaxBonfireCount(phaseId, stageId)
	local data = AshlessLongYanConfig.instance:getStageData(self._activityId, phaseId, stageId)

	return (data or nil) and (data.woodNeedCount or 0)
end

function LongYanMo:getMaxNeedUseScoreInPhaseId(phaseId)
	local result = 0
	local dataList = AshlessLongYanConfig.instance:getStageDataList(self._activityId, phaseId)

	if dataList then
		for _, data in ipairs(dataList) do
			result = result + self:getMaxBonfireCount(phaseId, data.stageId)
		end
	end

	return result
end

function LongYanMo:setTotalScore(value)
	self._totalScore = value

	MaterialFacade.instance:UpdateMaterial(self._goldMatArray[1], self._goldMatArray[2], self._totalScore)
end

function LongYanMo:getTotalScore()
	return self._totalScore
end

function LongYanMo:getStashStageIds(phaseId)
	return self._phaseInfos[phaseId].stashStageIds
end

function LongYanMo:isStashStageId(phaseId, stageId)
	local stageIds = self:getStashStageIds(phaseId)

	return table.indexof(stageIds, stageId) ~= false
end

function LongYanMo:getEndResMsg()
	return self._endResMsg
end

function LongYanMo:setChangeSetId(value)
	self._changeSetId = value
end

function LongYanMo:popChangeSetId()
	return self._changeSetId
end

return LongYanMo
