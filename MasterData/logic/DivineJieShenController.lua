-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinejieshen/controller/DivineJieShenController.lua

module("logic.extensions.divinejieshen.controller.DivineJieShenController", package.seeall)

local DivineJieShenController = class("DivineJieShenController", BaseController)

function DivineJieShenController:ctor()
	return
end

function DivineJieShenController:onInit()
	return
end

function DivineJieShenController:onReset()
	return
end

function DivineJieShenController:sendPM_DivineJieShenClgGetInfoReq(activityId)
	DivineJieShenClgAgent.instance:sendPM_DivineJieShenClgGetInfoReq(activityId)
end

function DivineJieShenController:handlePM_DivineJieShenClgGetInfoRes(msg)
	local mo = DivineJieShenModel.instance:getDivineJieShenMo(msg.activityId)

	mo:handlePM_DivineJieShenClgGetInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_DivineJieShenClgGetInfoRes)
end

function DivineJieShenController:sendPM_DivineJieShenClgExtremeChallengeReq(activityId, towerId, stageId, leftOrRight, form)
	DivineJieShenClgAgent.instance:sendPM_DivineJieShenClgExtremeChallengeReq(activityId, towerId, stageId, leftOrRight, form)
end

function DivineJieShenController:handlePM_DivineJieShenClgExtremeChallengeRes(status, msg)
	if status == 0 then
		-- block empty
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function DivineJieShenController:sendPM_DivineJieShenClgResetExtremeStageReq(activityId, leftOrRight)
	DivineJieShenClgAgent.instance:sendPM_DivineJieShenClgResetExtremeStageReq(activityId, leftOrRight)
end

function DivineJieShenController:handlePM_DivineJieShenClgResetExtremeStageRes(msg)
	local mo = DivineJieShenModel.instance:getDivineJieShenMo(msg.activityId)

	mo:handlePM_DivineJieShenClgResetExtremeStageRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_DivineJieShenClgResetExtremeStageRes)
end

function DivineJieShenController:sendPM_DivineJieShenClgNormalRandomTrialReq(activityId, stageId, drawTimes)
	DivineJieShenClgAgent.instance:sendPM_DivineJieShenClgNormalRandomTrialReq(activityId, stageId, drawTimes)
end

function DivineJieShenController:handlePM_DivineJieShenClgNormalRandomTrialRes(msg)
	local mo = DivineJieShenModel.instance:getDivineJieShenMo(msg.activityId)

	mo:handlePM_DivineJieShenClgNormalRandomTrialRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_DivineJieShenClgNormalRandomTrialRes, msg)
end

function DivineJieShenController:sendPM_DivineJieShenClgNormalStartGameReq(activityId, stageId, trialId)
	local clientKey = math.random(1, 100000)
	local mo = DivineJieShenModel.instance:getDivineJieShenMo(activityId)

	mo:setClientKeyInNor(stageId, clientKey)
	DivineJieShenClgAgent.instance:sendPM_DivineJieShenClgNormalStartGameReq(activityId, stageId, trialId, clientKey)
end

function DivineJieShenController:handlePM_DivineJieShenClgNormalStartGameRes(status, msg)
	if status == 0 then
		local mo = DivineJieShenModel.instance:getDivineJieShenMo(msg.activityId)

		mo:handlePM_DivineJieShenClgNormalStartGameRes(msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_DivineJieShenClgNormalStartGameRes, status, msg)
end

function DivineJieShenController:sendPM_DivineJieShenClgNormalFinishGameReq(activityId, stageId, pass, score)
	local mo = DivineJieShenModel.instance:getDivineJieShenMo(activityId)
	local clientKey = mo:getClientKeyInNor(stageId)
	local serverKey = mo:getServerKeyInNor(stageId)
	local encryptedKey = GameUtil.getClientEncryptedKey(clientKey, serverKey, {
		stageId,
		pass and 1 or 0,
		score
	})

	DivineJieShenClgAgent.instance:sendPM_DivineJieShenClgNormalFinishGameReq(activityId, pass, score, encryptedKey)
end

function DivineJieShenController:handlePM_DivineJieShenClgNormalFinishGameRes(status, msg)
	if status == 0 then
		local mo = DivineJieShenModel.instance:getDivineJieShenMo(msg.activityId)

		mo:handlePM_DivineJieShenClgNormalFinishGameRes(msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_DivineJieShenClgNormalFinishGameRes, status, msg)
end

function DivineJieShenController:sendPM_DivineJieShenClgNormalChallengeStageReq(activityId, stageId, form)
	DivineJieShenClgAgent.instance:sendPM_DivineJieShenClgNormalChallengeStageReq(activityId, stageId, form)
end

function DivineJieShenController:handlePM_DivineJieShenClgNormalChallengeStageRes(status, msg)
	if status == 0 then
		-- block empty
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function DivineJieShenController:sendPM_DivineJieShenClgNormalChallengeBossReq(activityId, form)
	DivineJieShenClgAgent.instance:sendPM_DivineJieShenClgNormalChallengeBossReq(activityId, form)
end

function DivineJieShenController:handlePM_DivineJieShenClgNormalChallengeBossRes(status, msg)
	if status == 0 then
		-- block empty
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function DivineJieShenController:handlePM_Notify_DivineJieShenClgExtremeChallengeEndRes(msg)
	local mo = DivineJieShenModel.instance:getDivineJieShenMo(msg.activityId)

	mo:handlePM_Notify_DivineJieShenClgExtremeChallengeEndRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_Notify_DivineJieShenClgExtremeChallengeEndRes)
end

function DivineJieShenController:handlePM_Notify_DivineJieShenClgNormalChallengeStageEndRes(msg)
	local mo = DivineJieShenModel.instance:getDivineJieShenMo(msg.activityId)

	mo:handlePM_Notify_DivineJieShenClgNormalChallengeStageEndRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_Notify_DivineJieShenClgNormalChallengeStageEndRes)
end

function DivineJieShenController:handlePM_Notify_DivineJieShenClgNormalChallengeBossEndRes(msg)
	local mo = DivineJieShenModel.instance:getDivineJieShenMo(msg.activityId)

	mo:handlePM_Notify_DivineJieShenClgNormalChallengeBossEndRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_Notify_DivineJieShenClgNormalChallengeBossEndRes)
end

function DivineJieShenController:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(self:getActivityType())
end

function DivineJieShenController:getActivityType()
	return GameEnum.ActivityType.DivineJieShen
end

function DivineJieShenController:isInActivityTime(activityId)
	local activityType = self:getActivityType()

	return ActivityDefineController.instance:isInActivityTimeById(activityType, activityId)
end

function DivineJieShenController:getCurTowerRule(activityId, towerId)
	local data = DivineJieShenConfig.instance:getExtTowerData(activityId)[towerId]

	if data then
		return data.towerRule
	end
end

function DivineJieShenController:getCompareMode(activityId, towerId, stageId)
	local data = DivineJieShenConfig.instance:getExtStageData(activityId, towerId, stageId)

	if data then
		return data.compareMode
	end
end

function DivineJieShenController:checkTowerIsInTime(activityId, towerId)
	local mo = DivineJieShenModel.instance:getDivineJieShenMo(activityId)

	return mo:_isUnlockTower(towerId)
end

function DivineJieShenController:getRaceId(activityId)
	return PetSkinConfig.instance:getPetSkinRaceId(self:getSkinId(activityId))
end

function DivineJieShenController:getSkinId(activityId)
	return DivineJieShenConfig.instance:getCommonValue(activityId, "skinId")
end

function DivineJieShenController:enterBattleInExt(activityId, towerId, stageId, teamId)
	local customFmtMo = DivineJieShenModel.instance:getExtCustomFmtMo(activityId)

	customFmtMo:updateCfg(activityId, towerId, stageId, teamId)
	CustomFmtController.instance:showMissionView(customFmtMo)
end

function DivineJieShenController:enterBattleInNorStage(activityId, stageId)
	local customFmtMo = DivineJieShenModel.instance:getNorStageCustomFmtMo(activityId)

	customFmtMo:updateCfg(activityId, stageId)
	CustomFmtController.instance:showMissionView(customFmtMo)
end

function DivineJieShenController:enterBattleInNorBoss(activityId)
	local customFmtMo = DivineJieShenModel.instance:getNorBossCustomFmtMo(activityId)

	customFmtMo:updateCfg(activityId)
	CustomFmtController.instance:showMissionView(customFmtMo)
end

function DivineJieShenController:enterBoxGameInNorStage(activityId, stageId)
	local data = DivineJieShenConfig.instance:getRandomPlanData(activityId, DivineJieShenEnum.TrialMode_BoxGame)
	local params = {}

	params.activityId = activityId
	params.stageId = stageId
	params.trialId = DivineJieShenEnum.TrialMode_BoxGame

	local guessActivityId = checknumber(data.params.activityId)
	local levelId = checknumber(data.params.levelId)

	if guessActivityId <= 0 or levelId <= 0 then
		printError("猜盒子配置错误，activityId <= 0 or levelId <= 0")
	else
		UIStateManager.instance:push(ViewName.GuessSnowmanGameCopyInDjsView, guessActivityId, levelId, params)
	end
end

function DivineJieShenController:enterAnswerInNorStage(activityId, stageId)
	GlobalDispatcher:addListener(GlobalNotify.HandlePM_DivineJieShenClgNormalStartGameRes, self._handleAnswerInNorStage, self)
	DivineJieShenController.instance:sendPM_DivineJieShenClgNormalStartGameReq(activityId, stageId, DivineJieShenEnum.TrialMode_Answer)
end

function DivineJieShenController:_handleAnswerInNorStage(status, msg)
	GlobalDispatcher:removeListener(GlobalNotify.HandlePM_DivineJieShenClgNormalStartGameRes, self._handleAnswerInNorStage, self)

	if status == 0 then
		local data = DivineJieShenConfig.instance:getRandomPlanData(msg.activityId, DivineJieShenEnum.TrialMode_Answer)
		local params = {}

		params.activityId = msg.activityId
		params.stageId = msg.stageId

		local problemPlanId = checknumber(data.params.problemPlanId)
		local problemCount = checknumber(data.params.problemCount)

		if problemPlanId <= 0 then
			printError("答题游戏配置错误，problemPlanId <= 0")
		else
			UIStateManager.instance:push(ViewName.GuessLanternAnswerCopyInDjsView, problemPlanId, problemCount, params)
		end
	else
		printError("答题游戏开始失败，请联系开发检查原因")
	end
end

DivineJieShenController.instance = DivineJieShenController.New()

return DivineJieShenController
