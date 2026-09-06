-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingarena/controller/KingArenaController.lua

module("logic.extensions.kingarena.controller.KingArenaController", package.seeall)

local KingArenaController = class("KingArenaController", BaseController)

function KingArenaController:onInit()
	GlobalDispatcher:addListener("openkingarena", self._openKingArena, self)
	self:onReset()
end

function KingArenaController:onReset()
	self:_destroyAllStepMgr()
end

function KingArenaController:sendPM_KingArenaGetInfoReq(seasonId)
	KingArenaAgent.instance:sendPM_KingArenaGetInfoReq(seasonId)
end

function KingArenaController:handlePM_KingArenaGetInfoRes(status, msg)
	if status == 0 then
		local mo = self:getKingArenaMo(msg.seasonId)

		mo:handlePM_KingArenaGetInfoRes(msg)
		self:_updateSeasonPrizeRed(msg.seasonId)
	end

	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_KingArenaGetInfoRes, status, msg)
end

function KingArenaController:sendPM_KingArenaFightReq(seasonId, targetRankId, form, useSystemPro)
	KingArenaAgent.instance:sendPM_KingArenaFightReq(seasonId, targetRankId, form, useSystemPro)
end

function KingArenaController:handlePM_KingArenaFightRes(status, msg)
	if status == 0 then
		local mo = self:getKingArenaMo(msg.seasonId)
		local oldRank = mo:getMyCurRank()

		mo:handlePM_KingArenaFightRes(msg)
		self:sendPM_KingArenaGetInfoReq(msg.seasonId)

		if msg:HasField("battleResult") then
			local params = {
				oldRank = oldRank,
				newRank = msg.newRank
			}

			BattleSettlementModel.instance:setType(BattleSettlementModel.Enum.KingArena, params)

			local myUserId = RoleModel.instance:getUserId()

			self:playFightRecord(msg.battleResult, myUserId)
		else
			FloatWordMgr.instance:show("战斗胜利")
		end
	end

	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_KingArenaFightRes, status)
end

function KingArenaController:sendPM_KingArenaViewFormReq(playerId)
	KingArenaAgent.instance:sendPM_KingArenaViewFormReq(playerId)
end

function KingArenaController:handlePM_KingArenaViewFormRes(status, msg)
	if status == 0 then
		KingArenaModel.instance:handlePM_KingArenaViewFormRes(msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_KingArenaViewFormRes, status, msg)
end

function KingArenaController:sendPM_KingArenaSetDefenseFormReq(form)
	KingArenaAgent.instance:sendPM_KingArenaSetDefenseFormReq(form)
end

function KingArenaController:handlePM_KingArenaSetDefenseFormRes(status, msg)
	if status == 0 then
		KingArenaModel.instance:setEmptyInMyFmt(false)
	end

	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_KingArenaSetDefenseFormRes, status)
end

function KingArenaController:sendPM_KingArenaRefreshOpReq(seasonId)
	KingArenaAgent.instance:sendPM_KingArenaRefreshOpReq(seasonId)
end

function KingArenaController:handlePM_KingArenaRefreshOpRes(status, msg)
	if status == 0 then
		local mo = self:getKingArenaMo(msg.seasonId)

		mo:handlePM_KingArenaRefreshOpRes(msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_KingArenaRefreshOpRes, status)
end

function KingArenaController:sendPM_KingArenaBuyFightTimesReq(seasonId, wantBuyTimes)
	KingArenaAgent.instance:sendPM_KingArenaBuyFightTimesReq(seasonId, wantBuyTimes)
end

function KingArenaController:handlePM_KingArenaBuyFightTimesRes(status, msg)
	if status == 0 then
		local mo = self:getKingArenaMo(msg.seasonId)

		mo:handlePM_KingArenaBuyFightTimesRes(msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_KingArenaBuyFightTimesRes, status, msg)
end

function KingArenaController:sendPM_KingArenaGainSeasonPrizeReq(seasonId, prizeId)
	KingArenaAgent.instance:sendPM_KingArenaGainSeasonPrizeReq(seasonId)
end

function KingArenaController:handlePM_KingArenaGainSeasonPrizeRes(msg)
	local mo = self:getKingArenaMo(msg.seasonId)

	mo:handlePM_KingArenaGainSeasonPrizeRes(msg)
	self:_updateSeasonPrizeRed(msg.seasonId)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_KingArenaGainSeasonPrizeRes)
end

function KingArenaController:sendPM_KingArenaResetZoneReq(seasonId, newZoneId)
	KingArenaAgent.instance:sendPM_KingArenaResetZoneReq(seasonId, newZoneId)
end

function KingArenaController:handlePM_KingArenaResetZoneRes(status, msg)
	if status == 0 then
		local mo = self:getKingArenaMo(msg.seasonId)

		mo:handlePM_KingArenaResetZoneRes(msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_KingArenaResetZoneRes, status, msg)
end

function KingArenaController:sendPM_KingArenaGetRecordsReq(seasonId)
	KingArenaAgent.instance:sendPM_KingArenaGetRecordsReq(seasonId)
end

function KingArenaController:handlePM_KingArenaGetRecordsRes(msg)
	local mo = self:getKingArenaMo(msg.seasonId)

	mo:handlePM_KingArenaGetRecordsRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_KingArenaGetRecordsRes, msg)
end

function KingArenaController:sendPM_KingArenaBattleVideoReq(battleId)
	KingArenaAgent.instance:sendPM_KingArenaBattleVideoReq(battleId)
end

function KingArenaController:handlePM_KingArenaBattleVideoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_KingArenaBattleVideoRes, msg)
end

function KingArenaController:sendPM_KingArenaRankViewReq(type, zoneId)
	KingArenaAgent.instance:sendPM_KingArenaRankViewReq(type, zoneId)
end

function KingArenaController:handlePM_KingArenaRankViewRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_KingArenaRankViewRes, msg)
end

function KingArenaController:sendPM_KingArenaPetRankViewReq(seasonId, type, side)
	KingArenaAgent.instance:sendPM_KingArenaPetRankViewReq(seasonId, type, side)
end

function KingArenaController:handlePM_KingArenaPetRankViewRes(msg)
	local mo = self:getKingArenaMo(msg.seasonId)

	mo:handlePM_KingArenaPetRankViewRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_KingArenaPetRankViewRes, msg)
end

function KingArenaController:_updateSeasonPrizeRed(seasonId)
	local isActive = false

	if self:isInTimeOfSeason(seasonId) then
		local kingArenaMo = self:getKingArenaMo(seasonId)
		local cfg = KingArenaConfig.instance:getPeriodCfg(seasonId)

		if cfg then
			for _, data in ipairs(cfg) do
				if kingArenaMo:isCanGainBestRankPrize(data.periodId) then
					isActive = true

					break
				end
			end
		end
	end

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_KINGARENA_SEASON_PRIZE, isActive)
end

function KingArenaController:getKingArenaMo(seasonId)
	return KingArenaModel.instance:getKingArenaMo(seasonId)
end

function KingArenaController:getSeasonId()
	local seasonId = 0
	local dataList = KingArenaConfig.instance:getSeasonDataList()

	if dataList then
		for _, data in ipairs(dataList) do
			if self:isInTimeOfSeason(data.seasonId) then
				seasonId = data.seasonId

				break
			end
		end
	end

	return seasonId
end

function KingArenaController:getNewestSeasonId()
	local seasonId = 0
	local dataList = KingArenaConfig.instance:getSeasonDataList()

	if dataList then
		for _, v in ipairs(dataList) do
			local timePeriod = GameUtil.getTimePeriod(v.openTime, v.endTime)

			if timePeriod < GameUtil.inTimePeriod then
				break
			elseif timePeriod == GameUtil.inTimePeriod then
				seasonId = v.seasonId

				break
			elseif timePeriod > GameUtil.inTimePeriod then
				seasonId = v.seasonId
			end
		end
	end

	return seasonId
end

function KingArenaController:getPeriodId(seasonId)
	local periodId = 0
	local cfg = KingArenaConfig.instance:getPeriodCfg(seasonId)

	if cfg then
		for _, data in ipairs(cfg) do
			if self:isInTimeOfSeasonPeriod(seasonId, data.periodId) then
				periodId = data.periodId

				break
			end
		end
	end

	return periodId
end

function KingArenaController:isInTimeOfSeason(seasonId)
	local data = KingArenaConfig.instance:getSeasonData(seasonId)

	if data then
		return GameUtil.getTimePeriod(data.openTime, data.endTime) == GameUtil.inTimePeriod
	end

	return false
end

function KingArenaController:isInTimeOfSeasonPeriod(seasonId, periodId)
	local data = KingArenaConfig.instance:getPeriodData(seasonId, periodId)

	if data then
		return GameUtil.getTimePeriod(data.openTime, data.endTime) == GameUtil.inTimePeriod
	end

	return false
end

function KingArenaController:enterInStepMgr()
	if self._stepMgr == nil then
		self._stepMgr = KingArenaStepMgr.New()
		self._stepMgrDelta = 0
	end

	if self._stepMgrDelta == 0 then
		self._stepMgr:onEnter()
	end

	self._stepMgrDelta = self._stepMgrDelta + 1
end

function KingArenaController:exitInStepMgr()
	if self._stepMgr then
		self._stepMgrDelta = Mathf.Max(self._stepMgrDelta - 1, 0)

		if self._stepMgrDelta <= 0 then
			self._stepMgr:onExit()
		end
	end
end

function KingArenaController:_destroyAllStepMgr()
	if self._stepMgr then
		self._stepMgr:onDestroy()
	end

	self._stepMgr = nil
	self._stepMgrDelta = 0
end

function KingArenaController:getStepMgr()
	return self._stepMgr
end

function KingArenaController:_openKingArena(params)
	self:enterKingArena()
end

function KingArenaController:enterKingArena()
	local seasonId = KingArenaController.instance:getSeasonId()

	if not self:isInTimeOfSeason(seasonId) then
		FloatWordMgr.instance:show("赛季未开启")

		return
	end

	GlobalDispatcher:addListener(GlobalNotify.HandlePM_KingArenaGetInfoRes, self._enterKingArena, self)
	KingArenaController.instance:sendPM_KingArenaGetInfoReq(seasonId)

	local userId = RoleModel.instance:getUserId()

	KingArenaController.instance:sendPM_KingArenaViewFormReq(userId)
end

function KingArenaController:_enterKingArena(status, msg)
	GlobalDispatcher:removeListener(GlobalNotify.HandlePM_KingArenaGetInfoRes, self._enterKingArena, self)

	if status ~= 0 then
		return
	end

	local seasonId = msg.seasonId
	local kingArenaMo = self:getKingArenaMo(seasonId)
	local zoneId = kingArenaMo:getZoneId()

	if zoneId > 0 then
		UIStateManager.instance:push(ViewName.KingArenaMainView, seasonId)
	else
		UIStateManager.instance:push(ViewName.KingArenaArrangeView, seasonId)
	end
end

function KingArenaController:isUseMaxZdl(seasonId)
	local key = self:getUseMaxZdlUserDataKey(seasonId)
	local value = GameUtil.getUserData(key)

	return checknumber(value) == 1
end

function KingArenaController:setIsUseMaxZdl(seasonId, isUse)
	local key = self:getUseMaxZdlUserDataKey(seasonId)

	GameUtil.saveUserData(key, isUse and 1 or 0)
end

function KingArenaController:getUseMaxZdlUserDataKey(seasonId)
	return "KingArena_UseMaxZdl_" .. seasonId
end

function KingArenaController:doCallbackWhenFirstZoneBuffTips(seasonId, firstCallback, nextCallBack)
	local key = self:getFirstZoneBuffTipsUserDataKey(seasonId)

	GameUtil.doCallbackWhenFirst(key, firstCallback, nextCallBack)
end

function KingArenaController:getFirstZoneBuffTipsUserDataKey(seasonId)
	return string.format("KingArenaFirstZoneBuffTips_%s", seasonId)
end

function KingArenaController:FormatTimeWords(timeStamp)
	local day, hour, min, sec = GameUtil.getTimeDDHHMMSS(timeStamp)

	if day >= 1 then
		return string.format("%02d天%02d时%02d分", day, hour, min)
	elseif hour >= 1 then
		return string.format("%02d时%02d分%02d秒", hour, min, sec)
	elseif min >= 1 then
		return string.format("%02d分%02d秒", min, sec)
	else
		return string.format("%02d秒", sec)
	end
end

function KingArenaController:enterBattle(seasonId, periodId, userId, rank)
	local isEmptyFmt = KingArenaModel.instance:isEmptyInMyFmt()

	if isEmptyFmt then
		TipsFacade.instance:openTipWindow(lang("tip"), lang("fight_unformation"), function()
			KingArenaController.instance:enterFormation(seasonId, periodId)
		end, lang("fight_goto_fmt"))
	else
		local isUseMaxZdl = self:isUseMaxZdl(seasonId)
		local customFmtMo = KingArenaModel.instance:getCustomFmtMo()

		customFmtMo:updateCfg(seasonId, periodId, userId, rank, isUseMaxZdl)
		CustomFmtController.instance:showMissionView(customFmtMo)
	end
end

function KingArenaController:enterFormation(seasonId, periodId)
	GlobalDispatcher:addListener(GlobalNotify.HandlePM_KingArenaViewFormRes, self._enterFormation, self)

	self._seasonIdInFormation = seasonId
	self._periodIdInFormation = periodId

	local userId = RoleModel.instance:getUserId()

	KingArenaController.instance:sendPM_KingArenaViewFormReq(userId)
end

function KingArenaController:_enterFormation(status, msg)
	GlobalDispatcher:removeListener(GlobalNotify.HandlePM_KingArenaViewFormRes, self._enterFormation, self)

	if status == 0 then
		local seasonId = self._seasonIdInFormation
		local periodId = self._periodIdInFormation
		local customFmtMo = KingArenaModel.instance:getFormationCustomFmtMo()

		customFmtMo:updateCfg(seasonId, periodId, msg.playerView.curForm)
		CustomFmtController.instance:showMissionFormationView(customFmtMo)
	end

	self._seasonIdInFormation = nil
	self._periodIdInFormation = nil
end

function KingArenaController:viewFormation(userId)
	GlobalDispatcher:addListener(GlobalNotify.HandlePM_KingArenaViewFormRes, self._viewFormation, self)
	KingArenaController.instance:sendPM_KingArenaViewFormReq(userId)
end

function KingArenaController:_viewFormation(status, msg)
	GlobalDispatcher:removeListener(GlobalNotify.HandlePM_KingArenaViewFormRes, self._viewFormation, self)

	if status == 0 then
		UIStateManager.instance:open(ViewName.KingArenaShowFmtView)
	end
end

function KingArenaController:playFightRecord(battleResult, leftUserId)
	local teamId = self:getMyTeamIdByBattleResult(battleResult, leftUserId)

	if teamId >= 0 then
		BattleModel.instance:setLeftTeamId(teamId)
	end

	BattleController.instance:viewUserFightMonsterBtlResult(battleResult, false)
end

function KingArenaController:getMyTeamIdByBattleResult(battleResult, leftUserId)
	local teamId = 0

	leftUserId = checknumber(leftUserId)

	if battleResult and leftUserId > 0 then
		local teams = battleResult.originalStates.teams

		for _, v in ipairs(teams) do
			local id = checknumber(v.playerView.id)

			if leftUserId == id then
				teamId = v.teamId

				break
			end
		end
	end

	return teamId
end

function KingArenaController:checkMatEnough(seasonId, startTimes, endTimes, isAutoOpenSource)
	local matArray = KingArenaConfig.instance:getCostMatsWithBuyTimes(seasonId, startTimes, endTimes)

	for matKey, matNum in pairs(matArray) do
		local matType, matId, _ = MaterialMgr.getMatParams(matKey)

		if not MaterialFacade.instance:checkMatEnough(matType, matId, matNum, nil, isAutoOpenSource) then
			return false
		end
	end

	return true
end

KingArenaController.instance = KingArenaController.New()

return KingArenaController
