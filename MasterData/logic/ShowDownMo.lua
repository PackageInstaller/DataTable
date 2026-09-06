-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/showdown/data/ShowDownMo.lua

module("logic.extensions.showdown.data.ShowDownMo", package.seeall)

local ShowDownMo = class("ShowDownMo")

function ShowDownMo:ctor(activityId)
	self._activityId = activityId
	self._petShopMos = {}
	self._curChallengeTimesInQualify = 0
	self._curChallengeTimesInFunc = 0
	self._mainRaceInfoMos = {}
	self._mainRaceInfoMoInFinals = {}
	self._isGainDailyGuessItem = false
	self._changeSetIdsInQual = {}
	self._myScoreInFunc = 0
	self._myRankInFunc = 0
	self._winCountInFunc = 0
	self._loseCountInFunc = 0
	self._battleRecordsInFunc = {}
	self._playerRoundId = 0
	self._scheduleInfoInQualify = ShowDownScheduleInfoInQualify.New()
	self._scheduleInfoInElimate = ShowDownScheduleInfoInEliminate.New()
	self._scheduleInfoInFinal = ShowDownScheduleInfoInFinal.New()
	self._myFinalRank = -1
	self._curStepId = 0
	self._battleOrderMoDic = {}
	self._searchResults = {}
	self._searchStartId = -1
	self._searchEndId = -1
	self._isGetAllSearchResult = false
	self._applyInfos = {}
	self._curHandleApplyInfo = nil
	self._lastInquireBattleRecords = {}
	self._inputRecuit = {}
	self._teamSimpleViewMoListInMe = {}
	self._teamMemberViewMoListInMe = {}
	self._finalResultInfos = {}
	self._isNeedGuessInAct = false

	local stepCfg = ShowDownConfig.instance:getStepCfg(activityId)

	for _, data in ipairs(stepCfg) do
		if data.canGuess then
			self._isNeedGuessInAct = true

			break
		end
	end
end

function ShowDownMo:getActivityId()
	return self._activityId
end

function ShowDownMo:handlePM_ShowDown_SetWishListRes(msg)
	local roundId = msg.round.roundId
	local petShopMo = self:getPetShopMo(roundId)

	petShopMo:updateDataByPetRepo(msg.curRepo)
end

function ShowDownMo:handlePM_ShowDown_RollPetsRes(msg)
	local roundId = msg.round.roundId
	local petShopMo = self:getPetShopMo(roundId)

	petShopMo:updateDataByPetRepo(msg.repo)
	petShopMo:setCurRefreshTimes(msg.hasReRollTimes)
end

function ShowDownMo:handlePM_ShowDown_ConfirmPetsRes(msg)
	local roundId = msg.round.roundId
	local petShopMo = self:getPetShopMo(roundId)

	petShopMo:setIsHasConfirm(true)
	petShopMo:setCurRefreshTimes(0)
end

function ShowDownMo:handlePM_ShowDown_SetFormRes(msg)
	return
end

function ShowDownMo:handlePM_ShowDown_ResetPetsAndFormRes(msg)
	local roundId = msg.round.roundId
	local petShopMo = self:getPetShopMo(roundId)

	petShopMo:onReset()
	petShopMo:setCurResetTimes(msg.resetTimes)
end

function ShowDownMo:handlePM_ShowDown_GainDailyGuessItemRes(msg)
	self._isGainDailyGuessItem = true
end

function ShowDownMo:handlePM_ShowDownTeam_GetPlayerViewRes(msg)
	self._tmepPlayerInfo = GameUtil.pbToTable(msg)
end

function ShowDownMo:handlePM_ShowDownQualify_StartMatchingRes(msg)
	return
end

function ShowDownMo:handlePM_ShowDownQualify_CancelMatchingRes(msg)
	return
end

function ShowDownMo:handlePM_ShowDownQualify_GetQualifyRankRes(msg)
	return
end

function ShowDownMo:handlePM_ShowDownQualify_NotifyMatchBattleResultRes(msg)
	local qualType = msg.detail.type

	self._changeSetIdsInQual[qualType] = msg.detail.changeSetId
end

function ShowDownMo:handlePM_ShowDownQualify_GetQualifyBattleVideoRes(msg)
	return
end

function ShowDownMo:handlePM_ShowDownQualify_NotifyMatchFailRes(msg)
	return
end

function ShowDownMo:handlePM_ShowDownTeam_SetMyTeamInfoRes(msg)
	return
end

function ShowDownMo:handlePM_ShowDownTeam_GetOtherGroupInfoRes(msg)
	return
end

function ShowDownMo:handlePM_ShowDownTeam_GetTeamMemberInfoRes(msg)
	return
end

function ShowDownMo:handlePM_ShowDownTeam_SendEnlistMsgRes(msg)
	return
end

function ShowDownMo:handlePM_ShowDownTeam_GetMyTeamApplyListRes(msg)
	self._applyInfos = {}

	for _, info in ipairs(msg.applyList) do
		local data = {
			applyState = 0,
			headInfo = info.headInfo,
			winCount = info.winLoseMark.left,
			loseCount = info.winLoseMark.right
		}

		table.insert(self._applyInfos, data)
	end
end

function ShowDownMo:handlePM_ShowDownTeam_GetOrRefreshTeamListRes(msg)
	self._teamSimpleViewMoListInMe = {}

	for i, v in ipairs(msg.teamList) do
		local simpleMo = ShowDownTeamSimpleViewMo.New()

		simpleMo:updateData(v.simpleView)
		table.insert(self._teamSimpleViewMoListInMe, simpleMo)

		local memberViewMo = ShowDownTeamMemberViewMo.New()

		memberViewMo:updateData(v.memberView)
		table.insert(self._teamMemberViewMoListInMe, memberViewMo)

		self._teamMemberViewMoListInMe = {}
	end
end

function ShowDownMo:getTeamList()
	return self._teamSimpleViewMoListInMe
end

function ShowDownMo:handlePM_ShowDownTeam_SearchTeamRes(msg)
	self._searchResults = {}

	for _, result in ipairs(msg.teamList) do
		table.insert(self._searchResults, result)
	end

	if #msg.teamList < 10 then
		self._isGetAllSearchResult = true
	end

	self._searchStartId = msg.beginIndex
	self._searchEndId = msg.endIndex
end

function ShowDownMo:handlePM_ShowDownTeam_QuickJoinRes(msg)
	return
end

function ShowDownMo:handlePM_ShowDownTeam_JoinRes(msg)
	return
end

function ShowDownMo:handlePM_ShowDownTeam_HandleApplyRes(msg)
	local info = GameUtil.pbToTable(msg)

	if self._curHandleApplyInfo then
		if info.handled then
			if self._curHandleApplyInfo.applyState == 0 then
				self._curHandleApplyInfo.applyState = info.sucJoinTeam and 1 or -2
			end
		else
			self._curHandleApplyInfo.applyState = 0
		end
	end
end

function ShowDownMo:handlePM_ShowDown_NotifyJoinTeamRes(msg)
	return
end

function ShowDownMo:handlePM_ShowDown_GetQualifyMainInfoRes(msg)
	local qulifyMainInfo = msg.qulifyMainInfo
	local repoAndForm = msg.qulifyMainInfo.repoAndForm

	self._curChallengeTimesInQualify = qulifyMainInfo.hasChallengeTimes

	local petShopMo = self:getPetShopMo(ShowDownEnum.Round_Qualify)

	petShopMo:updateDataByPetRepo(repoAndForm.petRepo)
	petShopMo:setCurRefreshTimes(repoAndForm.hasReRollTimes)
	petShopMo:setCurResetTimes(repoAndForm.resetTimes)
	petShopMo:updateDataByIdFormList(repoAndForm.formation)
end

function ShowDownMo:handlePM_ShowDown_GetJoyModeInfoRes(msg)
	local repoAndForm = msg.repoAndForm
	local petShopMo = self:getPetShopMo(ShowDownEnum.Round_Func)

	petShopMo:updateDataByPetRepo(repoAndForm.petRepo)
	petShopMo:setCurRefreshTimes(repoAndForm.hasReRollTimes)
	petShopMo:setCurResetTimes(repoAndForm.resetTimes)
	petShopMo:updateDataByIdFormList(repoAndForm.formation)

	self._myScoreInFunc = msg.myScore
	self._myRankInFunc = msg.myRank
	self._winCountInFunc = msg.winLoseMark.left
	self._loseCountInFunc = msg.winLoseMark.right

	local length = #self._battleRecordsInFunc
	local recordsLength = #msg.records

	for index, data in ipairs(msg.records) do
		local record = self._battleRecordsInFunc[index]

		if record == nil then
			record = ShowDownBattleRecord.New()
			self._battleRecordsInFunc[index] = record
		end

		record:updateData(data)
	end

	for index = recordsLength + 1, length do
		self._battleRecordsInFunc[index] = nil
	end
end

function ShowDownMo:handlePM_ShowDown_GetTeamMainInfoRes(msg)
	local groupInfo = msg.teamMainInfo.groupInfo
	local gainDailyGuessItem = msg.teamMainInfo.gainDailyGuessItem
	local hasApply = msg.teamMainInfo.hasApply
	local hasSendEnlistEver = msg.teamMainInfo.hasSendEnlistEver
	local myTeamId = msg.teamMainInfo.myTeamId
	local isLeader = msg.teamMainInfo.isLeader
	local mainRaceInfoMo = self:getMainRaceInfoMo(ShowDownEnum.Round_Eliminate_Group)

	mainRaceInfoMo:updateDataOfTeamList(groupInfo.groupId, groupInfo.teamList)
	mainRaceInfoMo:setIsHasApply(hasApply)
	mainRaceInfoMo:setIsHasSendEnlistEver(hasSendEnlistEver)
	mainRaceInfoMo:setMyTeamId(myTeamId)
	mainRaceInfoMo:setIsLeader(isLeader)

	self._isGainDailyGuessItem = checkbool(gainDailyGuessItem)
end

function ShowDownMo:handlePM_ShowDown_GetMainInfoRes(msg)
	local roundId = msg.curRoundId
	local groupId = msg.groupId
	local repoAndForm = msg.repoAndForm
	local mainRaceInfoMo = self:getMainRaceInfoMo(roundId)

	mainRaceInfoMo:updateDataOfTeamList(groupId, msg.teamViewList)

	for _, v in ipairs(msg.roundList) do
		local mainRaceInfoMoInFinal = self:getMainRaceInfoMoInFinal(v.roundId)

		mainRaceInfoMoInFinal:updateDataOfRoundInfoList(groupId, v.matchSchedule)
	end

	local petShopMo = self:getPetShopMo(roundId)

	petShopMo:updateDataByPetRepo(repoAndForm.petRepo)
	petShopMo:setCurRefreshTimes(repoAndForm.hasReRollTimes)
	petShopMo:setCurResetTimes(repoAndForm.resetTimes)
	petShopMo:updateDataByIdFormList(repoAndForm.formation)

	self._isGainDailyGuessItem = checkbool(msg.gainDailyGuessItem)
end

function ShowDownMo:handlePM_ShowDown_GetScheduleInfoRes(msg)
	self._playerRoundId = msg.playerRoundId

	self._scheduleInfoInQualify:updateData(msg)
	self._scheduleInfoInElimate:updateData(msg)
	self._scheduleInfoInFinal:updateData(msg)

	self._myFinalRank = checknumber(msg.myFinalRank)
end

function ShowDownMo:handlePM_ShowDownKnockout_GetBattleOrderRes(msg)
	local roundId = msg.roundId
	local battleOrderMo = self:getBattleOrderMo(roundId)

	battleOrderMo:updateData(msg)
end

function ShowDownMo:handlePM_ShowDownKnockout_AdjustBattleOrderRes(msg)
	return
end

function ShowDownMo:handlePM_ShowDown_GetGuessRecordRes(msg)
	self._guessInfo = GameUtil.pbToTable(msg)
	self._guessRoundInfo = {}
	self._allGuessInfos = {}

	for i, v in ipairs(self._guessInfo.guessRecord or {}) do
		if not self._guessRoundInfo[v.roundId] then
			local roundInfo = {}

			if not roundInfo.allInfos then
				local roundInfoList = {}

				if not roundInfo.groupHash then
					local roundInfoGroupHash = {}

					if not roundInfoGroupHash[v.teamInfo.groupId] then
						local groupCount = 0

						table.insert(roundInfoList, v)

						groupCount = groupCount + 1
						roundInfo[v.teamInfo.teamInfo.teamId] = v
						roundInfoGroupHash[v.teamInfo.groupId] = groupCount
						roundInfo.groupHash = roundInfoGroupHash
						roundInfo.allInfos = roundInfoList
						self._guessRoundInfo[v.roundId] = roundInfo

						table.insert(self._allGuessInfos, v)
					end
				end
			end
		end
	end

	self._guessFinalRoundInfos = {}
	self._guessFinalRoundHash = {}

	if not self._guessInfo.finalMatchGuessList then
		for _, info in ipairs(self._guessInfo.finalMatchGuessList) do
			local simpleMo = ShowDownTeamSimpleViewMo.New()

			simpleMo:updateData(info.teanView)

			info.simpleMo = simpleMo

			if info.guessRank >= 1 then
				self._guessFinalRoundHash[info.guessRank] = info
			end

			table.insert(self._guessFinalRoundInfos, info)
		end
	end
end

function ShowDownMo:handlePM_ShowDown_GuessRes(msg)
	return
end

function ShowDownMo:handlePM_ShowDown_GetDisplayInfoRes(msg)
	local info = GameUtil.pbToTable(msg)

	self._finalResultInfos = {}

	for _, info in ipairs(info.teamViewList or {}) do
		self._finalResultInfos[info.rank] = info
	end
end

function ShowDownMo:handlePM_ShowDown_GetBattleRecordsRes(msg)
	local length = #self._lastInquireBattleRecords
	local recordsLength = #msg.records

	for index, data in ipairs(msg.records) do
		local record = self._lastInquireBattleRecords[index]

		if record == nil then
			record = ShowDownBattleRecord.New()
			self._lastInquireBattleRecords[index] = record
		end

		record:updateData(data)
	end

	for index = recordsLength + 1, length do
		self._lastInquireBattleRecords[index] = nil
	end
end

function ShowDownMo:handlePM_ShowDown_FinalMatchGuessRes(msg)
	return
end

function ShowDownMo:handlePM_ShowDown_GetStepInfoRes(msg)
	self._curStepId = msg.stepInfo.curStepId
end

function ShowDownMo:handlePM_ShowDown_NotifyStepChangeRes(msg)
	self._curStepId = msg.stepInfo.curStepId
end

function ShowDownMo:getCurStepId()
	return self._curStepId
end

function ShowDownMo:isNeedGuessInAct()
	return self._isNeedGuessInAct
end

function ShowDownMo:getGuessInfos()
	return self._allGuessInfos or {}
end

function ShowDownMo:getGuessInfoByRound(roundId)
	return (self._guessRoundInfo and self._guessRoundInfo[roundId] or nil) and (self._guessRoundInfo[roundId].allInfos or {})
end

function ShowDownMo:getGuessInfoByTeamId(roundId, teamId)
	if self._guessRoundInfo and self._guessRoundInfo[roundId] and self._guessRoundInfo[roundId][teamId] then
		return self._guessRoundInfo[roundId][teamId]
	end

	return nil
end

function ShowDownMo:getGuessCountByGroupId(roundId, groupId)
	return (self._guessRoundInfo and self._guessRoundInfo[roundId] and self._guessRoundInfo[roundId].groupHash or nil) and (self._guessRoundInfo[roundId].groupHash[groupId] or 0)
end

function ShowDownMo:getGuessValue(roundId, teamId)
	local guessInfo = self:getGuessInfoByTeamId(roundId, teamId)

	return (guessInfo or nil) and checknumber(guessInfo.guessValue)
end

function ShowDownMo:getTotalGuessValue(roundId, teamId)
	local guessInfo = self:getGuessInfoByTeamId(roundId, teamId)

	return (guessInfo or nil) and checknumber(guessInfo.totalGuessValue)
end

function ShowDownMo:getVoteResult(roundId, teamId)
	local guessInfo = self:getGuessInfoByTeamId(roundId, teamId)

	return (guessInfo or nil) and checknumber(guessInfo.result)
end

function ShowDownMo:getPetShopMo(roundId)
	if self._petShopMos[roundId] == nil then
		self._petShopMos[roundId] = ShowDownPetShopMo.New(self._activityId, roundId)
	end

	return self._petShopMos[roundId]
end

function ShowDownMo:getMainRaceInfoMo(roundId)
	if self._mainRaceInfoMos[roundId] == nil then
		self._mainRaceInfoMos[roundId] = ShowDownMainRaceInfoMo.New()
	end

	return self._mainRaceInfoMos[roundId]
end

function ShowDownMo:getMainRaceInfoMoInFinal(roundId)
	if self._mainRaceInfoMoInFinals[roundId] == nil then
		self._mainRaceInfoMoInFinals[roundId] = ShowDownMainRaceInfoMoInFinal.New()
	end

	return self._mainRaceInfoMoInFinals[roundId]
end

function ShowDownMo:isGainDailyGuessItem()
	return self._isGainDailyGuessItem
end

function ShowDownMo:getChangeSetIdListInQualify()
	return TableUtil.toList(self._changeSetIdsInQual)
end

function ShowDownMo:clearChangeSetIdListInQualify()
	table.clear(self._changeSetIdsInQual)
end

function ShowDownMo:getChangeSetIdInQualify(qualType)
	return self._changeSetIdsInQual[qualType]
end

function ShowDownMo:clearChangeSetIdInQualify(qualType)
	self._changeSetIdsInQual[qualType] = nil
end

function ShowDownMo:getBattleOrderMo(roundId)
	if self._battleOrderMoDic[roundId] == nil then
		self._battleOrderMoDic[roundId] = ShowDownBattleOrderMo.New()
	end

	return self._battleOrderMoDic[roundId]
end

function ShowDownMo:getPlayerRoundId()
	return self._playerRoundId
end

function ShowDownMo:getCurChallengeTimesInQualify(qualType)
	if qualType == ShowDownEnum.QualType_Normal then
		return self._curChallengeTimesInQualify
	else
		return self._curChallengeTimesInFunc
	end
end

function ShowDownMo:getScheduleInfoInQualify()
	return self._scheduleInfoInQualify
end

function ShowDownMo:getScheduleInfoInElimate()
	return self._scheduleInfoInElimate
end

function ShowDownMo:getScheduleInfoInFinal()
	return self._scheduleInfoInFinal
end

function ShowDownMo:getTempPlayerInfo()
	return self._tmepPlayerInfo
end

function ShowDownMo:getMyFinalRank()
	return self._myFinalRank
end

function ShowDownMo:getMyScoreInFunc()
	return self._myScoreInFunc
end

function ShowDownMo:getMyRankInFunc()
	return self._myRankInFunc
end

function ShowDownMo:getWinCountInFunc()
	return self._winCountInFunc
end

function ShowDownMo:getLoseCountInFunc()
	return self._loseCountInFunc
end

function ShowDownMo:getBattleRecordsInFunc()
	return self._battleRecordsInFunc
end

function ShowDownMo:getSearchResultParams()
	return self._searchResults, self._searchStartId, self._searchEndId, self._isGetAllSearchResult
end

function ShowDownMo:resetSearchResultParams()
	self._searchResults = {}
	self._isGetAllSearchResult = false
	self._searchStartId = -1
	self._searchEndId = -1
end

function ShowDownMo:getTeamApplyInfos()
	return self._applyInfos or {}
end

function ShowDownMo:setCurHandleApplyInfo(info)
	if table.keyof(self._applyInfos, info) then
		self._curHandleApplyInfo = info
	end
end

function ShowDownMo:getCurHandleApplyInfo()
	return self._curHandleApplyInfo
end

function ShowDownMo:getLastInquireBattleRecords()
	return self._lastInquireBattleRecords or {}
end

function ShowDownMo:setInputRecuit(left, right, winCount, ownRaceCount)
	self._inputRecuit.left = left
	self._inputRecuit.right = right
	self._inputRecuit.winCount = winCount
	self._inputRecuit.ownRaceCount = ownRaceCount
end

function ShowDownMo:getInputRecuit()
	return self._inputRecuit
end

function ShowDownMo:getFinalResultInfos()
	return self._finalResultInfos
end

function ShowDownMo:getFinalRoundGuessInfos()
	return self._guessFinalRoundInfos or {}
end

function ShowDownMo:getFinalRoundGuessInfoHash()
	return self._guessFinalRoundHash or {}
end

return ShowDownMo
