-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tourarena/controller/TourArenaController.lua

module("logic.extensions.tourarena.controller.TourArenaController", package.seeall)

local TourArenaController = class("TourArenaController", BaseController)

function TourArenaController:ctor()
	return
end

function TourArenaController:onInit()
	self:onReset()
end

function TourArenaController:onReset()
	GlobalDispatcher:addListener("tourarenafighttaskcommongroup", self.opTourArenaFightTaskCommonGroup, self)
end

function TourArenaController:sendPM_TourArenaZoneInfoReq(termId)
	TourArenaAgent.instance:sendPM_TourArenaZoneInfoReq(termId)
end

function TourArenaController:handlePM_TourArenaZoneInfoRes(msg)
	TourArenaModel.instance:handlePM_TourArenaZoneInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.TourArenaZoneInfoRes, msg)
end

function TourArenaController:sendPM_TourArenaZoneBindingReq(termId)
	TourArenaAgent.instance:sendPM_TourArenaZoneBindingReq(termId)
end

function TourArenaController:handlePM_TourArenaZoneBindingRes(status, msg)
	if status == 0 then
		TourArenaModel.instance:handlePM_TourArenaZoneBindingRes(msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.TourArenaZoneBindingRes, status, msg)
end

function TourArenaController:sendPM_TourArenaZoneSelectBindingReq(termId, province)
	TourArenaAgent.instance:sendPM_TourArenaZoneSelectBindingReq(termId, province)
end

function TourArenaController:handlePM_TourArenaZoneSelectBindingRes(status, msg)
	if status == 0 then
		TourArenaModel.instance:handlePM_TourArenaZoneSelectBindingRes(msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.TourArenaZoneSelectBindingRes, status, msg)
end

function TourArenaController:sendPM_TourArenaGameInfoReq(activityId)
	TourArenaAgent.instance:sendPM_TourArenaGameInfoReq(activityId)
end

function TourArenaController:handlePM_TourArenaGameInfoRes(msg)
	TourArenaModel.instance:handlePM_TourArenaGameInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.TourArenaGameInfoRes)
end

function TourArenaController:sendPM_TourArenaGameStartGameReq(activityId, gameId, stageId)
	local clientKey = math.random(1, 100000)
	local taGameMo = self:getTourArenaGameMo(activityId)

	taGameMo:setClientKey(clientKey)
	TourArenaAgent.instance:sendPM_TourArenaGameStartGameReq(activityId, gameId, stageId, clientKey)
end

function TourArenaController:handlePM_TourArenaGameStartGameRes(status, msg)
	if status == 0 then
		TourArenaModel.instance:handlePM_TourArenaGameStartGameRes(msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.TourArenaGameStartGameRes, status, msg)
end

function TourArenaController:sendPM_TourArenaGameEndGameReq(activityId, gameId, stageId, isPass, progressIdx)
	local taGameMo = self:getTourArenaGameMo(activityId)
	local encryptedKey = taGameMo:getEncryptedKey(isPass, progressIdx)

	TourArenaAgent.instance:sendPM_TourArenaGameEndGameReq(activityId, gameId, stageId, isPass, progressIdx, encryptedKey)
end

function TourArenaController:handlePM_TourArenaGameEndGameRes(status, msg)
	if status == 0 then
		TourArenaModel.instance:handlePM_TourArenaGameEndGameRes(msg)
		self:_popGameEndResultTips(msg.addScore)
	end

	GlobalDispatcher:dispatch(GlobalNotify.TourArenaGameEndGameRes, status, msg)
end

function TourArenaController:sendPM_TourArenaGameGainPrizeReq(activityId, prizeId)
	TourArenaAgent.instance:sendPM_TourArenaGameGainPrizeReq(activityId, prizeId)
end

function TourArenaController:handlePM_TourArenaGameGainPrizeRes(msg)
	TourArenaModel.instance:handlePM_TourArenaGameGainPrizeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.TourArenaGameGainPrizeRes)
end

function TourArenaController:sendPM_TourArenaGameTotalRankReq(activityId, zoneId)
	TourArenaAgent.instance:sendPM_TourArenaGameTotalRankReq(activityId, zoneId)
end

function TourArenaController:handlePM_TourArenaGameTotalRankRes(msg)
	TourArenaModel.instance:handlePM_TourArenaGameTotalRankRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.TourArenaGameTotalRankRes)
end

function TourArenaController:sendPM_TourArenaGameRankReq(activityId, gameId)
	TourArenaAgent.instance:sendPM_TourArenaGameRankReq(activityId, gameId)
end

function TourArenaController:handlePM_TourArenaGameRankRes(msg)
	TourArenaModel.instance:handlePM_TourArenaGameRankRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.TourArenaGameRankRes)
end

function TourArenaController:sendPM_TourArenaFightInfoReq(activityId)
	TourArenaAgent.instance:sendPM_TourArenaFightInfoReq(activityId)
end

function TourArenaController:handlePM_TourArenaFightInfoRes(msg)
	TourArenaModel.instance:handlePM_TourArenaFightInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.TourArenaFightInfoRes)
end

function TourArenaController:sendPM_TourArenaFightGainPrizeReq(activityId, prizeId)
	TourArenaAgent.instance:sendPM_TourArenaFightGainPrizeReq(activityId, prizeId)
end

function TourArenaController:handlePM_TourArenaFightGainPrizeRes(msg)
	TourArenaModel.instance:handlePM_TourArenaFightGainPrizeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.TourArenaFightGainPrizeRes)
end

function TourArenaController:sendPM_TourArenaFightTotalRankReq(activityId, zoneId)
	TourArenaAgent.instance:sendPM_TourArenaFightTotalRankReq(activityId, zoneId)
end

function TourArenaController:handlePM_TourArenaFightTotalRankRes(msg)
	TourArenaModel.instance:handlePM_TourArenaFightTotalRankRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.TourArenaFightTotalRankRes, msg)
end

function TourArenaController:sendPM_TourArenaPeriodRankReq(activityId)
	TourArenaAgent.instance:sendPM_TourArenaPeriodRankReq(activityId)
end

function TourArenaController:handlePM_TourArenaPeriodRankRes(msg)
	TourArenaModel.instance:handlePM_TourArenaPeriodRankRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.TourArenaPeriodRankRes, msg)
end

function TourArenaController:sendPM_TourArenaFightGainPeriodPrizeReq(activityId, prizeId)
	TourArenaAgent.instance:sendPM_TourArenaFightGainPeriodPrizeReq(activityId, prizeId)
end

function TourArenaController:handlePM_TourArenaFightGainPeriodPrizeRes(msg)
	TourArenaModel.instance:handlePM_TourArenaFightGainPeriodPrizeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.TourArenaFightGainPeriodPrizeRes)
end

function TourArenaController:sendPM_TourArenaGameStageInfoReq(activityId, gameId)
	TourArenaAgent.instance:sendPM_TourArenaGameStageInfoReq(activityId, gameId)
end

function TourArenaController:handlePM_TourArenaGameStageInfoRes(msg)
	TourArenaModel.instance:handlePM_TourArenaGameStageInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.TourArenaGameStageInfoRes)
end

function TourArenaController:getActivityIdOfGame()
	return ActivityDefineController.instance:getActivityIdByType(self:getActivityTypeOfGame())
end

function TourArenaController:getActivityTypeOfGame()
	return GameEnum.ActivityType.TourArenaGame
end

function TourArenaController:isInActivityTimeOfGame(activityId)
	local activityType = self:getActivityTypeOfGame()

	return ActivityDefineController.instance:isInActivityTimeById(activityType, activityId)
end

function TourArenaController:getActivityIdOfFight()
	return ActivityDefineController.instance:getActivityIdByType(self:getActivityTypeOfFight())
end

function TourArenaController:getActivityTypeOfFight()
	return GameEnum.ActivityType.TourArenaFight
end

function TourArenaController:isInActivityTimeOfFight(activityId)
	local activityType = self:getActivityTypeOfFight()

	return ActivityDefineController.instance:isInActivityTimeById(activityType, activityId)
end

function TourArenaController:getTourArenaGameMo(activityId)
	return TourArenaModel.instance:getTourArenaGameMo(activityId)
end

function TourArenaController:getTourArenaFightMo(activityId)
	return TourArenaModel.instance:getTourArenaFightMo(activityId)
end

function TourArenaController:opTourArenaFightTaskCommonGroup(params)
	local activityId = TourArenaController.instance:getActivityIdOfFight()

	if not self:isInActivityTimeOfFight(activityId) then
		FloatWordMgr.instance:show("活动不在开启期限内")

		return
	end

	UIStateManager.instance:push(ViewName.CommonGroupTaskMainView, activityId)
end

function TourArenaController:openTourArenaGame(activityId, gameId, stageId)
	local data = TourArenaGameConfig.instance:getTagStageData(activityId, gameId, stageId)

	if string.nilorempty(data.gameOpenParams) then
		printError("缺失gameOpenParams( yy游园擂台赛-游戏达人.xlsx | export_游戏关卡 )")

		return
	end

	local data = TourArenaGameConfig.instance:getTagStageData(activityId, gameId, stageId)
	local progressPlanId = data.progressPlanId
	local gameOpenParams = string.split(data.gameOpenParams, "#")
	local gameName = gameOpenParams[1]
	local openParams = {}

	for i = 2, #gameOpenParams do
		table.insert(openParams, gameOpenParams[i])
	end

	local function startCallBack()
		TourArenaController.instance:sendPM_TourArenaGameStartGameReq(activityId, gameId, stageId)
	end

	local function finishCallBack(info)
		local info = info or {}
		local isPass = checkbool(info.isPass)
		local gameScore = checknumber(info.gameScore)
		local progressIdx = 0
		local progressData = TourArenaGameConfig.instance:getTagProgressDataByScore(progressPlanId, gameScore)

		if progressData then
			progressIdx = progressData.progressIdx
		else
			printError(string.format("无法找到配置,请检查是否配置问题( activityId=%s, gameId=%s, stageId=%s, gameScore=%s )( yy游园擂台赛-游戏达人.xlsx )", activityId, gameId, stageId, gameScore))
		end

		TourArenaController.instance:sendPM_TourArenaGameEndGameReq(activityId, gameId, stageId, isPass, progressIdx)
	end

	if gameName == TourArenaGameNameEnum.NumberBomb then
		NumberGameController.instance:startMatchByTourArena(startCallBack, finishCallBack)
	elseif gameName == TourArenaGameNameEnum.FirePowerContest then
		FirePowerContestController.instance:startMatchByTourArena(startCallBack, finishCallBack)
		FirePowerContestController.instance:setIsTourArenaMode(true)
		FirePowerContestController.instance:reqStartGame()
	elseif gameName == TourArenaGameNameEnum.DarkDragonKnife then
		local scorePlanId = checknumber(openParams[1])
		local propPlanId = checknumber(openParams[2])
		local gamePlanId = checknumber(openParams[3])

		UIStateManager.instance:push(ViewName.DarkDragonKnifeGameCopyView, scorePlanId, propPlanId, gamePlanId, startCallBack, finishCallBack)
	else
		GlobalDispatcher:addListener(GlobalNotify.TourArenaGameStartGameRes, self._handleOpenTourArenaGame, self)
		TourArenaController.instance:sendPM_TourArenaGameStartGameReq(activityId, gameId, stageId)
	end
end

function TourArenaController:_handleOpenTourArenaGame(status, msg)
	GlobalDispatcher:removeListener(GlobalNotify.TourArenaGameStartGameRes, self._handleOpenTourArenaGame, self)

	if status ~= 0 then
		return
	end

	local taActivityId, taGameId, taStageId = msg.activityId, msg.gameId, msg.stageId
	local data = TourArenaGameConfig.instance:getTagStageData(taActivityId, taGameId, taStageId)
	local progressPlanId = data.progressPlanId
	local gameOpenParams = string.split(data.gameOpenParams, "#")
	local gameName = gameOpenParams[1]
	local openParams = {}

	for i = 2, #gameOpenParams do
		table.insert(openParams, gameOpenParams[i])
	end

	local function finishCallBack(info)
		local info = info or {}
		local isPass = checkbool(info.isPass)
		local gameScore = checknumber(info.gameScore)
		local progressIdx = 0
		local progressData = TourArenaGameConfig.instance:getTagProgressDataByScore(progressPlanId, gameScore)

		if progressData then
			progressIdx = progressData.progressIdx
		else
			printError(string.format("无法找到配置,请检查是否配置问题( activityId=%s, gameId=%s, stageId=%s, gameScore=%s )( yy游园擂台赛-游戏达人.xlsx )", taActivityId, taGameId, taStageId, gameScore))
		end

		TourArenaController.instance:sendPM_TourArenaGameEndGameReq(taActivityId, taGameId, taStageId, isPass, progressIdx)
	end

	if gameName == TourArenaGameNameEnum.LinkGameEndless then
		local linkGameId, ruleId = checknumber(openParams[1]), checknumber(openParams[2])
		local info = {}

		info.progressPlanId = progressPlanId
		info.finishCallBack = finishCallBack

		UIStateManager.instance:push(ViewName.LinkGameEndlessCopyOfTourArenaView, linkGameId, ruleId, info)
	elseif gameName == TourArenaGameNameEnum.PickAPet then
		local id = checknumber(openParams[1])
		local mo = PickAPetInfoOfTourArena.New()

		mo:setGateId(id)
		mo:setOnCloseCallback(finishCallBack)
		UIStateManager.instance:push(ViewName.PickAPetView, mo)
	elseif gameName == TourArenaGameNameEnum.JumpFloorEndless then
		local actId = 0
		local stagePlanId, stageId = checknumber(openParams[1]), checknumber(openParams[2])

		UIStateManager.instance:push(ViewName.JumpFloorGameView, JumpFloorModel.EndlessMode, actId, stagePlanId, stageId, finishCallBack)
	elseif gameName == TourArenaGameNameEnum.SphereGame then
		local activityId = 0
		local stagePlanId, stageId = checknumber(openParams[1]), checknumber(openParams[2])

		UIStateManager.instance:push(ViewName.SphereGameMainCopyOfTourArenaView, activityId, stagePlanId, stageId, finishCallBack)
	elseif gameName == TourArenaGameNameEnum.HuaRongRoad then
		local activityId, stateId = checknumber(openParams[1]), checknumber(openParams[2])

		HuarongRoadModel.instance:setGameProgress(activityId, stateId, nil)
		UIStateManager.instance:push(ViewName.HuarongRoadGameCopyOfTourArenaView, activityId, stateId, finishCallBack)
	elseif gameName == TourArenaGameNameEnum.FlipGame then
		local planId = checknumber(openParams[1])

		UIStateManager.instance:push(ViewName.FlipGameMainCopyOfTourArenaView, planId, finishCallBack)
	elseif gameName == TourArenaGameNameEnum.BuryGame then
		local actId = checknumber(openParams[1])

		UIStateManager.instance:push(ViewName.BuryGameMainCopyOfTourArenaView, actId, finishCallBack)
	elseif gameName == TourArenaGameNameEnum.Sxgame then
		local info = {}

		info.progressPlanId = progressPlanId
		info.finishCallBack = finishCallBack

		UIStateManager.instance:push(ViewName.SxGameCopyOfTourArenaView, info)
	elseif gameName == TourArenaGameNameEnum.NumberPuzzle then
		local mapId = checknumber(openParams[1])

		NumberPuzzleGameController.instance:gotoStartNumberPuzzleGameOfTourArenaGame(mapId, finishCallBack)
	elseif gameName == TourArenaGameNameEnum.Elizabeth then
		local activityId = checknumber(openParams[1])

		UIStateManager.instance:push(ViewName.ElizabethactgameCopyOfTourArenaView, activityId, finishCallBack)
	elseif gameName == TourArenaGameNameEnum.PinGame then
		local mode = checknumber(openParams[1])
		local stageId = checknumber(openParams[2])

		PinGameController.instance:enterGameByTourArena(mode, stageId, finishCallBack)
	elseif gameName == TourArenaGameNameEnum.ThreeMatches then
		local activityId = checknumber(openParams[1])
		local stageId = checknumber(openParams[2])

		UIStateManager.instance:push(ViewName.TripleMacthesGameCopyView, activityId, stageId, finishCallBack)
	elseif gameName == TourArenaGameNameEnum.DuoLaLightGame then
		local mapId = checknumber(openParams[1])

		UIStateManager.instance:push(ViewName.LightGameCopyView, mapId, finishCallBack)
	elseif gameName == TourArenaGameNameEnum.TheOutcast then
		local planId = checknumber(openParams[1])

		UIStateManager.instance:push(ViewName.HexagramGameCopyView, planId, finishCallBack)
	end
end

function TourArenaController:_popGameEndResultTips(addScore)
	local text = string.format("恭喜你，本局获得积分\n\n<color=#20b376><size=35>%s</size></color>", addScore)
	local func
	local btnText = "确定"
	local alignment = UnityEngine.TextAnchor.MiddleCenter

	TipsFacade.instance:openTipWindowNoX("提示", text, func, btnText, alignment)
end

function TourArenaController:getTryGameResultAndTips(activityId, gameId, stageId)
	local result = GameEnum.ResultCode.Success
	local tips = ""
	local taGameMo = self:getTourArenaGameMo(activityId)

	if not taGameMo:isInTimePeriodOfStage(gameId, stageId) then
		result = GameEnum.ResultCode.Error
		tips = "不在游戏开放时间内"
	elseif not taGameMo:isEnoughTimesOfGame(gameId) then
		result = GameEnum.ResultCode.Error
		tips = "次数不足"
	end

	return result, tips
end

function TourArenaController:isUsePeriodMode(activityId)
	local data = TourArenaFightConfig.instance:getTafActData(activityId)

	return data and data.periodId > 0 or false
end

function TourArenaController:openTourArenaFightRank(activityId)
	UIStateManager.instance:push(ViewName.TourArenaFightTotalRankFatherView, activityId)
end

function TourArenaController:getTourArenaFightRankTabZoneKey(zoneId)
	return string.format("zone_%s", zoneId)
end

TourArenaController.instance = TourArenaController.New()

return TourArenaController
