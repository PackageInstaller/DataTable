-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godaruishichallenge/controller/GodARuiShiChallengeController.lua

module("logic.extensions.godaruishichallenge.controller.GodARuiShiChallengeController", package.seeall)

local GodARuiShiChallengeController = class("GodARuiShiChallengeController", BaseController)

function GodARuiShiChallengeController:ctor()
	return
end

function GodARuiShiChallengeController:onInit()
	GlobalDispatcher:addListener(GodARuiShiChallengeAgent.PM_GodARuiShiChallengeInfoRes, self._onGetInfo, self)
	GlobalDispatcher:addListener(GodARuiShiChallengeAgent.PM_GodARuiShiChallengeSkipRes, self._onSkipChallenge, self)
	GlobalDispatcher:addListener(GodARuiShiChallengeAgent.PM_GodARuiShiChallengeStageRes, self._onChallengeStage, self)
	GlobalDispatcher:addListener(GodARuiShiChallengeAgent.PM_GodARuiShiChallengeBossRes, self._onChallengeBoss, self)
	GlobalDispatcher:addListener(GodARuiShiChallengeAgent.PM_GodARuiShiChallengeOneKeyPassRes, self._onOneKeyPass, self)
	GlobalDispatcher:addListener(GodARuiShiChallengeAgent.PM_NotifyGodARuiShiChallengeStageEndRes, self._onNotifyChallengeStageEnd, self)
	GlobalDispatcher:addListener(GodARuiShiChallengeAgent.PM_NotifyGodARuiShiChallengeBossEndRes, self._onNotifyChallengeBossEnd, self)
end

function GodARuiShiChallengeController:onReset()
	return
end

function GodARuiShiChallengeController:send_GodARuiShiChallengeInfoReq(challengeId)
	GodARuiShiChallengeAgent.instance:sendPM_GodARuiShiChallengeInfoReq(challengeId)
	GodARuiShiChallengeModel.instance:setChallengeId(challengeId)
end

function GodARuiShiChallengeController:_onGetInfo(status, msg)
	GodARuiShiChallengeModel.instance:setChallengeInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.GodARuiShiChallengeInfoRes)
end

function GodARuiShiChallengeController:_onSkipChallenge(status, msg)
	GodARuiShiChallengeModel.instance:setWaveInfo(msg.waveInfo)
	GlobalDispatcher:dispatch(GlobalNotify.GodARuiShiChallengeSkipRes)
end

function GodARuiShiChallengeController:_onChallengeStage(status, msg)
	GlobalDispatcher:dispatch(GlobalNotify.GodARuiShiChallengeStageRes)
end

function GodARuiShiChallengeController:_onChallengeBoss(status, msg)
	GlobalDispatcher:dispatch(GlobalNotify.GodARuiShiChallengeBossRes)
end

function GodARuiShiChallengeController:_onOneKeyPass(status, msg)
	GlobalDispatcher:dispatch(GlobalNotify.GodARuiShiChallengeOneKeyPassRes)
	GodARuiShiChallengeModel.instance:onGodARuiShiQuickPassRes(msg)

	if msg:HasField("changeSetId") then
		MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
	end

	local function callback()
		GodARuiShiChallengeController.instance:showOneKeyReward()
	end

	UIStateManager.instance:popByName(ViewName.GodARuiShiChallengeMainView)
	UIStateManager.instance:push(ViewName.DivineEvolveTipView, callback)
end

function GodARuiShiChallengeController:_onNotifyChallengeStageEnd(status, msg)
	GlobalDispatcher:dispatch(GlobalNotify.NotifyGodARuiShiChallengeStageEndRes)

	local challengeId = GodARuiShiChallengeModel.instance:getChallengeId()
	local stageId = BattleModel.instance.godARuiShiStageId
	local params = {}

	if msg.isWin == true then
		if challengeId == GodARuiShiChallengeConfig.instance:getChallengeEvolveChallengeId() and stageId then
			local stageCfg = GodARuiShiChallengeConfig.instance:getStageInfo(challengeId, stageId)

			params.addScore = stageCfg.score
		end

		MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
		BattleSettlementModel.instance:setChangeSetId(msg.changeSetId)
	end

	BattleSettlementModel.instance:setType(BattleSettlementModel.Enum.GodARuiShi, params)
	UIJumper.instance:pushOneStack(ViewName.GodARuiShiChallengeMainView, true, challengeId)
end

function GodARuiShiChallengeController:_onNotifyChallengeBossEnd(status, msg)
	GlobalDispatcher:dispatch(GlobalNotify.NotifyGodARuiShiChallengeBossEndRes)

	local challengeId = GodARuiShiChallengeModel.instance:getChallengeId()
	local params = {}

	if msg.isWin == true then
		params.damage = msg.damage

		if challengeId == GodARuiShiChallengeConfig.instance:getChallengeEvolveChallengeId() then
			params.addScore = msg.addScore
		end
	end

	BattleSettlementModel.instance:setType(BattleSettlementModel.Enum.GodARuiShi, params)

	if msg.isWin == true then
		MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
		BattleSettlementModel.instance:setChangeSetId(msg.changeSetId)
	end

	GodARuiShiChallengeModel.instance:setBossBattleEnd(true)
	UIJumper.instance:pushOneStack(ViewName.GodARuiShiChallengeMainView, true, challengeId)
end

function GodARuiShiChallengeController:showOneKeyReward()
	local changeSetId = GodARuiShiChallengeModel.instance:getOneKeyChangeSetId()

	MaterialController.instance:showChangeSetInTemp(changeSetId)
end

GodARuiShiChallengeController.instance = GodARuiShiChallengeController.New()

return GodARuiShiChallengeController
