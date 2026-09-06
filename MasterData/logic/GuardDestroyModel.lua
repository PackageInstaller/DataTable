-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guarddestroy/model/GuardDestroyModel.lua

module("logic.extensions.guarddestroy.model.GuardDestroyModel", package.seeall)

local GuardDestroyModel = class("GuardDestroyModel", BaseModel)

function GuardDestroyModel:ctor()
	return
end

function GuardDestroyModel:onInit()
	self:onReset()
end

function GuardDestroyModel:onReset()
	self._fmtMo = nil
	self._info = {}
	self._stageInfo = {}
	self._prizeInfo = {}
	self._progressInfo = {}
	self._tempChallengeInfo = nil
	self._rankInfo = {}
end

function GuardDestroyModel:saveInfo(msg)
	self._info[msg.activityId] = GameUtil.pbToTable(msg)

	local stageInfo = {}
	local progressInfo = {}

	if msg.stageInfos then
		for i, v in ipairs(msg.stageInfos) do
			stageInfo[v.stageId] = v

			if v.type1Score >= 0 then
				progressInfo[1] = (progressInfo[1] or 0) + v.type1Score
			end

			if v.type2Score >= 0 then
				progressInfo[2] = (progressInfo[2] or 0) + v.type2Score
			end
		end
	end

	self._stageInfo[msg.activityId] = stageInfo
	self._progressInfo[msg.activityId] = progressInfo

	local prizeInfo = {}

	if msg.gainStageType1PrizeIds then
		prizeInfo[1] = prizeInfo[1] or {}

		for i, v in ipairs(msg.gainStageType1PrizeIds) do
			prizeInfo[1][v] = true
		end
	end

	if msg.gainStageType2PrizeIds then
		prizeInfo[2] = prizeInfo[2] or {}

		for i, v in ipairs(msg.gainStageType2PrizeIds) do
			prizeInfo[2][v] = true
		end
	end

	self._prizeInfo[msg.activityId] = prizeInfo
end

function GuardDestroyModel:getFmtMo()
	self._fmtMo = self._fmtMo or GuardDestroyFmtMo.New()

	return self._fmtMo
end

function GuardDestroyModel:getProgress(activityId, type)
	return self._progressInfo[activityId][type] or 0
end

function GuardDestroyModel:getGainProgress(activityId, type, id)
	return self._prizeInfo[activityId][type][id]
end

function GuardDestroyModel:getGainEqualPrize(activityId)
	if self._info[activityId] then
		return self._info[activityId].gainBalancePrize
	end
end

function GuardDestroyModel:isCanGainEqualPrize(activityId)
	if not self:getGainEqualPrize(activityId) then
		return checknumber(self._info[activityId].balanceAchieveTimeMillis) > 0
	else
		return false
	end
end

function GuardDestroyModel:getStageScore(activityId, stageId, type)
	local stageInfo = self._stageInfo[activityId][stageId]

	if stageInfo then
		if type == 1 then
			return stageInfo.type1Score
		else
			return stageInfo.type2Score
		end
	else
		return -1
	end
end

function GuardDestroyModel:getFirstRankInfo(activityId)
	if self._info[activityId] then
		return self._info[activityId].firstPlaceInfo
	end
end

function GuardDestroyModel:saveChallengeInfo(msg)
	if msg.needConfirm == false then
		self._stageInfo[msg.activityId][msg.stageId] = self._stageInfo[msg.activityId][msg.stageId] or {}

		local info = self._stageInfo[msg.activityId][msg.stageId]

		info.stageId = msg.stageId
		info.type1Score = info.type1Score or -1
		info.type2Score = info.type2Score or -1

		if msg.stageType == 1 then
			info.type1Score = msg.score
		else
			info.type2Score = msg.score
		end

		self:_checkProgressInfo(msg.activityId)

		if msg.balanceAchieveTimeMillis then
			self._info[msg.activityId].balanceAchieveTimeMillis = msg.balanceAchieveTimeMillis
		end
	end
end

function GuardDestroyModel:resetTempChallengeInfo()
	self._tempChallengeInfo = nil
end

function GuardDestroyModel:saveTempChallengeInfo(msg)
	self._tempChallengeInfo = GameUtil.pbToTable(msg)
end

function GuardDestroyModel:getTempChallengeInfo()
	return self._tempChallengeInfo
end

function GuardDestroyModel:saveConfirmInfo(msg)
	if msg.replace == true then
		self._stageInfo[msg.activityId][msg.stageId] = self._stageInfo[msg.activityId][msg.stageId] or {}

		local info = self._stageInfo[msg.activityId][msg.stageId]

		info.stageId = msg.stageId
		info.type1Score = info.type1Score or -1
		info.type2Score = info.type2Score or -1

		if msg.stageType == 1 then
			info.type1Score = msg.score
		else
			info.type2Score = msg.score
		end

		self._stageInfo[msg.activityId][msg.stageId] = info

		self:_checkProgressInfo(msg.activityId)

		if msg.balanceAchieveTimeMillis then
			self._info[msg.activityId].balanceAchieveTimeMillis = msg.balanceAchieveTimeMillis
		end
	end
end

function GuardDestroyModel:_checkProgressInfo(activityId)
	local progressInfo = self._progressInfo[activityId]

	progressInfo[1] = 0
	progressInfo[2] = 0

	for i, v in pairs(self._stageInfo[activityId]) do
		if v.type1Score >= 0 then
			progressInfo[1] = progressInfo[1] + v.type1Score
		end

		if v.type2Score >= 0 then
			progressInfo[2] = progressInfo[2] + v.type2Score
		end
	end
end

function GuardDestroyModel:_isStagePass(activityId, stageId)
	if stageId <= 0 then
		return true
	end

	if self._stageInfo[activityId] then
		local stageInfo = self._stageInfo[activityId][stageId]

		if stageInfo and stageInfo.type1Score > 0 and stageInfo.type2Score > 0 then
			return true
		end
	end

	return false
end

function GuardDestroyModel:saveGainPrize(msg)
	self._prizeInfo[msg.activityId] = self._prizeInfo[msg.activityId] or {}
	self._prizeInfo[msg.activityId][msg.stageType] = self._prizeInfo[msg.activityId][msg.stageType] or {}
	self._prizeInfo[msg.activityId][msg.stageType][msg.prizeId] = true
end

function GuardDestroyModel:saveGainBalancePrize(msg)
	if self._info[msg.activityId] then
		self._info[msg.activityId].gainBalancePrize = true
	end
end

function GuardDestroyModel:saveRankInfo(msg)
	self._rankInfo[msg.activityId] = GameUtil.pbToTable(msg)
end

function GuardDestroyModel:getRankInfo(activityId)
	return self._rankInfo[activityId]
end

function GuardDestroyModel:saveDayBuffInfo(msg)
	if self._info[msg.activityId] then
		self._info[msg.activityId].signInBuffLv = msg.signInBuffLv
		self._info[msg.activityId].hasSignInToday = true
	end
end

function GuardDestroyModel:getSignBuffLevel(activityId)
	if self._info[activityId] then
		return self._info[activityId].signInBuffLv
	end
end

function GuardDestroyModel:isSignInDay(activityId)
	if self._info[activityId] then
		return self._info[activityId].hasSignInToday
	end
end

GuardDestroyModel.instance = GuardDestroyModel.New()

return GuardDestroyModel
