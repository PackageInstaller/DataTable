-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kunwu/model/KunWuModel.lua

module("logic.extensions.kunwu.model.KunWuModel", package.seeall)

local KunWuModel = class("KunWuModel", BaseModel)

KunWuModel.EXT_PHASE_NUM = 2
KunWuModel.EXT_PHASE_STAGE_NUM = 3

function KunWuModel:onInit()
	self:onReset()
end

function KunWuModel:onReset()
	self._customNorFmtMoPool = {}
	self._customExtFmtMoPool = {}
	self.infos = {}
	self._curExtPhaseId = 0
	self._changeSetIdStack = {}
end

function KunWuModel:getInfo(activityId)
	return self.infos[activityId] or {}
end

function KunWuModel:addChangeSetId(changeSetId)
	table.insert(self._changeSetIdStack, changeSetId)
end

function KunWuModel:popChangeSetId()
	return table.remove(self._changeSetIdStack, #self._changeSetIdStack)
end

function KunWuModel:getChangeSetIdStackLength()
	return #self._changeSetIdStack
end

function KunWuModel:handlePM_KunWuClgGetInfoRes(msg)
	self.infos[msg.activityId] = GameUtil.pbToTable(msg)

	local info = self.infos[msg.activityId]

	info.extremeClgStageInfo = {
		{},
		{}
	}

	for i, stageInfo in ipairs(msg.extremeClgStageInfo) do
		local phaseId = stageInfo.left
		local stageId = stageInfo.mid

		info.extremeClgStageInfo[phaseId][stageId] = stageInfo.right
	end

	self.infos[msg.activityId].normalClgGainedDataBitId = msg.normalClgGainedDataBitId or {}
end

function KunWuModel:handlePM_NotifyKunWuNormalFightEndRes(msg)
	if msg.win then
		local info = self.infos[msg.activityId]

		info.normalClgProgress = msg.normalClgProgress or {}
	end
end

function KunWuModel:handlePM_KunWuClgGainProgressPrizeRes(msg)
	local info = self.infos[msg.activityId]

	table.insert(info.normalClgGainedDataBitId, msg.dataBitId)
end

function KunWuModel:handlePM_NotifyKunWuExtremeFightEndRes(msg)
	local info = self.infos[msg.activityId]

	info.confirmNum = msg.win and msg.confirmNum or -1
end

function KunWuModel:handlePM_KunWuClgConfirmRes(msg)
	local info = self.infos[msg.activityId]

	if msg.stageInfo and msg.stageInfo.left ~= 0 then
		local phase = msg.stageInfo.left
		local stage = msg.stageInfo.mid

		info.extremeClgStageInfo[phase][stage] = msg.stageInfo.right

		if self:hasPassedAllPhase(msg.activityId) then
			MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
			self:addChangeSetId(msg.changeSetId)
		end
	end
end

function KunWuModel:handlePM_KunWuResetExtremeClgPhaseRes(msg)
	local info = self.infos[msg.activityId]

	info.extremeClgStageInfo[msg.phaseId] = {}
end

function KunWuModel:getNorFmtMo(activityId)
	if self._customNorFmtMoPool[activityId] == nil then
		self._customNorFmtMoPool[activityId] = KunWuNorFmtMo.New()
	end

	return self._customNorFmtMoPool[activityId]
end

function KunWuModel:getExtFmtMo(activityId)
	if self._customExtFmtMoPool[activityId] == nil then
		self._customExtFmtMoPool[activityId] = KunWuExtFmtMo.New()
	end

	return self._customExtFmtMoPool[activityId]
end

function KunWuModel:getCurNorProgress(activityId)
	local info = self.infos[activityId]

	return info.normalClgProgress
end

function KunWuModel:getNormalClgDailyPassedTeamIndex(activityId)
	local info = self.infos[activityId]

	return info.normalClgDailyPassedTeamIndex or {}
end

function KunWuModel:getNormalClgTodayStageGroupId(activityId)
	local info = self.infos[activityId]

	return info.normalClgTodayStageGroupId
end

function KunWuModel:getExtStageScore(activityId, phase, stage)
	local info = self.infos[activityId]
	local curExtClgStageInfo = info.extremeClgStageInfo

	if curExtClgStageInfo[phase][stage] then
		return checknumber(curExtClgStageInfo[phase][stage])
	else
		return 0
	end
end

function KunWuModel:extPhaseHasNoChallenged(activityId, phase)
	for stageId = 1, KunWuModel.EXT_PHASE_STAGE_NUM do
		if self:getExtStageScore(activityId, phase, stageId) > 0 then
			return false
		end
	end

	return true
end

function KunWuModel:getExtPhaseTotalScore(activityId, phase)
	local info = self.infos[activityId]
	local extClgStageInfos = info.extremeClgStageInfo
	local extClgStageInfo = extClgStageInfos[phase]
	local totalScore = 0

	for i, score in pairs(extClgStageInfo) do
		totalScore = totalScore + score
	end

	return totalScore
end

function KunWuModel:getExtConfirmNum(activityId)
	local info = self:getInfo(activityId)

	return info.confirmNum or -1
end

function KunWuModel:setExtPhaseId(phaseId)
	self._curExtPhaseId = phaseId
end

function KunWuModel:getExtPhaseId(activityId)
	if self._curExtPhaseId <= 0 then
		for phase = 1, KunWuModel.EXT_PHASE_NUM do
			local phasePass = self:hasPassedPhase(activityId, phase)

			if not phasePass then
				self._curExtPhaseId = phase

				return self._curExtPhaseId
			end
		end
	elseif self:hasPassedPhase(activityId, self._curExtPhaseId) then
		for phase = 1, KunWuModel.EXT_PHASE_NUM do
			local phasePass = self:hasPassedPhase(activityId, phase)

			if not phasePass then
				self._curExtPhaseId = phase

				return self._curExtPhaseId
			end
		end
	end

	return self._curExtPhaseId
end

function KunWuModel:hasPassedAllPhase(activityId)
	local info = self.infos[activityId]

	if info.extremeClgPrizeGained then
		return true
	end

	local passAllPhase = true

	for phase = 1, KunWuModel.EXT_PHASE_NUM do
		passAllPhase = passAllPhase and self:hasPassedPhase(activityId, phase)
	end

	return passAllPhase
end

function KunWuModel:hasPassedPhase(activityId, phase)
	local info = self.infos[activityId]

	if info.extremeClgPrizeGained then
		return true
	end

	local phaseTotalScore = self:getExtPhaseTotalScore(activityId, phase)
	local scoreCorrectRequest = false
	local phaseSymbol = KunWuConfig.instance:getExtCaculateSymbol(activityId, phase)
	local targetValue = KunWuConfig.instance:getExtStageTargetSumValue(activityId, phase)
	local phaseChallenged = true

	for stageId = 1, KunWuModel.EXT_PHASE_STAGE_NUM do
		phaseChallenged = phaseChallenged and self:hasChallengedStage(activityId, phase, stageId)
	end

	scoreCorrectRequest = phaseSymbol == ">=" and targetValue <= phaseTotalScore or phaseTotalScore <= targetValue

	return phaseChallenged and scoreCorrectRequest
end

function KunWuModel:canPassedPhase(activityId, phase, curStageId, score)
	local phaseTotalScore = self:getExtPhaseTotalScore(activityId, phase) + score
	local scoreCorrectRequest = false
	local phaseSymbol = KunWuConfig.instance:getExtCaculateSymbol(activityId, phase)
	local targetValue = KunWuConfig.instance:getExtStageTargetSumValue(activityId, phase)
	local phaseChallenged = true

	for stageId = 1, KunWuModel.EXT_PHASE_STAGE_NUM do
		if stageId ~= curStageId then
			phaseChallenged = phaseChallenged and self:hasChallengedStage(activityId, phase, stageId)
		end
	end

	scoreCorrectRequest = phaseSymbol == ">=" and targetValue <= phaseTotalScore or phaseTotalScore <= targetValue

	return phaseChallenged and scoreCorrectRequest
end

function KunWuModel:hasChallengedStage(activityId, phase, stage)
	local info = self.infos[activityId]
	local curExtClgStageInfo = info.extremeClgStageInfo

	return curExtClgStageInfo[phase][stage] ~= nil
end

function KunWuModel:getExtBuffs(activityId, phase)
	local info = self.infos[activityId]

	if not info.extBuffs then
		local extBuffs = {
			{},
			{}
		}
		local curPhaseBuffs = extBuffs[phase]
		local originBuffs = KunWuConfig.instance:getExtOriginBuffs(activityId, phase)
		local curPassStage = {}

		for stageId = 1, KunWuModel.EXT_PHASE_STAGE_NUM do
			if self:hasChallengedStage(activityId, phase, stageId) then
				table.insert(curPassStage, stageId)
			end
		end

		for stageId = 1, KunWuModel.EXT_PHASE_STAGE_NUM do
			curPhaseBuffs[stageId] = curPhaseBuffs[stageId] or {}

			if not self:hasChallengedStage(activityId, phase, stageId) then
				table.insert(curPhaseBuffs[stageId], originBuffs[stageId])
			end

			for curStageId = 1, KunWuModel.EXT_PHASE_STAGE_NUM do
				if table.indexof(curPassStage, curStageId) and stageId ~= curStageId then
					local stageBuff = KunWuConfig.instance:getExtStageOriginBuff(activityId, phase, curStageId)

					table.insert(curPhaseBuffs[stageId], stageBuff)
				end
			end
		end

		return curPhaseBuffs
	end
end

KunWuModel.instance = KunWuModel.New()

return KunWuModel
