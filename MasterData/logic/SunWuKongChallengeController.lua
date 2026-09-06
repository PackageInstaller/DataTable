-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sunwukongchallenge/controller/SunWuKongChallengeController.lua

module("logic.extensions.sunwukongchallenge.controller.SunWuKongChallengeController", package.seeall)

local SunWuKongChallengeController = class("SunWuKongChallengeController", BaseController)

function SunWuKongChallengeController:onReset()
	self._isFormMainBattle = false
	self._isWinMainbattle = false
end

function SunWuKongChallengeController:onInit()
	GlobalDispatcher:addListener(SunWuKongChallengeAgent.PM_SunWuKongChallengeGetInfoRes, self.handlePM_SunWuKongChallengeGetInfoRes, self)
	GlobalDispatcher:addListener(SunWuKongChallengeAgent.PM_SunWuKongChallengeRes, self.handlePM_SunWuKongChallengeRes, self)
	GlobalDispatcher:addListener(SunWuKongChallengeAgent.PM_SunWuKongChallengeResultRes, self.handlePM_SunWuKongChallengeResultRes, self)
	GlobalDispatcher:addListener(SunWuKongChallengeAgent.PM_SunWuKongChallengeDoHiddenTaskRes, self.handlePM_SunWuKongChallengeDoHiddenTaskRes, self)
	GlobalDispatcher:addListener(SunWuKongChallengeAgent.PM_SunWuKongChallengeStartGameRes, self.handlePM_SunWuKongChallengeStartGameRes, self)
	GlobalDispatcher:addListener(SunWuKongChallengeAgent.PM_SunWuKongChallengeEndGameRes, self.handlePM_SunWuKongChallengeEndGameRes, self)
	GlobalDispatcher:addListener(SunWuKongChallengeAgent.PM_SunWuKongChallengeGetCimeliaInfoRes, self.handlePM_SunWuKongChallengeGetCimeliaInfoRes, self)
	GlobalDispatcher:addListener(SunWuKongChallengeAgent.PM_SunWuKongChallengeUpgradeCimeliaRes, self.handlePM_SunWuKongChallengeUpgradeCimeliaRes, self)
	GlobalDispatcher:addListener(SunWuKongChallengeAgent.PM_SunWuKongChallengeResetCimeliaRes, self.handlePM_SunWuKongChallengeResetCimeliaRes, self)
	GlobalDispatcher:addListener(GlobalNotify.RoleLogined, self._resetData, self)
	self:onReset()
end

function SunWuKongChallengeController:_resetData()
	RedPointController.instance:setRedPointInfo(RedPointModel.ID_SUNWUKONGCHALLENGE_NEW_CIMELIA, false)
	GameUtil.whenLocalDataInited(function()
		local cfgs = ActivityDefineConfig.instance:getCfgByActivityTypeId(GameEnum.ActivityType.SunWuKongChallenge)

		for i, v in pairs(cfgs or {}) do
			if ActivityDefineController.instance:isInActivityTimeById(v.activityType, v.activityId) == true then
				local result = GameUtil.getUserData(SunWuKongChallengeModel.ReadFlag .. "#NewCimelia#" .. v.activityId)

				if result == true then
					RedPointController.instance:setRedPointInfo(RedPointModel.ID_SUNWUKONGCHALLENGE_NEW_CIMELIA, result)
				end
			end
		end
	end)
end

function SunWuKongChallengeController:isWinMainBattle()
	return self._isWinMainbattle
end

function SunWuKongChallengeController:resetWinMainBattle()
	self._isWinMainbattle = false
	self._mainStageId = 0
	self._battleActivieyId = 0
end

function SunWuKongChallengeController:tryToOpenTipsView(viewName)
	local actCfg = SunWuKongChallengeConfig.instance:getActivityCfg(self._battleActivieyId)

	if self._isWinMainbattle and actCfg then
		local stageCfg = SunWuKongChallengeConfig.instance:getStageCfg(actCfg.stagePlanId, self._mainStageId)

		if stageCfg and checknumber(stageCfg.hiddenTaskId) > 0 then
			UIStateManager.instance:push(viewName)
		end
	end
end

function SunWuKongChallengeController:setLatestStage(stageId)
	self._latestStage = stageId
end

function SunWuKongChallengeController:getLatestStage()
	return checknumber(self._latestStage)
end

function SunWuKongChallengeController:handlePM_SunWuKongChallengeGetInfoRes(msg)
	SunWuKongChallengeModel.instance:setStageData(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_SunWuKongChallengeGetInfoRes)
end

function SunWuKongChallengeController:sendPM_SunWuKongChallengeReq(activityId, form, stageId)
	local mainStageId = SunWuKongChallengeModel.instance:getCurStageId(activityId)

	if checknumber(stageId) <= 0 or checknumber(stageId) == mainStageId then
		self._mainStageId = mainStageId
		self._battleActivieyId = activityId
	end

	SunWuKongChallengeAgent:sendPM_SunWuKongChallengeReq(activityId, form, stageId)
end

function SunWuKongChallengeController:handlePM_SunWuKongChallengeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_SunWuKongChallengeRes)
end

function SunWuKongChallengeController:handlePM_SunWuKongChallengeResultRes(msg)
	if msg.win and checknumber(self._mainStageId) > 0 then
		self._isWinMainbattle = true

		SunWuKongChallengeModel.instance:checkNewCimelia(msg.activityId, self._mainStageId)
	end

	if msg.changeSetId ~= nil then
		MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
		BattleSettlementModel.instance:setChangeSetId(msg.changeSetId)
	end

	GlobalDispatcher:dispatch(GlobalNotify.PM_SunWuKongChallengeResultRes)
end

function SunWuKongChallengeController:handlePM_SunWuKongChallengeDoHiddenTaskRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_SunWuKongChallengeDoHiddenTaskRes)
end

function SunWuKongChallengeController:sendPM_SunWuKongChallengeStartGameReq(activityId, stageId)
	math.randomseed(tostring(os.time()):reverse():sub(1, 7))

	local clientKey = math.random(1, 100000000)

	SunWuKongChallengeModel.instance:setMiniGameClintKey(clientKey)
	SunWuKongChallengeAgent.instance:sendPM_SunWuKongChallengeStartGameReq(activityId, stageId, clientKey)
end

function SunWuKongChallengeController:handlePM_SunWuKongChallengeStartGameRes(msg)
	SunWuKongChallengeModel.instance:setMiniGameMixedKey(msg.mixedKey)
	GlobalDispatcher:dispatch(GlobalNotify.PM_SunWuKongChallengeStartGameRes)
end

function SunWuKongChallengeController:sendPM_SunWuKongChallengeEndGameReq(score)
	local encryptedKey = GameUtil.getClientEncryptedKey(SunWuKongChallengeModel.instance:getMiniGameClintKey(), SunWuKongChallengeModel.instance:getMiniGameMixedKey(), {
		score
	})

	SunWuKongChallengeAgent.instance:sendPM_SunWuKongChallengeEndGameReq(score, encryptedKey)
end

function SunWuKongChallengeController:handlePM_SunWuKongChallengeEndGameRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_SunWuKongChallengeEndGameRes)
end

function SunWuKongChallengeController:handlePM_SunWuKongChallengeGetCimeliaInfoRes(msg)
	SunWuKongChallengeModel.instance:setCimeliaData(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_SunWuKongChallengeGetCimeliaInfoRes)
end

function SunWuKongChallengeController:handlePM_SunWuKongChallengeUpgradeCimeliaRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_SunWuKongChallengeUpgradeCimeliaRes)
end

function SunWuKongChallengeController:handlePM_SunWuKongChallengeResetCimeliaRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_SunWuKongChallengeResetCimeliaRes)
end

SunWuKongChallengeController.instance = SunWuKongChallengeController.New()

return SunWuKongChallengeController
