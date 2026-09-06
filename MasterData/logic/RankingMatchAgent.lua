-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rankrace/agent/RankingMatchAgent.lua

module("logic.extensions.rankrace.agent.RankingMatchAgent", package.seeall)

local RankingMatchAgent = class("RankingMatchAgent", BaseAgent)

function RankingMatchAgent:sendRM_OpenRankingMatchReq(matchType)
	local req = RankingMatchExtension_pb.RM_OpenRankingMatchReq()

	req.matchType = matchType

	self:sendMsg(req)
end

function RankingMatchAgent:handleRM_OpenRankingMatchRes(status, msg)
	if status == 0 then
		RankRaceController.instance:setOpenRankingMatchData(msg)
	end
end

function RankingMatchAgent:sendRM_AutoSetDefenseFormReq(matchType)
	local req = RankingMatchExtension_pb.RM_AutoSetDefenseFormReq()

	req.matchType = matchType

	self:sendMsg(req)
end

function RankingMatchAgent:handleRM_AutoSetDefenseFormRes(status, msg)
	if status == 0 then
		local buffid = msg.buffId

		RankRaceFmtController.instance:onAutoSetDefenseFormRes(buffid)
	end
end

function RankingMatchAgent:sendRM_SetDefenseFormReq(matchType, form_pb)
	local req = RankingMatchExtension_pb.RM_SetDefenseFormReq()

	req.matchType = matchType

	if form_pb ~= nil then
		req.form:ParseFromString(form_pb:SerializeToString())
	end

	self:sendMsg(req)
end

function RankingMatchAgent:handleRM_SetDefenseFormRes(status, msg)
	if status == 0 then
		RankRaceFmtController.instance:onSetDefenseFormRes()
	else
		GlobalDispatcher:dispatch(GlobalNotify.OneKeySetDefenseSaveFmtFailed)
	end
end

function RankingMatchAgent:sendRM_BeginMatchingReq(matchType)
	local req = RankingMatchExtension_pb.RM_BeginMatchingReq()

	req.matchType = matchType

	self:sendMsg(req)
end

function RankingMatchAgent:handleRM_BeginMatchingRes(status, msg)
	if status == 0 then
		UIStateManager.instance:push(ViewName.RankRaceFindEnemyView)
	end
end

function RankingMatchAgent:sendRM_CancelMatchingReq()
	local req = RankingMatchExtension_pb.RM_CancelMatchingReq()

	self:sendMsg(req)
end

function RankingMatchAgent:handleRM_CancelMatchingRes(status, msg)
	if status == 0 then
		RankRaceController.instance:closeFindEnemyView()
	elseif status == -5209 and RankRaceController.instance:getNotifyBeginGameResData() then
		RankRaceController.instance:matchComplete()
	end
end

function RankingMatchAgent:sendRM_ReadyFightReq(view, form)
	local req = RankingMatchExtension_pb.RM_ReadyFightReq()

	self._tempView = view

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function RankingMatchAgent:handleRM_ReadyFightRes(status, msg)
	if status == 0 then
		-- block empty
	elseif status == -5207 and RankRaceModel.instance:getRecordflag() then
		self._tempView:close()
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function RankingMatchAgent:sendRM_ChatReq(chatMsg)
	local req = RankingMatchExtension_pb.RM_ChatReq()

	req.chatMsg = chatMsg

	self:sendMsg(req)
end

function RankingMatchAgent:handleRM_ChatRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function RankingMatchAgent:sendRM_LeaveGameReq()
	local req = RankingMatchExtension_pb.RM_LeaveGameReq()

	self:sendMsg(req)
end

function RankingMatchAgent:handleRM_LeaveGameRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function RankingMatchAgent:sendRM_GetBattleRecordReq(matchType)
	local req = RankingMatchExtension_pb.RM_GetBattleRecordReq()

	req.matchType = matchType

	self:sendMsg(req)
end

function RankingMatchAgent:handleRM_GetBattleRecordRes(status, msg)
	if status == 0 then
		RankRaceModel.instance:setRecordflag(true)
		RankRaceController.instance:getBattleRecordRes(msg)
	end
end

function RankingMatchAgent:sendRM_GetBattleVideoReq(myAttackBattleId, opAttackBattleId)
	local req = RankingMatchExtension_pb.RM_GetBattleVideoReq()

	req.myAttackBattleId = myAttackBattleId
	req.opAttackBattleId = opAttackBattleId

	self:sendMsg(req)
end

function RankingMatchAgent:handleRM_GetBattleVideoRes(status, msg)
	if status == 0 then
		RankRaceController.instance:operView(ViewName.RankRaceBattleReportView, function(_view)
			_view:showReportDetailView(msg.myAttackBattleResult, msg.opAttackBattleResult)
		end)
	end
end

function RankingMatchAgent:sendRM_GetMyDefenseFormReq(matchType)
	local req = RankingMatchExtension_pb.RM_GetMyDefenseFormReq()

	req.matchType = matchType

	self:sendMsg(req)
end

function RankingMatchAgent:handleRM_GetMyDefenseFormRes(status, msg)
	if status == 0 then
		local simpleform = msg.simpleForm
		local defensebuffid = msg.defenseBuffId

		RankRaceFmtController.instance:onGetMyDefenseForm(simpleform, defensebuffid)
		GlobalDispatcher:dispatch(GlobalNotify.RankingMatchGetMyDefenseFormRes)
	end
end

function RankingMatchAgent:handleRM_NotifyBeginGameRes(status, msg)
	if status == 0 then
		RankRaceController.instance:setNotifyBeginGameResData(msg)
		RankRaceController.instance:matchComplete()
	end
end

function RankingMatchAgent:handleRM_NotifyMatchingOverTimeRes(status, msg)
	if status == 0 then
		RankRaceController.instance:matchFail()
	end
end

function RankingMatchAgent:handleRM_NotifyMatchFailRes(status, msg)
	if status == 0 then
		RankRaceController.instance:matchFail()
	end
end

function RankingMatchAgent:handleRM_NotifyGameResult(status, msg)
	if status == 0 then
		RankRaceResultController.instance:notifyGameResult(msg)
		RankRaceController.instance:notifyGameResult(msg)

		if msg and msg.state then
			if msg.state == RankRaceResultModel.State_Exit then
				FloatWordMgr.instance:show(RankRaceConfig.instance:getWord(26))
			elseif msg.state == RankRaceResultModel.State_PlayerExit then
				FloatWordMgr.instance:show(RankRaceConfig.instance:getWord(27))
			end
		end
	end
end

function RankingMatchAgent:handleRM_NotifyOpReadyFight(status, msg)
	if status == 0 then
		RankRaceFmtController.instance:notifyOpReadyFight()
	end
end

function RankingMatchAgent:sendPM_GetRMLegendRankReq(matchType, startRank, endRank, space)
	local req = RankingMatchExtension_pb.PM_GetRMLegendRankReq()

	req.matchType = matchType
	req.startRank = startRank
	req.endRank = endRank
	req.space = checkbool(space)
	self._isLegendSpace = space

	self:sendMsg(req)
end

function RankingMatchAgent:handlePM_GetRMLegendRankRes(status, msg)
	if status == 0 then
		local dumpMsg = NetConnMgr.instance:_dumpMsg(msg)
		local matchType = msg.matchType
		local data = {}

		data.myRank = msg.myRank
		data.legendTimes = msg.legendTimes
		data.rankList = msg.infoList

		local tabIndex = self._isLegendSpace and 1 or 2

		if matchType == RankRaceController.MatchTypeClassics then
			RankRaceController.instance:setRankMo(data, GameEnum.RankType.RankMatchClass, tabIndex)
			RankModel.instance:setRankData(data, GameEnum.RankType.RankMatchClass, tabIndex)
		elseif matchType == RankRaceController.MatchTypeLimit then
			RankRaceController.instance:setRankMo(data, GameEnum.RankType.RankMatchLimit, tabIndex)
			RankModel.instance:setRankData(data, GameEnum.RankType.RankMatchLimit, tabIndex)
		end

		GlobalDispatcher:dispatch(GlobalNotify.RankDataGet)
	end
end

function RankingMatchAgent:sendPM_GetRMDefenseDetailReq(userId, matchType)
	local req = RankingMatchExtension_pb.PM_GetRMDefenseDetailReq()

	req.userId = userId
	req.matchType = matchType

	self:sendMsg(req)
end

function RankingMatchAgent:handlePM_GetRMDefenseDetailRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function RankingMatchAgent:sendPM_GetRMPetRaceRankReq(matchType, winRank, startRank, endRank)
	local req = RankingMatchExtension_pb.PM_GetRMPetRaceRankReq()

	req.matchType = matchType
	req.winRank = winRank
	req.startRank = startRank
	req.endRank = endRank

	print("1044200312 精灵榜 matchType,winRank,startRank,endRank:", matchType, winRank, startRank, endRank)
	self:sendMsg(req)
end

function RankingMatchAgent:handlePM_GetRMPetRaceRankRes(status, msg)
	if status == 0 then
		local dumpMsg = NetConnMgr.instance:_dumpMsg(msg)
		local infolist = msg.infoList
		local matchType = msg.matchType
		local winRank = msg.winRank
		local data = {}

		data.rankList = {}

		for i = 1, #infolist do
			local petCo = CharacterConfig.instance:getPetCo(infolist[i].raceId)
			local var_34_0 = {
				raceId = infolist[i].raceId,
				winRate = infolist[i].winRate,
				winTimes = infolist[i].winTimes,
				fightTimes = infolist[i].fightTimes,
				oldRank = infolist[i].oldRank,
				rank = infolist[i].rank
			}

			var_34_0.petName = petCo.name or ""
			data.rankList[i] = var_34_0
		end

		local tabIndex = winRank and 3 or 4

		if matchType == RankRaceController.MatchTypeClassics then
			RankRaceController.instance:setRankMo(data, GameEnum.RankType.RankMatchClass, tabIndex)
			RankModel.instance:setRankData(data, GameEnum.RankType.RankMatchClass, tabIndex)
		elseif matchType == RankRaceController.MatchTypeLimit then
			RankRaceController.instance:setRankMo(data, GameEnum.RankType.RankMatchLimit, tabIndex)
			RankModel.instance:setRankData(data, GameEnum.RankType.RankMatchLimit, tabIndex)
		end

		GlobalDispatcher:dispatch(GlobalNotify.RankDataGet)
	end
end

function RankingMatchAgent:sendRM_GetMyDeclarationReq()
	local req = RankingMatchExtension_pb.RM_GetMyDeclarationReq()

	self:sendMsg(req)
end

function RankingMatchAgent:handleRM_GetMyDeclarationRes(status, msg)
	if status == 0 then
		local winbit = msg.winBit
		local losebit = msg.loseBit
		local _winBitData = RankRaceModel.instance:_decimal10ToDecimal2(winbit)
		local _winData = RankRaceModel.instance:_decimal2ToData(tostring(_winBitData))

		RankRaceModel.instance:setCheckData(1, _winData)

		local _loseBitData = RankRaceModel.instance:_decimal10ToDecimal2(losebit)
		local _loseData = RankRaceModel.instance:_decimal2ToData(tostring(_loseBitData))

		RankRaceModel.instance:setCheckData(2, _loseData)
		RankRaceController.instance:updateDeclareView()
	end
end

function RankingMatchAgent:sendRM_SetMyDeclarationReq(winBit, loseBit)
	local req = RankingMatchExtension_pb.RM_SetMyDeclarationReq()

	req.winBit = winBit
	req.loseBit = loseBit

	self:sendMsg(req)
end

function RankingMatchAgent:handleRM_SetMyDeclarationRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function RankingMatchAgent:sendRM_GetAllInformationReq()
	local req = RankingMatchExtension_pb.RM_GetAllInformationReq()

	self:sendMsg(req)
end

function RankingMatchAgent:handleRM_GetAllInformationRes(status, msg)
	if status == 0 then
		local infos = msg.infos

		RankRaceController.instance:updateMyInfoView(infos)
	end
end

function RankingMatchAgent:sendRM_GetAllTaskReq(matchType)
	local req = RankingMatchExtension_pb.RM_GetAllTaskReq()

	req.matchType = matchType

	self:sendMsg(req)
end

function RankingMatchAgent:handleRM_GetAllTaskRes(status, msg)
	if status == 0 then
		RankRaceController.instance:updateRewardView(msg)
	end
end

function RankingMatchAgent:sendRM_GainTaskPrizeReq(taskId_i32_Ary)
	local req = RankingMatchExtension_pb.RM_GainTaskPrizeReq()

	for _, v in ipairs(taskId_i32_Ary or {}) do
		req.taskId:append(v)
	end

	self:sendMsg(req)
end

function RankingMatchAgent:handleRM_GainTaskPrizeRes(status, msg)
	if status == 0 then
		RankRaceController.instance:gainTaskPrizeSucc(msg)
	end
end

function RankingMatchAgent:sendRM_CheckLastSeasonPrizeReq()
	local req = RankingMatchExtension_pb.RM_CheckLastSeasonPrizeReq()

	self:sendMsg(req)
end

function RankingMatchAgent:handleRM_CheckLastSeasonPrizeRes(status, msg)
	if status == 0 then
		RankRaceController.instance:checkLastSeasonPrize(msg)
	end
end

function RankingMatchAgent:sendRM_RefreshMyLocalRankReq(matchType)
	local req = RankingMatchExtension_pb.RM_RefreshMyLocalRankReq()

	req.matchType = matchType

	self:sendMsg(req)
end

function RankingMatchAgent:handleRM_RefreshMyLocalRankRes(status, msg)
	if status == 0 then
		RankRaceController.instance:refreshMyLocalRankRes(msg)
	end
end

function RankingMatchAgent:sendRM_BanPetReq(seasonId, raceIds)
	local req = RankingMatchExtension_pb.RM_BanPetReq()

	req.seasonId = seasonId

	for _, v in ipairs(raceIds) do
		req.raceIds:append(v)
	end

	self:sendMsg(req)
end

function RankingMatchAgent:handleRM_BanPetRes(status, msg)
	if status == 0 then
		RankRaceController.instance:handleRM_BanPetRes(msg)
	end
end

function RankingMatchAgent:sendRM_GetBanPetInfoReq(seasonId)
	local req = RankingMatchExtension_pb.RM_GetBanPetInfoReq()

	req.seasonId = seasonId

	self:sendMsg(req)
end

function RankingMatchAgent:handleRM_GetBanPetInfoRes(status, msg)
	if status == 0 then
		RankRaceController.instance:handleRM_GetBanPetInfoRes(msg)
	end
end

RankingMatchAgent.instance = RankingMatchAgent.New()

return RankingMatchAgent
