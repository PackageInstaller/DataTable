-- chunkname: @modules/logic/versionactivity2_8/molideer/model/MoLiDeErGameMo.lua

module("modules.logic.versionactivity2_8.molideer.model.MoLiDeErGameMo", package.seeall)

local MoLiDeErGameMo = pureTable("MoLiDeErGameMo")

function MoLiDeErGameMo:init(activityId, episodeInfo, isEpisodeFinish, passStar)
	self.actId = activityId
	self.episodeId = episodeInfo.episodeId

	local episodeConfig = MoLiDeErConfig.instance:getEpisodeConfig(activityId, episodeInfo.episodeId)

	self.gameId = episodeConfig.gameId
	self.previousRound = self.currentRound
	self.previousRoundEnergy = self.leftRoundEnergy
	self.currentRound = episodeInfo.currentRound
	self.totalRoundEnergy = episodeInfo.totalRoundEnergy
	self.leftRoundEnergy = episodeInfo.leftRoundEnergy
	self.eventInfos = episodeInfo.eventInfos
	self.teamInfos = episodeInfo.teamInfos
	self.itemInfos = episodeInfo.itemInfos
	self.buffIds = episodeInfo.buffIds
	self.itemBuffIds = episodeInfo.itemBuffIds
	self.finishedEventInfos = episodeInfo.finishedEventInfos
	self.isExtraStar = episodeInfo.isExtraStar
	self.isEpisodeFinish = isEpisodeFinish
	self.passStar = passStar

	self:initEquipInfo()
	self:initEventInfo()
	self:initFinishEventInfo()
	self:initTeamInfo()
	self:initEventProgressInfo()
end

function MoLiDeErGameMo:initEquipInfo()
	local tempEquipInfoDic = {}
	local newGetItem = {}
	local newGetItemDic = {}

	for _, info in ipairs(self.itemInfos) do
		local itemId = info.itemId

		tempEquipInfoDic[itemId] = info

		if self._equipInfoDic and self._equipInfoDic[itemId] == nil then
			logNormal("莫莉德尔 角色活动 获得新装备 id:" .. tostring(itemId))
			table.insert(newGetItem, itemId)

			newGetItemDic[itemId] = true
		end
	end

	self._equipInfoDic = tempEquipInfoDic
	self.newGetItem = newGetItem
	self.newGetItemDic = newGetItemDic
end

function MoLiDeErGameMo:initEventInfo()
	self._eventInfoDic = {}
	self._dispatchDic = {}
	self._allDispatch = true

	for _, info in ipairs(self.eventInfos) do
		self._eventInfoDic[info.eventId] = info

		if info.teamId ~= nil or info.teamId ~= 0 then
			self._dispatchDic[info.teamId] = true
			self._allDispatch = false
		end
	end
end

function MoLiDeErGameMo:getEventInfo(eventId)
	return self._eventInfoDic[eventId]
end

function MoLiDeErGameMo:getEquipInfo(itemId)
	return self._equipInfoDic[itemId]
end

function MoLiDeErGameMo:canEquipUse(itemId)
	local equipInfo = self:getEquipInfo(itemId)

	if equipInfo == nil then
		return false
	end

	local itemConfig = MoLiDeErConfig.instance:getItemConfig(itemId)

	if itemConfig == nil then
		logError("不存在的道具id:" .. itemId)
	end

	return itemConfig.isUse == MoLiDeErEnum.ItemType.Initiative and equipInfo.quantity > 0
end

function MoLiDeErGameMo:initTeamInfo()
	local tempTeamInfoDic = {}
	local newGetTeam = {}
	local newGetTeamDic = {}

	self._allActTimeNotMatch = true

	for _, info in ipairs(self.teamInfos) do
		local teamId = info.teamId

		tempTeamInfoDic[teamId] = info

		if self._allActTimeNotMatch == true and info.roundActionTime > 0 and info.roundActedTime < info.roundActionTime then
			self._allActTimeNotMatch = false
		end

		if self._teamInfoDic and self._teamInfoDic[teamId] == nil then
			logNormal("莫莉德尔 角色活动 获得新小队 id:" .. tostring(teamId))
			table.insert(newGetTeam, teamId)

			newGetTeamDic[teamId] = true
		end
	end

	self._teamInfoDic = tempTeamInfoDic
	self.newGetTeam = newGetTeam
	self.newGetTeamDic = newGetTeamDic
	self._teamDispatchDic = {}
	self._teamDispatchEventDic = {}

	for _, eventInfo in ipairs(self.eventInfos) do
		if eventInfo.teamId ~= nil and eventInfo.teamId ~= 0 then
			self._teamDispatchDic[eventInfo.teamId] = eventInfo.eventId
			self._teamDispatchEventDic[eventInfo.eventId] = eventInfo.teamId
		end
	end
end

function MoLiDeErGameMo:initFinishEventInfo()
	self._finishEventDic = {}

	for _, info in ipairs(self.finishedEventInfos) do
		self._finishEventDic[info.finishedEventId] = info
	end
end

function MoLiDeErGameMo:isNewFinishEvent(eventId)
	return self._finishEventDic[eventId] == nil
end

function MoLiDeErGameMo:isNewEvent(eventId)
	return self._eventInfoDic[eventId] == nil
end

function MoLiDeErGameMo:isDispatchTeam(teamId)
	return self._teamDispatchDic[teamId] ~= nil
end

function MoLiDeErGameMo:getEventDispatchTeam(eventId)
	return self._teamDispatchEventDic[eventId]
end

function MoLiDeErGameMo:getTeamInfo(teamId)
	return self._teamInfoDic[teamId]
end

function MoLiDeErGameMo:canDispatchTeam(teamId)
	local teamInfo = self:getTeamInfo(teamId)

	if teamInfo == nil then
		return false
	end

	return not self:isInDispatching(teamId)
end

function MoLiDeErGameMo:isInDispatching(teamId)
	return self._dispatchDic[teamId] ~= nil
end

function MoLiDeErGameMo:isAllInDispatching()
	return self._allDispatch
end

function MoLiDeErGameMo:isAllActTimesNotMatch()
	return self._allActTimeNotMatch
end

function MoLiDeErGameMo:initEventProgressInfo()
	self._targetProgressDic = {}
	self._targetNewCompleteDic = {}
	self._targetNewFailDic = {}

	local tempTargetCompleteDic = {}
	local tempTargetFailDic = {}
	local gameConfig = MoLiDeErConfig.instance:getGameConfig(self.gameId)

	if self.isEpisodeFinish and self.passStar == -1 then
		self._targetProgressDic[MoLiDeErEnum.TargetId.Main] = MoLiDeErEnum.ProgressRange.Failed
		tempTargetFailDic[MoLiDeErEnum.TargetId.Main] = true

		logNormal("莫莉德尔 角色活动 主目标失败")
	end

	if self.isExtraStar then
		self._targetProgressDic[MoLiDeErEnum.TargetId.Extra] = MoLiDeErEnum.ProgressRange.Success
		tempTargetCompleteDic[MoLiDeErEnum.TargetId.Extra] = true
	else
		local extraConditionParam = gameConfig.extraCondition

		if not string.nilorempty(extraConditionParam) then
			local data = string.splitToNumber(extraConditionParam, "#")
			local type = data[1]

			if type == MoLiDeErEnum.TargetConditionType.RoundLimitedFinishAll or type == MoLiDeErEnum.TargetConditionType.RoundLimitedFinishAny then
				local round = data[2]

				if round < self.currentRound then
					self._targetProgressDic[MoLiDeErEnum.TargetId.Extra] = MoLiDeErEnum.ProgressRange.Failed
					tempTargetFailDic[MoLiDeErEnum.TargetId.Extra] = true
				end
			end
		end
	end

	if self.finishedEventInfos and self.finishedEventInfos[1] then
		for _, info in ipairs(self.finishedEventInfos) do
			local progressConfig = MoLiDeErConfig.instance:getProgressConfig(info.optionId)

			if progressConfig ~= nil then
				local conditionParams = string.split(progressConfig.condition, "|")

				for _, conditionParam in ipairs(conditionParams) do
					local conditionData = string.splitToNumber(conditionParam, "#")
					local gameId = conditionData[1]
					local targetId = conditionData[2]

					if gameId == self.gameId then
						local curProgress = self._targetProgressDic[targetId]

						curProgress = curProgress or 0

						if curProgress > MoLiDeErEnum.ProgressRange.Failed and curProgress < MoLiDeErEnum.ProgressRange.Success then
							local changeType = progressConfig.progressChange
							local changeNum = progressConfig.progressNum

							if changeType == MoLiDeErEnum.ProgressChangeType.Percentage then
								curProgress = Mathf.Clamp(curProgress + changeNum, MoLiDeErEnum.ProgressRange.Failed, MoLiDeErEnum.ProgressRange.Success)
							elseif changeType == MoLiDeErEnum.ProgressChangeType.Success then
								curProgress = MoLiDeErEnum.ProgressRange.Success
								tempTargetCompleteDic[targetId] = true
							elseif changeType == MoLiDeErEnum.ProgressChangeType.Failed then
								curProgress = MoLiDeErEnum.ProgressRange.Failed
							end
						end

						self._targetProgressDic[targetId] = curProgress
					end
				end
			end
		end
	end

	if self.isEpisodeFinish and (self.passStar == -1 or self.passStar == 1) and self._targetProgressDic[MoLiDeErEnum.TargetId.Extra] ~= MoLiDeErEnum.ProgressRange.Success then
		self._targetProgressDic[MoLiDeErEnum.TargetId.Extra] = MoLiDeErEnum.ProgressRange.Failed
		tempTargetFailDic[MoLiDeErEnum.TargetId.Extra] = true

		logNormal("莫莉德尔 角色活动 额外目标失败")
	end

	if self._targetCompleteDic then
		for targetId, state in pairs(tempTargetCompleteDic) do
			if self._targetCompleteDic[targetId] == nil then
				self._targetNewCompleteDic[targetId] = true

				logNormal("莫莉德尔 角色活动 存在新的完成目标 id: " .. tostring(targetId))
			end
		end
	end

	if self._targetFailDic then
		for targetId, state in pairs(tempTargetFailDic) do
			if self._targetFailDic[targetId] == nil then
				self._targetNewFailDic[targetId] = true

				logNormal("莫莉德尔 角色活动 存在新的失败目标 id: " .. tostring(targetId))
			end
		end
	end

	self._targetCompleteDic = tempTargetCompleteDic
	self._targetFailDic = tempTargetFailDic
end

function MoLiDeErGameMo:getTargetProgress(targetId)
	return self._targetProgressDic[targetId] or 0
end

function MoLiDeErGameMo:isNewCompleteTarget(targetId)
	return self._targetNewCompleteDic[targetId]
end

function MoLiDeErGameMo:isNewFailTarget(targetId)
	return self._targetNewFailDic[targetId]
end

return MoLiDeErGameMo
