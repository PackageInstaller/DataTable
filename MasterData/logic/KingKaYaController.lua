-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingkaya/controller/KingKaYaController.lua

module("logic.extensions.kingkaya.controller.KingKaYaController", package.seeall)

local KingKaYaController = class("KingKaYaController", BaseController)

function KingKaYaController:ctor()
	return
end

function KingKaYaController:onInit()
	self:onReset()
	GlobalDispatcher:addListener("enterkingkayamainview", self._enterEventOpenView, self)
end

function KingKaYaController:onReset()
	return
end

function KingKaYaController:sendPM_KingKaYaGetInfoReq(activityId)
	KingKaYaAgent.instance:sendPM_KingKaYaGetInfoReq(activityId)
end

function KingKaYaController:handlePM_KingKaYaGetInfoRes(msg)
	local mo = self:getKingKaYaMo(msg.activityId)

	mo:handlePM_KingKaYaGetInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_KingKaYaGetInfoRes)
end

function KingKaYaController:sendPM_KingKaYaExtremeChallengeReq(activityId, stageId, form)
	BattleFacade.instance:registerResultHandler(GameUtil.handler(self._handlerBattleEndInExt, self, activityId, stageId))
	KingKaYaAgent.instance:sendPM_KingKaYaExtremeChallengeReq(activityId, stageId, form)
end

function KingKaYaController:handlePM_KingKaYaExtremeChallengeRes(status, msg)
	if status == 0 then
		-- block empty
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end

	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_KingKaYaExtremeChallengeRes)
end

function KingKaYaController:sendPM_KingKaYaResetExtremeStageReq(activityId, stageId)
	KingKaYaAgent.instance:sendPM_KingKaYaResetExtremeStageReq(activityId, stageId)
end

function KingKaYaController:handlePM_KingKaYaResetExtremeStageRes(msg)
	local mo = self:getKingKaYaMo(msg.activityId)

	mo:handlePM_KingKaYaResetExtremeStageRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_KingKaYaResetExtremeStageRes)
end

function KingKaYaController:sendPM_KingKaYaNormalChallengeReq(activityId, difficulty, form)
	KingKaYaAgent.instance:sendPM_KingKaYaNormalChallengeReq(activityId, difficulty, form)
end

function KingKaYaController:handlePM_KingKaYaNormalChallengeRes(status, msg)
	if status == 0 then
		-- block empty
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end

	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_KingKaYaNormalChallengeRes)
end

function KingKaYaController:sendPM_KingKaYaGainProgressPrizeReq(activityId, prizeId)
	KingKaYaAgent.instance:sendPM_KingKaYaGainProgressPrizeReq(activityId, prizeId)
end

function KingKaYaController:handlePM_KingKaYaGainProgressPrizeRes(msg)
	local mo = self:getKingKaYaMo(msg.activityId)

	mo:handlePM_KingKaYaGainProgressPrizeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_KingKaYaGainProgressPrizeRes)
end

function KingKaYaController:handlePM_Notify_KingKaYaExtremeChallengeEndRes(msg)
	local mo = self:getKingKaYaMo(msg.activityId)

	mo:handlePM_Notify_KingKaYaExtremeChallengeEndRes(msg)

	local isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(msg.activityId)

	if isAoqiGodProcessType then
		local allPass = self:_checkIsAllDone(msg.activityId)

		if allPass then
			AoqiGodController.instance:doHandleChallengeFinishReady(GameEnum.ActivityType.KingKaYa, msg.activityId)
		end
	end

	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_Notify_KingKaYaExtremeChallengeEndRes)
end

function KingKaYaController:handlePM_Notify_KingKaYaNormalChallengeEndRes(msg)
	local mo = self:getKingKaYaMo(msg.activityId)

	mo:handlePM_Notify_KingKaYaNormalChallengeEndRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_Notify_KingKaYaNormalChallengeEndRes)
end

function KingKaYaController:getKingKaYaMo(activityId)
	return KingKaYaModel.instance:getKingKaYaMo(activityId)
end

function KingKaYaController:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(self:getActivityType())
end

function KingKaYaController:getActivityType()
	return GameEnum.ActivityType.KingKaYa
end

function KingKaYaController:isInActivityTime(activityId)
	local activityType = self:getActivityType()

	return ActivityDefineController.instance:isInActivityTimeById(activityType, activityId)
end

function KingKaYaController:getRaceId(activityId)
	return PetSkinConfig.instance:getPetSkinRaceId(self:getSkinId(activityId))
end

function KingKaYaController:getSkinId(activityId)
	return KingKaYaConfig.instance:getCommonValue(activityId, "skinId")
end

function KingKaYaController:enterBattleInNor(activityId, stageId)
	local customFmtMo = KingKaYaModel.instance:getNorCustomFmtMo(activityId)

	customFmtMo:updateCfg(activityId, stageId)
	CustomFmtController.instance:showMissionView(customFmtMo)
end

function KingKaYaController:enterBattleInExt(activityId, stageId)
	local customFmtMo = KingKaYaModel.instance:getExtCustomFmtMo(activityId)

	customFmtMo:updateCfg(activityId, stageId)
	CustomFmtController.instance:showMissionView(customFmtMo)
end

function KingKaYaController:_handlerBattleEndInExt(activityId, stageId)
	BattleFacade.instance:registerResultHandler(nil, nil)
	UIStateManager.instance:push(ViewName.KingKaYaExtClgResultView, activityId, stageId)

	return true
end

function KingKaYaController:_enterEventOpenView(params)
	local actId = checknumber(params[1])

	UIStateManager.instance:push(ViewName.KingKaYaMainView, actId)
end

function KingKaYaController:_checkIsAllDone(activityId)
	local kayaMo = KingKaYaModel.instance:getKingKaYaMo(activityId)
	local extStageCfgs = KingKaYaConfig.instance:getExtStageCfg(activityId)
	local clsEndRes = kayaMo:getExtClgEndRes()

	return clsEndRes.stageId == #extStageCfgs and clsEndRes.stagePass
end

KingKaYaController.instance = KingKaYaController.New()

return KingKaYaController
