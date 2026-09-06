-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonpsychicclg/controller/DragonPsychicClgController.lua

module("logic.extensions.dragonpsychicclg.controller.DragonPsychicClgController", package.seeall)

local DragonPsychicClgController = class("DragonPsychicClgController", BaseController)

function DragonPsychicClgController:ctor()
	return
end

function DragonPsychicClgController:onInit()
	GlobalDispatcher:addListener("dragonpsychicclgmainview", self._onOpenEvent, self)
end

function DragonPsychicClgController:onReset()
	return
end

function DragonPsychicClgController:sendPM_DPClgGetUniversalInfoReq(activityId)
	DragonPsychicClgAgent.instance:sendPM_DPClgGetUniversalInfoReq(activityId)
end

function DragonPsychicClgController:handlePM_DPClgGetUniversalInfoRes(msg)
	local mo = self:getDpcMo(msg.activityId)

	mo:handlePM_DPClgGetUniversalInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_DPClgGetUniversalInfoRes)
end

function DragonPsychicClgController:sendPM_DPClgUniversalChallengeReq(activityId, form, stageId)
	DragonPsychicClgAgent.instance:sendPM_DPClgUniversalChallengeReq(activityId, form, stageId)
end

function DragonPsychicClgController:handlePM_DPClgUniversalChallengeRes(status, msg)
	if status == 0 then
		-- block empty
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end

	GlobalDispatcher:dispatch(GlobalNotify.handlePM_DPClgUniversalChallengeRes)
end

function DragonPsychicClgController:sendPM_DPClgHatchReq(activityId, creepsId)
	DragonPsychicClgAgent.instance:sendPM_DPClgHatchReq(activityId, creepsId)
end

function DragonPsychicClgController:handlePM_DPClgHatchRes(msg)
	local mo = self:getDpcMo(msg.activityId)

	mo:handlePM_DPClgHatchRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_DPClgHatchRes)
end

function DragonPsychicClgController:sendPM_DPClgDecHatchTimeReq(activityId, times)
	DragonPsychicClgAgent.instance:sendPM_DPClgDecHatchTimeReq(activityId, times)
end

function DragonPsychicClgController:handlePM_DPClgDecHatchTimeRes(msg)
	local mo = self:getDpcMo(msg.activityId)

	mo:handlePM_DPClgDecHatchTimeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_DPClgDecHatchTimeRes)
end

function DragonPsychicClgController:sendPM_DPClgGainHatchPetReq(activityId)
	DragonPsychicClgAgent.instance:sendPM_DPClgGainHatchPetReq(activityId)
end

function DragonPsychicClgController:handlePM_DPClgGainHatchPetRes(msg)
	local mo = self:getDpcMo(msg.activityId)

	mo:handlePM_DPClgGainHatchPetRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_DPClgGainHatchPetRes, msg)
end

function DragonPsychicClgController:sendPM_DPClgSelectPetReq(activityId, creepsIds)
	DragonPsychicClgAgent.instance:sendPM_DPClgSelectPetReq(activityId, creepsIds)
end

function DragonPsychicClgController:handlePM_DPClgSelectPetRes(msg)
	local mo = self:getDpcMo(msg.activityId)

	mo:handlePM_DPClgSelectPetRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_DPClgSelectPetRes)
end

function DragonPsychicClgController:sendPM_DPClgGetExtremeInfoReq(activityId)
	DragonPsychicClgAgent.instance:sendPM_DPClgGetExtremeInfoReq(activityId)
end

function DragonPsychicClgController:handlePM_DPClgGetExtremeInfoRes(msg)
	local mo = self:getDpcMo(msg.activityId)

	mo:handlePM_DPClgGetExtremeInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_DPClgGetExtremeInfoRes)
end

function DragonPsychicClgController:sendPM_DPClgExtremeChallengeReq(activityId, form, stageId, teamId)
	DragonPsychicClgAgent.instance:sendPM_DPClgExtremeChallengeReq(activityId, form, stageId, teamId)
end

function DragonPsychicClgController:handlePM_DPClgExtremeChallengeRes(status, msg)
	if status == 0 then
		-- block empty
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end

	GlobalDispatcher:dispatch(GlobalNotify.handlePM_DPClgUniversalChallengeRes)
end

function DragonPsychicClgController:sendPM_DPClgResetReq(activityId, stageId, teamId)
	DragonPsychicClgAgent.instance:sendPM_DPClgResetReq(activityId, stageId, teamId)
end

function DragonPsychicClgController:handlePM_DPClgResetRes(msg)
	local mo = self:getDpcMo(msg.activityId)

	mo:handlePM_DPClgResetRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_DPClgResetRes)
end

function DragonPsychicClgController:handlePM_DPClgNotifyUniversalChallengeRes(msg)
	local mo = self:getDpcMo(msg.activityId)

	mo:handlePM_DPClgNotifyUniversalChallengeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_DPClgNotifyUniversalChallengeRes)
end

function DragonPsychicClgController:handlePM_DPClgNotifyExtremeChallengeRes(msg)
	BattleFacade.instance:registerResultHandler(function()
		BattleFacade.instance:registerResultHandler(nil, nil)

		local activityId = msg.activityId
		local isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(activityId)

		if isAoqiGodProcessType then
			local activityType = ActivityDefineController.instance:getActTypeByActId(activityId)

			AoqiGodController.instance:doHandleChallengeFinishReady(activityType, activityId)
		end

		return false
	end)

	local mo = self:getDpcMo(msg.activityId)

	mo:handlePM_DPClgNotifyExtremeChallengeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_DPClgNotifyExtremeChallengeRes)
end

function DragonPsychicClgController:getDpcMo(activityId)
	return DragonPsychicClgModel.instance:getDpcMo(activityId)
end

function DragonPsychicClgController:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(self:getActivityType())
end

function DragonPsychicClgController:getActivityType()
	return GameEnum.ActivityType.DragonPsychicClg
end

function DragonPsychicClgController:isInActivityTime(activityId)
	local activityType = self:getActivityType()

	return ActivityDefineController.instance:isInActivityTimeById(activityType, activityId)
end

function DragonPsychicClgController:getRaceId(activityId)
	return PetSkinConfig.instance:getPetSkinRaceId(self:getSkinId(activityId))
end

function DragonPsychicClgController:getSkinId(activityId)
	return DragonPsychicClgConfig.instance:getCommonValue(activityId, "skinId")
end

function DragonPsychicClgController:getTryEnterDpcNormalViewResultAndTips(activityId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if not self:isInActivityTime(activityId) then
		result = GameEnum.ResultCode.NotInTime
		tips = "不在开启期限内"
	elseif self:isAllStagePassOfNor(activityId) then
		result = GameEnum.ResultCode.IsPass
		tips = "已通关"
	end

	return result, tips
end

function DragonPsychicClgController:getTryStartDpcNormalClgResultAndTips(activityId, stageId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if not self:isInActivityTime(activityId) then
		result = GameEnum.ResultCode.NotInTime
		tips = "不在开启期限内"
	elseif self:isAllStagePassOfNor(activityId) then
		result = GameEnum.ResultCode.IsPass
		tips = "所有关卡已通关"
	elseif self:isHasPassStageOfNor(activityId, stageId) then
		result = GameEnum.ResultCode.IsPass
		tips = "该关卡已通关"
	elseif not self:isHasPassPreStageOfNor(activityId, stageId) then
		result = GameEnum.ResultCode.NotPassLast
		tips = "请通关前置关卡后解锁"
	elseif self:isNeedSelectInitialPets(activityId) then
		result = GameEnum.ResultCode.NotEnoughNum
	end

	return result, tips
end

function DragonPsychicClgController:getTryEnterDpcExtViewResultAndTips(activityId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if not self:isInActivityTime(activityId) then
		result = GameEnum.ResultCode.NotInTime
		tips = "不在开启期限内"
	end

	return result, tips
end

function DragonPsychicClgController:getTryStartDpcExtClgResultAndTips(activityId, stageId, teamId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if not self:isInActivityTime(activityId) then
		result = GameEnum.ResultCode.NotInTime
		tips = "不在开启期限内"
	elseif self:isAllPassOfExt(activityId) then
		result = GameEnum.ResultCode.Error
		tips = "挑战已完成"
	elseif self:isPassInTeamOfExt(activityId, stageId, teamId) then
		result = GameEnum.ResultCode.Error
		tips = "已通关"
	elseif not self:isPreCondFirstPassFinishOfExt(activityId, stageId, teamId) then
		result = GameEnum.ResultCode.Error
		tips = "前置关卡未通关"
	end

	return result, tips
end

function DragonPsychicClgController:enterBattle(activityId, stageId)
	local customFmtMo = DragonPsychicClgModel.instance:getDpcCustomFmtMo(activityId)

	customFmtMo:updateCfg(activityId, stageId)
	CustomFmtController.instance:showMissionView(customFmtMo)
end

function DragonPsychicClgController:isAllStagePassOfNor(activityId)
	local curStageId = self:getCurStageIdOfNor(activityId)
	local maxStageId = self:getTotalStageNum(activityId)

	return maxStageId <= curStageId
end

function DragonPsychicClgController:isHasPassStageOfNor(activityId, stageId)
	local curStageId = self:getCurStageIdOfNor(activityId)

	return stageId <= curStageId
end

function DragonPsychicClgController:isHasPassPreStageOfNor(activityId, stageId)
	local curStageId = self:getCurStageIdOfNor(activityId)
	local preStageId = stageId - 1

	return self:isHasPassStageOfNor(activityId, preStageId)
end

function DragonPsychicClgController:getTotalStageNum(activityId)
	local cfg = DragonPsychicClgConfig.instance:getDpcUniversalStageCfg(activityId)

	return (cfg or nil) and #cfg
end

function DragonPsychicClgController:getCurStageIdOfNor(activityId)
	local mo = self:getDpcMo(activityId)

	return mo:getCurStageIdOfNor()
end

function DragonPsychicClgController:getLeftSpeedTimesOfNor(activityId)
	local data = DragonPsychicClgConfig.instance:getDpcData(activityId)
	local matStr = data and data.decHatchTimeCost
	local matType, matId, matNum = MaterialMgr.getMatParams(matStr)

	return MaterialModel.instance:getMaterialsNumber(matType, matId)
end

function DragonPsychicClgController:getHatchStateOfNor(activityId)
	local creepsId = self:getCreepsIdInHatchOfNor(activityId)

	if creepsId <= 0 then
		return DragonPsychicClgEnum.HatchState_Null
	end

	local finishTime = self:getFinishTimeInHatchOfNor(activityId)

	finishTime = finishTime / 1000

	local curTime = ServerTime.now()

	if finishTime <= curTime then
		return DragonPsychicClgEnum.HatchState_Finish
	else
		return DragonPsychicClgEnum.HatchState_Doing
	end
end

function DragonPsychicClgController:isNeedSelectInitialPets(activityId)
	local list = self:getCanUseCreepsIdsOfNor(activityId)

	return #list <= 0
end

function DragonPsychicClgController:isWithThePetOfNor(activityId, creepsId)
	local list = self:getCanUseCreepsIdsOfNor(activityId)

	return table.indexof(list, creepsId)
end

function DragonPsychicClgController:getCanUseCreepsIdsOfNor(activityId)
	local mo = self:getDpcMo(activityId)

	return mo:getCanUseCreepsIdsOfNor()
end

function DragonPsychicClgController:getHatchInfoOfNor(activityId)
	local mo = self:getDpcMo(activityId)

	return mo:getHatchInfoOfNor()
end

function DragonPsychicClgController:getCreepsIdInHatchOfNor(activityId)
	local mo = self:getDpcMo(activityId)

	return mo:getCreepsIdInHatchOfNor()
end

function DragonPsychicClgController:getFinishTimeInHatchOfNor(activityId)
	local mo = self:getDpcMo(activityId)

	return mo:getFinishTimeInHatchOfNor()
end

function DragonPsychicClgController:enterBattleOfExt(activityId, stageId, teamId)
	local customFmtMo = DragonPsychicClgModel.instance:getDpcExtCustomFmtMo(activityId)

	customFmtMo:updateCfg(activityId, stageId, teamId)
	CustomFmtController.instance:showMissionView(customFmtMo)
end

function DragonPsychicClgController:isPreCondFirstPassFinishOfExt(activityId, stageId, teamId)
	local result = true
	local cfg = DragonPsychicClgConfig.instance:getDpcExtremeStageCfg(activityId, stageId)

	if cfg then
		for tId = teamId - 1, 1, -1 do
			local isPassTeam = self:isFirstPassInTeamOfExt(activityId, stageId, tId)

			if not isPassTeam then
				result = false

				break
			end
		end
	end

	return result
end

function DragonPsychicClgController:isPassInStageOfExt(activityId, stageId)
	local result = true
	local cfg = DragonPsychicClgConfig.instance:getDpcExtremeStageCfg(activityId, stageId)

	if cfg then
		for _, data in ipairs(cfg) do
			local isPassTeam = self:isPassInTeamOfExt(activityId, stageId, data.teamId)

			if not isPassTeam then
				result = false

				break
			end
		end
	end

	return result
end

function DragonPsychicClgController:isPassInTeamOfExt(activityId, stageId, teamId)
	local teamInfoMo = self:getExtTeamInfoMo(activityId, stageId, teamId)

	return teamInfoMo:isPass()
end

function DragonPsychicClgController:getLockRaceIdsOfExt(activityId)
	local result = {}
	local cfgs = DragonPsychicClgConfig.instance:getDpcExtremeStageCfgs(activityId)

	if cfgs then
		for _, cfg in ipairs(cfgs) do
			for _, data in ipairs(cfg) do
				local raceIds = self:getLockRaceIdsInTeamOfExt(data.activityId, data.stageId, data.teamId)

				table.insertto(result, raceIds)
			end
		end
	end

	return result
end

function DragonPsychicClgController:getLockRaceIdsInTeamOfExt(activityId, stageId, teamId)
	local teamInfoMo = self:getExtTeamInfoMo(activityId, stageId, teamId)

	return teamInfoMo:getLockRaceIds()
end

function DragonPsychicClgController:isFirstPassInTeamOfExt(activityId, stageId, teamId)
	local teamInfoMo = self:getExtTeamInfoMo(activityId, stageId, teamId)

	return teamInfoMo:isFirstPass()
end

function DragonPsychicClgController:getExtTeamInfoMo(activityId, stageId, teamId)
	local mo = self:getDpcMo(activityId)

	return mo:getExtTeamInfoMo(stageId, teamId)
end

function DragonPsychicClgController:isAllPassOfExt(activityId)
	local mo = self:getDpcMo(activityId)

	return mo:isAllPassOfExt()
end

function DragonPsychicClgController:_onOpenEvent(params)
	local activityId = checknumber(params[1])

	if activityId <= 0 then
		return
	end

	UIStateManager.instance:push(ViewName.DragonPsychicClgMainView, activityId)
end

DragonPsychicClgController.instance = DragonPsychicClgController.New()

return DragonPsychicClgController
