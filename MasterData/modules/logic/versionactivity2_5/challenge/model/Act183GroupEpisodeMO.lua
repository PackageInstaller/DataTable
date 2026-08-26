-- chunkname: @modules/logic/versionactivity2_5/challenge/model/Act183GroupEpisodeMO.lua

module("modules.logic.versionactivity2_5.challenge.model.Act183GroupEpisodeMO", package.seeall)

local Act183GroupEpisodeMO = pureTable("Act183GroupEpisodeMO")

function Act183GroupEpisodeMO:init(info)
	self._groupId = info.groupId
	self._finished = info.finished

	self:_onGetEpisodeList(info.episodeList)
end

function Act183GroupEpisodeMO:_onGetEpisodeList(episodeList)
	self._episodeList = {}
	self._episodeMap = {}

	for _, episodeInfo in ipairs(episodeList) do
		local episodeMo = Act183EpisodeMO.New()

		episodeMo:init(episodeInfo)
		table.insert(self._episodeList, episodeMo)

		local episodeId = episodeMo:getEpisodeId()

		self._episodeMap[episodeId] = episodeMo
	end

	local episodeMo = self._episodeList[1]

	self._groupType = episodeMo and episodeMo:getGroupType()

	if self._episodeList then
		self._episodeCount = #self._episodeList or 0
	end
end

function Act183GroupEpisodeMO:isHasFinished()
	return self._finished
end

function Act183GroupEpisodeMO:getEpisodeMos()
	return self._episodeList
end

function Act183GroupEpisodeMO:getGroupId()
	return self._groupId
end

function Act183GroupEpisodeMO:getGroupType()
	return self._groupType
end

function Act183GroupEpisodeMO:getStatus()
	local status = Act183Enum.GroupStatus.Locked

	if self._groupType == Act183Enum.GroupType.Daily then
		local unlockRemainTime = self:getUnlockRemainTime()

		if not unlockRemainTime or unlockRemainTime <= 0 then
			status = Act183Enum.GroupStatus.Unlocked
		end
	elseif self._groupType == Act183Enum.GroupType.NormalMain or self._groupType == Act183Enum.GroupType.HardMain then
		local isGroupFinished = self:isGroupFinished()

		status = isGroupFinished and Act183Enum.GroupStatus.Finished or Act183Enum.GroupStatus.Unlocked
	else
		logError(string.format("挑战玩法获取关卡组状态失败  未定义关卡组类型 groupId = %s, groupType = %s", self._groupId, self._groupType))
	end

	return status
end

function Act183GroupEpisodeMO:isGroupFinished()
	local finishEpisodes = self:getStatusEpisodes(Act183Enum.GroupStatus.Finished)

	if finishEpisodes then
		if not #finishEpisodes then
			local finishEpisodeCount = 0

			return finishEpisodeCount >= self._episodeCount
		end
	end
end

function Act183GroupEpisodeMO:getUnlockRemainTime()
	return Act183Helper.getDailyGroupEpisodeUnlockRemainTime(self._groupId) or 0
end

function Act183GroupEpisodeMO:getEpisodeCount()
	return self._episodeCount
end

function Act183GroupEpisodeMO:getEpisodeFinishCount()
	local episodeList = self:getStatusEpisodes(Act183Enum.EpisodeStatus.Finished)

	return (episodeList or nil) and (#episodeList or 0)
end

function Act183GroupEpisodeMO:isAllSubEpisodeFinished()
	for _, episodeMo in ipairs(self._episodeList) do
		local episodeType = episodeMo:getEpisodeType()
		local status = episodeMo:getStatus()

		if episodeType == Act183Enum.EpisodeType.Sub and status ~= Act183Enum.EpisodeStatus.Finished then
			return false
		end
	end

	return true
end

function Act183GroupEpisodeMO:getAllPassConditionIds()
	local passConditionIds = {}

	for _, episodeMo in ipairs(self._episodeList) do
		if episodeMo:isFinished() then
			tabletool.addValues(passConditionIds, episodeMo:getPassConditions())
		end
	end

	return passConditionIds
end

function Act183GroupEpisodeMO:getTotalAndPassConditionIds(episodeId)
	local curEpisodeMo = self:getEpisodeMo(episodeId)
	local preEpisodeMos = self:getPreEpisodeMos(episodeId)
	local allEpisodeMos = {
		curEpisodeMo
	}

	tabletool.addValues(allEpisodeMos, preEpisodeMos)
	table.sort(allEpisodeMos, self._sortEpisodeByPassOrder)

	local allConditionIds = {}
	local passConditionIds = {}

	for _, episodeMo in ipairs(allEpisodeMos) do
		local conditionIds = episodeMo:getConditionIds()
		local passIds = episodeMo:getPassConditions()

		tabletool.addValues(allConditionIds, conditionIds)
		tabletool.addValues(passConditionIds, passIds)
	end

	return allConditionIds, passConditionIds
end

function Act183GroupEpisodeMO:getEpisodeListByPassOrder()
	local episodeMos = tabletool.copy(self._episodeList)

	table.sort(episodeMos, self._sortEpisodeByPassOrder)

	return episodeMos
end

function Act183GroupEpisodeMO._sortEpisodeByPassOrder(aEpisodeMo, bEpisodeMo)
	local aFinished = aEpisodeMo:isFinished()
	local bFinished = bEpisodeMo:isFinished()

	if aFinished ~= bFinished then
		return aFinished
	end

	local aPassOrder = aEpisodeMo:getPassOrder()
	local bPassOrder = bEpisodeMo:getPassOrder()

	if aPassOrder ~= bPassOrder then
		return aPassOrder < bPassOrder
	end

	local aConfig = aEpisodeMo:getConfig()
	local bConfig = bEpisodeMo:getConfig()
	local aOrder = aConfig.order
	local bOrder = bConfig.order

	if aOrder ~= bOrder then
		return aOrder < bOrder
	end

	return aEpisodeMo:getEpisodeId() < bEpisodeMo:getEpisodeId()
end

function Act183GroupEpisodeMO:isConditionPass(conditionId)
	for _, episodeMo in ipairs(self._episodeList) do
		if episodeMo:isConditionPass(conditionId) then
			return true
		end
	end
end

function Act183GroupEpisodeMO:getPreEpisodeMos(episodeId)
	local episodeMo = self:getEpisodeMo(episodeId)
	local preEpisodeMos = {}

	if episodeMo then
		local preEpisodeIds = episodeMo:getPreEpisodeIds()

		if preEpisodeIds then
			for _, preEpisodeId in ipairs(preEpisodeIds) do
				local episodeMo = self:getEpisodeMo(preEpisodeId)

				table.insert(preEpisodeMos, episodeMo)
			end
		end
	end

	return preEpisodeMos
end

function Act183GroupEpisodeMO:getConditionFinishCount()
	local totalPassConditionCount = 0

	for _, episodeMo in ipairs(self._episodeList) do
		local passConditions = episodeMo:getPassConditions()

		if passConditions then
			if not #passConditions then
				local passConditionCount = 0

				totalPassConditionCount = totalPassConditionCount + passConditionCount
			end
		end
	end

	return totalPassConditionCount
end

function Act183GroupEpisodeMO:getBossEpisodePassCount()
	local bossEpisodePassCount = 0

	for _, episodeMo in ipairs(self._episodeList) do
		local episodeType = episodeMo:getEpisodeType()
		local status = episodeMo:getStatus()

		if episodeType == Act183Enum.EpisodeType.Boss and status == Act183Enum.EpisodeStatus.Finished then
			bossEpisodePassCount = bossEpisodePassCount + 1
		end
	end

	return bossEpisodePassCount
end

function Act183GroupEpisodeMO:getEpisodeMo(episodeId)
	return self._episodeMap[episodeId]
end

function Act183GroupEpisodeMO:getEscapeRules(episodeId)
	local episodeMo = self:getEpisodeMo(episodeId)

	if not episodeMo then
		return
	end

	local totalEscapeRules = {}
	local passOrderMos = self:getEpisodeListByPassOrder()

	for _, mo in ipairs(passOrderMos) do
		if not mo:isFinished() then
			break
		end

		if mo:getEpisodeId() == episodeMo:getEpisodeId() then
			break
		end

		local escapeRules = mo:getEscapeRules()

		if escapeRules and #escapeRules > 0 then
			for index, ruleDesc in ipairs(escapeRules) do
				if not string.nilorempty(ruleDesc) then
					local escapeRuleInfo = {
						episodeId = mo:getEpisodeId(),
						ruleDesc = ruleDesc,
						ruleIndex = index,
						passOrder = mo:getPassOrder()
					}

					table.insert(totalEscapeRules, escapeRuleInfo)
				end
			end
		end
	end

	return totalEscapeRules
end

function Act183GroupEpisodeMO:isEpisodeCanRestart(episodeId)
	local episodeMo = self:getEpisodeMo(episodeId)

	if not episodeMo then
		return
	end

	local isFinished = episodeMo:isFinished()
	local episodeType = episodeMo:getEpisodeType()

	if episodeType == Act183Enum.EpisodeType.Boss and isFinished then
		return true
	end

	local simulate = episodeMo:isSimulate()
	local episodePassOrder = episodeMo:getPassOrder()
	local maxPassOrder = self:findMaxPassOrder()

	return isFinished and episodePassOrder == maxPassOrder and not simulate
end

function Act183GroupEpisodeMO:isEpisodeCanReset(episodeId)
	local episodeMo = self:getEpisodeMo(episodeId)

	if not episodeMo then
		return
	end

	local episodeType = episodeMo:getEpisodeType()

	if episodeType == Act183Enum.EpisodeType.Boss then
		return
	end

	local status = episodeMo:getStatus()
	local episodePassOrder = episodeMo:getPassOrder()
	local simulate = episodeMo:isSimulate()
	local maxPassOrder = self:findMaxPassOrder()

	return status == Act183Enum.EpisodeStatus.Finished and episodePassOrder < maxPassOrder and not simulate
end

function Act183GroupEpisodeMO:isCanStart(episodeId)
	local episodeMo = self:getEpisodeMo(episodeId)

	if not episodeMo then
		return
	end

	local status = episodeMo:getStatus()

	if status ~= Act183Enum.EpisodeStatus.Unlocked then
		return
	end

	local episodeType = episodeMo:getEpisodeType()

	if episodeType == Act183Enum.EpisodeType.Sub then
		return true
	elseif episodeType == Act183Enum.EpisodeType.Boss then
		return self:isAllSubEpisodeFinished()
	end
end

function Act183GroupEpisodeMO:isEpisodeCanReRepress(episodeId)
	local episodeMo = self:getEpisodeMo(episodeId)

	if not episodeMo then
		return
	end

	local episodeType = episodeMo:getEpisodeType()

	if episodeType == Act183Enum.EpisodeType.Boss then
		return
	end

	local episodePassOrder = episodeMo:getPassOrder()
	local isFinished = episodeMo:isFinished()
	local maxPassOrder = self:findMaxPassOrder()
	local isLastEpisode = Act183Helper.isLastPassEpisodeInGroup(episodeMo)

	return isFinished and episodePassOrder == maxPassOrder and not isLastEpisode
end

function Act183GroupEpisodeMO:isHeroRepress(heroId, excludeEpisodeId)
	for _, episodeMo in ipairs(self._episodeList) do
		local isRepress = episodeMo:isHeroRepress(heroId)
		local episodeId = episodeMo:getEpisodeId()

		if isRepress and (not excludeEpisodeId or excludeEpisodeId == episodeId) then
			return true
		end
	end

	return false
end

function Act183GroupEpisodeMO:findMaxPassOrder()
	local maxPassOrder = 0

	for _, episdoeMo in ipairs(self._episodeList) do
		local isFinished = episdoeMo:isFinished()

		if isFinished then
			local episodeOrder = episdoeMo:getPassOrder()

			if maxPassOrder < episodeOrder then
				maxPassOrder = episodeOrder
			end
		end
	end

	return maxPassOrder
end

function Act183GroupEpisodeMO:isHeroRepressInPreEpisode(episodeId, heroId)
	local episodeMo = self:getEpisodeMo(episodeId)
	local isFinished = episodeMo:isFinished()
	local passOrder = episodeMo:getPassOrder()

	for _, mo in ipairs(self._episodeList) do
		if mo:isFinished() and (not isFinished or passOrder > mo:getPassOrder()) then
			local isRepress = mo:isHeroRepress(heroId)

			if isRepress then
				return true
			end
		end
	end

	return false
end

function Act183GroupEpisodeMO:getStatusEpisodes(targetStatus)
	local result = {}

	for _, episodeMo in ipairs(self._episodeList) do
		local status = episodeMo:getStatus()

		if targetStatus == status then
			table.insert(result, episodeMo)
		end
	end

	return result
end

function Act183GroupEpisodeMO:isAnySubEpisodeNotFinished()
	for _, episdoeMo in ipairs(self._episodeList) do
		if episdoeMo:getEpisodeType() == Act183Enum.EpisodeType.Sub and episdoeMo:getStatus() ~= Act183Enum.EpisodeStatus.Finished then
			return true
		end
	end
end

function Act183GroupEpisodeMO:getTargetTypeAndStatusEpisodes(episodeType, status)
	local episodeList = {}

	for _, episdoeMo in ipairs(self._episodeList) do
		if episdoeMo:getEpisodeType() == episodeType and episdoeMo:getStatus() == status then
			table.insert(episodeList, episdoeMo)
		end
	end

	return episodeList
end

return Act183GroupEpisodeMO
