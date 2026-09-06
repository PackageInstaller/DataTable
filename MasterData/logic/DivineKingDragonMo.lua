-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinekingdragonchallenge/view/DivineKingDragonMo.lua

module("logic.extensions.divinekingdragonchallenge.view.DivineKingDragonMo", package.seeall)

local DivineKingDragonMo = class("DivineKingDragonMo")

function DivineKingDragonMo:ctor(activityId)
	self._activityId = activityId
	self._actData = DivineKingDragonChallengeConfig.instance:getDkdActData(self._activityId)
	self._stageDataList = DivineKingDragonChallengeConfig.instance:getDkdStageDataList(self._activityId)
	self._prizeOfStages = {}
	self._passOfTeams = {}
	self._lockPetIdsOfTeams = {}
	self._teamIdRecords = {}
end

function DivineKingDragonMo:getActivityId()
	return self._activityId
end

function DivineKingDragonMo:deepcopy()
	return TableUtil.deepcopy(self)
end

function DivineKingDragonMo:getTryEnterStageOfResultAndTips(activityId, stageId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if not DivineKingDragonChallengeController.instance:isInActivityTime(activityId) then
		result = GameEnum.ResultCode.Error
		tips = "不在活动时间内"
	elseif self:isPassOfStage(stageId) then
		result = GameEnum.ResultCode.Error
		tips = "已通关"
	end

	return result, tips
end

function DivineKingDragonMo:getTryFightTeamOfResultAndTips(activityId, stageId, teamId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if not DivineKingDragonChallengeController.instance:isInActivityTime(activityId) then
		result = GameEnum.ResultCode.Error
		tips = "不在活动时间内"
	elseif self:isPassOfTeam(stageId, teamId) then
		result = GameEnum.ResultCode.Error
		tips = "已通关"
	elseif self:isPassOfStage(stageId) then
		result = GameEnum.ResultCode.Error
		tips = "已通关"
	end

	return result, tips
end

function DivineKingDragonMo:getTryRestartTeamOfResultAndTips(activityId, stageId, teamId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if not DivineKingDragonChallengeController.instance:isInActivityTime(activityId) then
		result = GameEnum.ResultCode.Error
		tips = "不在活动时间内"
	elseif not self:isPassOfTeam(stageId, teamId) then
		result = GameEnum.ResultCode.Error
		tips = "关卡未通关，无需重置"
	elseif self:isPassOfStage(stageId) then
		result = GameEnum.ResultCode.Error
		tips = "所有关卡已通关，无需重置"
	end

	return result, tips
end

function DivineKingDragonMo:getTryGainPrizeInStageOfResultAndTips(activityId, stageId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if not DivineKingDragonChallengeController.instance:isInActivityTime(activityId) then
		result = GameEnum.ResultCode.Error
		tips = "不在活动时间内"
	elseif self:isHasGainPrizeOfStage(stageId) then
		result = GameEnum.ResultCode.Error
		tips = "已领取"
	elseif not self:isEnoughGainPrizeOfStage(stageId) then
		result = GameEnum.ResultCode.Error
		tips = "未满足领取条件"
	end

	return result, tips
end

function DivineKingDragonMo:isCanGainPrizeOfStage(stageId)
	local result = self:getTryGainPrizeInStageOfResultAndTips(self._activityId, stageId)

	return result == GameEnum.ResultCode.Success
end

function DivineKingDragonMo:isEnoughGainPrizeOfStage(stageId)
	return self:isPassOfStage(stageId)
end

function DivineKingDragonMo:isHasGainPrizeOfStage(stageId)
	return self._prizeOfStages[stageId] or false
end

function DivineKingDragonMo:setGainPrizeOfStage(stageId, isHasGain)
	self._prizeOfStages[stageId] = isHasGain
end

function DivineKingDragonMo:isPassOfStage(stageId)
	local result = true
	local dataList = DivineKingDragonChallengeConfig.instance:getDkdTeamDataListByStage(self._activityId, stageId)

	if dataList then
		for _, data in ipairs(dataList) do
			if not self:isPassOfTeam(stageId, data.teamId) then
				result = false

				break
			end
		end
	else
		result = false
	end

	return result
end

function DivineKingDragonMo:isPassOfTeam(stageId, teamId)
	return (self._passOfTeams[stageId] or nil) and (self._passOfTeams[stageId][teamId] or false)
end

function DivineKingDragonMo:setPassOfTeam(stageId, teamId, isPass)
	if self._passOfTeams[stageId] == nil then
		self._passOfTeams[stageId] = {}
	end

	if self._passOfTeams[stageId][teamId] == nil then
		self._passOfTeams[stageId][teamId] = {}
	end

	self._passOfTeams[stageId][teamId] = isPass
end

function DivineKingDragonMo:isPetIdLockedOfStage(stageId, petId)
	local result = false

	if self._lockPetIdsOfTeams[stageId] then
		for teamId, vv in pairs(self._lockPetIdsOfTeams[stageId]) do
			if self:isPetIdLockedOfTeam(stageId, teamId, petId) then
				result = true

				break
			end
		end
	end

	return result
end

function DivineKingDragonMo:isPetIdLockedOfTeam(stageId, teamId, petId)
	local list = self:getLockPetIdsOfTeam(stageId, teamId)

	return table.indexof(list, petId)
end

function DivineKingDragonMo:getLockPetIdsOfTeam(stageId, teamId)
	return (self._lockPetIdsOfTeams[stageId] or nil) and (self._lockPetIdsOfTeams[stageId][teamId] or {})
end

function DivineKingDragonMo:getLockPetBagMoOfTeam(petId)
	return BagModel.instance:getBagPetById(petId)
end

function DivineKingDragonMo:setLockPetIdsOfTeam(stageId, teamId, lockPetIds)
	if self._lockPetIdsOfTeams[stageId] == nil then
		self._lockPetIdsOfTeams[stageId] = {}
	end

	if self._lockPetIdsOfTeams[stageId][teamId] == nil then
		self._lockPetIdsOfTeams[stageId][teamId] = {}
	end

	self._lockPetIdsOfTeams[stageId][teamId] = lockPetIds
end

function DivineKingDragonMo:getTeamIdRecord(stageId)
	return self._teamIdRecords[stageId] or 0
end

function DivineKingDragonMo:setTeamIdRecord(stageId, teamId)
	self._teamIdRecords[stageId] = teamId
end

return DivineKingDragonMo
