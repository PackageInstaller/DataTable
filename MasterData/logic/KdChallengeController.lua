-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingdragonchallenge/controller/KdChallengeController.lua

module("logic.extensions.kingdragonchallenge.controller.KdChallengeController", package.seeall)

local KdChallengeController = class("KdChallengeController", BaseController)

function KdChallengeController:ctor()
	return
end

function KdChallengeController:onInit()
	self:onReset()
end

function KdChallengeController:onReset()
	return
end

function KdChallengeController:loadKingdDragonChallenge()
	if not self:isInOpenTimeByAllKd() then
		return
	end

	KdChallengeController.instance:resetLandingOnceRed()
	GlobalDispatcher:addListener(GlobalNotify.KDChallengeGetInfoRes, self._handleUpdateLandingOnceRed, self)

	local challengeId = KdChallengeConfig.instance:getKdCurChallengeId()

	KdChallengeController.instance:sendPM_TQKingDragonGetInfoReq(challengeId)
end

function KdChallengeController:loadNuoYaChallenge()
	if not self:isInOpenTimeByAllNuoya() then
		return
	end

	GlobalDispatcher:addListener(GlobalNotify.KDChallengeGetInfoRes, self._handleUpdateNuoyaLandingOnceRed, self)

	local challengeId = KdChallengeConfig.instance:getNuoyaCurChallengeId()

	KdChallengeController.instance:sendPM_TQKingDragonGetInfoReq(challengeId)
end

function KdChallengeController:sendPM_TQKingDragonGetInfoReq(challengeId)
	TianQiKingDragonAgent.instance:sendPM_TQKingDragonGetInfoReq(challengeId)
end

function KdChallengeController:handlePM_TQKingDragonGetInfoRes(msg)
	KdChallengeModel.instance:handlePM_TQKingDragonGetInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.KDChallengeGetInfoRes)
end

function KdChallengeController:sendPM_TQKingDragonBossClgReq(challengeId, simpleForm)
	TianQiKingDragonAgent.instance:sendPM_TQKingDragonBossClgReq(challengeId, simpleForm)
end

function KdChallengeController:handlePM_TQKingDragonBossClgRes(status, msg)
	if status == 0 then
		KdChallengeModel.instance:handlePM_TQKingDragonBossClgRes(msg)

		local function handler()
			GlobalDispatcher:addListener(GlobalNotify.KDChallengeResultConfirmRes, self._handlerBattleEnd, self)

			local challengeId = KdChallengeModel.instance:getCurChallengeId()

			KdChallengeController.instance:sendPM_TQKingDragonResultConfirmReq(challengeId, GameEnum.KingDragonType.Boss)
		end

		BattleFacade.instance:registerResultHandler(handler)
		BattleSettlementModel.instance:setType(BattleSettlementModel.Enum.KingDragonChallenge)
	end

	GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	GlobalDispatcher:dispatch(GlobalNotify.KDChallengeBossClgRes, status, msg)
end

function KdChallengeController:sendPM_TQKingDragonBossSweepReq(challengeId)
	TianQiKingDragonAgent.instance:sendPM_TQKingDragonBossSweepReq(challengeId)
end

function KdChallengeController:handlePM_TQKingDragonBossSweepRes(msg)
	KdChallengeModel.instance:handlePM_TQKingDragonBossSweepRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.KDChallengeBossSweepRes)
end

function KdChallengeController:sendPM_TQKingDragonResultConfirmReq(challengeId, type)
	TianQiKingDragonAgent.instance:sendPM_TQKingDragonResultConfirmReq(challengeId, type)
end

function KdChallengeController:handlePM_TQKingDragonResultConfirmRes(msg)
	KdChallengeModel.instance:handlePM_TQKingDragonResultConfirmRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.KDChallengeResultConfirmRes)
end

function KdChallengeController:sendPM_TQKingDragonBossGetPrizeReq(challengeId, prizeId)
	TianQiKingDragonAgent.instance:sendPM_TQKingDragonBossGetPrizeReq(challengeId, prizeId)
end

function KdChallengeController:handlePM_TQKingDragonBossGetPrizeRes(msg)
	KdChallengeModel.instance:handlePM_TQKingDragonBossGetPrizeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.KDChallengeBossGetPrizeRes)
end

function KdChallengeController:sendPM_TQKingDragonBossBuyReq(challengeId)
	TianQiKingDragonAgent.instance:sendPM_TQKingDragonBossBuyReq(challengeId)
end

function KdChallengeController:handlePM_TQKingDragonBossBuyRes(msg)
	KdChallengeModel.instance:handlePM_TQKingDragonBossBuyRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.KDChallengeBossBuyRes)
end

function KdChallengeController:sendPM_TQKingDragonUnitClgReq(challengeId, unitId, simpleForm)
	BattleFacade.instance:registerResultHandler(self._handlerBattleEndAsUnit, self)
	TianQiKingDragonAgent.instance:sendPM_TQKingDragonUnitClgReq(challengeId, unitId, simpleForm)
end

function KdChallengeController:handlePM_TQKingDragonUnitClgRes(status, msg)
	if status == 0 then
		KdChallengeModel.instance:handlePM_TQKingDragonUnitClgRes(msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	GlobalDispatcher:dispatch(GlobalNotify.KDChallengeUnitClgRes, status, msg)
end

function KdChallengeController:handlePM_TQKingDragonUnitBattleEndRes(msg)
	KdChallengeModel.instance:handlePM_TQKingDragonUnitBattleEndRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.KDChallengeUnitBattleEndRes)
end

function KdChallengeController:sendPM_TQKingDragonUnitResetReq(challengeId)
	TianQiKingDragonAgent.instance:sendPM_TQKingDragonUnitResetReq(challengeId)
end

function KdChallengeController:handlePM_TQKingDragonUnitResetRes(msg)
	KdChallengeModel.instance:handlePM_TQKingDragonUnitResetRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.KDChallengeUnitUnitResetRes)
end

function KdChallengeController:sendPM_TQKingDragonStageClgReq(challengeId, stageId, simpleForm)
	BattleFacade.instance:registerResultHandler(self._handlerBattleEnd, self)
	TianQiKingDragonAgent.instance:sendPM_TQKingDragonStageClgReq(challengeId, stageId, simpleForm)
end

function KdChallengeController:handlePM_TQKingDragonStageClgRes(status, msg)
	if status == 0 then
		KdChallengeModel.instance:handlePM_TQKingDragonStageClgRes(msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	GlobalDispatcher:dispatch(GlobalNotify.KDChallengeStageClgRes, status, msg)
end

function KdChallengeController:sendPM_TQKingDragonStageResetReq(challengeId)
	TianQiKingDragonAgent.instance:sendPM_TQKingDragonStageResetReq(challengeId)
end

function KdChallengeController:handlePM_TQKingDragonStageResetRes(msg)
	KdChallengeModel.instance:handlePM_TQKingDragonStageResetRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.KDChallengeStageResetRes)
end

function KdChallengeController:sendPM_TQKingDragonStageForcePrizeReq(challengeId)
	TianQiKingDragonAgent.instance:sendPM_TQKingDragonStageForcePrizeReq(challengeId)
end

function KdChallengeController:handlePM_TQKingDragonStageForcePrizeRes(msg)
	KdChallengeModel.instance:handlePM_TQKingDragonStageForcePrizeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.KDChallengeStageForcePrizeRes)
end

function KdChallengeController:handlePM_TQKingDragonStageBattleWinRes(msg)
	KdChallengeModel.instance:handlePM_TQKingDragonStageBattleWinRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.KDChallengeStageBattleWinRes)
end

function KdChallengeController:sendPM_TQKingDragonGetLoginTaskPrizeReq(challengeId, days)
	TianQiKingDragonAgent.instance:sendPM_TQKingDragonGetLoginTaskPrizeReq(challengeId, days)
end

function KdChallengeController:handlePM_TQKingDragonGetLoginTaskPrizeRes(msg)
	KdChallengeModel.instance:handlePM_TQKingDragonGetLoginTaskPrizeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.KDChallengeLoginTaskRes)
end

function KdChallengeController:_handleUpdateLandingOnceRed()
	GlobalDispatcher:removeListener(GlobalNotify.KDChallengeGetInfoRes, self._handleUpdateLandingOnceRed, self)
	self:updateLandingOnceRed()
end

function KdChallengeController:_handleUpdateNuoyaLandingOnceRed()
	GlobalDispatcher:removeListener(GlobalNotify.KDChallengeGetInfoRes, self._handleUpdateNuoyaLandingOnceRed, self)
	self:updateNuoyaLandingOnceRed()
end

function KdChallengeController:updateLandingOnceRed()
	local redIdList = KdChallengeConfig.instance:getKdLandingOnceRedList()

	for _, redId in ipairs(redIdList) do
		local isNeedTryReg = true

		if redId == RedPointModel.ID_KINGDRAGON_LANDINGONCE_RED_BOSS then
			local isInTime = self:isInOpenTimeByKdType(GameEnum.KingDragonType.Boss)
			local isPass = KdChallengeController.instance:isPassAllBossAsBoss()
			local isHaveTimes = KdChallengeController.instance:isHaveTimesAsBoss()

			isNeedTryReg = isInTime and not isPass and isHaveTimes
		elseif redId == RedPointModel.ID_KINGDRAGON_LANDINGONCE_RED_STAGE then
			local isInTime = self:isInOpenTimeByKdType(GameEnum.KingDragonType.Stage)
			local isPass = KdChallengeController.instance:isPassAllStageAsStage()

			isNeedTryReg = isInTime and not isPass
		elseif redId == RedPointModel.ID_KINGDRAGON_LANDINGONCE_RED_UNIT then
			local isInTime = self:isInOpenTimeByKdType(GameEnum.KingDragonType.Unit)
			local isPass = KdChallengeController.instance:isPassAllUnitAsUnit()

			isNeedTryReg = isInTime and not isPass
		end

		if isNeedTryReg then
			self:regRedAsLandingOnce(redId)
		end
	end
end

function KdChallengeController:updateNuoyaLandingOnceRed()
	local redIdList = KdChallengeConfig.instance:getNuoyaLandingOnceRedList()

	for _, redId in ipairs(redIdList) do
		self:regRedAsLandingOnce(redId)
	end
end

function KdChallengeController:resetLandingOnceRed()
	local redIdList = KdChallengeConfig.instance:getKdLandingOnceRedList()

	for _, redId in ipairs(redIdList) do
		self:saveRedAsLandingOnce(redId, false)
	end
end

function KdChallengeController:resetNuoYaLandingOnceRed()
	local redIdList = KdChallengeConfig.instance:getNuoyaLandingOnceRedList()

	for _, redId in ipairs(redIdList) do
		self:saveRedAsLandingOnce(redId, false)
	end
end

function KdChallengeController:regRedAsLandingOnce(redId)
	if string.nilorempty(redId) then
		return
	end

	local function handle(value)
		RedPointController.instance:setRedPointInfo(redId, checknumber(value) == 0)
	end

	local key = self:_getUserDataKeyAsKdLandingOnceRed(redId)

	GameUtil.getUserDayData(key, handle)
end

function KdChallengeController:saveRedAsLandingOnce(redId, isHasActivated)
	if string.nilorempty(redId) then
		return
	end

	local key = self:_getUserDataKeyAsKdLandingOnceRed(redId)
	local value = isHasActivated and 1 or 0

	GameUtil.saveUserDayData(key, value)
	RedPointController.instance:setRedPointInfo(redId, not isHasActivated)
end

function KdChallengeController:_getUserDataKeyAsKdLandingOnceRed(redId)
	return "Kd" .. "LO" .. "Red" .. redId
end

function KdChallengeController:enterBattleAsKd(kdType, ...)
	local customFmtMo = KdChallengeModel.instance:getCustomFmtMoAsKd(kdType)

	if customFmtMo == nil then
		printError(string.format("无法找到对应类型的customFmtMo,请检查kdType.( kdType = %d )", kdType))

		return
	end

	local params = {
		...
	}

	if kdType == GameEnum.KingDragonType.Boss then
		-- block empty
	elseif kdType == GameEnum.KingDragonType.Stage then
		local stageId = checknumber(params[1])

		if stageId == 0 then
			printError("群体试炼缺乏传入stageId,无法开始战斗,请检查")

			return
		end

		customFmtMo:updateCfg(stageId)
	elseif kdType == GameEnum.KingDragonType.Unit then
		local unitId = checknumber(params[1])

		if unitId == 0 then
			printError("合体试炼缺乏传入unitId,无法开始战斗,请检查")

			return
		end

		customFmtMo:updateCfg(unitId)
	end

	CustomFmtController.instance:showMissionView(customFmtMo)
end

function KdChallengeController:_handlerBattleEnd()
	BattleFacade.instance:registerResultHandler(nil, nil)
	GlobalDispatcher:removeListener(GlobalNotify.KDChallengeResultConfirmRes, self._handlerBattleEnd, self)

	local function succHandler()
		local viewInfos = KdChallengeModel.instance:getViewInfos()

		for _, info in ipairs(viewInfos) do
			UIJumper.instance:pushOneStack(info.viewName, true, unpack(info.params))
		end

		ViewMgr.instance:open(ViewName.BattleSettlementSuccess)
	end

	local function failHandler()
		local viewInfos = KdChallengeModel.instance:getViewInfos()

		for _, info in ipairs(viewInfos) do
			UIJumper.instance:pushOneStack(info.viewName, true, unpack(info.params))
		end

		ViewMgr.instance:open(ViewName.BattleSettlementFailSimple)
	end

	if BattleModel.instance.battleResult == GameEnum.BattleResult.ExpSuccess then
		succHandler()
	elseif BattleModel.instance.battleResult == GameEnum.BattleResult.Success then
		succHandler()
	elseif BattleModel.instance.battleResult == GameEnum.BattleResult.DogFall then
		failHandler()
	elseif BattleModel.instance.battleResult == GameEnum.BattleResult.Failed then
		failHandler()
	end

	return true
end

function KdChallengeController:_handlerBattleEndAsUnit()
	BattleFacade.instance:registerResultHandler(nil, nil)

	local function succHandler()
		local viewInfos = KdChallengeModel.instance:getViewInfos()

		for _, info in ipairs(viewInfos) do
			UIJumper.instance:pushOneStack(info.viewName, true, unpack(info.params))
		end

		UIJumper.instance:pushOneStack(ViewName.KdChallengeUnitPopView, true)
		ViewMgr.instance:open(ViewName.BattleSettlementSuccess)
	end

	local function failHandler()
		local viewInfos = KdChallengeModel.instance:getViewInfos()

		for _, info in ipairs(viewInfos) do
			UIJumper.instance:pushOneStack(info.viewName, true, unpack(info.params))
		end

		ViewMgr.instance:open(ViewName.BattleSettlementFailSimple)
	end

	if BattleModel.instance.battleResult == GameEnum.BattleResult.ExpSuccess then
		succHandler()
	elseif BattleModel.instance.battleResult == GameEnum.BattleResult.Success then
		succHandler()
	elseif BattleModel.instance.battleResult == GameEnum.BattleResult.DogFall then
		failHandler()
	elseif BattleModel.instance.battleResult == GameEnum.BattleResult.Failed then
		failHandler()
	end

	return true
end

function KdChallengeController:isInTimeByOpenTime(openTime)
	return GameUtil.getTimePeriod(openTime, nil) == GameUtil.inTimePeriod
end

function KdChallengeController:isInOpenTimeByAllKd()
	local challengeId = KdChallengeConfig.instance:getKdCurChallengeId()
	local startStamp, endStamp = TLChallengeController.instance:getStartAndEndTimeStampByCId(challengeId)

	if string.nilorempty(startStamp) or string.nilorempty(endStamp) then
		return false
	end

	return GameUtil.getTimePeriodTypeBySec(startStamp, endStamp) == GameUtil.inTimePeriod
end

function KdChallengeController:isInOpenTimeByKdType(kdType)
	local challengeId = KdChallengeConfig.instance:getKdCurChallengeId()
	local data = KdChallengeConfig.instance:getKdChallengeData(challengeId)
	local isInTime = GameUtil.errorTimePeriod

	if kdType == GameEnum.KingDragonType.Boss then
		isInTime = self:isInTimeByOpenTime(data.openTime1)
	elseif kdType == GameEnum.KingDragonType.Stage then
		isInTime = self:isInTimeByOpenTime(data.openTime2)
	elseif kdType == GameEnum.KingDragonType.Unit then
		isInTime = self:isInTimeByOpenTime(data.openTime3)
	end

	return isInTime
end

function KdChallengeController:isInOpenTimeByAllNuoya()
	local challengeId = KdChallengeConfig.instance:getNuoyaCurChallengeId()
	local startStamp, endStamp = TLChallengeController.instance:getStartAndEndTimeStampByCId(challengeId)

	if string.nilorempty(startStamp) or string.nilorempty(endStamp) then
		return false
	end

	return GameUtil.getTimePeriodTypeBySec(startStamp, endStamp) == GameUtil.inTimePeriod
end

function KdChallengeController:isInOpenTimeByNuoyaType(kdType)
	local challengeId = KdChallengeConfig.instance:getNuoyaCurChallengeId()
	local data = KdChallengeConfig.instance:getKdChallengeData(challengeId)
	local isInTime = GameUtil.errorTimePeriod

	if kdType == GameEnum.KingDragonType.Boss then
		isInTime = self:isInTimeByOpenTime(data.openTime1)
	elseif kdType == GameEnum.KingDragonType.Stage then
		isInTime = self:isInTimeByOpenTime(data.openTime2)
	elseif kdType == GameEnum.KingDragonType.Unit then
		isInTime = self:isInTimeByOpenTime(data.openTime3)
	end

	return isInTime
end

function KdChallengeController:isCanGetPrizeAsBoss(id)
	return self:isEnoughGetPrizeAsBoss(id) and not self:isHasGainPrizeAsBoss(id)
end

function KdChallengeController:isEnoughGetPrizeAsBoss(id)
	local challengeId = KdChallengeConfig.instance:getKdCurChallengeId()
	local data = KdChallengeConfig.instance:getKdBossDamageDataByCId(challengeId, id)
	local totalDmg = KdChallengeModel.instance:getTotalDmgAsBoss()

	return totalDmg >= data.dmgProgress
end

function KdChallengeController:isCanGetPrizeAsNuoyaBoss(id)
	return self:isEnoughGetPrizeAsNuoyaBoss(id) and not self:isHasGainPrizeAsBoss(id)
end

function KdChallengeController:isEnoughGetPrizeAsNuoyaBoss(id)
	local challengeId = KdChallengeConfig.instance:getKdCurChallengeId()
	local data = KdChallengeConfig.instance:getKdBossDamageDataByCId(challengeId, id)
	local totalDmg = KdChallengeModel.instance:getTotalDmgAsBoss()

	return totalDmg >= data.dmgProgress
end

function KdChallengeController:isHasGainPrizeAsBoss(id)
	return KdChallengeModel.instance:isHasGainPrizeAsBoss(id)
end

function KdChallengeController:isHaveTimesAsBoss()
	return self:getLeftTimesAsBoss() > 0
end

function KdChallengeController:isHaveTimesAsNuoyaBoss()
	return self:getNuoyaLeftTimesAsBoss() > 0
end

function KdChallengeController:getLeftTimesAsBoss()
	local challengeId = KdChallengeConfig.instance:getKdCurChallengeId()
	local data = KdChallengeConfig.instance:getKdBossDataByCId(challengeId)
	local challengeTimes = KdChallengeModel.instance:getChallengeTimesAsBoss()
	local challengeBuyTimes = KdChallengeModel.instance:getChallengeBuyTimesAsBoss()

	return data.freeDailyTimes + challengeBuyTimes - challengeTimes
end

function KdChallengeController:getNuoyaLeftTimesAsBoss()
	local challengeId = KdChallengeConfig.instance:getNuoyaCurChallengeId()
	local data = KdChallengeConfig.instance:getKdBossDataByCId(challengeId)
	local challengeTimes = KdChallengeModel.instance:getChallengeTimesAsBoss()
	local challengeBuyTimes = KdChallengeModel.instance:getChallengeBuyTimesAsBoss()

	return data.freeDailyTimes + challengeBuyTimes - challengeTimes
end

function KdChallengeController:isExceedLimitTimesAsBoss()
	local challengeId = KdChallengeConfig.instance:getKdCurChallengeId()
	local cfg = KdChallengeConfig.instance:getKdBossBuyCfgByCId(challengeId)
	local limitTimes = #cfg
	local challengeBuyTimes = KdChallengeModel.instance:getChallengeBuyTimesAsBoss()

	return limitTimes <= challengeBuyTimes
end

function KdChallengeController:isEnoughSweepAsBoss()
	local challengeId = KdChallengeConfig.instance:getKdCurChallengeId()
	local data = KdChallengeConfig.instance:getKdBossDataByCId(challengeId)
	local curMaxDmg = KdChallengeModel.instance:getMaxDmgAsBoss()

	return curMaxDmg >= data.maxDmg
end

function KdChallengeController:isPassAllBossAsBoss()
	local challengeId = KdChallengeConfig.instance:getKdCurChallengeId()
	local dmgCfg = KdChallengeConfig.instance:getKdBossDamageCfgByCId(challengeId)
	local curDmg = KdChallengeModel.instance:getTotalDmgAsBoss()

	return curDmg >= dmgCfg[#dmgCfg].dmgProgress
end

function KdChallengeController:isExceedLimitTimesAsNuoyaBoss()
	local challengeId = KdChallengeConfig.instance:getNuoyaCurChallengeId()
	local cfg = KdChallengeConfig.instance:getKdBossBuyCfgByCId(challengeId)
	local limitTimes = #cfg
	local challengeBuyTimes = KdChallengeModel.instance:getChallengeBuyTimesAsBoss()

	return limitTimes <= challengeBuyTimes
end

function KdChallengeController:isEnoughSweepAsNuoyaBoss()
	local challengeId = KdChallengeConfig.instance:getNuoyaCurChallengeId()
	local data = KdChallengeConfig.instance:getKdBossDataByCId(challengeId)
	local curMaxDmg = KdChallengeModel.instance:getMaxDmgAsBoss()

	return curMaxDmg >= data.maxDmg
end

function KdChallengeController:isPassNuoyaAllBossAsBoss()
	local challengeId = KdChallengeConfig.instance:getNuoyaCurChallengeId()
	local dmgCfg = KdChallengeConfig.instance:getKdBossDamageCfgByCId(challengeId)
	local curDmg = KdChallengeModel.instance:getTotalDmgAsBoss()

	return curDmg >= dmgCfg[#dmgCfg].dmgProgress
end

function KdChallengeController:isCanResetAsStage()
	local result = self:getResetResultAsStage()

	return result == GameEnum.ResultCode.Success
end

function KdChallengeController:getResetResultAsStage()
	if KdChallengeModel.instance:getPassStageNumAsStage() <= 0 then
		return GameEnum.ResultCode.NotEnoughNum
	end

	if self:isHasForceSurePrizeAsStage() then
		return GameEnum.ResultCode.HasSure
	end

	if self:isPassAllStageAsStage() then
		return GameEnum.ResultCode.AllPass
	end

	return GameEnum.ResultCode.Success
end

function KdChallengeController:isCanForceSurePrizeAsStage()
	local result = self:getForceSurePrizeResultAsStage()

	return result == GameEnum.ResultCode.Success
end

function KdChallengeController:getForceSurePrizeResultAsStage()
	if self:isHasForceSurePrizeAsStage() then
		return GameEnum.ResultCode.HasSure
	end

	if not self:isHasPrizeCanGetAsStage() then
		return GameEnum.ResultCode.NotPrizeCanGet
	end

	if self:isPassAllStageAsStage() then
		return GameEnum.ResultCode.AllPass
	end

	return GameEnum.ResultCode.Success
end

function KdChallengeController:isPassAllStageAsStage()
	local challengeId = KdChallengeConfig.instance:getKdCurChallengeId()
	local stageIdList = KdChallengeModel.instance:getStageIdListAsStage()
	local isPassAll = true

	for _, stageId in ipairs(stageIdList) do
		if not KdChallengeModel.instance:isPassStageAsStage(stageId) then
			isPassAll = false

			break
		end
	end

	return isPassAll
end

function KdChallengeController:isHasPrizeCanGetAsStage()
	local isHas = false
	local stageIdList = KdChallengeModel.instance:getStageIdListAsStage()

	for _, stageId in ipairs(stageIdList) do
		local isPass = KdChallengeModel.instance:isPassStageAsStage(stageId)
		local isHasGain = KdChallengeModel.instance:isHasGainPrizeAsStage(stageId)

		if isPass and not isHasGain then
			isHas = true

			break
		end
	end

	return isHas
end

function KdChallengeController:isHasForceSurePrizeAsStage()
	local stageIdList = KdChallengeModel.instance:getPrizeStageIdListAsStage()

	return #stageIdList > 0
end

function KdChallengeController:getRemainPrizeNumAsStage()
	local challengeId = KdChallengeConfig.instance:getKdCurChallengeId()
	local stageIdList = KdChallengeModel.instance:getStageIdListAsStage()
	local sum = 0

	for _, stageId in ipairs(stageIdList) do
		if not KdChallengeModel.instance:isHasGainPrizeAsStage(stageId) then
			local stageData = KdChallengeConfig.instance:getKdStageDataByCId(challengeId, stageId)

			if not string.nilorempty(stageData.prize) then
				local matType, matId, matNum = MaterialMgr.getMatParams(stageData.prize)

				sum = sum + matNum
			end
		end
	end

	return sum
end

function KdChallengeController:getNuoyaRemainPrizeNumAsStage()
	local challengeId = KdChallengeConfig.instance:getNuoyaCurChallengeId()
	local stageIdList = KdChallengeModel.instance:getStageIdListAsStage()
	local sum = 0

	for _, stageId in ipairs(stageIdList) do
		if not KdChallengeModel.instance:isHasGainPrizeAsStage(stageId) then
			local stageData = KdChallengeConfig.instance:getKdStageDataByCId(challengeId, stageId)

			if not string.nilorempty(stageData.prize) then
				local matType, matId, matNum = MaterialMgr.getMatParams(stageData.prize)

				sum = sum + matNum
			end
		end
	end

	return sum
end

function KdChallengeController:isPassAllUnitAsUnit()
	local challengeId = KdChallengeConfig.instance:getKdCurChallengeId()
	local cfg = KdChallengeConfig.instance:getKdUnitCfgByCId(challengeId)
	local isPassAll = true

	for _, data in ipairs(cfg) do
		if not KdChallengeModel.instance:isPassUnitAsUnit(data.unitId) then
			isPassAll = false

			break
		end
	end

	return isPassAll
end

function KdChallengeController:isPassNuoyaAllUnitAsUnit()
	local challengeId = KdChallengeConfig.instance:getNuoyaCurChallengeId()
	local cfg = KdChallengeConfig.instance:getKdUnitCfgByCId(challengeId)
	local isPassAll = true

	for _, data in ipairs(cfg) do
		if not KdChallengeModel.instance:isPassUnitAsUnit(data.unitId) then
			isPassAll = false

			break
		end
	end

	return isPassAll
end

function KdChallengeController:getbuffNumAsUnit(unitId)
	local buffIdList = KdChallengeModel.instance:getBuffIdsAsUnit(unitId)

	return #buffIdList
end

function KdChallengeController:getCongBuffIdAsUnit(unitId)
	local challengeId = KdChallengeModel.instance:getCurChallengeId()
	local unitData = KdChallengeConfig.instance:getKdUnitDataByCId(challengeId, unitId)

	return unitData.buffId
end

function KdChallengeController:getAcqBuffIdListAsUnit(unitId)
	local buffIdList = KdChallengeModel.instance:getBuffIdsAsUnit(unitId)
	local congBuffId = self:getCongBuffIdAsUnit(unitId)
	local list = {}
	local count = 0

	for _, buffId in ipairs(buffIdList) do
		if buffId == congBuffId and count < 1 then
			count = count + 1
		else
			table.insert(list, buffId)
		end
	end

	return list
end

function KdChallengeController:getNuoyaCongBuffIdAsUnit(unitId)
	local challengeId = KdChallengeModel.instance:getCurChallengeId()
	local unitData = KdChallengeConfig.instance:getKdUnitDataByCId(challengeId, unitId)

	return unitData.buffId
end

function KdChallengeController:getNuoyaAcqBuffIdListAsUnit(unitId)
	local buffIdList = KdChallengeModel.instance:getBuffIdsAsUnit(unitId)
	local congBuffId = self:getNuoyaCongBuffIdAsUnit(unitId)
	local list = {}
	local count = 0

	for _, buffId in ipairs(buffIdList) do
		if buffId == congBuffId and count < 1 then
			count = count + 1
		else
			table.insert(list, buffId)
		end
	end

	return list
end

KdChallengeController.instance = KdChallengeController.New()

return KdChallengeController
