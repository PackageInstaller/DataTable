-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/youngchampionking/model/YoungChampionKingModel.lua

module("logic.extensions.youngchampionking.model.YoungChampionKingModel", package.seeall)

local YoungChampionKingModel = class("YoungChampionKingModel", BaseModel)

function YoungChampionKingModel:ctor()
	return
end

function YoungChampionKingModel:onInit()
	self:onReset()
end

function YoungChampionKingModel:onReset()
	self._curMo = nil
	self._moList = {}
	self._qualifierFormInfo = nil
	self._qualifierDefenseFmtMo = nil
	self._qualifierFmtMo = nil
	self._knockOutFormInfos = nil
	self._knockOutDefenseFmtMo = nil
	self._knockOutFmtMo = nil
	self._knockOutRoundFmtMo = nil
	self._guessRecordInfo = nil
	self._displayInfo = nil
	self._inRoomUserIds = {}
	self._banPetRaceIds = {}
end

function YoungChampionKingModel:setCurActMo(actId)
	self._curMo = self:_getActMo(actId)
end

function YoungChampionKingModel:_getActMo(actId)
	if self._moList then
		local mo = self._moList[actId]

		if not self._moList then
			mo = {
				playerRoundId = 1,
				gainDailyCoin = false,
				curStepId = 1,
				activityId = actId,
				fightInfoList = {},
				fightInfoMap = {},
				battleRecords = {},
				qualifierInfoMap = {},
				qualifierRankInfoMap = {},
				qualifierPetRankInfoMap = {},
				knockoutScheduleInfoMap = {}
			}
			self._moList[actId] = self._moList
		end

		return self._moList
	end
end

function YoungChampionKingModel:getQualifierInfo(actId, stepId)
	local mo = self:_getActMo(actId)
	local info = mo.qualifierInfoMap[stepId]

	if not info then
		info = {
			dailyFightTimes = 0,
			winStreak = 0,
			rankScore = 0,
			stepId = stepId
		}
		mo.qualifierInfoMap[stepId] = info
	end

	return info
end

function YoungChampionKingModel:getQualifierRankInfo(actId, stepId, zoneId)
	local mo = self:_getActMo(actId)
	local infoKey = stepId .. "---" .. zoneId
	local info = mo.qualifierRankInfoMap[infoKey]

	if not info then
		info = {
			myRank = -1,
			stepId = stepId,
			zoneId = zoneId,
			rankList = {}
		}
		mo.qualifierRankInfoMap[infoKey] = info
	end

	return info
end

function YoungChampionKingModel:getQualifierPetRankInfo(actId, stepId, winRank)
	local mo = self:_getActMo(actId)
	local infoKey = stepId .. "---" .. (winRank and 1 or 0)
	local info = mo.qualifierPetRankInfoMap[infoKey]

	if not info then
		info = {
			stepId = stepId,
			winRank = winRank,
			rankList = {}
		}
		mo.qualifierPetRankInfoMap[infoKey] = info
	end

	return info
end

function YoungChampionKingModel:getKnockoutScheduleInfo(actId, startRoundId, viewGroupId)
	local mo = self:_getActMo(actId)
	local infoKey = string.format("%s---%s", startRoundId, viewGroupId)
	local info = mo.knockoutScheduleInfoMap[infoKey]

	if not info then
		info = {
			roundGuessCount = 0,
			startRoundId = startRoundId,
			viewGroupId = viewGroupId,
			matchInfoMap = {}
		}
		mo.knockoutScheduleInfoMap[infoKey] = info
	end

	return info
end

function YoungChampionKingModel:getQualifierFormInfo()
	return self._qualifierFormInfo
end

function YoungChampionKingModel:getQualifierDefenseFmtMo()
	self._qualifierDefenseFmtMo = self._qualifierDefenseFmtMo or YoungChampionKingQualifierDefenseFmtMo.New()

	return self._qualifierDefenseFmtMo
end

function YoungChampionKingModel:getQualifierFmtMo()
	self._qualifierFmtMo = self._qualifierFmtMo or YoungChampionKingQualifierFmtMo.New()

	return self._qualifierFmtMo
end

function YoungChampionKingModel:getKnockoutFormInfos()
	return self._knockOutFormInfos
end

function YoungChampionKingModel:getKnockoutDefenseFmtMo()
	self._knockOutDefenseFmtMo = self._knockOutDefenseFmtMo or YoungChampionKingKnockoutDefenseFmtMo.New()

	return self._knockOutDefenseFmtMo
end

function YoungChampionKingModel:getKnockoutFmtMo()
	self._knockOutFmtMo = self._knockOutFmtMo or YoungChampionKingKnockoutFmtMo.New()

	return self._knockOutFmtMo
end

function YoungChampionKingModel:getKnockoutRoundFmtMo()
	self._knockOutRoundFmtMo = self._knockOutRoundFmtMo or YoungChampionKingKnockoutRoundFmtMo.New()

	return self._knockOutRoundFmtMo
end

function YoungChampionKingModel:getBanPetRaceIds()
	return self._banPetRaceIds or {}
end

function YoungChampionKingModel:getCurActId()
	return (self._curMo or nil) and (self._curMo.activityId or ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.YoungChampionKing))
end

function YoungChampionKingModel:getCurStepId()
	return (self._curMo or nil) and (self._curMo.curStepId or 1)
end

function YoungChampionKingModel:getIsGainDailyCoin()
	return (self._curMo or nil) and (self._curMo.gainDailyCoin or false)
end

function YoungChampionKingModel:getPlayerRoundId()
	return (self._curMo or nil) and (self._curMo.playerRoundId or 1)
end

function YoungChampionKingModel:getCurFightInfo(stepId)
	return self._curMo and self._curMo.fightInfoMap and self._curMo.fightInfoMap[stepId]
end

function YoungChampionKingModel:getCurFightTimes(stepId)
	local info = self:getCurFightInfo(stepId)

	return (info or nil) and (info.fightTimes or 0)
end

function YoungChampionKingModel:getCurMyBattleRecords()
	return (self._curMo or nil) and (self._curMo.battleRecords or {})
end

function YoungChampionKingModel:getCurKnockoutInfo()
	return self._curMo and self._curMo.myKnockoutInfo
end

function YoungChampionKingModel:getUserIdIsReady(userId)
	return table.keyof(self._inRoomUserIds, checknumber(userId))
end

function YoungChampionKingModel:onGetInfo(msg)
	local info = GameUtil.pbToTable(msg)
	local mo = self:_getActMo(info.activityId)

	mo.curStepId = info.curStepId
	mo.playerRoundId = info.playerRoundId
	mo.gainDailyCoin = info.gainDailyCoin
	mo.fightInfoList = info.fightInfoList
	mo.fightInfoMap = {}

	for i, fightInfo in ipairs(mo.fightInfoList) do
		mo.fightInfoMap[fightInfo.stepId] = fightInfo
	end
end

function YoungChampionKingModel:onNotifyStepChange(msg)
	local info = GameUtil.pbToTable(msg)
	local mo = self:_getActMo(info.activityId)

	mo.curStepId = info.curStepId
end

function YoungChampionKingModel:onGetQualifierInfo(msg)
	local info = GameUtil.pbToTable(msg)
	local mo = self:_getActMo(info.activityId)
	local qualifierInfo = self:getQualifierInfo(info.activityId, info.stepId)

	qualifierInfo.rankScore = info.rankScore
	qualifierInfo.winStreak = info.winStreak
	qualifierInfo.dailyFightTimes = info.dailyFightTimes

	if info.opponent then
		info.opponent.forms = msg.opponent.forms
	end

	qualifierInfo.opponent = info.opponent
end

function YoungChampionKingModel:onGetDefenseForamtion(msg)
	local info = GameUtil.pbToTable(msg)

	self._qualifierFormInfo = info.simpleForm
end

function YoungChampionKingModel:onSetDefenseForamtion(msg)
	local info = GameUtil.pbToTable(msg)
end

function YoungChampionKingModel:onQualifierGetNewOpponent(msg)
	local info = GameUtil.pbToTable(msg)
	local mo = self:_getActMo(info.activityId)
	local qualifierInfo = self:getQualifierInfo(info.activityId, info.stepId)

	qualifierInfo.dailyFightTimes = qualifierInfo.dailyFightTimes + 1

	if info.opponent then
		info.opponent.forms = msg.opponent.forms
	end

	qualifierInfo.opponent = info.opponent
end

function YoungChampionKingModel:onQualifierFight(msg)
	local info = GameUtil.pbToTable(msg)
	local mo = self:_getActMo(info.activityId)
	local qualifierInfo = self:getQualifierInfo(info.activityId, info.stepId)

	qualifierInfo.opponent = nil
	qualifierInfo.rankScore = info.score
	qualifierInfo.winStreak = info.winStreak
	qualifierInfo.dailyFightTimes = info.dailyFightTimes
end

function YoungChampionKingModel:onQualifierRecords(msg)
	local info = GameUtil.pbToTable(msg)
	local mo = self:_getActMo(info.activityId)

	mo.battleRecords = info.records
end

function YoungChampionKingModel:onQualifierRankInfo(msg)
	local info = GameUtil.pbToTable(msg)
	local mo = self:_getActMo(info.activityId)
	local rankInfo = self:getQualifierRankInfo(info.activityId, info.stepId, info.zoneId)

	rankInfo.rankList = info.rankList
	rankInfo.myRank = info.myRank
end

function YoungChampionKingModel:onQualifierPetRaceRank(msg)
	local info = GameUtil.pbToTable(msg)
	local mo = self:_getActMo(info.activityId)
	local rankInfo = self:getQualifierPetRankInfo(info.activityId, info.stepId, info.winRank)

	rankInfo.rankList = info.infoList
end

function YoungChampionKingModel:onMyKnockoutInfo(msg)
	local info = GameUtil.pbToTable(msg)
	local mo = self:_getActMo(info.activityId)

	mo.myKnockoutInfo = info.knockoutInfo
	self._inRoomUserIds = {}
end

function YoungChampionKingModel:onGetKnockoutSchedule(msg)
	local info = GameUtil.pbToTable(msg)
	local mo = self:_getActMo(info.activityId)
	local knockoutScheduleInfo = self:getKnockoutScheduleInfo(info.activityId, info.roundId, info.viewGroupId)

	knockoutScheduleInfo.roundGuessCount = checknumber(info.roundGuessCount)

	if not info.groupList then
		for _, matchInfo in ipairs(info.groupList) do
			if not knockoutScheduleInfo.matchInfoMap[matchInfo.roundId] then
				knockoutScheduleInfo.matchInfoMap[matchInfo.roundId][matchInfo.index] = matchInfo
				knockoutScheduleInfo.matchInfoMap[matchInfo.roundId] = knockoutScheduleInfo.matchInfoMap[matchInfo.roundId]
			end
		end
	end
end

function YoungChampionKingModel:onGetGuessRecord(msg)
	self._guessRecordInfo = GameUtil.pbToTable(msg)
end

function YoungChampionKingModel:getGuessRecordInfo()
	return self._guessRecordInfo
end

function YoungChampionKingModel:onGuess(msg, viewGroupId, roundId, index)
	local info = GameUtil.pbToTable(msg)
	local mo = self:_getActMo(info.activityId)
	local scheduleInfo = self:getKnockoutScheduleInfo(info.activityId, roundId, viewGroupId)
	local matchinfo = YoungChampionKingController.instance:getKnockoutScheduleMatchInfo(roundId, viewGroupId, index)
	local guessNum = checknumber(info.guessRecord.guessNum)
	local addCount = 0

	if matchinfo then
		matchinfo.guessPlayerId = checknumber(info.guessRecord.targetPlayerId)

		if checknumber(matchinfo.guessCount) <= 0 then
			matchinfo.guessCount = 0
		end

		addCount = guessNum - matchinfo.guessCount
		matchinfo.guessCount = guessNum

		if matchinfo.playerA and checknumber(matchinfo.playerA.headInfo.headInfo.userId) == matchinfo.guessPlayerId then
			matchinfo.playerA.totalGuessCount = addCount + matchinfo.playerA.totalGuessCount
		end

		if matchinfo.playerB and checknumber(matchinfo.playerB.headInfo.headInfo.userId) == matchinfo.guessPlayerId then
			matchinfo.playerB.totalGuessCount = addCount + matchinfo.playerB.totalGuessCount
		end
	end

	if scheduleInfo then
		scheduleInfo.roundGuessCount = scheduleInfo.roundGuessCount + addCount
	end
end

function YoungChampionKingModel:onGainGuessCoin(msg)
	local info = GameUtil.pbToTable(msg)
	local mo = self:_getActMo(info.activityId)

	mo.gainDailyCoin = true
end

function YoungChampionKingModel:onGetDisplayInfo(msg)
	self._displayInfo = GameUtil.pbToTable(msg)
end

function YoungChampionKingModel:getDisplayInfo()
	return self._displayInfo
end

function YoungChampionKingModel:onKnockoutGetFormation(msg)
	local info = GameUtil.pbToTable(msg)

	self._knockOutFormInfos = info.forms
end

function YoungChampionKingModel:onKnockoutSetFormation(msg)
	local info = GameUtil.pbToTable(msg)
end

function YoungChampionKingModel:onGetKnockoutJoinRoomInfo(msg)
	local info = GameUtil.pbToTable(msg)

	if not info.inRoomUserIds then
		self._inRoomUserIds = {}

		for _, userId in ipairs(info.inRoomUserIds) do
			table.insert(self._inRoomUserIds, checknumber(userId))
		end
	end
end

function YoungChampionKingModel:onKnockoutJoinRoom(msg)
	local info = GameUtil.pbToTable(msg)
	local myUserId = checknumber(RoleModel.instance:getUserId())

	table.insert(self._inRoomUserIds, myUserId)
end

function YoungChampionKingModel:onKnockoutLeaveRoom(msg)
	local info = GameUtil.pbToTable(msg)
	local myUserId = checknumber(RoleModel.instance:getUserId())

	table.removebyvalue(self._inRoomUserIds, myUserId, true)
end

function YoungChampionKingModel:onNotifyYCKKnockoutOpJoinRoom(msg)
	local info = GameUtil.pbToTable(msg)

	if self._curMo then
		local opUserId = checknumber(self._curMo.myKnockoutInfo.opponent.headInfo.headInfo.userId)

		if info.join then
			table.insert(self._inRoomUserIds, opUserId)
		else
			table.removebyvalue(self._inRoomUserIds, opUserId, true)
		end
	end
end

function YoungChampionKingModel:onNotifyYCKKnockoutFightStart(msg)
	local info = GameUtil.pbToTable(msg)

	self._inRoomUserIds = {}
	self._banPetRaceIds = info.banPetRaceIds
end

function YoungChampionKingModel:onKnockoutSetGameFormation(msg)
	local info = GameUtil.pbToTable(msg)
end

function YoungChampionKingModel:onNotifyYCKKnockoutOpSetFormationFinish(msg)
	local info = GameUtil.pbToTable(msg)
end

function YoungChampionKingModel:onNotifyYCKKnockoutTurnToNextGameRound(msg)
	local info = GameUtil.pbToTable(msg)
end

function YoungChampionKingModel:onNotifyYCKKnockoutGameEnd(msg)
	local info = GameUtil.pbToTable(msg)
end

function YoungChampionKingModel:onNotifyYCKKnockoutOpInvited(msg)
	local info = GameUtil.pbToTable(msg)
	local mo = self:_getActMo(info.activityId)

	mo.stepId = info.stepId
	mo.playerRoundId = YoungChampionKingController.instance:getRoundIdByStepId(mo.stepId)
end

YoungChampionKingModel.instance = YoungChampionKingModel.New()

return YoungChampionKingModel
