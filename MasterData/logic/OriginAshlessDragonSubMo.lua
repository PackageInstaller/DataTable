-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originashlessdragon/data/OriginAshlessDragonSubMo.lua

module("logic.extensions.originashlessdragon.data.OriginAshlessDragonSubMo", package.seeall)

local OriginAshlessDragonSubMo = class("OriginAshlessDragonSubMo")

function OriginAshlessDragonSubMo:ctor(activityId)
	self._activityId = activityId

	local actData = OriginAshlessDragonConfig.instance:getActivityData(activityId)

	if actData then
		self._initBudget = actData.initBudget or 0
	end

	local phaseDatas = OriginAshlessDragonConfig.instance:getPhaseDatas(activityId)

	if phaseDatas then
		self._maxPhaseId = #phaseDatas or 0
	end

	self:_resetData()
end

function OriginAshlessDragonSubMo:_resetData()
	self._stageInfos = {}
	self._everPassedPhaseIds = {}
	self._fightResultMsg = nil
	self._selectedBudgets = {}
end

function OriginAshlessDragonSubMo:dispose()
	self:_resetData()
end

function OriginAshlessDragonSubMo:handlePM_OriginAshlessDragonGetInfoRes(msg)
	self._stageInfos = {}

	for _, phaseInfo in ipairs(msg.phaseInfo) do
		self._stageInfos[phaseInfo.phaseId] = {}

		for _, stageInfo in ipairs(phaseInfo.stages) do
			self._stageInfos[phaseInfo.phaseId][stageInfo.stageId] = stageInfo
		end
	end

	MmUtil.coverList(self._everPassedPhaseIds, msg.everPassedPhaseIds)
end

function OriginAshlessDragonSubMo:handlePM_OriginAshlessDragonConfirmRes(msg)
	if msg.save then
		self:clearSelectedBudget(msg.phaseId, msg.stageId)
	end
end

function OriginAshlessDragonSubMo:handlePM_OriginAshlessDragonResetRes(msg)
	local phaseId = msg.phaseId

	for id = phaseId, self._maxPhaseId do
		self._stageInfos[id] = nil
	end
end

function OriginAshlessDragonSubMo:handlePM_Notify_OriginAshlessDragonChallengeEndRes(msg)
	self._fightResultMsg = msg
end

function OriginAshlessDragonSubMo:getMaxPhaseId()
	return self._maxPhaseId
end

function OriginAshlessDragonSubMo:getInitBudget()
	return self._initBudget
end

function OriginAshlessDragonSubMo:getUsedBudget()
	local result = 0

	for phaseId = 1, self._maxPhaseId do
		result = result + self:getInvestBudgetInPhase(phaseId)
	end

	return result
end

function OriginAshlessDragonSubMo:getCurrentTotalBudget()
	local result = self:getInitBudget()

	for phaseId = 1, self._maxPhaseId do
		result = result + self:getExAddBudgetInPhase(phaseId)
	end

	return result
end

function OriginAshlessDragonSubMo:getTotalRisk()
	local result = 0

	for phaseId = 1, self._maxPhaseId do
		result = result + self:getRiskInPhase(phaseId)
	end

	return result
end

function OriginAshlessDragonSubMo:getConstructionUnit(phaseId, budget)
	local data = OriginAshlessDragonConfig.instance:getBudgetPlanData(self._activityId, phaseId)

	if data then
		if not data.constructionUnit then
			local constructionUnit = 0

			return budget * constructionUnit
		end
	end
end

function OriginAshlessDragonSubMo:getRiskUnit(phaseId, budget)
	local data = OriginAshlessDragonConfig.instance:getBudgetPlanData(self._activityId, phaseId)

	if data then
		if not data.riskUnit then
			local riskUnit = 0

			return budget * riskUnit
		end
	end
end

function OriginAshlessDragonSubMo:getFightResultMsg()
	return self._fightResultMsg
end

function OriginAshlessDragonSubMo:isHasHistoryFirstPassClg()
	return table.indexof(self._everPassedPhaseIds, self._maxPhaseId) ~= false
end

function OriginAshlessDragonSubMo:isHistoryPassedInPhase(phaseId)
	return table.indexof(self._everPassedPhaseIds, phaseId) ~= false
end

function OriginAshlessDragonSubMo:saveChangeSetId(changeSetId)
	self._changeSetId = changeSetId
end

function OriginAshlessDragonSubMo:popChangeSetId()
	self._changeSetId = nil

	return self._changeSetId
end

function OriginAshlessDragonSubMo:isUnlockedInPhase(phaseId)
	local lastPhaseId = phaseId - 1

	if lastPhaseId <= 0 then
		return true
	end

	return self:isPassedInPhase(lastPhaseId)
end

function OriginAshlessDragonSubMo:isPassedInPhase(phaseId)
	local result = true

	if result then
		local stageDatas = OriginAshlessDragonConfig.instance:getStageDatas(self._activityId, phaseId) or {}

		for stageId, data in ipairs(stageDatas) do
			if not self:isPassedInStage(phaseId, stageId) then
				result = false

				break
			end
		end
	end

	if result then
		local construction = self:getConstructionInPhase(phaseId)
		local targetConstruction = self:getTargetConstructionInPhase(phaseId)

		if construction < targetConstruction then
			result = false
		end
	end

	if result and phaseId == self._maxPhaseId then
		local leftInvestBudget = self:getLeftInvestBudgetInPhase(phaseId)

		if leftInvestBudget > 0 then
			result = false
		end
	end

	return result
end

function OriginAshlessDragonSubMo:getLockRaceIdsInPhase(phaseId)
	local result = {}
	local stageDatas = OriginAshlessDragonConfig.instance:getStageDatas(self._activityId, phaseId)

	if stageDatas then
		for stageId, data in ipairs(stageDatas) do
			local list = self:getLockRaceIdsInStage(phaseId, stageId)

			table.insertto(result, list)
		end
	end

	return result
end

function OriginAshlessDragonSubMo:getConstructionInPhase(phaseId)
	local result = 0
	local stageDatas = OriginAshlessDragonConfig.instance:getStageDatas(self._activityId, phaseId)

	if stageDatas then
		for stageId, data in ipairs(stageDatas) do
			result = result + self:getConstructionInStage(phaseId, stageId)
		end
	end

	return result
end

function OriginAshlessDragonSubMo:getTargetConstructionInPhase(phaseId)
	local data = OriginAshlessDragonConfig.instance:getPhaseData(self._activityId, phaseId)

	return (data or nil) and (data.constructionCondition or 0)
end

function OriginAshlessDragonSubMo:getOverConstructionInPhase(phaseId)
	local cur = self:getConstructionInPhase(phaseId)
	local target = self:getTargetConstructionInPhase(phaseId)

	return Mathf.Max(cur - target, 0)
end

function OriginAshlessDragonSubMo:getRiskInPhase(phaseId)
	local result = 0
	local stageDatas = OriginAshlessDragonConfig.instance:getStageDatas(self._activityId, phaseId) or {}

	for stageId, data in ipairs(stageDatas) do
		result = result + self:getRiskInStage(phaseId, stageId)
	end

	return result
end

function OriginAshlessDragonSubMo:getInvestBudgetInPhase(phaseId)
	local result = 0
	local stageDatas = OriginAshlessDragonConfig.instance:getStageDatas(self._activityId, phaseId)

	if stageDatas then
		for stageId, data in ipairs(stageDatas) do
			result = result + self:getInvestBudgetInStage(phaseId, stageId)
		end
	end

	return result
end

function OriginAshlessDragonSubMo:getLeftInvestBudgetInPhase(phaseId)
	local result = self:getInitBudget()

	for id = 1, phaseId do
		local cost = self:getInvestBudgetInPhase(id)

		result = result - cost
	end

	for id = 1, phaseId - 1 do
		local ex = self:getExAddBudgetInPhase(id)

		result = result + ex
	end

	return Mathf.Max(result, 0)
end

function OriginAshlessDragonSubMo:getExAddBudgetInPhase(phaseId)
	local result = 0

	if self:isPassedInPhase(phaseId) and phaseId ~= self._maxPhaseId then
		local overAddBudget = self:getOverAddBudgetInPhase(phaseId)
		local overConstruction = self:getOverConstructionInPhase(phaseId)

		result = overConstruction * overAddBudget
	end

	return result
end

function OriginAshlessDragonSubMo:getOverAddBudgetInPhase(phaseId)
	local data = OriginAshlessDragonConfig.instance:getPhaseData(self._activityId, phaseId)

	return (data or nil) and (data.overAddBudget or 0)
end

function OriginAshlessDragonSubMo:isUnlockedInStage(phaseId, stageId)
	return self:isUnlockedInPhase(phaseId)
end

function OriginAshlessDragonSubMo:isPassedInStage(phaseId, stageId)
	local info = self:getStageInfo(phaseId, stageId)

	return info ~= nil
end

function OriginAshlessDragonSubMo:getLockRaceIdsInStage(phaseId, stageId)
	local info = self:getStageInfo(phaseId, stageId)

	return (info or nil) and (info.lockRaceIds or {})
end

function OriginAshlessDragonSubMo:getConstructionInStage(phaseId, stageId)
	local ex = self:getBalanceAddConstructionInStage(phaseId, stageId)
	local budget = self:getInvestBudgetInStage(phaseId, stageId)
	local construction = self:getConstructionUnit(phaseId, budget)

	return ex + construction
end

function OriginAshlessDragonSubMo:getBalanceAddConstructionInStage(phaseId, stageId)
	local info = self:getStageInfo(phaseId, stageId)

	return (info or nil) and (info.balanceAddConstruction or 0)
end

function OriginAshlessDragonSubMo:getRiskInStage(phaseId, stageId)
	local budget = self:getInvestBudgetInStage(phaseId, stageId)

	return self:getRiskUnit(phaseId, budget)
end

function OriginAshlessDragonSubMo:getInvestBudgetInStage(phaseId, stageId)
	local info = self:getStageInfo(phaseId, stageId)

	return (info or nil) and (info.investBudget or 0)
end

function OriginAshlessDragonSubMo:getStageInfo(phaseId, stageId)
	return (self._stageInfos[phaseId] or nil) and (self._stageInfos[phaseId][stageId] or nil)
end

function OriginAshlessDragonSubMo:saveSelectedBudget(phaseId, stageId, budget)
	self._selectedBudgets = self._selectedBudgets or {}
	self._selectedBudgets[phaseId] = self._selectedBudgets[phaseId] or {}
	self._selectedBudgets[phaseId][stageId] = budget
end

function OriginAshlessDragonSubMo:getSelectedBudget(phaseId, stageId)
	if not self._selectedBudgets then
		return 0
	end

	return (self._selectedBudgets[phaseId] or nil) and (self._selectedBudgets[phaseId][stageId] or 0)
end

function OriginAshlessDragonSubMo:clearSelectedBudget(phaseId, stageId)
	if self._selectedBudgets and self._selectedBudgets[phaseId] then
		self._selectedBudgets[phaseId][stageId] = nil
	end
end

return OriginAshlessDragonSubMo
