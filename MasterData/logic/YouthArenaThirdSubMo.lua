-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/youtharenathird/data/YouthArenaThirdSubMo.lua

module("logic.extensions.youtharenathird.data.YouthArenaThirdSubMo", package.seeall)

local YouthArenaThirdSubMo = class("YouthArenaThirdSubMo")
local PB_MUTABLE_KEEP_FIELDS = {
	opponent = true
}

local function _pbToTable(msg)
	return GameUtil.pbToTable(msg) or {}
end

local function _pbToMutableInfo(msg)
	local info = _pbToTable(msg)

	for fieldName in pairs(PB_MUTABLE_KEEP_FIELDS) do
		info[fieldName] = msg and msg.HasField and msg:HasField(fieldName) and msg[fieldName] or nil
	end

	return info
end

local function _restoreQualifierRoundPlayed(msg, info)
	for recordIndex, recordMsg in ipairs((msg or nil) and (msg.records or {})) do
		if info then
			::label_3_0::

			local var_3_0 = info.records

			if info.records then
				local recordInfo = info.records[recordIndex]

				for roundIndex, roundMsg in ipairs((not recordMsg.roundList or nil) and {}) do
					if recordInfo then
						::label_3_1::

						local var_3_2 = recordInfo.roundList

						if recordInfo.roundList then
							local roundInfo = recordInfo.roundList[roundIndex]

							if roundInfo then
								roundInfo.played = roundMsg.played == true
							end
						end
					end
				end
			end
		end
	end
end

local function _getModeKey(isFun, mode)
	return string.format("%s_%s", isFun and 1 or 0, checknumber(mode))
end

local function _getQualifierInfoKey(stepId, mode)
	return string.format("%s_%s", checknumber(stepId), checknumber(mode))
end

local function _getRankKey(stepId, zoneId)
	return string.format("%s_%s", checknumber(stepId), checknumber(zoneId))
end

local function _getPetRankKey(stepId, winRank)
	return string.format("%s_%s", checknumber(stepId), winRank and 1 or 0)
end

local function _getKnockoutScheduleKey(viewGroupId, roundId)
	return string.format("%s_%s", checknumber(viewGroupId), checknumber(roundId))
end

function YouthArenaThirdSubMo:ctor(activityId)
	self._activityId = activityId

	self:onReset()
end

function YouthArenaThirdSubMo:onReset()
	self._curStepId = 0
	self._playerRoundId = 0
	self._matchInfoMap = {}
	self._qualifierInfoMap = {}
	self._dailyScoreTipPendingMap = {}
	self._qualifierRecordsMap = {}
	self._qualifierRankInfoMap = {}
	self._qualifierPetRankInfoMap = {}
	self._myKnockoutInfo = nil
	self._myKnockoutInfoLoaded = false
	self._knockoutScheduleMap = {}
	self._displayInfo = nil
	self._lastFightResult = nil
end

function YouthArenaThirdSubMo:dispose()
	self:onReset()
end

function YouthArenaThirdSubMo:handlePM_YoungArenaKingS3GetInfoRes(msg)
	local info = _pbToTable(msg)

	self._curStepId = checknumber(info.curStepId)
	self._playerRoundId = checknumber(info.playerRoundId)
	self._matchInfoMap = {}

	for _, matchInfo in ipairs(info.matchInfoList or {}) do
		self._matchInfoMap[matchInfo.stepId] = matchInfo
	end
end

function YouthArenaThirdSubMo:handlePM_YoungArenaKingS3NotifyStepChangeRes(msg)
	self._curStepId = checknumber(msg.curStepId)
end

function YouthArenaThirdSubMo:handlePM_YoungArenaKingS3GetVideoRes(msg)
	return
end

function YouthArenaThirdSubMo:handlePM_YoungArenaKingS3GetDefenseForamtionRes(msg)
	return
end

function YouthArenaThirdSubMo:handlePM_YoungArenaKingS3SetDefenseForamtionRes(msg)
	return
end

function YouthArenaThirdSubMo:handlePM_YoungArenaKingS3GetQualifierInfoRes(msg)
	local info = _pbToMutableInfo(msg)

	self._qualifierInfoMap[_getQualifierInfoKey(info.stepId, info.mode)] = info

	if info.addDailyScore == true then
		self._dailyScoreTipPendingMap[checknumber(info.stepId)] = true
	end
end

function YouthArenaThirdSubMo:handlePM_YoungArenaKingS3QualifierGetNewOpponentRes(msg)
	local info = _pbToMutableInfo(msg)
	local key = _getQualifierInfoKey(info.stepId, info.mode)

	if not self._qualifierInfoMap[key] then
		self._qualifierInfoMap[key].opponent = info.opponent
		self._qualifierInfoMap[key] = self._qualifierInfoMap[key]
	end
end

function YouthArenaThirdSubMo:handlePM_YoungArenaKingS3QualifierFightRes(msg)
	local info = _pbToTable(msg)

	self._lastFightResult = info

	self:invalidateQualifierRecords(info.stepId == YouthArenaThirdEnum.MatchStepId.Fun, info.mode)

	local key = _getQualifierInfoKey(info.stepId, info.mode)

	if not self._qualifierInfoMap[key] then
		self._qualifierInfoMap[key].opponent = nil
		self._qualifierInfoMap[key].rankScore = info.newScore
		self._qualifierInfoMap[key].modeWinStreak = info.modeWinStreak
		self._qualifierInfoMap[key].dailyFightTimes = info.dailyFightTimes
		self._qualifierInfoMap[key] = self._qualifierInfoMap[key]
	end
end

function YouthArenaThirdSubMo:handlePM_YoungArenaKingS3QualifierRecordsRes(msg)
	local info = _pbToTable(msg)

	_restoreQualifierRoundPlayed(msg, info)

	self._qualifierRecordsMap[_getModeKey(info.isFun, info.mode)] = info
end

function YouthArenaThirdSubMo:handlePM_YoungArenaKingS3QualifierRankInfoRes(msg)
	local info = _pbToTable(msg)

	self._qualifierRankInfoMap[_getRankKey(info.stepId, info.zoneId)] = info
end

function YouthArenaThirdSubMo:handlePM_YoungArenaKingS3QualifierPetRaceRankRes(msg)
	local info = _pbToTable(msg)

	self._qualifierPetRankInfoMap[_getPetRankKey(info.stepId, info.winRank)] = info
end

function YouthArenaThirdSubMo:handlePM_YoungArenaKingS3MyKnockoutInfoRes(msg)
	local info = _pbToTable(msg)

	self._myKnockoutInfo = info.knockoutInfo
	self._myKnockoutInfoLoaded = true
end

function YouthArenaThirdSubMo:handlePM_YoungArenaKingS3GetKnockoutScheduleRes(msg)
	local info = _pbToTable(msg)

	self._knockoutScheduleMap[_getKnockoutScheduleKey(info.viewGroupId, info.roundId)] = info
end

function YouthArenaThirdSubMo:handlePM_YoungArenaKingS3GetDisplayInfoRes(msg)
	self._displayInfo = _pbToTable(msg)
end

function YouthArenaThirdSubMo:getActivityId()
	return self._activityId
end

function YouthArenaThirdSubMo:getCurStepId()
	return self._curStepId
end

function YouthArenaThirdSubMo:getPlayerRoundId()
	return self._playerRoundId
end

function YouthArenaThirdSubMo:getMatchInfo(stepId)
	return self._matchInfoMap[stepId]
end

function YouthArenaThirdSubMo:getQualifierInfo(stepId, mode)
	return self._qualifierInfoMap[_getQualifierInfoKey(stepId, mode)]
end

function YouthArenaThirdSubMo:consumeDailyScoreTip(stepId)
	stepId = checknumber(stepId)

	if self._dailyScoreTipPendingMap[stepId] ~= true then
		return false
	end

	self._dailyScoreTipPendingMap[stepId] = nil

	return true
end

function YouthArenaThirdSubMo:getOpponent(stepId, mode)
	local info = self:getQualifierInfo(stepId, mode)

	return info and info.opponent
end

function YouthArenaThirdSubMo:getQualifierRecords(isFun, mode)
	return self._qualifierRecordsMap[_getModeKey(isFun, mode)]
end

function YouthArenaThirdSubMo:invalidateQualifierRecords(isFun, mode)
	self._qualifierRecordsMap[_getModeKey(isFun, mode)] = nil
end

function YouthArenaThirdSubMo:getQualifierRankInfo(stepId, zoneId)
	return self._qualifierRankInfoMap[_getRankKey(stepId, zoneId)]
end

function YouthArenaThirdSubMo:getQualifierPetRankInfo(stepId, winRank)
	return self._qualifierPetRankInfoMap[_getPetRankKey(stepId, winRank)]
end

function YouthArenaThirdSubMo:getMyKnockoutInfo()
	return self._myKnockoutInfo
end

function YouthArenaThirdSubMo:hasMyKnockoutInfoLoaded()
	return self._myKnockoutInfoLoaded == true
end

function YouthArenaThirdSubMo:getKnockoutScheduleInfo(viewGroupId, roundId)
	return self._knockoutScheduleMap[_getKnockoutScheduleKey(viewGroupId, roundId)]
end

function YouthArenaThirdSubMo:getTop8ScoreMatchPlayers(viewGroupId, roundId)
	local info = self:getKnockoutScheduleInfo(viewGroupId, roundId)

	return (info or nil) and (info.top8ScoreMatchPlayers or {})
end

function YouthArenaThirdSubMo:getDisplayInfo()
	return self._displayInfo
end

function YouthArenaThirdSubMo:getLastFightResult()
	return self._lastFightResult
end

return YouthArenaThirdSubMo
