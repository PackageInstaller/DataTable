-- chunkname: @modules/logic/versionactivity2_1/aergusi/model/AergusiDialogModel.lua

module("modules.logic.versionactivity2_1.aergusi.model.AergusiDialogModel", package.seeall)

local AergusiDialogModel = class("AergusiDialogModel", BaseModel)

function AergusiDialogModel:onInit()
	self:reInit()
end

function AergusiDialogModel:reInit()
	self._curGroup = 0
	self._curStep = 0
	self._targetList = {}
	self._errorOperates = {}
	self._promptOperates = {}
end

function AergusiDialogModel:setDialogGroup(group)
	self._curGroup = group
	self._curStep = 0
end

function AergusiDialogModel:getCurDialogGroup()
	if self._curGroup == 0 then
		local episodeId = AergusiModel.instance:getCurEpisode()

		self._curGroup = AergusiConfig.instance:getEpisodeConfig(nil, episodeId).initialDialog
	end

	return self._curGroup
end

function AergusiDialogModel:setCurDialogStep(step)
	self._curStep = step
end

function AergusiDialogModel:getCurDialogStep()
	if self._curStep == 0 then
		local group = self:getCurDialogGroup()

		self._curStep = self:getGroupFirstStep(group)
	end

	return self._curStep
end

function AergusiDialogModel:getGroupFirstStep(groupId)
	local configs = AergusiConfig.instance:getEvidenceDialogConfigs(groupId)
	local nextSteps = {}

	for _, v in pairs(configs) do
		table.insert(nextSteps, v.nextStep)
	end

	for _, v in pairs(configs) do
		for _, nextStep in pairs(nextSteps) do
			if v.stepId == nextStep then
				break
			end
		end

		return v.stepId
	end

	return 1
end

function AergusiDialogModel:setCurDialogProcess(groupId, stepId)
	self._curGroup = groupId
	self._curStep = stepId
end

function AergusiDialogModel:getCurDialogProcess()
	local group = self:getCurDialogGroup()
	local step = self:getCurDialogStep()

	return group, step
end

function AergusiDialogModel:clearDialogProcess()
	self:reInit()
end

function AergusiDialogModel:getDialogStepList(groupId)
	local firstStep = self:getGroupFirstStep(groupId)
	local stepCoList = {}

	local function getnextstepco(stepId)
		local stepCo = AergusiConfig.instance:getDialogConfig(groupId, stepId)

		table.insert(stepCoList, stepCo)

		if stepCo.nextStep > 0 then
			return getnextstepco(stepCo.nextStep)
		end
	end

	getnextstepco(firstStep)

	return stepCoList
end

function AergusiDialogModel:addPromptOperate(data, isInClue)
	if isInClue then
		self._promptOperates.inClue = self._promptOperates.inClue or {}

		table.insert(self._promptOperates.inClue, data)
	else
		self._promptOperates.inEvidence = self._promptOperates.inEvidence or {}

		table.insert(self._promptOperates.inEvidence, data)
	end
end

function AergusiDialogModel:isOperateHasPrompted(data, isInClue)
	if isInClue then
		self._promptOperates.inClue = self._promptOperates.inClue or {}

		for _, v in pairs(self._promptOperates.inClue) do
			if v.groupId == data.groupId and v.stepId == data.stepId and v.clueId == data.clueId then
				return true
			end
		end
	else
		self._promptOperates.inEvidence = self._promptOperates.inEvidence or {}

		for _, v in pairs(self._promptOperates.inEvidence) do
			if v.groupId == data.groupId and v.stepId == data.stepId and v.type == data.type then
				return true
			end
		end
	end

	return false
end

function AergusiDialogModel:getLastPromptOperate(isInClue, stepId)
	if isInClue then
		self._promptOperates.inClue = self._promptOperates.inClue or {}

		for _, v in pairs(self._promptOperates.inClue) do
			if v.stepId == stepId then
				return v
			end
		end

		return self._promptOperates.inClue[#self._promptOperates.inClue]
	end

	self._promptOperates.inEvidence = self._promptOperates.inEvidence or {}

	return self._promptOperates.inEvidence[#self._promptOperates.inEvidence]
end

function AergusiDialogModel:getNextPromptOperate(isInClue)
	local dialogCos = AergusiConfig.instance:getDialogConfigs(self._curGroup)

	for _, v in pairs(dialogCos) do
		if v.condition ~= "" then
			local conditions = string.splitToNumber(v.condition, "#")

			if conditions[1] == AergusiEnum.OperationType.Submit then
				local data = {}

				data.groupId = self._curGroup
				data.stepId = v.stepId
				data.type = AergusiEnum.OperationType.Submit

				if isInClue then
					data.clueId = conditions[2]

					if not self:isOperateHasPrompted(data, true) then
						return data
					end
				elseif not self:isOperateHasPrompted(data, false) then
					return data
				end
			elseif conditions[1] == AergusiEnum.OperationType.Refutation then
				local data = {}

				data.groupId = self._curGroup
				data.stepId = v.stepId
				data.type = AergusiEnum.OperationType.Refutation

				if isInClue then
					data.clueId = conditions[2]

					if not self:isOperateHasPrompted(data, true) then
						return data
					end
				elseif not self:isOperateHasPrompted(data, false) then
					return data
				end
			elseif conditions[1] == AergusiEnum.OperationType.Probe then
				local data = {}

				data.groupId = self._curGroup
				data.stepId = v.stepId
				data.type = AergusiEnum.OperationType.Probe

				if not self:isOperateHasPrompted(data) then
					return data
				end
			end
		end
	end

	return nil
end

function AergusiDialogModel:getLeftPromptTimes()
	local curEpisode = AergusiModel.instance:getCurEpisode()
	local evidenceInfo = AergusiModel.instance:getEvidenceInfo(curEpisode)

	return evidenceInfo.tipCount
end

function AergusiDialogModel:getLeftErrorTimes()
	local curEpisode = AergusiModel.instance:getCurEpisode()
	local evidenceInfo = AergusiModel.instance:getEvidenceInfo(curEpisode)

	return evidenceInfo.hp
end

function AergusiDialogModel:isOperateHasError(data)
	for _, v in pairs(self._errorOperates) do
		if v.groupId == data.groupId and v.stepId == data.stepId and v.type == data.type then
			return true
		end
	end

	return false
end

function AergusiDialogModel:isCurClueHasOperateError(stepId, clueId)
	for _, v in pairs(self._errorOperates) do
		if v.groupId == self._curGroup and v.stepId == stepId and v.clueId == clueId then
			return true
		end
	end

	return false
end

function AergusiDialogModel:addErrorOperate(data)
	table.insert(self._errorOperates, data)
end

function AergusiDialogModel:getTargetGroupList()
	return self._targetList
end

function AergusiDialogModel:addTargetGroup(groupId)
	table.insert(self._targetList, groupId)
end

function AergusiDialogModel:getFinishedTargetGroupCount()
	return (#self._targetList > 0 or nil) and (#self._targetList - 1 or 0)
end

function AergusiDialogModel:setShowingGroup(show)
	self._showinggroup = show
end

function AergusiDialogModel:getShowingGroupState()
	return self._showinggroup
end

function AergusiDialogModel:getBubbleFirstStep(bubbleId)
	local configs = AergusiConfig.instance:getBubbleConfigs(bubbleId)
	local nextSteps = {}

	for _, v in pairs(configs) do
		table.insert(nextSteps, v.nextStep)
	end

	for _, v in pairs(configs) do
		for _, nextStep in pairs(nextSteps) do
			if v.stepId == nextStep then
				break
			end
		end

		return v.stepId
	end

	return 1
end

function AergusiDialogModel:getBubbleStepList(bubbleId)
	local firstStep = self:getBubbleFirstStep(bubbleId)
	local stepCoList = {}

	local function getnextstepco(stepId)
		local stepCo = AergusiConfig.instance:getBubbleConfig(bubbleId, stepId)

		table.insert(stepCoList, stepCo)

		if stepCo.nextStep > 0 then
			return getnextstepco(stepCo.nextStep)
		end
	end

	getnextstepco(firstStep)

	return stepCoList
end

function AergusiDialogModel:setUnlockAutoShow(show)
	self._unlockShow = show
end

function AergusiDialogModel:getUnlockAutoShow()
	local episodeId = AergusiModel.instance:getCurEpisode()
	local isPassed = AergusiModel.instance:isEpisodePassed(episodeId)

	if isPassed then
		return false
	end

	local processes = AergusiModel.instance:getUnlockAutoTipProcess()

	if processes[1] == self._curGroup and processes[2] == self._curStep then
		return true
	end

	return self._unlockShow
end

AergusiDialogModel.instance = AergusiDialogModel.New()

return AergusiDialogModel
