-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/peaktournament/model/PeakTournamentModel.lua

module("logic.extensions.peaktournament.model.PeakTournamentModel", package.seeall)

local PeakTournamentModel = class("PeakTournamentModel", BaseModel)

function PeakTournamentModel:ctor()
	return
end

function PeakTournamentModel:onInit()
	self:onReset()
end

function PeakTournamentModel:onReset()
	self._actId = 0
	self._quaInfoMsg = {}
	self._quaRecordsMsg = {}
	self._quaRankMsg = {}
	self._roundInfoPool = {}
	self._guessRecordInfoPool = {}
	self._partInfoMsg = {}
	self._roundGroupPool = {}
	self._taskInfoPool = {}
	self._myScheduleMsg = {}
	self._myScheduleMsg.resultInfoMo = PTBatResultInfoMo.New()
	self._guessInfoMsg = {}
	self._myBattleRecordsMsg = {}
	self._ptCustomFmtMo = nil
	self._ptFmtCustomFmtMo = nil
	self._formResMsg = nil
	self._ptBtlCustomFmtMo = nil
	self._views = {}
	self._zoneBestKudoInfo = {}
	self._banPetVoteDic = {}
	self._defenseFormResMsg = nil
end

function PeakTournamentModel:handlePM_PeakTournamentGetQualifierInfoRes(msg)
	self._actId = msg.actId
	self._quaInfoMsg.rankScore = msg.rankScore
	self._quaInfoMsg.winStreak = msg.winStreak
	self._quaInfoMsg.dailyFightTimes = msg.dailyFightTimes
	self._quaInfoMsg.opponent = msg.opponent
end

function PeakTournamentModel:handlePM_PeakTournamentQualifierFightRes(msg)
	self._actId = msg.actId
	self._quaInfoMsg.newRankScore = msg.score
end

function PeakTournamentModel:handlePM_PeakTournamentQualifierRecordsRes(msg)
	self._actId = msg.actId
	self._quaRecordsMsg.recordInfoList = msg.records
end

function PeakTournamentModel:handlePM_PeakTournamentQualifierRankInfoRes(msg)
	self._quaRankMsg = msg
end

function PeakTournamentModel:handlePM_PeakTournamentQualifierTaskInfoRes(msg)
	self._actId = msg.actId
	self._taskInfoPool = {}

	for _, v in ipairs(msg.taskList) do
		self._taskInfoPool[v.taskId] = v
	end
end

function PeakTournamentModel:handlePM_PeakTournamentGainQualifierTaskPrizeRes(msg)
	for _, taskId in ipairs(msg.taskId or {}) do
		local info = self._taskInfoPool[taskId]

		if info then
			info.hasGainPrize = true
		end
	end
end

function PeakTournamentModel:handlePM_PeakTournamentQualifierVideoRes(msg)
	return
end

function PeakTournamentModel:handlePM_PeakTournamentKnockoutGetParticipationInfoRes(msg)
	self._partInfoMsg = msg
	self._roundGroupPool = {}

	for _, v in ipairs(msg.roundGroups) do
		self._roundGroupPool[v.roundId] = v.groupId
	end
end

function PeakTournamentModel:handlePM_PeakTournamentKnockoutGetMyScheduleInfoRes(msg)
	self._myScheduleMsg.isKnockout = msg.isKnockout

	if self._myScheduleMsg.resultInfoMo == nil then
		self._myScheduleMsg.resultInfoMo = PTBatResultInfoMo.New()
	end

	self._myScheduleMsg.resultInfoMo:init(msg.info)
end

function PeakTournamentModel:handlePM_PeakTournamentKnockoutGetMyBattleRecordsRes(msg)
	local resultInfoMoList = {}

	for _, v in ipairs(msg.records) do
		local resultInfoMo = PTBatResultInfoMo.New()

		resultInfoMo:init(v)
		table.insert(resultInfoMoList, resultInfoMo)
	end

	self._myBattleRecordsMsg.resultInfoMoList = resultInfoMoList
end

function PeakTournamentModel:handlePM_PeakTournamentKnockoutGetBattleVideoRes(status, msg)
	return
end

function PeakTournamentModel:handlePM_PeakTournamentSetFormRes(msg)
	if msg.defenseForm then
		self._defenseFormResMsg = msg
	else
		self._formResMsg = msg
	end

	if msg.autoSetOtherForm then
		if msg.defenseForm then
			self._formResMsg = msg
		else
			self._defenseFormResMsg = msg
		end
	end
end

function PeakTournamentModel:handlePM_PeakTournamentFormRes(msg)
	if msg.defenseForm then
		self._defenseFormResMsg = msg
	else
		self._formResMsg = msg
	end
end

function PeakTournamentModel:handlePM_PeakTournamentKnockoutGetGuessInfoRes(msg)
	self._guessInfoMsg.guessInfoList = msg.guessInfos
	self._guessInfoMsg.guessRoundIds = msg.guessRoundIds
	self._guessInfoMsg.resultInfoMoList = {}

	for _, guessInfo in ipairs(msg.guessInfos) do
		local resultInfoMo = PTBatResultInfoMo.New()

		resultInfoMo:init(guessInfo.battleInfo)
		table.insert(self._guessInfoMsg.resultInfoMoList, resultInfoMo)
	end
end

function PeakTournamentModel:handlePM_PeakTournamentKnockoutGuessRes(status, msg)
	return
end

function PeakTournamentModel:handlePM_PeakTournamentKnockoutGainGuessCoinRes(msg)
	return
end

function PeakTournamentModel:handlePM_PeakTournamentKnockoutGainGuessRecordRes(msg)
	self._guessRecordInfoPool[msg.roundId] = msg
end

function PeakTournamentModel:handlePM_PeakTournamentKnockoutGetGroupStageInfoRes(msg)
	for _, roundInfo in ipairs(msg.infos) do
		local groupInfoPool = {}

		for _, groupInfo in ipairs(roundInfo.groupinfos) do
			local stageInfoPool = {}

			for stageId, stageInfo in ipairs(groupInfo.infos) do
				stageInfoPool[stageId] = stageInfo
			end

			local resultInfoMoList = {}

			for _, v in ipairs(groupInfo.infos) do
				local resultInfoMo = PTBatResultInfoMo.New()

				resultInfoMo:init(v)
				table.insert(resultInfoMoList, resultInfoMo)
			end

			groupInfoPool[groupInfo.groupId] = {
				groupId = groupInfo.groupId,
				stageInfoPool = stageInfoPool,
				resultInfoMoList = resultInfoMoList
			}
		end

		self._roundInfoPool[roundInfo.roundId] = {
			roundId = roundInfo.roundId,
			groupInfoPool = groupInfoPool
		}
	end
end

function PeakTournamentModel:handlePM_PeakTournamentKnockoutGetTopViewRes(msg)
	self._views = GameUtil.pbToTable(msg) or {}
end

function PeakTournamentModel:getZonePtKnockoutGetTopView()
	return self._views.zoneRankInfo or {}
end

function PeakTournamentModel:getGlobalPtKnockoutGetTopView()
	return self._views.globalRankInfo or {}
end

function PeakTournamentModel:handlePM_PeakTournamentKudosRes(msg, isKudoGlobal)
	if isKudoGlobal == true then
		self._views.globalRankInfo.dailyKudosTimes = msg.dailyKudosTimes
		self._views.globalRankInfo.totalKudisTimes = msg.totalKudisTimes
	else
		self._views.zoneRankInfo.dailyKudosTimes = msg.dailyKudosTimes
		self._views.zoneRankInfo.totalKudisTimes = msg.totalKudisTimes
	end
end

function PeakTournamentModel:handlePM_PeakTournamentBanPetRes(msg)
	return
end

function PeakTournamentModel:handlePM_PeakTournamentBanPetInfoRes(msg)
	self._banPetInfo = msg.banPetInfo

	table.clear(self._banPetVoteDic)

	for i, v in ipairs(self._banPetInfo.raceIdAndVote) do
		self._banPetVoteDic[v.left] = v.right
	end
end

function PeakTournamentModel:getActivityId()
	return self._actId
end

function PeakTournamentModel:getPtBtlCustomFmtMo()
	if self._ptBtlCustomFmtMo == nil then
		self._ptBtlCustomFmtMo = PeakTournamentBattleCustomFmtMo.New()
	end

	return self._ptBtlCustomFmtMo
end

function PeakTournamentModel:getPtFmtCustomFmtMo()
	if self._ptFmtCustomFmtMo == nil then
		self._ptFmtCustomFmtMo = PeakTournamentFormationCustomFmtMo.New()
	end

	return self._ptFmtCustomFmtMo
end

function PeakTournamentModel:getRankScoreAsQua()
	return self._quaInfoMsg.rankScore or 0
end

function PeakTournamentModel:getWinStreakAsQua()
	if not self._quaInfoMsg.winStreak then
		return Mathf.Max(self._quaInfoMsg.winStreak, 0)
	end
end

function PeakTournamentModel:getDailyFightTimesAsQua()
	return self._quaInfoMsg.dailyFightTimes or 0
end

function PeakTournamentModel:getOpPlayerInfoAsQua()
	return self._quaInfoMsg.opponent
end

function PeakTournamentModel:getOpFormAsQua(formId)
	local res

	if self._quaInfoMsg.opponent then
		for _, form in ipairs(self._quaInfoMsg.opponent.forms) do
			if form.formId == formId then
				res = form

				break
			end
		end
	end

	if res == nil then
		printWarn(string.format("试图获取nil的敌方阵型信息,请检查( formId = %s )", formId))
	end

	return res
end

function PeakTournamentModel:getNewRankScoreAsQua()
	return self._quaInfoMsg.newRankScore or 0
end

function PeakTournamentModel:getMyRankAsQua()
	return self._quaRankMsg.myRank or 0
end

function PeakTournamentModel:getrankInfoListAsQua()
	return self._quaRankMsg.rankList or {}
end

function PeakTournamentModel:getTaskInfoAsQua(taskId)
	return self._taskInfoPool[taskId]
end

function PeakTournamentModel:getTaskCurProgressAsQua(taskId)
	local info = self:getTaskInfoAsQua(taskId)

	return (info or nil) and (info.curProgress or 0)
end

function PeakTournamentModel:isHasGainPrizeTaskAsQua(taskId)
	local info = self:getTaskInfoAsQua(taskId)

	return (info or nil) and (info.hasGainPrize or false)
end

function PeakTournamentModel:isParticipateAsPartInfo()
	return self._partInfoMsg.participate or false
end

function PeakTournamentModel:getRoundGroupsAsPartInfo()
	return self._partInfoMsg.roundGroups
end

function PeakTournamentModel:isInGroupAsPartInfo(roundId, groupId)
	return self._roundGroupPool[roundId] == groupId
end

function PeakTournamentModel:getGroupAsPartInfo(roundId)
	return self._roundGroupPool[roundId] or 0
end

function PeakTournamentModel:isKnockoutAsPartInfo()
	return self._partInfoMsg.isKnockout
end

function PeakTournamentModel:getPlayerOutRoundIdAsPartInfo()
	return self._partInfoMsg.outRoundId or 0
end

function PeakTournamentModel:getPlayerRankAsPartInfo()
	return self._partInfoMsg.rank or 0
end

function PeakTournamentModel:getCurIsKnockout()
	return self._myScheduleMsg.isKnockout or false
end

function PeakTournamentModel:getResultInfoMoInMySchedule()
	return self._myScheduleMsg.resultInfoMo
end

function PeakTournamentModel:getResultInfoMoListInMyBtlRecord()
	return self._myBattleRecordsMsg.resultInfoMoList
end

function PeakTournamentModel:getMyFormInfoList()
	return self._formResMsg and self._formResMsg.forms
end

function PeakTournamentModel:getMyFormBanRaceIds()
	return self._formResMsg and self._formResMsg.banRaceIds
end

function PeakTournamentModel:getMyDefenseFormInfoList()
	return self._defenseFormResMsg and self._defenseFormResMsg.forms
end

function PeakTournamentModel:getMyDefenseFormBanRaceIds()
	return self._defenseFormResMsg and self._defenseFormResMsg.banRaceIds
end

function PeakTournamentModel:getGuessInfoList()
	return self._guessInfoMsg.guessInfoList
end

function PeakTournamentModel:getHasVoteCount()
	local voteCount = 0
	local guessInfoList = self:getGuessInfoList()

	if guessInfoList then
		for _, guessInfo in ipairs(guessInfoList) do
			voteCount = voteCount + guessInfo.myGuessNum
		end
	end

	return voteCount
end

function PeakTournamentModel:getGuessInfoByIdx(guessInfoIndex)
	local guessInfo
	local guessInfoList = self:getGuessInfoList()

	return (guessInfoList or nil) and guessInfoList[guessInfoIndex]
end

function PeakTournamentModel:isHasGuessTheStage(stageIndex)
	local guessInfo = self:getGuessInfoByIdx(stageIndex)

	return (guessInfo and guessInfo.myGuessNum or nil) and guessInfo.myGuessNum > 0
end

function PeakTournamentModel:isHasGuessTheUser(targetUserId)
	local isHasGuess = false
	local guessInfoList = self:getGuessInfoList()

	if guessInfoList then
		for _, guessInfo in ipairs(guessInfoList) do
			if guessInfo.myGuessTargetId == targetUserId then
				isHasGuess = true
			end
		end
	end

	return isHasGuess
end

function PeakTournamentModel:getCanGainCoinRoundIdList()
	return self._guessInfoMsg.guessRoundIds
end

function PeakTournamentModel:isCanGainGuessCoinAsRound(roundId)
	local isCanGain = false

	for _, v in ipairs(self._guessInfoMsg.guessRoundIds) do
		if v == roundId then
			isCanGain = true

			break
		end
	end

	return isCanGain
end

function PeakTournamentModel:isHaveCanGainGuessCoinAsPT()
	return #self._guessInfoMsg.guessRoundIds > 0
end

function PeakTournamentModel:getResultInfoMoListAsGuess()
	return self._guessInfoMsg.resultInfoMoList or {}
end

function PeakTournamentModel:getResultInfoMoAsGuess(index)
	return self._guessInfoMsg.resultInfoMoList[index]
end

function PeakTournamentModel:getGuessRecordInfoList(roundId)
	return (self._guessRecordInfoPool[roundId] or nil) and self._guessRecordInfoPool[roundId].infos
end

function PeakTournamentModel:getRoundInfoAsEli(roundId)
	return self._roundInfoPool[roundId]
end

function PeakTournamentModel:getGroupInfoAsEli(roundId, groupId)
	local roundInfo = self:getRoundInfoAsEli(roundId)
	local groupInfo

	return (roundInfo or nil) and roundInfo.groupInfoPool[groupId]
end

function PeakTournamentModel:getResultInfoMo(roundId, groupId, stageId)
	local resultInfoMo
	local groupInfo = self:getGroupInfoAsEli(roundId, groupId)

	return (groupInfo or nil) and groupInfo.resultInfoMoList[stageId]
end

function PeakTournamentModel:getBanPetInfo()
	return self._banPetInfo
end

function PeakTournamentModel:getVoteOfBanPet(raceId)
	return self._banPetVoteDic[raceId] or 0
end

function PeakTournamentModel:isHaveVoteOfBanPet()
	if self._banPetInfo then
		return self._banPetInfo and #self._banPetInfo > 0 or false
	end
end

function PeakTournamentModel:getBanRaceIds()
	return (self._banPetInfo or nil) and (self._banPetInfo.banRaceIds or {})
end

PeakTournamentModel.instance = PeakTournamentModel.New()

return PeakTournamentModel
